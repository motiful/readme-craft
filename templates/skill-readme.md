# Skill README Template (SkillForge-Enhanced)

> This template extends the universal template with Agent Skills-specific sections.
> Replace all `<placeholders>` and remove this instruction block before publishing.

---

<!-- ============================================================ -->
<!-- TIER 1: ABOVE THE FOLD — Your 3-second pitch                 -->
<!-- ============================================================ -->

<!-- Logo: dark/light mode support -->
<div align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="<assets/logo-dark.svg>">
    <source media="(prefers-color-scheme: light)" srcset="<assets/logo-light.svg>">
    <img alt="<skill-name>" src="<assets/logo-light.svg>" width="120">
  </picture>

  <h1><skill-name></h1>
  <p><one-line value proposition — what problem this solves, not what it is></p>
</div>

<div align="center">

<!-- Badges: pick the most relevant 4-6 -->
[![License: <license>](https://img.shields.io/badge/License-<license>-<color>.svg)](<license-url>)
[![Version](https://img.shields.io/badge/version-<version>-blue.svg)](<releases-url>)
[![Agent Skills](https://img.shields.io/badge/Agent%20Skills-compatible-DA7857?logo=anthropic)](https://agentskills.io)

</div>

<div align="center">
  <a href="#usage">Usage</a> &middot;
  <a href="#install">Install</a> &middot;
  <a href="#how-it-works">How It Works</a> &middot;
  <a href="<docs-url>">Docs</a>
</div>

<br>

> [!NOTE]
> [Agent Skills](https://agentskills.io) compatible — works with Claude Code, Codex, Cursor, Windsurf, GitHub Copilot, and other Agent Skills adopters.

---

<!-- ============================================================ -->
<!-- TIER 2: SCAN QUICKLY — Prove value to interested visitors     -->
<!-- ============================================================ -->

## The Problem

<2-4 sentences describing the pain point. Be specific — what goes wrong without this skill? What does the user waste time on?>

## What <skill-name> Does

<How the skill solves the problem. Show the workflow or key capabilities. Use a code block, table, or bullet list — whichever communicates fastest.>

```
<visual workflow diagram or pipeline, if applicable>
```

## Usage

<Trigger phrases that activate this skill. What does the user say?>

```
"<trigger phrase 1>"
"<trigger phrase 2>"
"<trigger phrase 3>"
```

**Example:**

> User: "<example prompt>"
>
> <skill-name> will:
> 1. <step 1>
> 2. <step 2>
> 3. <step 3>

## Install

```bash
npx skills add <org>/<skill-name>
```

<details>
<summary>Manual registration</summary>

```bash
git clone https://github.com/<org>/<skill-name> ~/skills/<skill-name>

# Pick only the roots you actually use.

# Claude Code
ln -sfn ~/skills/<skill-name> ~/.claude/skills/<skill-name>

# Codex
ln -sfn ~/skills/<skill-name> ~/.agents/skills/<skill-name>

# VS Code / GitHub Copilot
ln -sfn ~/skills/<skill-name> ~/.copilot/skills/<skill-name>

# Cursor
ln -sfn ~/skills/<skill-name> ~/.cursor/skills/<skill-name>

# Windsurf
ln -sfn ~/skills/<skill-name> ~/.codeium/windsurf/skills/<skill-name>
```

</details>

---

<!-- ============================================================ -->
<!-- TIER 3: REFERENCE — Serve committed users                    -->
<!-- ============================================================ -->

<details>
<summary><strong>How It Works</strong></summary>

<Deeper explanation of the skill's workflow. Step-by-step execution logic. When to elaborate here vs in SKILL.md: if the user needs to understand the process to use the skill effectively, put it here. If it's internal agent logic, keep it in SKILL.md only.>

</details>

<details>
<summary><strong>What's Inside</strong></summary>

```
SKILL.md              — <short description>
references/           — <if applicable>
  <file>.md           — <what it contains>
scripts/              — <if applicable>
  <file>.<ext>        — <what it does>
```

</details>

<details>
<summary><strong>Configuration</strong></summary>

<If the skill has configurable behavior, document it here.>

| Option | Default | Description |
|--------|---------|-------------|
| <option> | <default> | <description> |

</details>

<details>
<summary><strong>Contributing</strong></summary>

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/<name>`)
3. Commit your changes
4. Push to the branch
5. Open a Pull Request

</details>

## License

<license-type> — See [LICENSE](LICENSE) for details.

---

Forged with [Skill Forge](https://github.com/<org>/skill-forge)

<!-- Reference-style links (define all badge URLs here for cleaner source) -->
<!-- [contributors-shield]: https://img.shields.io/github/contributors/<org>/<skill-name>.svg -->
<!-- [license-shield]: https://img.shields.io/github/license/<org>/<skill-name>.svg -->
