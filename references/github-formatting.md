# GitHub-Native Formatting

Use GitHub formatting features deliberately. The goal is clarity, not decoration.

## Default Tools

- Relative links for docs split across `README.md`, `docs/`, and sibling markdown files
- `<details><summary>` for Tier 3 reference material
- Tables for structured data such as config, prerequisites, and compatibility
- `<picture>` for dark/light mode logos

## Optional Tools

Use these only when they communicate faster than prose:

- Mermaid diagrams for architecture, flow, sequence, timeline, or dependency relationships
- Task lists for roadmap and progress, not marketing copy
- Footnotes for citations or side notes that should not interrupt the main reading flow
- Math expressions for technical or scientific projects that genuinely need formulas
- Minimal HTML when Markdown is not enough (`<picture>`, `<kbd>`, `<sub>`, `<sup>`, `<br>`)

## Decision Rules

### `<details>`

Use for Tier 3 or overflow content only. Do not hide the core value proposition, quick start, or install path inside collapsed sections.

### Relative Links

Use when the README links to `docs/`, `CONTRIBUTING.md`, `CHANGELOG.md`, or other repo-local files. Prefer relative links over hard-coded GitHub blob URLs for in-repo navigation.

### Mermaid

Use only when a diagram is faster to parse than bullets or prose. Good cases:

- architecture overview
- request or data flow
- release or implementation timeline
- multi-step workflow with branching

Avoid Mermaid for decorative charts or information already obvious from a short list.

### Task Lists

Use for roadmap or status checkpoints. Do not use task lists for feature marketing.

### Footnotes

Use when a citation, caveat, or attribution is useful but should not interrupt scanning. Keep onboarding content in the main body, not in notes.

### Math

Use only for projects where formulas are part of the core explanation. If the project can be explained without formulas, prefer prose.

### Social Proof

Contributor widgets, star counts, and popularity badges are optional enhancements. Add them only when:

- the repository is public
- the numbers are real and easy to verify
- the user wants social proof in the README

Do not add them by default for early-stage, private, or unpublished repositories.

## Overflow Strategy

When the README becomes too long:

1. Keep Tier 1 and Tier 2 compact in `README.md`
2. Move deep reference material to `docs/` or separate markdown files
3. Link back with relative links
4. Preserve a short explanation in README so the reader knows why the linked doc exists

## Official GitHub Coverage

This reference assumes current GitHub support for:

- basic Markdown and relative links
- collapsed sections
- Mermaid and other diagram syntaxes
- math expressions
- footnotes

Verify current behavior against the official GitHub docs when adding a new formatting pattern.
