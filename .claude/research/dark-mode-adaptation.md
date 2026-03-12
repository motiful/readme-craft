# Dark Mode Color Adaptation Research

Internal research doc — Work Stream D findings on dark mode color adaptation.

## Problem: RGB-Space Lightening Destroys Color Character

The naive approach `lightenHex(color, 0.35)` mixes the source color toward white (#FFFFFF) in RGB space. This produces a linear interpolation:

```
R' = R + (255 - R) * 0.35
G' = G + (255 - G) * 0.35
B' = B + (255 - B) * 0.35
```

The result is **desaturation**. Every channel moves toward 255 at the same rate, collapsing the color toward a pale, washed-out version of itself. Saturated brand colors lose their identity — a vivid blue (#2563EB) becomes a chalky periwinkle rather than a luminous blue.

This is a fundamental limitation of RGB as a color space: it conflates luminance and chromaticity. "Make it lighter" in RGB inherently means "make it less colorful."

## Solution: HSL-Space Manipulation

Operate in HSL (Hue, Saturation, Lightness) instead. The adaptation formula:

```
H' = H          (preserve hue identity exactly)
S' = S - 0.12   (slight desaturation to avoid neon glare on dark bg)
L' = L + 0.30   (boost lightness for visibility on dark backgrounds)
```

Why this works:
- **Hue preservation**: The hue channel is untouched. Blue stays blue, not blue-gray.
- **Controlled desaturation**: A small S reduction (-0.12) compensates for the Helmholtz-Kohlrausch effect — highly saturated colors at high lightness appear unnaturally vivid on dark backgrounds.
- **Lightness boost**: +0.30 L provides sufficient contrast against dark backgrounds (typically L=0.10-0.15 for dark surfaces).

### Implementation Numbers

| Parameter | Range | Sweet Spot | Rationale |
|-----------|-------|------------|-----------|
| L boost | 25-35% | **30%** | Below 25% is too subtle on dark bg; above 35% approaches white |
| S reduction | 8-15% | **12%** | Below 8% still looks neon; above 15% loses brand vibrancy |
| L clamp max | — | **0.90** | Hard ceiling to prevent pure white (L=1.0) blowout |

### Clamping

Always clamp output values:
- `L' = min(L + 0.30, 0.90)` — prevents colors from becoming indistinguishable from white
- `S' = max(S - 0.12, 0.0)` — prevents negative saturation (nonsensical)

## Design System References

### Material Design 3 — Tone System

Material 3 uses the **HCT color space** (Hue, Chroma, Tone) developed by Google. Tone is a perceptually uniform lightness scale from 0 (black) to 100 (white).

- Light mode surfaces use **Tone 40** for primary colors
- Dark mode surfaces use **Tone 80** for the same role
- This is a 40-point tone shift, not a simple inversion
- The HCT space ensures that chroma (colorfulness) is maintained across tone shifts
- Key insight: the same hue at Tone 40 and Tone 80 are perceptually "the same color" at different lightness levels

### Apple Human Interface Guidelines — Dynamic Colors

Apple's approach uses **semantic color tokens** with separate light/dark definitions:

- Colors are defined as **resolved values** per appearance, not transformations
- **Vibrancy layers** (behind-window, in-window) add material-aware blending
- System colors have carefully tuned dark variants — `systemBlue` in dark mode is NOT `systemBlue.lighten(30%)`
- Apple provides **increased contrast** accessibility variants as a third tier
- Takeaway: the best systems don't derive dark colors algorithmically — they author them

### Radix Colors — 12-Step Scale

Radix provides a 12-step color scale designed for automatic dark mode:

- Steps 1-2: backgrounds
- Steps 3-5: component backgrounds (hover, active states)
- Steps 6-8: borders
- Steps 9-10: solid colors (buttons, badges)
- Steps 11-12: text
- Dark mode is a **separate 12-step scale**, not an inversion of the light scale
- Maintains **APCA contrast** (Advanced Perceptual Contrast Algorithm) at every step pairing
- Radix dark scales are authored to preserve the _feel_ of each color, not just the contrast ratio

### GitHub Primer — Functional Color Scales

Primer uses **functional color scales** with explicit dark-mode definitions:

- Each color has a light scale and a **separate dark scale** (not inverted)
- Roles like `fg.default`, `bg.subtle`, `border.muted` resolve to different scale steps per mode
- Dark mode scale is independently tuned — `blue-3` in dark mode is not derived from `blue-3` in light mode
- Emphasis on functional naming over absolute color values
- Demonstrates that large-scale systems treat dark mode as a parallel design surface

### Tailwind CSS — Shade System

Tailwind's 50-950 shade system provides a practical mapping reference:

- Light mode typically uses shades **500-700** for primary actions
- Dark mode maps these to **200-400** range
- Common mappings: `600 → 300`, `700 → 200`
- The shade numbers are not perceptually linear — the gap between 100 and 200 is not the same as 400 and 500
- Dark mode strategy: pick a shade that _feels_ equivalent in prominence, not one that is mathematically equidistant

## Key Principle

**Dark mode is NOT "invert and lighten."**

It is a **re-mapping** that must preserve:

1. **Color relationships** — If blue is more prominent than green in light mode, it must remain so in dark mode
2. **Brand identity** — A brand's primary blue must still _read_ as that brand's blue
3. **Semantic meaning** — Error red, success green, warning amber must retain their associations
4. **Contrast hierarchy** — Primary, secondary, and tertiary text levels must maintain relative contrast ratios
5. **Emotional tone** — If the light mode feels warm, the dark mode should not feel cold

The practical consequence: a single algorithmic transform (lighten, invert, shift) will never produce a good dark mode. The best systems use **authored palettes** with algorithmic starting points refined by human judgment.

## Application to readme-craft

For SVG badge/header generation where we cannot author per-color dark variants:

1. Convert input hex to HSL
2. Apply `L += 0.30`, `S -= 0.12` (clamped)
3. Convert back to hex
4. This is a pragmatic middle ground — not as good as authored palettes, but far better than RGB lightening
5. The HSL approach preserves enough color character that brand colors remain recognizable
