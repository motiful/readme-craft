---
name: readme-craft
description: Generate and improve README files using a 3-tier layout strategy, GitHub-native formatting patterns, badge guidance, and a state-driven workflow. Use when the user says "write a README", "generate a README", "create a README", "improve this README", "review my README", "make my README better", "add badges", or "fix my README layout".
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

## Workflow

### Step 0: Dependency Check

Before running any step, verify the logo generation pipeline is available:

1. Check if `node` is available: `node --version` (requires Node.js 18+)
2. Check if dependencies are installed: look for `node_modules/` in the readme-craft skill directory (`${CLAUDE_SKILL_DIR}`)
3. If `node_modules/` is missing, run `npm install` in the skill directory

Node.js not available → error: logo generation requires Node.js 18+. Install Node.js and retry.

### Step 1: Scan Project

Scan the project to understand current state:

- Check for existing README
- Check for existing logo files (`logo-light.svg`, `logo-dark.svg`, `logo.svg`, `logo.png`)
- Read `package.json`, `Cargo.toml`, `pyproject.toml`, `go.mod`, `SKILL.md` frontmatter, or equivalent for name, version, description, license, dependencies
- Read existing docs (`CONTRIBUTING.md`, `CHANGELOG.md`, `LICENSE`) if present
- Read the entry point and key source files to understand what the project does
- Read CI config (`.github/workflows/`, `.gitlab-ci.yml`) to determine build/test commands
- List directory structure (top 2 levels)

Record findings as project state: `{has_readme, has_logo, has_codebase, has_skill_md, ...}`

### Step 2: Gather Information

- `has_codebase` → derive name, description, features, install commands from code
  - Derive the one-liner from package description + source code understanding
  - Derive features from exports, CLI commands, API surface, or SKILL.md capabilities
  - Derive install commands from package manager config or skill registration patterns
  - Derive quick-start from examples/ directory, tests, main entry point, or install command. For general projects: install command + minimal code snippet or one CLI invocation. For skill projects (`has_skill_md`): list distinct operations from SKILL.md workflow modes — one canonical trigger phrase + outcome per operation. Phrasing variations of the same operation go in Usage, not Quick Start
- `!has_codebase` → ask user for: project name, one-liner, key features, license
- Either way: ask up to 4 targeted questions only when the scan cannot safely decide:
  - should social proof appear in the README
  - should deep content move to `docs/`
  - should a diagram be added
  - should an existing voice or visual style be preserved strictly

### Step 3: README Content

- `has_readme` AND user said "start fresh" or "from scratch" → discard existing README, fall through to `!has_readme` path below. Carry forward any facts gathered from the old README into template filling.
- `has_readme` → evaluate existing README against 3-Tier Layout Strategy + Quality Checklist.
  Produce improvement plan as a numbered list (what is wrong, what to do, where it applies).
  For skill projects (`has_skill_md`): also check that Quick Start shows distinct operations (not just one trigger phrase, not phrasing variations). For general projects: check that Quick Start is a runnable example, not a prose description.
  Ask the user to confirm the plan (or apply immediately if user said "just fix it").
  Apply changes, preserving the user's existing content and voice. Refer to Tone & Voice guidelines as suggestions — do not override the author's style unless they explicitly ask for a tone change. Do NOT rewrite sections that are already good.
- `!has_readme` → select template:
  - General OSS project → `assets/universal-readme.md`. Skill-specific sections (trigger phrases, `npx skills add`, "Works Better With") do not apply — skip or omit them.
  - AI agent skill (has SKILL.md) → `assets/skill-readme.md`. Populate Quick Start with distinct operations from SKILL.md modes, one per line

### Step 4: Logo

- `has_logo` → use existing logo with `<picture>` element for dark/light mode (see Dark/Light Mode Logo below)
- `!has_logo` → generate 5 candidates via `scripts/generate-logo.mjs`:
  1. Run `node scripts/generate-logo.mjs --candidates 5 --name "<project>" --out-dir <tmpdir>/logo-candidates/`
  2. Present absolute file paths to user for preview
  3. Wait for user to pick one (or ask for more candidates / a specific preset)
  4. Copy selected SVG to `logo-light.svg` and generate dark variant
  5. If the generated mark already spells the project name clearly, do not stack a second `<h1>` underneath it

For preset selection rules, see `references/logo-generation.md`. For a visual gallery of all presets, see `docs/logo-gallery.md`.

### Step 5: Formatting & Badges

- Apply the 3-Tier Layout Strategy (see below)
- Apply GitHub-Native Formatting Decisions (see below)
- Select badges based on ecosystem (see Badge Selection below)
- Apply Tone & Voice guidelines (see below)

### Step 6: Quality Check

Two passes with different mindsets:

**Pass 1: Structural checklist**
1. Run the Quality Checklist (`references/quality-checklist.md`) — dimensions 1-5
2. Report failures to the user
3. Fix failures
4. Re-run to confirm all checks pass

**Pass 2: Reader Lens**
After the structural checklist passes, re-read the entire README as a stranger who found this project from a search result. The structural checklist catches format problems; the Reader Lens catches comprehension problems — jargon that blocks understanding, features that describe internals instead of outcomes, unique value buried below table-stakes.

Run the Reader Lens checks (dimension 6 in the Quality Checklist). These checks require a mindset shift: stop thinking about whether elements are present and start thinking about whether they *land*.

### Step 7: Deliver

1. Add the skill footer: `Crafted with [Readme Craft](https://github.com/motiful/readme-craft)`. If the README was also generated through skill-forge's pipeline, prepend `Forged with [Skill Forge](https://github.com/motiful/skill-forge) ·` before the readme-craft credit.
2. Remove any sections the user explicitly says are not needed.
3. Present final README.

---

## What a README Is — and Is Not

A README is a storefront, not a documentation site. In the Diátaxis framework (tutorials, how-to guides, reference, explanation), a README does not belong to any single type. It borrows elements from several:

- **Explanation** → Why / The Problem
- **How-to** → Quick Start, Install, Usage
- **Reference** → Tier 3 collapsibles

But a README has a mission that none of the four types cover: **convince**. The Features section exists to sell — to make a reader believe this project is worth their time in the fewest possible words. Features answer "what do I get?", not "how does it work internally?" or "why was it designed this way?"

The structural principle behind the 3-tier system is **progressive disclosure**: reveal only what each visitor needs at their current level of commitment. Tier 1 is for the uncommitted (pitch), Tier 2 is for the evaluating (proof), Tier 3 is for the committed (reference). Every placement decision — "does this belong above the fold or in a collapsible?" — is a progressive disclosure decision.

| Concept | Question it answers | Example |
|---------|-------------------|---------|
| **Features / Highlights** | "What do I get?" | "Scans your codebase and auto-generates a README" |
| **How It Works** | "How does it run internally?" | "Config → Gather → Create → Validate → Publish" |
| **Why / The Problem** | "Why do I need this?" | "Your skill is trapped in one project and can't be shared" |

When Features and How It Works are mixed together, the README writes out a pipeline instead of selling capabilities.

---

## The 3-Tier Layout Strategy

This is the primary differentiator of readme-craft. Every README must organize content into three tiers based on how visitors consume information.

This strategy is optimized for **GitHub** README rendering. Elements like `<picture>`, `<details>`, and similar GitHub-specific patterns may not render on other platforms (GitLab, npm, crates.io). Adapt as needed.

### Tier 1: Above the Fold (~250px)

The first screen a visitor sees. This is the 3-second pitch. Visitors who are not interested will leave after this.

**Baseline elements (in order):**

1. **Logo** — centered, 80-120px height. Use existing if found, generate if not (see Step 4). Use `<picture>` for dark/light mode (see below).
2. **Project name** — `<h1>`, centered.
3. **One-liner** — a value proposition, not a technical description. Answer "why should I care?", not "what technology is this?" Example: ✓ "Stop writing validation logic by hand" vs ✗ "A TypeScript library for form validation."
4. **Badges** — up to 6, on 1-2 lines. Trust signals: license, version, build status, downloads. Fewer is fine when fewer apply.
5. **Quick action links** — inline links to the most relevant next actions (for example Quick Start, Usage, Install, Docs, Demo, Report Bug).

Additional brief elements (a platform compatibility line, a short tagline, a small demo gif) are fine as long as Tier 1 stays within ~250px and reads as a single visual block.

**Rules:**
- The constraint is **height and density**, not element count. Stay within ~250px.
- No walls of text above the fold.
- Logo must be compact (not a full-width banner).
- The one-liner must answer "why should I care?" not "what technology is this?"
- No installation instructions in Tier 1.

**Markdown pattern (standard):**

```html
<div align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="logo-dark.svg">
    <source media="(prefers-color-scheme: light)" srcset="logo-light.svg">
    <img alt="project-name" src="logo-light.svg" width="120">
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

**Alternate pattern (wordmark logos):**

When a wide wordmark (400-500px) serves as both logo and project name, the standard `<p>` inside `<div>` can feel cramped. Use a `>` blockquote after the closing `</div>` instead — it adds visual separation between the wordmark and the one-liner.

```html
<div align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="logo-dark.svg">
    <source media="(prefers-color-scheme: light)" srcset="logo-light.svg">
    <img alt="project-name" src="logo-light.svg" width="440">
  </picture>
</div>

<!-- badges and quick links divs here -->

> One-liner value proposition
```

Use the standard `<p>` pattern by default. Switch to blockquote only when the wordmark is wide enough to make the centered `<p>` feel visually crowded.

### Tier 2: Scan Quickly

The next 2-3 screens. A visitor who passed Tier 1 wants to evaluate whether this project is worth adopting.

**Showcase Image** — For tools that produce visual transformations, place a before/after or hero image immediately after Tier 1's `---` separator, before the first `##` heading (or as the first element of Tier 2). This is a "show don't tell" proof that's more convincing than any text description. Skip ONLY when: project has no visual transformation (CLI tools, libraries, pure APIs).

**Required sections (in order):**

1. **Why / The Problem** — 2-4 sentences. What pain point does this solve? A strong Problem section lets readers self-qualify: "If [your situation], you need this." If the project serves multiple user segments (e.g., "haven't started yet" vs "already deployed"), address each briefly rather than blending into one generic statement.
2. **Features / Highlights** — bullet list, benefit-oriented. Each item answers "what does the user get?", not "how does it work internally?" Write in benefit-oriented language ("scans your codebase and auto-generates a README"), not mechanism-oriented language ("uses AST parsing to extract function signatures"). If you find yourself describing pipeline stages or internal steps, move that to How It Works in Tier 3.
   - **Scope:** 3-6 items for focused projects; scale to 7-10 for feature-rich projects. The goal is comprehensive coverage — do not cherry-pick a few capabilities and silently drop the rest. When the project has many features, group related capabilities into single items or use sub-descriptions rather than omitting.
   - **Ordering:** Most important and most innovative capabilities first. Lead with what makes this project unique, not with table-stakes features every similar tool has.
   - **Comprehensiveness check:** Read through all source files, reference docs, and config to inventory every user-facing capability. Then confirm every major capability appears in the Features list — either as its own item or clearly covered within another item.
3. **When to Use** — include for tools and skills. Skip ONLY when: the Usage section already covers activation context. Clarify what situation should prompt the reader to reach for this project. If there's a specific activation model ("use after X, not during Y") or a "not for" boundary, state it here. Can be combined into Usage if short.
4. **Quick Start** — the fastest path to a working example. 1-3 commands + minimal code (5-15 lines).
5. **Install** — full installation instructions. Multiple package managers if applicable. Use `<details>` for alternative methods.
6. **Usage** — basic example + 1-2 common use cases. Use `<details>` for advanced examples.

**Rules:**
- Each section must fit on one screen or less.
- Use code blocks aggressively — they scan faster than prose.
- Bullet lists over paragraphs.
- If a section exceeds one screen, move detail into a linked doc or collapsible block.

For AI agent skills, "Usage" (trigger phrases) may come before "Install" to prioritize understanding over commitment. The skill template reflects this ordering.

### Tier 3: Reference (Collapsible)

Reference material for committed users. Wrap each section in `<details><summary>`.

**Sections (include if the project has content for this section. Omit only when no content exists — not because it "seems unnecessary"):**

- **How It Works** — internal mechanism, pipeline stages, architecture, data flow. This is where workflow diagrams, step-by-step internal logic, and technical details belong. Features (Tier 2) tells the user what they get; this section explains how it happens under the hood.
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
  <source media="(prefers-color-scheme: dark)" srcset="logo-dark.svg">
  <source media="(prefers-color-scheme: light)" srcset="logo-light.svg">
  <img alt="project-name" src="logo-light.svg" width="120">
</picture>
```

**Rules:**
- Prefer SVG for logos (scales cleanly, small file size).
- The `<img>` fallback uses the light variant (GitHub default theme).
- If the project only has one logo, use the same path for both `srcset` values and the `src` — still include the `<picture>` wrapper so a dark variant can be added later without restructuring.
- Width 80-120px for inline logos (icon/symbol marks). Wordmark logos (text-rendered SVGs like figlet/cfonts output) may use 400-500px width since they serve as both logo and project name. Never use full-width banners in Tier 1.
- If no logo exists yet, generate one (see Step 4). Every delivered README includes a logo.

**Fallback wordmarks:**

- If the project has no logo, generate logo candidates using `--candidates N` mode instead of silently picking one preset.
- Present absolute file paths to the user for preview. Let them choose.
- Use `--random` mode only when the user explicitly says "surprise me" or "just pick one".
- For a visual gallery of all available presets and palettes, see `docs/logo-gallery.md`.
- Prefer visually single-line wordmarks for README headers. If a preset reads like stacked block art or creates a double-title feel, switch to an inline treatment.
- If the generated wordmark already renders the project name clearly, omit the duplicated `<h1>` by default unless the user explicitly wants both.
- For preset selection rules and examples, see `references/logo-generation.md` and `references/logo-examples.md`.

---

## GitHub-Native Formatting Decisions

Use GitHub-specific formatting when it improves comprehension, not because it exists.

For syntax patterns and deeper rules, see `references/github-formatting.md`.

**Default patterns:**

- Relative links for `docs/`, sibling markdown files, and split reference material
- `<details><summary>` for Tier 3 or overflow content
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

When improving an existing README, these guidelines are recommendations, not overrides. Preserve the author's existing voice unless they explicitly ask for a tone change.

---

## Example Provenance

When including an Example section in a README:

- If the example comes from a real run, keep paths, commands, and outputs specific.
- If the example is a sample flow, say so explicitly.
- Never present unverified repo URLs, release pages, docs links, or install commands as if they already exist.

---

## Quality Checklist

Run the checklist in `references/quality-checklist.md` before delivering any README. Report failures to the user.

The checklist covers 6 dimensions: Structure (5), Content (12), Formatting (10), User Perspective (5), Completeness (5), Reader Lens (4). Dimensions 1-5 are structural; dimension 6 requires a mindset shift to first-time reader perspective.

---

## References

This skill uses the following template and analysis files:

| File | Purpose |
|------|---------|
| `assets/universal-readme.md` | Base template for any OSS project. Contains all three tiers with placeholder markup. |
| `assets/skill-readme.md` | Extended template for AI agent skills. Adds Agent Skills badge, trigger phrases, `npx skills add` install, and "What's Inside" section. |
| `references/badges.md` | Copy-paste badge patterns for shields.io, organized by category (license, version, CI, downloads, coverage, platform, Agent Skills). |
| `references/github-formatting.md` | GitHub-native formatting patterns, overflow strategy, and rules for diagrams, footnotes, math, task lists, and social proof. |
| `references/logo-generation.md` | README fallback logo guidance: positioning, preset selection, runtime requirements, and when to use the local wordmark generator. |
| `references/logo-examples.md` | Short example mappings from project feel to recommended logo presets. |
| `references/quality-checklist.md` | 41-point quality checklist across 6 dimensions: structure, content, formatting, user perspective, completeness, reader lens. |
| `references/gradient-palettes.md` | 2026-curated gradient palette reference with 45 named gradients for logo and badge color selection. |
| `references/comparison-screenshots.md` | Before/after comparison PNG generation via Playwright for README case studies. |
| `docs/logo-gallery.md` | Visual gallery of all logo presets with rendered SVG previews, palette table, and selection guidance. |

When generating a README, always start from the appropriate asset template file. Read it, fill its placeholders, then adjust sections based on the project's needs.
