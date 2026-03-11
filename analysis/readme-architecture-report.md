# README Architecture Report

Analysis of README conventions: what belongs to SkillForge, what is universal, and how to structure the information hierarchy.

---

## A. SkillForge-Specific vs Universal

### SkillForge-Specific Conventions

These conventions exist because skill-forge produces AI agent skills, not general software. They should stay in skill-forge's `references/` and not be pulled into the universal template.

| Convention | Why It's Skill-Specific |
|-----------|------------------------|
| Agent Skills compatibility line | Only relevant for AI agent skills |
| Trigger phrases section | Only skills have "activation phrases" |
| `npx skills add` as primary install | Only works for skill repos registered with Agent Skills |
| "What's Inside" tree (SKILL.md, references/, scripts/) | Skill-specific directory structure |
| "Forged with Skill Forge" footer | Branding for skill-forge output |
| Promise-Capability Alignment check | Validates SKILL.md claims vs README claims |
| Manual registration symlink examples | Agent platform roots (~/.claude/skills/, ~/.agents/skills/) |
| "Usage before Install" ordering | Optimized for skill discovery flow |

### Universal Best Practices

These work for any open source project and should become the core of readme-craft.

| Practice | Origin | Notes |
|----------|--------|-------|
| Value proposition first | skill-forge | Universal — the reader needs "why" before "how" |
| One-line description after title | All skills | Standard across GitHub |
| Badge section | dmccreary, othneildrew | shields.io is the standard |
| Dark/light mode logo | GitHub feature | `<picture>` element with `prefers-color-scheme` |
| Collapsible TOC | othneildrew | `<details><summary>` |
| Tiered information hierarchy | New (this analysis) | Above-fold, scan, reference |
| Problem statement | skill-forge | "The Problem" section |
| Quick-start / Getting Started | All | Every project needs this |
| Project structure tree | dmccreary, GLINCKER | ASCII tree with comments |
| Contributing guidelines | othneildrew | Standard open source section |
| License section | All | Required for open source |
| Collapsible detail sections | New (this analysis) | `<details>` for Tier 3 content |
| Back-to-top navigation | othneildrew | For long READMEs |
| Reference-style links | othneildrew | Cleaner source markdown |
| GitHub Alerts | GitHub feature | `> [!NOTE]`, `> [!WARNING]`, etc. |
| Centered logo+title | othneildrew | Clean visual hierarchy |

---

## B. Layout Competition Analysis

### The Space Budget Problem

A GitHub README renders in a viewport roughly 700px wide and ~900px tall on a standard laptop. The "above the fold" area is precious real estate. Every element competes for attention.

### What MUST Be Above the Fold (Tier 1)

The first screen a visitor sees. This is your 3-second pitch.

| Element | Purpose | Space Budget |
|---------|---------|-------------|
| Logo | Visual identity, professionalism signal | 80-120px height |
| Project name | What is this? | 1 line |
| One-liner | Why should I care? | 1-2 lines |
| Badges | Trust signals (license, build, version, downloads) | 1-2 lines |
| Quick action links | Demo / Docs / Install | 1 line |

**Total: ~250px.** This leaves ~650px for the beginning of Tier 2.

**Rules:**
- No walls of text above the fold
- Logo should be compact (not a full-width banner)
- Badges should be on 1-2 lines max (pick 4-6 most relevant)
- The one-liner should be a value proposition, not a technical description

### What Can Be Scanned Quickly (Tier 2)

The next 2-3 screens. A visitor who's interested will scroll here.

| Section | Purpose | Format |
|---------|---------|--------|
| The Problem / Why | Contextualize the value proposition | 2-4 sentences |
| What It Does / Features | Core capabilities | Bullet list or table |
| Quick Start | Get running in 30 seconds | Code block (3-5 lines) |
| Usage examples | "How do I use this?" | Code blocks with brief commentary |
| Install | Full installation instructions | Code block + brief notes |

**Rules:**
- Each section should fit in one screen or less
- Use code blocks aggressively — they scan faster than prose
- Bullet lists > paragraphs
- If a section exceeds one screen, split detail into a linked doc

### What Should Be Folded or Linked (Tier 3)

Reference material. Only read by people who are already committed.

| Section | Format | Strategy |
|---------|--------|----------|
| Project Structure | ASCII tree | `<details>` collapsible |
| API Reference | Tables/code | Link to separate doc |
| Configuration | Tables | `<details>` collapsible |
| Contributing | Steps + links | `<details>` collapsible or separate CONTRIBUTING.md |
| Changelog | List | Link to CHANGELOG.md |
| Roadmap | Checklist | `<details>` collapsible |
| Acknowledgments | List | Bottom of README |
| License | Short text + link | Bottom of README |

**Rules:**
- Use `<details><summary>` for anything that's "nice to have" but not essential
- Link to separate files for anything that's > 1 screen of content
- Contributing, Changelog, and Code of Conduct should be separate files linked from README

### Trade-off Matrix

| Approach | Pros | Cons |
|----------|------|------|
| Everything in README | One file, easy to find | Wall of text, poor scannability |
| Minimal README + docs/ | Clean, focused | Important info hidden behind clicks |
| Tiered README (our approach) | Best of both — core info visible, details accessible | Slightly more complex markdown |

### The "Xianglvedan" Principle

The user's philosophy: show core info prominently, fold details into docs. This maps directly to our tier system:

- **Tier 1:** The storefront window — attract and qualify visitors
- **Tier 2:** The product demo — prove value to interested visitors
- **Tier 3:** The reference manual — serve committed users

---

## C. Where to Persist

### Recommendation: Two-Layer Architecture

```
readme-craft/                    ← Universal README skill (standalone)
  SKILL.md                       ← Universal README generation capability
  references/
    badges.md                    ← Badge library (adapted from dmccreary)
    layout-tiers.md              ← Tier 1/2/3 layout strategy
    dark-light-patterns.md       ← Logo and image dark/light mode patterns
  templates/
    universal-readme.md          ← Template for any OSS project
    skill-readme.md              ← Template for AI agent skills

skill-forge/                     ← Skill authoring tool (existing)
  references/
    readme-quality.md            ← KEEP: Skill-specific README rules
    templates.md                 ← UPDATE: Point to readme-craft for templates
```

### What Stays in skill-forge

These items are tightly coupled to skill authoring and should not move:

1. **readme-quality.md** — Promise-Capability Alignment, "What's Inside" rules, forge footer, `npx skills add` as primary path, "Usage before Install" ordering. These are skill-forge opinions, not universal truths.

2. **templates.md README template section** — The current template is skill-specific. Keep it as the skill-forge default but reference readme-craft's templates as the underlying structure.

### What Becomes readme-craft

These items are universal and should live in the new skill:

1. **Tiered layout strategy** — Tier 1/2/3 structure, space budget analysis, collapsible patterns
2. **Badge library** — Technology, license, platform, status badges
3. **Dark/light mode patterns** — `<picture>` element patterns for GitHub theme switching
4. **Universal README template** — The template without skill-specific sections
5. **Codebase analysis workflow** — How to scan a project and generate appropriate sections
6. **README improvement workflow** — How to evaluate and improve existing READMEs
7. **Validation checklist** — Link checks, section completeness, formatting

### How They Relate

```
User says: "Generate a README for my skill"
  → skill-forge activates
  → skill-forge uses its own readme-quality.md rules
  → skill-forge uses its own templates.md for skill-specific structure
  → (optionally) skill-forge defers to readme-craft for badge generation, layout strategy

User says: "Generate a README for my project"
  → readme-craft activates directly
  → readme-craft uses universal template
  → readme-craft applies tier strategy, badge selection, etc.

User says: "Improve my README"
  → readme-craft activates
  → readme-craft evaluates against tier strategy and quality checklist
  → readme-craft suggests improvements
```

**Dependency direction:** skill-forge MAY reference readme-craft as a recommended companion skill. readme-craft MUST NOT depend on skill-forge. readme-craft is the lower-level utility; skill-forge is the higher-level orchestrator that adds skill-specific opinions on top.

### Migration Path

1. Create readme-craft as a standalone skill (this project)
2. Add a note in skill-forge's templates.md: "For universal README conventions, see readme-craft"
3. Do NOT remove anything from skill-forge — it still needs its own opinions
4. Over time, skill-forge's README generation step can optionally delegate layout/badge decisions to readme-craft

---

## Summary of Recommendations

| Decision | Recommendation |
|----------|---------------|
| Template count | 2: universal-readme.md + skill-readme.md |
| Layout strategy | 3-tier: above-fold, scan, reference |
| Collapsible sections | Yes, for Tier 3 content |
| Dark/light mode | Yes, `<picture>` pattern in templates |
| Badge library | Yes, adapted from dmccreary + extended |
| Validation | Quality checklist in SKILL.md, optional script later |
| skill-forge integration | Companion, not dependency. skill-forge keeps its own opinions. |
| Operation modes | 3: create from scratch, create from codebase, improve existing |
| GitHub Alerts | Yes, where appropriate (install warnings, breaking changes) |
| Reference-style links | Yes, in templates for cleaner source |
| Back-to-top links | Optional, recommended for README > 300 lines |
