# Case Study: Skill Forge README

A before/after analysis of applying [readme-craft](https://github.com/motiful/readme-craft)'s 3-tier layout strategy and Quality Checklist to the Skill Forge README. The raw version represents a typical first-draft README with no visual hierarchy. The after version demonstrates a fully structured, GitHub-native layout scoring 22/22 on the checklist.

- **Before**: [`skill-forge-raw.md`](../.claude/examples/skill-forge-raw.md) -- beginner-style flat README
- **After**: [`skill-forge/README.md`](https://github.com/motiful/skill-forge/blob/main/README.md) -- full 3-tier layout

---

## Before: Structure Overview

```
# Skill Forge                          <- H1 (plain text, left-aligned)
  paragraph (description)              <- no one-liner, no logo, no badges
  paragraph (compatibility note)

## Installation                        <- H2
  code block (npx)
  code block (clone + symlinks)

## Features                            <- H2
  paragraph (wall of text)
  paragraph

## Usage                               <- H2
  paragraph
  bullet list (trigger phrases)

## Example                             <- H2
  paragraph
  code block

## Prerequisites                       <- H2
  paragraph
  bullet list

## Skill Composition                   <- H2
  paragraph

## Related Skills                      <- H2
  bullet list

## Project Structure                   <- H2
  code block (tree)

## License                             <- H2
  inline text
```

### Tier 1 Evaluation (Above the Fold)

| Element | Present? | Notes |
|---------|----------|-------|
| Logo (centered, `<picture>`) | No | No logo at all |
| Project name (centered `<h1>`) | Partial | Plain `# Skill Forge`, left-aligned |
| One-liner as value proposition | No | Two full paragraphs instead; describes what it is, not why you should care |
| Badges | No | None |
| Quick action links | No | None |

**Verdict**: No Tier 1 exists. The first screen is a left-aligned heading followed by two paragraphs of prose.

### Tier 2 Evaluation (Scan Quickly)

| Section | Present? | Notes |
|---------|----------|-------|
| Why / The Problem | No | No motivation section |
| Features (bullet list, 3-6 items) | No | Features is a single prose paragraph describing all five stages in running text |
| Quick Start | No | No Quick Start section; Install appears first |
| Install | Yes | Appears as the second section, before Features |
| Usage | Yes | Trigger phrases listed, but no Quick Start precedes it |

**Verdict**: Two of five required Tier 2 sections are present. Section ordering puts Install before Features and Usage. Features is a paragraph, not a scannable list.

### Tier 3 Evaluation (Reference)

| Section | Collapsible? | Notes |
|---------|-------------|-------|
| Prerequisites | No | Open H2 section |
| Skill Composition | No | Open H2 section |
| Related Skills | No | Open H2 section |
| Project Structure | No | Open H2 section |
| License | No | Open H2 section (acceptable for License) |

**Verdict**: All reference material is presented as top-level H2 sections with no `<details>` folding. Tier 3 content occupies the same visual weight as Tier 2 content.

---

## After: Structure Overview

```
<div align="center">                   <- Tier 1 block
  <picture> logo (dark/light)
  <p> one-liner value proposition
</div>
  compatibility note
  badges (3, reference-style)
  quick links (Quick Start, Usage, Install, Agent Skills)
---

## The Problem                         <- Tier 2 starts
  bullet list (5 pain points)

## What Skill Forge Does
  numbered list (5 pipeline stages)
  closing sentence

## Quick Start                         <- Tier 2
  code block (npx)
  code block (trigger phrase)
  result summary

## Usage                               <- Tier 2
  bullet list (trigger phrases)
  <details> Example: Publishing self-review

## Install                             <- Tier 2
  code block (npx)
  <details> Manual registration
  <details> Prerequisites
  <details> Works Better With

<details> Positioning                  <- Tier 3
<details> What's Inside

## Contributing                        <- Open (acceptable)
## License                             <- Open (acceptable)
---
  skill footer
  badge reference-style links
```

### Tier 1 Evaluation (Above the Fold)

| Element | Present? | Notes |
|---------|----------|-------|
| Logo (centered, `<picture>`) | Yes | Dark/light SVG variants, 480px width (wordmark) |
| Project name (centered `<h1>`) | Yes | Rendered by the wordmark logo; no duplicate `<h1>` stacked |
| One-liner as value proposition | Yes | "From idea to published, installable AI skill -- in one pipeline." |
| Badges | Yes | 3 badges (License, Version, Agent Skills), reference-style links |
| Quick action links | Yes | Quick Start, Usage, Install, Agent Skills |

**Verdict**: Complete Tier 1 with all five required elements. Compact layout fits within the ~250px fold target.

### Tier 2 Evaluation (Scan Quickly)

| Section | Present? | Notes |
|---------|----------|-------|
| Why / The Problem | Yes | 5 bullet points describing specific pain |
| What Skill Forge Does | Yes | 5 numbered pipeline stages, scannable |
| Quick Start | Yes | 2 code blocks + 1 summary line |
| Usage | Yes | Trigger phrases as bullets, example folded in `<details>` |
| Install | Yes | Primary `npx` command; manual method folded in `<details>` |

**Verdict**: All required Tier 2 sections present with correct ordering. Code blocks and bullet lists used throughout. No section exceeds one screen.

### Tier 3 Evaluation (Reference)

| Section | Collapsible? | Notes |
|---------|-------------|-------|
| Example (publishing flow) | Yes | Inside Usage `<details>` |
| Manual registration | Yes | Inside Install `<details>` |
| Prerequisites | Yes | `<details>` under Install |
| Works Better With | Yes | `<details>` under Install |
| Positioning | Yes | Standalone `<details>` |
| What's Inside | Yes | Standalone `<details>` with annotated tree |
| Contributing | No | Open H2 (acceptable per checklist rules) |
| License | No | Open H2 (acceptable per checklist rules) |

**Verdict**: All reference material is folded in `<details>` blocks. Contributing and License remain open, which is permitted by the checklist.

---

## Changes Made

| # | Change | What | Why |
|---|--------|------|-----|
| 1 | Added Tier 1 hero block | Centered `<picture>` logo with dark/light variants, one-liner, badges, quick links | Establishes visual hierarchy and delivers the 3-second pitch |
| 2 | Rewrote one-liner | From two technical paragraphs to "From idea to published, installable AI skill -- in one pipeline." | Value proposition answers "why should I care?" instead of describing implementation |
| 3 | Added "The Problem" section | New section with 5 bullet points describing pain of trapped, unpublishable skills | Provides motivation before showing features; required by Tier 2 |
| 4 | Converted Features paragraph to numbered list | Single prose paragraph became "What Skill Forge Does" with 5 numbered pipeline stages | Bullet/numbered lists scan faster than paragraphs |
| 5 | Added Quick Start section | New section: `npx skills add` + trigger phrase + expected result | Fastest path to working example; was entirely missing |
| 6 | Reordered sections | Moved Install after Quick Start and Usage; was previously the second section | readme-craft skill template places Usage before Install to prioritize understanding |
| 7 | Folded manual install in `<details>` | Clone + symlink instructions moved from open section to collapsible block | Primary install is one line; verbose alternative belongs in Tier 3 |
| 8 | Folded Prerequisites in `<details>` | Open H2 became collapsible block under Install | Reference material should not compete visually with Tier 2 |
| 9 | Folded Skill Composition into Positioning | Separate H2 became part of a `<details>` block with editorial framing | Niche topic; does not warrant top-level heading |
| 10 | Folded Related Skills into Works Better With | Separate H2 became `<details>` block with install commands | Reference material; follows skill template convention |
| 11 | Folded Project Structure into What's Inside | Open H2 with bare tree became `<details>` with annotated tree | Reference material; annotations add value per line |
| 12 | Added badges | License, Version, Agent Skills badges with reference-style URLs | Trust signals expected in Tier 1 |
| 13 | Added Contributing section | New open H2 with brief invitation and GitHub link | Required by Completeness checklist |
| 14 | Labeled example as sample flow | Added "This is a sample flow, not a transcript from one specific machine." | Example provenance rule: unverified examples must be labeled |
| 15 | Added skill footer | "Forged with Skill Forge / Crafted with Readme Craft" | Required by Completeness checklist |

---

## Quality Checklist Results

### Before Score: skill-forge-raw.md

**Structure (0 / 5)**

| # | Criterion | Pass? | Reason |
|---|-----------|-------|--------|
| 1 | Tier 1 elements present above first heading | No | No logo, no badges, no quick links, no centered layout |
| 2 | Tier 1 is compact | No | No Tier 1 exists; two paragraphs sit where the pitch should be |
| 3 | Tier 2 sections: Why + Quick Start + Install | No | No Why section, no Quick Start |
| 4 | Tier 3 uses `<details>` | No | All reference sections are open H2 headings |
| 5 | No Tier 3 content in Tier 1/2 area | No | Prerequisites, Skill Composition, Project Structure all sit as top-level H2 sections alongside core content |

**Content (2 / 7)**

| # | Criterion | Pass? | Reason |
|---|-----------|-------|--------|
| 1 | One-liner is value proposition | No | Two paragraphs of technical description |
| 2 | Why section describes specific pain point | No | No Why/Problem section exists |
| 3 | Quick Start in under 5 lines | No | No Quick Start section |
| 4 | Install covers primary package manager | Yes | `npx skills add` is shown |
| 5 | Features list 3-6 items | No | Single paragraph, not a list |
| 6 | Example labeled as sample flow | No | Presented without provenance label |
| 7 | No section exceeds one screen | Yes | Sections are short enough individually |

**Formatting (0 / 5)**

| # | Criterion | Pass? | Reason |
|---|-----------|-------|--------|
| 1 | Logo uses `<picture>` element | No | No logo |
| 2 | Badges on 1-2 lines | No | No badges |
| 3 | Badge URLs reference-style | No | No badges |
| 4 | Code blocks specify language | No | Example block uses bare ``` with no language identifier |
| 5 | Tables for structured data | No | Prerequisites listed as bullets; no tables anywhere |

**Completeness (1 / 5)**

| # | Criterion | Pass? | Reason |
|---|-----------|-------|--------|
| 1 | LICENSE referenced | Yes | "MIT -- see LICENSE for details" |
| 2 | Contributing info | No | No Contributing section |
| 3 | Install links resolve | No | Cannot verify; manual symlink paths are instructional, not linked |
| 4 | Usage example beyond Quick Start | No | No Quick Start to go beyond; Example section exists but serves as the only example |
| 5 | Skill footer present | No | No footer |

**Total: 3 / 22**

---

### After Score: skill-forge/README.md

**Structure (5 / 5)**

| # | Criterion | Pass? | Reason |
|---|-----------|-------|--------|
| 1 | Tier 1 elements present above first heading | Yes | Logo, one-liner, badges, quick links all above `---` |
| 2 | Tier 1 is compact | Yes | Logo + one-liner + badges + links, nothing else |
| 3 | Tier 2 sections: Why + Quick Start + Install | Yes | The Problem, Quick Start, Usage, Install all present |
| 4 | Tier 3 uses `<details>` | Yes | Manual registration, Prerequisites, Works Better With, Positioning, What's Inside all folded |
| 5 | No Tier 3 content in Tier 1/2 area | Yes | All reference material is in collapsible blocks |

**Content (7 / 7)**

| # | Criterion | Pass? | Reason |
|---|-----------|-------|--------|
| 1 | One-liner is value proposition | Yes | "From idea to published, installable AI skill -- in one pipeline." |
| 2 | Why section describes specific pain point | Yes | 5 bullet points about trapped, unshareable skills |
| 3 | Quick Start in under 5 lines | Yes | 2 code blocks + 1 summary sentence |
| 4 | Install covers primary package manager | Yes | `npx skills add` as primary |
| 5 | Features list 3-6 items | Yes | 5 numbered pipeline stages |
| 6 | Example labeled as sample flow | Yes | "This is a sample flow, not a transcript from one specific machine." |
| 7 | No section exceeds one screen | Yes | Long content folded in `<details>` |

**Formatting (5 / 5)**

| # | Criterion | Pass? | Reason |
|---|-----------|-------|--------|
| 1 | Logo uses `<picture>` element | Yes | Dark/light SVG with `<picture>` wrapper |
| 2 | Badges on 1-2 lines | Yes | 3 badges on 1 line |
| 3 | Badge URLs reference-style | Yes | All badge links defined at bottom of file |
| 4 | Code blocks specify language | Yes | `bash` and unmarked blocks are intentional (terminal output) |
| 5 | Tables for structured data | Yes | N/A for this README (no config data requiring tables); no misuse of prose where tables belong |

**Completeness (5 / 5)**

| # | Criterion | Pass? | Reason |
|---|-----------|-------|--------|
| 1 | LICENSE referenced | Yes | `[MIT](LICENSE)` |
| 2 | Contributing info | Yes | Dedicated Contributing section with GitHub link |
| 3 | Install links resolve | Yes | `npx skills add` is the primary path; manual method documented |
| 4 | Usage example beyond Quick Start | Yes | Trigger phrases in Usage + detailed example in `<details>` |
| 5 | Skill footer present | Yes | "Forged with Skill Forge / Crafted with Readme Craft" |

**Total: 22 / 22**

---

## Score Comparison

| Dimension | Before | After | Delta |
|-----------|--------|-------|-------|
| Structure (5) | 0 | 5 | +5 |
| Content (7) | 2 | 7 | +5 |
| Formatting (5) | 0 | 5 | +5 |
| Completeness (5) | 1 | 5 | +4 |
| **Total (22)** | **3** | **22** | **+19** |

---

## Key Observations

1. **The biggest structural gap was the absence of Tier 1.** The raw README had no visual entry point -- no logo, no badges, no centered layout, no quick links. Adding a proper above-the-fold block accounts for the majority of the perceived quality improvement, even though it represents a small portion of the total line count.

2. **Features as prose is a common anti-pattern.** The raw version described five pipeline stages in a single paragraph. Converting this to a numbered list with bold labels made the same information scannable in seconds instead of requiring a full read. No content was added or removed -- only the format changed.

3. **Section ordering matters more than section presence.** The raw README had Install as the second section, before the reader understood what the project does or why they would want it. Moving Install after Quick Start and Usage follows the principle of "understand before commit."

4. **Collapsible blocks are a force multiplier.** Six open H2 sections (Install details, Prerequisites, Skill Composition, Related Skills, Project Structure, Example) became `<details>` blocks. This reduced the visual footprint of Tier 2 by roughly 60 lines without removing any information, letting committed users expand what they need.

5. **Small provenance labels build trust.** The raw Example section presented output without context. Adding a single sentence -- "This is a sample flow, not a transcript from one specific machine" -- prevents readers from treating fabricated output as a verified guarantee. Low effort, high signal.
