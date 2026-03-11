# readme-craft

Research and templates for writing high-quality README files.

## What's Here

This project analyzes community README generation tools and distills their best ideas into reusable templates with a tiered layout strategy.

### Community Skills Survey

`community-skills/` contains downloaded README generation skills from GitHub:

| Source | Type | Key Strength |
|--------|------|-------------|
| [dmccreary/claude-skills](https://github.com/dmccreary/claude-skills) | Claude SKILL.md | Comprehensive badges reference, validation scripts |
| [GLINCKER/claude-code-marketplace](https://github.com/GLINCKER/claude-code-marketplace) | Claude SKILL.md | Clean project-type detection, error handling |
| [holasoymalva/README-Generator-Toolkit](https://github.com/holasoymalva/README-Generator-Toolkit) | Cursor .mdc | 3-mode lifecycle (create/analyze/improve) |
| [othneildrew/Best-README-Template](https://github.com/othneildrew/Best-README-Template) | Markdown template | Reference-style links, collapsible TOC, 15k+ stars |

### Analysis

`analysis/` contains two reports:

- **community-skill-evaluation.md** — Quality scores and feature comparison across all 4 community tools. Key finding: no existing tool addresses layout hierarchy or information tiering.
- **readme-architecture-report.md** — Separates SkillForge-specific conventions from universal best practices. Defines the 3-tier layout strategy. Recommends a two-layer architecture where readme-craft is the universal base and skill-forge adds skill-specific opinions on top.

### Templates

`templates/` contains two README templates:

- **universal-readme.md** — For any open source project. Includes dark/light mode logo, tiered sections with collapsible details, reference-style links, GitHub Alerts, and badge placeholders.
- **skill-readme.md** — For AI agent skills (SkillForge-enhanced). Extends the universal template with Agent Skills compatibility line, trigger phrases, `npx skills add` install, "What's Inside" tree, and forge footer.

## The 3-Tier Layout Strategy

The core insight from this research: README space is limited and must be budgeted.

| Tier | What | Format | Purpose |
|------|------|--------|---------|
| **1** (above fold) | Logo, name, one-liner, badges, quick links | Compact, centered | 3-second pitch |
| **2** (scan quickly) | Problem, features, quick start, usage, install | Bullet lists, code blocks | Prove value |
| **3** (reference) | Structure, config, API, contributing, roadmap | `<details>` collapsible | Serve committed users |

## Status

Research phase complete. Templates ready for use. Not yet packaged as a Claude skill (SKILL.md).

## License

MIT
