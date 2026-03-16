# Quality Checklist

Run this checklist before delivering any README. Report failures to the user.

**Total: 35 checks** across 5 dimensions.

## Structure (5)

- [ ] Tier 1 elements are present and above the first `---` or `## ` heading
- [ ] Tier 1 is compact (~250px height; additional brief elements are fine as long as they don't break compactness)
- [ ] Tier 2 sections exist: at minimum "Why" (or "The Problem") + "Quick Start" (or "Usage") + "Install"
- [ ] Tier 3 reference sections use `<details>` collapsible blocks
- [ ] No Tier 3 content is placed in the Tier 1 or Tier 2 area

## Content (10)

- [ ] One-liner is a value proposition, not a technical description
- [ ] "Why" section describes a specific pain point, not generic motivation
- [ ] Quick Start shows a working example in under 5 lines
- [ ] Install commands cover the primary package manager for the ecosystem
- [ ] Features list is written as user-facing capabilities ("detects leaked API keys"), not internal mechanisms ("runs regex scan on staged files"). 3-6 items for focused projects, 7-10 for feature-rich projects. Most innovative capabilities listed first
- [ ] Features comprehensively cover the project's capability surface — no major capability silently omitted
- [ ] How It Works / internal mechanism details are in Tier 3 (collapsible), not in Tier 2 Features. **Dedup**: if this check and the Features-language check (#5 above) both flag the same section for the same root cause, report them as one issue, not two
- [ ] Example sections are labeled as sample flows unless they come from a verified run
- [ ] No section exceeds one screen of content without folding or linking
- [ ] If the README is too long for one file, deep reference material is split to `docs/` or separate markdown files with relative links

## Formatting (10)

- [ ] Logo uses `<picture>` element (if logo exists)
- [ ] Generated wordmarks read as one dominant header line; avoid stacking the project name twice unless the user asks for it
- [ ] Showcase image (if applicable) is placed between Tier 1 and the first Tier 2 heading
- [ ] Badges are on 1-2 lines, max 6 badges
- [ ] Badge URLs use reference-style links at bottom of file
- [ ] Code blocks specify the language for syntax highlighting
- [ ] Any callouts are genuinely necessary, not decorative formatting
- [ ] No broken internal links (anchor links match actual heading slugs)
- [ ] Tables are used for structured data (config options, prerequisites)
- [ ] Mermaid / math / footnotes are used only when they communicate faster than prose

## User Perspective (5)

- [ ] **Self-selection** — A reader can tell within 10 seconds whether they are the target user. Look for a qualifying statement: "If [your situation], this is for you." The Problem section or one-liner should let visitors self-select in or out, not just describe an abstract pain point
- [ ] **When to reach for it** — README explains what situation, workflow stage, or trigger should make a reader think of this project. If there's a timing constraint ("use after X, not during Y"), it's stated explicitly
- [ ] **Audience segmentation** — If multiple user segments exist (e.g., new users vs power users, different use cases), key sections address them distinctly rather than blending into one generic narrative
- [ ] **Not-for boundary** — README clarifies what the project is NOT for, who should look elsewhere, or what problems it deliberately does not solve. Implicit signals count: a "When to Use" table with explicit "No" rows, a Positioning section with "does not" statements (even if collapsed), or a one-liner that inherently excludes non-target users. Only flag when none of these exist
- [ ] **30-second test** — A first-time visitor can determine within 30 seconds: (1) am I the target user, (2) does this solve my current problem, (3) what do I do next

## Completeness (5)

- [ ] LICENSE file exists and is referenced
- [ ] Contributing info exists (inline or linked CONTRIBUTING.md)
- [ ] Install, docs, and release links resolve or are clearly marked as pending
- [ ] At least one usage example beyond Quick Start
- [ ] Skill footer is present: `Crafted with [Readme Craft](...)` (prepend `Forged with [Skill Forge](...) ·` if generated through skill-forge's pipeline)
