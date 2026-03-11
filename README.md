<div align="center">

  <h1>readme-craft</h1>
  <p>Stop writing READMEs from scratch — or struggling with ones nobody reads.</p>

</div>

<div align="center">

[![License: MIT][license-shield]][license-url]
[![Version][version-shield]][version-url]
[![Agent Skills][skills-shield]][skills-url]

</div>

<div align="center">
  <a href="#the-problem">Why</a> &middot;
  <a href="#usage">Usage</a> &middot;
  <a href="#install">Install</a>
</div>

<br>

> [!NOTE]
> [Agent Skills](https://agentskills.io) compatible — works with Claude Code, Codex, Cursor, Windsurf, GitHub Copilot, and other Agent Skills adopters.

---

## The Problem

Most READMEs are either walls of text that bury what matters, or empty stubs that tell readers nothing. Many README generators and builders help with section selection, repo summarization, or template filling, but they still tend to optimize for completeness over reading order.

readme-craft focuses on the final reading experience: a **3-tier layout strategy** that decides what belongs above the fold, what should be easy to scan, and what should be folded into reference material. It is a GitHub-native, layout-first README skill for READMEs that need to serve both human readers and the agents that will keep iterating on them.

## What readme-craft Does

| Tier | Content | Purpose |
|------|---------|---------|
| **1** Above the fold (~250px) | Logo, name, one-liner, badges, quick links | 3-second pitch |
| **2** Scan quickly (2-3 screens) | Problem, features, quick start, install, usage | Prove value |
| **3** Reference (collapsible) | Config, API, structure, roadmap, contributing | Serve committed users |

**Key capabilities:**

- **Three operation modes** — create from scratch, generate from codebase, or improve an existing README
- **3-tier layout strategy** — information hierarchy based on how visitors actually consume READMEs
- **Dark/light mode logos** — `<picture>` element pattern for GitHub theme switching
- **GitHub-native formatting** — `<details>`, alerts, relative links, Mermaid, math, footnotes, and minimal HTML when they improve clarity
- **Badge selection** — priority-ordered guidance (license → version → CI → downloads → coverage)
- **Interactive collaboration** — asks before adding logos, social proof, docs splits, or more opinionated formatting
- **Quality checklist** — validation across structure, content, formatting, and completeness
- **Two templates** — universal OSS project + AI agent skill

## Usage

```text
"Write a README for this project"
"Generate a README"
"Improve this README"
"Review my README"
"Add badges to my README"
"Fix my README layout"
```

**Example**

Sample flow, not a transcript from a verified run:

> User: "Generate a README for this project"
>
> readme-craft will:
> 1. Scan the codebase for project metadata, dependencies, and structure
> 2. Select the appropriate template (universal or skill-specific)
> 3. Fill the template using detected information
> 4. Apply the 3-tier layout strategy
> 5. Run the quality checklist and report any issues

**Typical output**

- Tier 1 keeps the value proposition, trust badges, and quick links visible immediately.
- Tier 2 keeps problem, features, usage, and install sections short enough to scan without hunting.
- Tier 3 folds structure, configuration, roadmap, and contribution details into reference sections.

## Install

This repository is still being prepared for public publication. Until a public GitHub repo exists, register a local checkout in the agent roots you actually use.

```bash
# Replace /path/to/readme-craft with your local checkout.
ln -sfn /path/to/readme-craft ~/.claude/skills/readme-craft
```

<details>
<summary>Common skill roots</summary>

```bash
# Pick only the roots you actually use.
# You do not need to register every platform.
# If a root does not exist yet, create it only intentionally.

# Claude Code
ln -sfn /path/to/readme-craft ~/.claude/skills/readme-craft

# Codex
ln -sfn /path/to/readme-craft ~/.agents/skills/readme-craft

# VS Code / GitHub Copilot
ln -sfn /path/to/readme-craft ~/.copilot/skills/readme-craft

# Cursor (if your setup ignores the symlink, use a real copy instead)
ln -sfn /path/to/readme-craft ~/.cursor/skills/readme-craft

# Windsurf
ln -sfn /path/to/readme-craft ~/.codeium/windsurf/skills/readme-craft
```

</details>

Public repo-path install can replace this section after the GitHub repository is live.

---

<details>
<summary><strong>How It Works</strong></summary>

### Three Operation Modes

**Mode A: Create from Scratch** — User describes a project without code. The skill collects project info (name, description, features, license), selects a template, and produces a 3-tier README.

**Mode B: Create from Codebase** — Scans the project for package configs, entry points, CI config, and existing docs. Synthesizes findings into a complete README using the detected ecosystem.

**Mode C: Improve Existing** — Evaluates an existing README against the 3-tier strategy and quality checklist. Produces a numbered improvement plan, then applies changes while preserving the author's voice.

### The 3-Tier Layout Strategy

The core differentiator. Every README organizes content by how visitors consume information:

- **Tier 1 (~250px):** The storefront window — logo, name, value proposition, trust badges, quick links. Visitors who aren't interested leave here.
- **Tier 2 (2-3 screens):** The product demo — problem statement, features, quick start, install, usage. Proves the project is worth adopting.
- **Tier 3 (collapsible):** The reference manual — config, API, project structure, contributing, roadmap. Wrapped in `<details>` for committed users.

### GitHub-Native Formatting

readme-craft treats GitHub formatting as part of the README architecture, not as decoration:

- Use `<details>` to keep reference material out of the main reading path.
- Use relative links when the README needs to spill into `docs/` or sibling markdown files.
- Use Mermaid, math, or footnotes only when they explain faster than plain prose.
- Keep social proof optional. Stars, contributors, and popularity signals should be deliberate, not default.

</details>

<details>
<summary><strong>What's Inside</strong></summary>

```text
readme-craft/
├── SKILL.md                                # Skill definition — modes, tiers, checklist
├── templates/
│   ├── universal-readme.md                 # Template for any OSS project
│   └── skill-readme.md                     # Template for AI agent skills
└── references/
    ├── badges.md                           # Copy-paste badge patterns by ecosystem
    └── github-formatting.md                # GitHub-native formatting decisions and overflow strategy
```

</details>

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for contribution workflow and validation steps.

## License

MIT — See [LICENSE](LICENSE) for details.

---

Forged with [Skill Forge](https://github.com/motiful/skill-forge)

<!-- Reference-style link definitions -->
[license-shield]: https://img.shields.io/badge/License-MIT-green.svg
[license-url]: LICENSE
[version-shield]: https://img.shields.io/badge/version-1.0-blue.svg
[version-url]: SKILL.md
[skills-shield]: https://img.shields.io/badge/Agent%20Skills-compatible-DA7857?logo=anthropic
[skills-url]: https://agentskills.io
