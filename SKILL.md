---
name: readme-craft
description: Generate and improve README files using a 3-tier layout strategy, GitHub-native formatting patterns, badge guidance, and interactive three-mode workflows.
license: MIT
metadata:
  author: motiful
  version: "1.0"
---

# readme-craft

A GitHub-native, layout-first README generation and improvement skill for AI agents. Produces structured, scannable READMEs with a 3-tier information hierarchy designed for how GitHub READMEs are actually consumed.

This skill is a standalone utility. It does NOT depend on skill-forge or any other skill. Higher-level tools (like skill-forge) may optionally delegate to readme-craft for layout and badge decisions.

---

## When to Use

Activate this skill when the user says any of:

- "Write a README for this project"
- "Generate a README"
- "Create a README from scratch"
- "Improve this README"
- "Review my README"
- "Make my README better"
- "Add badges to my README"
- "Fix my README layout"
- Any request involving README creation, evaluation, or improvement

---

## Three Operation Modes

Determine the mode from the user's request and available context.

### Mode A: Create from Scratch

**Trigger:** User describes a project that does not yet exist as code, or explicitly asks to draft a README without scanning files.

**Steps:**

1. Ask the user for (or extract from conversation):
   - Project name
   - One-line description (value proposition, not technical description)
   - Primary language / framework
   - Key features (3-6)
   - License
2. Ask up to 4 focused presentation questions when they materially affect the output:
   - logo now or later
   - social proof badges or widgets
   - keep everything in README vs split deep reference content to `docs/`
   - diagrams / math / footnotes only if the project genuinely benefits
3. Select the appropriate template:
   - `templates/universal-readme.md` for general OSS projects
   - `templates/skill-readme.md` for AI agent skills
4. Fill every `<placeholder>` in the template using the collected information.
5. Apply the 3-Tier Layout Strategy (see below).
6. Apply GitHub-Native Formatting Decisions (see below).
7. Select badges using the Badge Selection guidance (see below).
8. Include the dark/light mode logo stub if the project has a logo (see below).
9. Remove any sections the user explicitly says are not needed.
10. Apply Tone & Voice guidelines (see below).
11. Run the Quality Checklist before delivering.

### Mode B: Create from Codebase

**Trigger:** User asks to generate a README and an existing codebase is available to scan.

**Steps:**

1. Scan the project to gather facts:
   - Read `package.json`, `Cargo.toml`, `pyproject.toml`, `go.mod`, `SKILL.md` frontmatter, or equivalent for name, version, description, license, dependencies.
   - Read existing docs (`CONTRIBUTING.md`, `CHANGELOG.md`, `LICENSE`) if present.
   - Read the entry point and key source files to understand what the project does.
   - List the directory structure (top 2 levels).
   - Check for existing CI config (`.github/workflows/`, `.gitlab-ci.yml`) to determine build/test commands.
   - Check for existing README — if found, switch to Mode C (Improve) unless user explicitly says "start fresh." Carry forward all data gathered in prior steps into Mode C's evaluation.
2. Synthesize findings into the information needed for template filling:
   - Derive the one-liner from package description + source code understanding.
   - Derive features from exports, CLI commands, API surface, or SKILL.md capabilities.
   - Derive install commands from package manager config or skill registration patterns.
   - Derive quick-start from examples/ directory, tests, main entry point, or install command + trigger phrase for skills.
3. Ask up to 4 targeted questions only when the scan cannot safely decide:
   - should social proof appear in the README
   - should deep content move to `docs/`
   - should a diagram be added
   - should an existing voice or visual style be preserved strictly
4. Select and fill the appropriate template:
   - `templates/universal-readme.md` for general OSS projects
   - `templates/skill-readme.md` for AI agent skills (projects with a SKILL.md)
5. Apply the 3-Tier Layout Strategy.
6. Apply GitHub-Native Formatting Decisions (see below).
7. Select badges based on detected ecosystem.
8. Apply Tone & Voice guidelines (see below).
9. Run the Quality Checklist before delivering.

### Mode C: Improve Existing README

**Trigger:** User says "improve", "review", "fix", or "make better" — or Mode B detected an existing README.

**Steps:**

1. Read the existing README in full.
2. Evaluate against the 3-Tier Layout Strategy:
   - Is Tier 1 (above-fold) present and compact (~250px)?
   - Is Tier 2 (scan) organized with code blocks and bullets?
   - Is Tier 3 (reference) collapsible or linked?
3. Evaluate GitHub-native formatting opportunities:
   - Should `<details>` be used or reduced?
   - Should content overflow move to `docs/` with relative links?
   - Would Mermaid / math / footnotes help, or would they just add noise?
   - Are social proof elements missing, excessive, or unverified?
4. Evaluate against the Quality Checklist (see below).
5. Produce a concrete improvement plan as a numbered list. Each item must state:
   - What is wrong or missing
   - What to do about it
   - Where in the file the change applies
6. Ask the user to confirm the plan (or apply immediately if user said "just fix it").
7. Apply changes, preserving the user's existing content and voice. Refer to Tone & Voice guidelines as suggestions — do not override the author's style unless they explicitly ask for a tone change. Do NOT rewrite sections that are already good.
8. Re-run the Quality Checklist on the result.

---

## The 3-Tier Layout Strategy

This is the primary differentiator of readme-craft. Every README must organize content into three tiers based on how visitors consume information.

> [!NOTE]
> This strategy is optimized for **GitHub** README rendering. Elements like `<picture>`, `<details>`, and GitHub Alerts may not render on other platforms (GitLab, npm, crates.io). Adapt as needed.

### Tier 1: Above the Fold (~250px)

The first screen a visitor sees. This is the 3-second pitch. Visitors who are not interested will leave after this.

**Required elements (in order):**

1. **Logo** (if exists) — centered, 80-120px height. Use `<picture>` for dark/light mode (see below). Omit if the project has no logo — do not use placeholders.
2. **Project name** — `<h1>`, centered.
3. **One-liner** — a value proposition, not a technical description. Answer "why should I care?", not "what technology is this?" Example: ✓ "Stop writing validation logic by hand" vs ✗ "A TypeScript library for form validation."
4. **Badges** — up to 6, on 1-2 lines. Trust signals: license, version, build status, downloads. Fewer is fine when fewer apply.
5. **Quick action links** — inline links to the most relevant next actions (for example Quick Start, Usage, Install, Docs, Demo, Report Bug).

**Rules:**
- No walls of text above the fold.
- Logo must be compact (not a full-width banner).
- The one-liner must answer "why should I care?" not "what technology is this?"
- No installation instructions in Tier 1.

**Markdown pattern:**

```html
<div align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="assets/logo-dark.svg">
    <source media="(prefers-color-scheme: light)" srcset="assets/logo-light.svg">
    <img alt="project-name" src="assets/logo-light.svg" width="120">
  </picture>

  <h1>project-name</h1>
  <p>One-liner value proposition</p>
</div>

<div align="center">

[![License: MIT][license-shield]][license-url]
[![Version][version-shield]][version-url]
[![Build][build-shield]][build-url]

</div>

<div align="center">
  <a href="#quick-start">Quick Start</a> &middot;
  <a href="https://docs-url">Docs</a> &middot;
  <a href="https://demo-url">Demo</a>
</div>
```

### Tier 2: Scan Quickly

The next 2-3 screens. A visitor who passed Tier 1 wants to evaluate whether this project is worth adopting.

**Required sections (in order):**

1. **Why / The Problem** — 2-4 sentences. What pain point does this solve?
2. **Features** — bullet list, 3-6 items. Brief, scannable.
3. **Quick Start** — the fastest path to a working example. 1-3 commands + minimal code (5-15 lines).
4. **Install** — full installation instructions. Multiple package managers if applicable. Use `<details>` for alternative methods.
5. **Usage** — basic example + 1-2 common use cases. Use `<details>` for advanced examples.

**Rules:**
- Each section must fit on one screen or less.
- Use code blocks aggressively — they scan faster than prose.
- Bullet lists over paragraphs.
- If a section exceeds one screen, move detail into a linked doc or collapsible block.
- Use GitHub Alerts (`> [!NOTE]`, `> [!WARNING]`) for important callouts.

> [!NOTE]
> For AI agent skills, "Usage" (trigger phrases) may come before "Install" to prioritize understanding over commitment. The skill template reflects this ordering.

### Tier 3: Reference (Collapsible)

Reference material for committed users. Wrap each section in `<details><summary>`.

**Optional sections (include only what's relevant):**

- **Prerequisites** — runtime versions, system dependencies. Table format.
- **Configuration** — config file options, environment variables. Table format.
- **API Reference** — brief overview + link to full docs.
- **Project Structure** — ASCII tree, top 2-3 levels with inline comments.
- **Development** — clone, install, test, lint, build commands.
- **Roadmap** — checkbox list of planned features.
- **Contributing** — inline or link to CONTRIBUTING.md.
- **Changelog** — link to CHANGELOG.md.
- **Acknowledgments** — credits.
- **License** — short text + link to LICENSE file.

**Rules:**
- Always use `<details><summary>` for Tier 3 sections (except License and Contributing, which may be open).
- Link to separate files for content > 1 screen.
- Contributing may be inline or linked. Prefer a separate `CONTRIBUTING.md` for mature or public repos.
- Add a back-to-top link for READMEs exceeding 300 lines.
- Use reference-style link definitions at the bottom of the file for badge URLs.

---

## Badge Selection

Choose badges based on the project's ecosystem and maturity. Up to 6 badges; fewer is fine when fewer apply.

**Priority order (pick from top, stop at 6):**

| Priority | Badge | When to Include |
|----------|-------|-----------------|
| 1 | License | Always |
| 2 | Version / Release | Always (npm, PyPI, crates.io, or GitHub release) |
| 3 | Build / CI status | If CI is configured |
| 4 | Downloads | If published to a package registry |
| 5 | Coverage | If coverage reporting is set up |
| 6 | Platform / ecosystem | If relevant (e.g., Agent Skills compatible, Node.js version) |

**Badge sources:**
- shields.io — the standard for most badges
- GitHub Actions badge URLs — for CI status
- Custom badges — only if shields.io does not cover the case

**Format:** Use reference-style links at the bottom of the README to keep the source markdown clean.

```markdown
[![License: MIT][license-shield]][license-url]

<!-- at bottom of file -->
[license-shield]: https://img.shields.io/github/license/org/repo.svg
[license-url]: https://github.com/org/repo/blob/main/LICENSE
```

For copy-paste badge patterns organized by ecosystem, see `references/badges.md`.

---

## Dark/Light Mode Logo

GitHub supports theme-aware images via the `<picture>` element. Always include this pattern when the project has a logo.

**The pattern:**

```html
<picture>
  <source media="(prefers-color-scheme: dark)" srcset="assets/logo-dark.svg">
  <source media="(prefers-color-scheme: light)" srcset="assets/logo-light.svg">
  <img alt="project-name" src="assets/logo-light.svg" width="120">
</picture>
```

**Rules:**
- Prefer SVG for logos (scales cleanly, small file size).
- The `<img>` fallback uses the light variant (GitHub default theme).
- If the project only has one logo, use the same path for both `srcset` values and the `src` — still include the `<picture>` wrapper so a dark variant can be added later without restructuring.
- Width 80-120px for inline logos. Never use full-width banners in Tier 1.
- If no logo exists, omit the `<picture>` block entirely. Do NOT use a placeholder image.

---

## GitHub-Native Formatting Decisions

Use GitHub-specific formatting when it improves comprehension, not because it exists.

For syntax patterns and deeper rules, see `references/github-formatting.md`.

**Default patterns:**

- Relative links for `docs/`, sibling markdown files, and split reference material
- `<details><summary>` for Tier 3 or overflow content
- GitHub Alerts for high-value notes, tips, and warnings
- Tables for structured data
- Minimal HTML where Markdown is not enough

**Optional patterns:**

- Mermaid diagrams for architecture, flow, sequence, timeline, or dependency relationships
- Task lists for roadmap or status
- Footnotes for citations and side notes
- Math expressions for technical projects that genuinely need formulas
- Social proof elements such as contributor widgets or star counts

**Rules:**

- Do not hide the core onboarding path inside collapsed sections.
- Use relative links when splitting a long README into `docs/` or separate markdown files.
- Add diagrams only when they explain faster than prose.
- Add social proof only when the repo is public, the numbers are real, and the user wants it.
- Prefer clarity over visual novelty.

---

## Tone & Voice

When writing README content, follow these guidelines:

- Address the reader as **"you"** — not "the user" or "one."
- Refer to the software in **third person** — "readme-craft generates..." not "we generate..."
- **Value proposition over technical description** — lead with what the reader gains, not what the software is.
- **Professional but direct** — no exclamation marks, no emoji, no hype words ("revolutionary", "blazing fast").
- **Concise** — if a sentence doesn't add information, cut it.

> [!NOTE]
> In Mode C (Improve), these guidelines are recommendations, not overrides. Preserve the author's existing voice unless they explicitly ask for a tone change.

---

## Example Provenance

When including an Example section in a README:

- If the example comes from a real run, keep paths, commands, and outputs specific.
- If the example is a sample flow, say so explicitly.
- Never present unverified repo URLs, release pages, docs links, or install commands as if they already exist.

---

## Quality Checklist

Run this checklist before delivering any README. Report failures to the user.

### Structure

- [ ] Tier 1 elements are present and above the first `---` or `## ` heading
- [ ] Tier 1 is compact (logo + name + one-liner + badges + links, no more)
- [ ] Tier 2 sections exist: at minimum "Why" (or "The Problem") + "Quick Start" (or "Usage") + "Install"
- [ ] Tier 3 reference sections use `<details>` collapsible blocks
- [ ] No Tier 3 content is placed in the Tier 1 or Tier 2 area

### Content

- [ ] One-liner is a value proposition, not a technical description
- [ ] "Why" section describes a specific pain point, not generic motivation
- [ ] Quick Start shows a working example in under 5 lines
- [ ] Install commands cover the primary package manager for the ecosystem
- [ ] Features list (or "What <name> Does" section) has 3-6 items (fewer is acceptable for focused projects)
- [ ] Example sections are labeled as sample flows unless they come from a verified run
- [ ] No section exceeds one screen of content without folding or linking
- [ ] If the README is too long for one file, deep reference material is split to `docs/` or separate markdown files with relative links

### Formatting

- [ ] Logo uses `<picture>` element (if logo exists)
- [ ] Badges are on 1-2 lines, max 6 badges
- [ ] Badge URLs use reference-style links at bottom of file
- [ ] Code blocks specify the language for syntax highlighting
- [ ] GitHub Alerts (`> [!NOTE]`, etc.) are used instead of bold/italic for callouts
- [ ] No broken internal links (anchor links match actual heading slugs)
- [ ] Tables are used for structured data (config options, prerequisites)
- [ ] Mermaid / math / footnotes are used only when they communicate faster than prose

### Completeness

- [ ] LICENSE file exists and is referenced
- [ ] Contributing info exists (inline or linked CONTRIBUTING.md)
- [ ] Install, docs, and release links resolve or are clearly marked as pending
- [ ] At least one usage example beyond Quick Start

---

## References

This skill uses the following template and analysis files:

| File | Purpose |
|------|---------|
| `templates/universal-readme.md` | Base template for any OSS project. Contains all three tiers with placeholder markup. |
| `templates/skill-readme.md` | Extended template for AI agent skills. Adds Agent Skills badge, trigger phrases, `npx skills add` install, and "What's Inside" section. |
| `references/badges.md` | Copy-paste badge patterns for shields.io, organized by category (license, version, CI, downloads, coverage, platform, Agent Skills). |
| `references/github-formatting.md` | GitHub-native formatting patterns, overflow strategy, and rules for diagrams, footnotes, math, task lists, and social proof. |

When generating a README, always start from the appropriate template file. Read it, fill its placeholders, then adjust sections based on the project's needs.
