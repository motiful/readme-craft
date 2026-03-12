# Logo Preset Gallery

Visual reference for all logo presets available in readme-craft's logo generator.

## How to Use This Gallery

Open the SVG file paths below in your browser or image viewer to preview each preset.
When using the logo generator in a workflow, present absolute file paths to the user for previewing.

## Figlet Family (Reliable)

These presets are stable and recommended for production README headers.

### figlet-dos-rebel-main

- **Default palette**: ocean
- **Best for**: infra, CLI, tooling, system utilities
- **Preview**: `examples/logos/readme-craft-figlet-dos-rebel-main.svg`

### figlet-dos-rebel-inline

- **Default palette**: sunset
- **Best for**: product-like tools, friendlier README headers
- **Preview**: `examples/logos/readme-craft-figlet-dos-rebel-inline.svg`

### figlet-ansi-shadow-sharp

- **Default palette**: fire
- **Best for**: poster-like, bold alternative
- **Preview**: `examples/logos/readme-craft-figlet-ansi-shadow-sharp.svg`

## cfonts Family (Experimental)

These presets have size guardrails applied. Output quality varies by project name length.
Review the SVG before committing. Long names (> 12 characters) may produce degraded results — prefer figlet for those.

### cfonts-console-neutral

- **Default palette**: sunset
- **Best for**: minimal fallback, neutral control
- **Render mode**: text (monospace font, not geometry rects)
- **Preview**: Generate with `--preset cfonts-console-neutral`

### cfonts-block-compact

- **Default palette**: ocean
- **Best for**: structured, display-ready wordmarks
- **Preview**: `examples/logos/readme-craft-cfonts-block-compact.svg`

### cfonts-simpleblock-slim

- **Default palette**: ocean
- **Best for**: slimmer block texture when block feels too heavy
- **Preview**: Generate with `--preset cfonts-simpleblock-slim`

### cfonts-shade-default

- **Default palette**: forest
- **Best for**: soft metallic texture, calmer feel
- **Preview**: Generate with `--preset cfonts-shade-default`

### cfonts-shade-crisp

- **Default palette**: ocean
- **Best for**: brighter, cleaner shade treatment
- **Preview**: `examples/logos/skill-forge-cfonts-shade-crisp.svg`

### cfonts-tiny-tall

- **Default palette**: ocean
- **Best for**: compact micro-display style with personality
- **Preview**: `examples/logos/repo-scaffold-cfonts-tiny-tall.svg`

## Palettes

| Name | Colors | Feel |
|------|--------|------|
| sunset | #ff9966 → #ff5e62 | Warm, energetic |
| nebula | #654ea3 → #eaafc8 | Purple, dreamy |
| ocean | #2193b0 → #6dd5ed | Cool, professional |
| forest | #11998e → #38ef7d | Green, natural |
| fire | #f12711 → #f5af19 | Red-orange, bold |

## CLI Quick Reference

| Command | Description |
|---------|-------------|
| `--candidates 5` | Generate 5 random candidates for HITL selection |
| `--random` | Pick one random preset from reliable pool + random palette |
| `--preset <name>` | Use a specific preset |
| `--palette <name>` | Override the default palette |
| `--header-style single-line\|stacked\|block` | Semantic preset selection |
| `--pack baselines` | Generate all baseline presets for comparison |

## npm Scripts

```sh
npm run logo:list                                          # List all presets
npm run logo:generate -- --name "my-project"               # Generate with default preset
npm run logo:random -- --name "my-project"                 # Random reliable preset + palette
npm run logo:candidates -- --name "my-project" --candidates 5  # HITL candidate selection
npm run logo:examples                                      # Regenerate example gallery
```
