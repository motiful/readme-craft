# Gradient Design Theory Research

Internal research doc — Work Stream D findings on gradient generation for SVG headers.

## sRGB vs OKLCH Interpolation

### The sRGB Problem

Standard CSS/SVG gradients interpolate in **sRGB** space by default. sRGB is a gamma-encoded space — it is not perceptually uniform. This causes two problems:

1. **Muddy midpoints**: Interpolating between complementary colors (e.g., blue #2563EB → orange #F97316) passes through desaturated gray/brown in the middle. The midpoint loses all vibrancy.
2. **Uneven perceptual transitions**: Equal numeric steps in sRGB do not produce equal perceptual steps. A gradient from dark blue to light blue appears to "jump" in the middle rather than transition smoothly.

The root cause is that sRGB mixes R, G, B channels independently. When complementary colors are mixed, the channels partially cancel out, producing gray.

### The OKLCH Solution

**OKLCH** (Oklab in polar form) is a **perceptually uniform** color space. Interpolation in OKLCH:

- Maintains saturation through the midpoint — blue→orange passes through vivid purple/magenta instead of mud
- Produces perceptually even transitions — each step looks like the same amount of change
- Handles hue interpolation correctly via the angular h channel (takes the short arc by default)

### OKLCH Math

OKLCH is the polar form of **Oklab**, created by Bjorn Ottosson (2020). The conversion pipeline:

```
sRGB → Linear RGB → Oklab → OKLCH

Step 1: sRGB → Linear RGB
  Remove gamma: c_linear = (c_srgb / 255)^2.2  (simplified; actual uses piecewise function)

Step 2: Linear RGB → Oklab (3×3 matrix transform)
  [l]   [0.4122214708  0.5363325363  0.0514459929] [R_lin]
  [m] = [0.2119034982  0.6806995451  0.1073969566] [G_lin]
  [s]   [0.0883024619  0.2817188376  0.6299787005] [B_lin]

  Then cube root: l' = l^(1/3), m' = m^(1/3), s' = s^(1/3)

  Then second matrix to get Lab coordinates (L, a, b)

Step 3: Oklab → OKLCH (cartesian → polar)
  L = L        (lightness, 0 to 1)
  C = √(a² + b²)  (chroma / saturation, 0 to ~0.37)
  h = atan2(b, a)  (hue angle, 0° to 360°)
```

**Channels**:
- **L** (Lightness): 0 = black, 1 = white. Perceptually uniform.
- **C** (Chroma): 0 = gray, higher = more colorful. Gamut-dependent maximum.
- **h** (Hue): Angular, in degrees. 0°≈pink, 90°≈yellow, 180°≈cyan, 270°≈blue.

### SVG Implementation

SVG gradients default to sRGB interpolation. To get linear (non-gamma-encoded) interpolation:

```xml
<linearGradient id="grad" color-interpolation="linearRGB">
  <stop offset="0%" stop-color="#2563EB"/>
  <stop offset="100%" stop-color="#F97316"/>
</linearGradient>
```

The attribute `color-interpolation="linearRGB"` on gradient elements prevents sRGB gamma-encoded interpolation. This is not full OKLCH, but it significantly reduces the muddy midpoint problem by operating in linear light space.

For true OKLCH interpolation in SVG, you must pre-compute stop colors at intervals in OKLCH space and emit them as explicit sRGB stops — there is no native OKLCH interpolation in SVG 1.1/2.0.

## Eased Stop Distribution

### The Problem with Linear Spacing

Default gradient stops at equal intervals (0%, 25%, 50%, 75%, 100%) produce **perceptually harsh transitions**. The human eye is more sensitive to changes in mid-tones than in highlights or shadows, so equal spacing creates a visible "band" effect in the middle range.

### Smoothstep Easing

Apply the smoothstep function to stop positions:

```
t_eased = t² × (3 - 2t)
```

Where `t` is the normalized position (0 to 1). This produces an S-curve that:
- Slows down at the start (ease-in)
- Speeds up through the middle
- Slows down at the end (ease-out)

For a 5-stop gradient:

| Linear t | Smoothstep t | Effect |
|----------|-------------|--------|
| 0.00 | 0.000 | Same — start color |
| 0.25 | 0.156 | Stops cluster near start |
| 0.50 | 0.500 | Same — midpoint |
| 0.75 | 0.844 | Stops cluster near end |
| 1.00 | 1.000 | Same — end color |

The visual effect: more color stops are concentrated at the transition zones, producing smoother apparent blending.

### Concentrate Stops at Transitions

For gradients with a clear dominant/accent color split, place more stops near the transition boundary. Example for a blue→purple accent transition at the 70% mark:

```
stops: [0%, 30%, 60%, 68%, 72%, 80%, 100%]
```

Three stops in the 60-80% range smooth the transition; fewer stops in the 0-60% range where the color is relatively uniform.

## Asymmetric Stop Placement

### The 70/30 Rule

Equal 50/50 color distribution is the hallmark of a "default" gradient. A **70/30 split** — where the dominant color occupies 70% of the gradient space — produces a more sophisticated, intentional look.

```xml
<linearGradient id="grad">
  <stop offset="0%" stop-color="#2563EB"/>    <!-- dominant blue -->
  <stop offset="70%" stop-color="#2563EB"/>   <!-- hold dominant -->
  <stop offset="100%" stop-color="#7C3AED"/>  <!-- accent purple -->
</linearGradient>
```

This creates a clear hierarchy: the gradient _has_ a primary color with an accent, rather than being an equal blend of two.

Variations: 80/20 (very subtle accent), 60/40 (balanced but still directional). Avoid exact 50/50 unless intentionally going for a "split" aesthetic.

## Grain Overlay

### Purpose

A subtle noise/grain texture serves two functions:
1. **Reduces banding** — gradient banding is visible on 8-bit displays, especially in dark, low-chroma gradients. Noise breaks up the quantization boundaries.
2. **Adds depth** — flat gradients feel digital/sterile. A touch of grain adds organic texture reminiscent of photographic or print media.

### SVG Implementation

```xml
<filter id="grain">
  <feTurbulence
    type="fractalNoise"
    baseFrequency="0.65"
    numOctaves="3"
    stitchTiles="stitch"
    result="noise"
  />
  <feColorMatrix type="saturate" values="0" in="noise" result="grayNoise"/>
  <feBlend in="SourceGraphic" in2="grayNoise" mode="overlay"/>
</filter>
```

### Parameters

| Parameter | Value | Rationale |
|-----------|-------|-----------|
| `type` | `fractalNoise` | Produces organic, multi-scale noise (vs `turbulence` which is more structured) |
| `baseFrequency` | 0.65 | Controls grain size. Lower = larger blobs, higher = finer grain. 0.65 is fine-grained without becoming pixel noise |
| `numOctaves` | 3 | Layers of detail. 1 = smooth blobs, 3 = natural texture, 5+ = diminishing returns and perf cost |
| `opacity` | 0.03-0.08 | Applied via feBlend or feComposite. Below 0.03 is invisible; above 0.08 becomes distracting. **0.05 is a safe default** |

### Opacity by Background

- Light backgrounds: 0.03-0.05 (grain is more visible on light surfaces)
- Dark backgrounds: 0.05-0.08 (grain needs more opacity to register)
- Vibrant/saturated: 0.04-0.06 (too much grain fights the color)

## Gradient Direction Psychology

The angle of a gradient carries **implicit visual meaning** based on cultural conventions and physical intuition:

| Angle | Direction | Association | Used By |
|-------|-----------|-------------|---------|
| 0° | Left → Right | Reading direction (LTR cultures), progression, calm, neutral | Many corporate sites |
| 45° | Top-left → Bottom-right | Forward momentum, tech, innovation, dynamism | **Stripe**, **Linear**, Vercel |
| 90° | Top → Bottom | Gravity, natural light (sky→ground), familiar, stable | Default in most tools |
| 135° | Top-right → Bottom-left | Unconventional, creative, slightly unsettling | Less common, art/design sites |
| 180° | Right → Left | Against reading direction, reverse, unusual | Rarely used intentionally |
| 270° | Bottom → Top | Anti-gravity, rising, aspiration | Occasionally for "uplifting" feel |
| Radial | Center → Edge | Focus, spotlight, portal, depth | **Raycast**, spotlight effects |

**For readme-craft**: Default to 135° (top-right → bottom-left) — it reads as modern/tech without being as overused as 45°. Allow user override.

## Palette Harmony Classification

Color theory provides frameworks for selecting colors that work well together:

### Monochromatic
- **Definition**: Single hue, vary only Lightness and Chroma
- **OKLCH**: h fixed, vary L and C
- **Character**: Safe, cohesive, professional. Cannot clash. Risk of being bland.
- **Best for**: Corporate, serious, minimalist designs

### Analogous
- **Definition**: Colors within a 15-30° hue arc
- **OKLCH**: h varies by ±15°, L and C adjusted for balance
- **Character**: Warm, harmonious, natural. Low contrast but visually rich.
- **Best for**: Nature-themed, warm/inviting, lifestyle brands

### Split-Complementary
- **Definition**: Colors spanning a 150-180° hue arc, but not directly opposite
- **OKLCH**: h₂ = h₁ + 150° or h₁ + 210° (asymmetric complement)
- **Character**: Dynamic, vibrant, energetic. High contrast without the muddiness risk of true complements.
- **Best for**: Creative tools, entertainment, marketing

### Complementary
- **Definition**: Colors at 180° hue separation (direct opposites)
- **OKLCH**: h₂ = h₁ + 180°
- **Character**: Maximum contrast, dramatic. **Muddy in sRGB interpolation** — must use OKLCH.
- **Best for**: High-impact headers, call-to-action. Use sparingly.

## Randomization Safe Ranges

When generating "unique but not broken" variations, constrain jitter to these ranges:

| Parameter | Safe Jitter Range | Beyond This |
|-----------|-------------------|-------------|
| Hue | ±5-15° | >15° shifts into adjacent color territory; looks like a different palette |
| Chroma | ±0.02 | >0.02 can push into out-of-gamut (especially high-C yellows/cyans) |
| Stop position | ±3% | >3% creates visible asymmetry in what should be smooth transitions |
| Direction angle | ±5° | >5° looks crooked rather than "subtly varied" |

### Implementation Notes

- Apply jitter **per-generation**, not per-stop — all stops in one gradient should share the same jitter seed for coherence
- Hue jitter should maintain relative relationships — if two colors are 30° apart, jitter both by the same amount
- Clamp all values after jitter to valid ranges (C ≥ 0, L in [0,1], h in [0,360))
- Seed the RNG from input text (e.g., repo name hash) so the same repo always gets the same "random" gradient

## Premium Brand Gradient Analysis

### Stripe
- **Style**: Animated diagonal gradient
- **Colors**: Blue → Purple (approximately #635BFF → #A259FF)
- **Angle**: 45° diagonal (top-left → bottom-right)
- **Technique**: Subtle grain overlay, eased stops, gentle CSS animation shifting stop positions
- **Impression**: Premium, trustworthy, innovative

### Linear
- **Style**: Dark-background gradients
- **Colors**: Deep blue → Purple (#1A1A2E → #5B21B6 range)
- **Angle**: Various, often radial or 45°
- **Technique**: Very dark palette with eased stop distribution, grain texture, multiple gradient layers
- **Impression**: Sophisticated, focused, developer-oriented

### Raycast
- **Style**: Radial gradients
- **Colors**: Orange → Pink (#FF6363 → #F97316 range)
- **Angle**: Radial (center-out)
- **Technique**: Vibrant colors, radial spread, blur effects
- **Impression**: Energetic, fast, modern macOS aesthetic

### Instagram
- **Style**: Multi-stop iconic gradient
- **Colors**: Yellow → Orange → Magenta → Purple (#FEDA75 → #FA7E1E → #D62976 → #962FBF → #4F5BD5)
- **Angle**: Radial/diagonal (varies by usage)
- **Technique**: 5+ stops with asymmetric placement, creates a sunset-like arc
- **Impression**: Warm, social, creative, recognizable as a brand element

### Common Patterns Across Premium Brands

1. **Never 50/50 splits** — all use asymmetric distribution
2. **Limited palette** — 2-3 colors maximum in the gradient itself
3. **Grain/texture** — subtle noise is nearly universal
4. **Dark backgrounds** — most premium gradients sit on dark (#0A0A0A - #1A1A2E) surfaces
5. **Eased transitions** — no harsh linear stops
6. **Hue rotation < 90°** — most stay within analogous range (Stripe: ~60° blue→purple, Linear: ~40°, Instagram is the exception at ~270° but uses 5 stops to manage it)
