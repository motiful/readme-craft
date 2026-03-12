# Comparison Screenshots

Generate before/after comparison PNGs for README case studies. Renders markdown as GitHub-styled HTML and captures via Playwright Chromium.

## Prerequisites

```bash
npm install
npx playwright install chromium
```

## CLI Usage

```bash
node scripts/generate-comparison.mjs \
  --before examples/skill-forge-original.md \
  --after examples/skill-forge-after.md \
  --output examples/skill-forge-comparison.png
```

### Options

| Flag | Default | Description |
|------|---------|-------------|
| `--before` | (required) | Path to the "before" markdown file |
| `--after` | (required) | Path to the "after" markdown file |
| `--output` | `comparison.png` | Output PNG path |
| `--mode` | `side-by-side` | Layout: `side-by-side` or `stacked` |
| `--crop` | (none) | Crop to N pixels height — useful for above-fold comparisons |
| `--width` | `1012` | Content width in pixels (1012 = GitHub's native width) |
| `--scale` | `2` | Device pixel ratio (2 = Retina clarity) |
| `--labels` | `BEFORE,AFTER` | Comma-separated label text |

### npm script

```bash
npm run comparison:generate -- --before <path> --after <path> --output <path>
```

## Recommended Usage

**Above-fold crop** — most impactful for showcasing layout improvements:

```bash
node scripts/generate-comparison.mjs \
  --before original.md --after improved.md \
  --output comparison-fold.png --crop 800
```

**Full-page stacked** — when the whole README changed significantly:

```bash
node scripts/generate-comparison.mjs \
  --before original.md --after improved.md \
  --output comparison-full.png --mode stacked
```

## Architecture

```
scripts/
├── generate-comparison.mjs       # CLI entry point
└── comparison/
    ├── render.mjs                # markdown → GitHub-styled HTML
    └── screenshot.mjs            # HTML → PNG via Playwright
```

- `render.mjs` uses `marked` for markdown parsing and `github-markdown-css` for styling
- `screenshot.mjs` launches headless Chromium at 2x DPR for sharp output
- The HTML layout uses GitHub's white card + border aesthetic with colored BEFORE/AFTER labels
