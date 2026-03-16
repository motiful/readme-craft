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

Use for reference material and secondary alternatives only. **Collapsed content is invisible to scanning readers — treat it as if it doesn't exist for first-time visitors.**

**MUST NOT collapse** (decision-making sections — readers need these to evaluate the project):
- Problem / Why
- Features / What It Does
- What Users Get / Value table
- Usage / Quick Start
- Install (primary command)
- Prerequisites
- Dependencies

**OK to collapse** (reference material — committed users expand what they need):
- How It Works / Pipeline stages / Architecture
- Manual / alternative install methods
- Advanced examples
- Positioning / Not-for boundary
- Project structure / What's Inside
- Configuration reference
- Changelog / Roadmap

**Within a visible section**, secondary alternatives can use `<details>` (e.g., manual clone inside an open Install section). The parent section itself must stay open.

### `<details>` vs Sub-Documents

Both are progressive disclosure, but at different levels. Wrong choice = content either feels buried or bloats the README.

| | `<details>` (same page) | Sub-document (`docs/xxx.md`) |
|---|---|---|
| Reader discovers it | By scanning — title is visible | By clicking a link — requires intent |
| Reader returns to README | Scrolls — zero cost | Browser back — high cost |
| Best length | Under ~30 lines / 1 screen | Over 1 screen |
| Independence | No standalone value | Can be bookmarked, linked from elsewhere |
| Update cadence | Changes with README | May update independently |

**Decision rule:**

```
Content to disclose:

1. Short (< ~30 lines)?
   YES → <details> in README
   NO  → continue

2. Independently useful (someone might link to it directly)?
   YES → sub-document in docs/
   NO  → continue

3. Updates on a different cadence than the README?
   YES → sub-document in docs/
   NO  → <details> in README (but consider splitting if > 1 screen)
```

**Anti-pattern:** collapsing everything in README while `docs/` sits empty. If you have 6+ collapsed sections, some of them are probably long enough to be sub-documents. If you have 0 collapsed sections, you're probably missing progressive disclosure.

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
