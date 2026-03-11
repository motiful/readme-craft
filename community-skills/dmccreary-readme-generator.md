---
name: readme-generator
description: This skill creates or updates a README.md file in the GitHub home directory of the current project. The README.md file it generates will conform to GitHub best practices, including badges, project overview, site metrics, getting started instructions, and comprehensive documentation.
license: MIT
---

# README Generator

Generate or update a comprehensive README.md file for GitHub repositories following best practices.

## Purpose

This skill automates the creation of professional, well-structured README.md files for GitHub repositories. It generates all essential sections including badges for technologies used, project overview, site metrics, getting started instructions, project structure, and contact information. The skill is particularly optimized for MkDocs-based intelligent textbook projects but can be adapted for any repository type.

## When to Use This Skill

Use this skill when:

- Starting a new GitHub repository that needs a README.md
- Updating an existing README.md to follow best practices
- After significant project changes that should be documented
- Before publishing or sharing a repository
- When migrating from another documentation system
- After adding new technologies or dependencies

## Workflow

### Step 1: Analyze Repository Context

Before generating the README, gather information about the repository:

1. Check if README.md already exists in the root directory
2. Identify the repository name from `.git/config` or the working directory
3. Read `mkdocs.yml` if it exists to extract:
   - Site name
   - Site description
   - Site URL (for GitHub Pages link)
   - Repository URL
4. Check for documentation in `/docs` directory
5. Identify technologies used (look for package.json, requirements.txt, mkdocs.yml, etc.)

**User Dialog Triggers:**

- If README.md exists: Ask "README.md already exists. Would you like to update it or create a backup first?"
- If repository URL not found: Ask "What is the GitHub repository URL? (e.g., https://github.com/username/repo-name)"
- If site URL not configured: Ask "Is this site deployed to GitHub Pages? If yes, what's the URL?"

### Step 2: Generate Badges

Create badges for all relevant technologies and platforms. Use shields.io format for consistency.

**Badge Order:**

1. MkDocs (if mkdocs.yml exists)
2. MkDocs Material (if theme is Material)
3. GitHub Pages live badge (if site is deployed)
4. Claude Code badge
5. Claude Skills badge (if .claude/skills or skills/ directory exists)
6. License badge
7. Additional technology badges (Python, JavaScript, p5.js, etc.)

**Badge Templates:**

```markdown
[![MkDocs](https://img.shields.io/badge/Made%20with-MkDocs-526CFE?logo=materialformkdocs)](https://www.mkdocs.org/)
[![Material for MkDocs](https://img.shields.io/badge/Material%20for%20MkDocs-526CFE?logo=materialformkdocs)](https://squidfunk.github.io/mkdocs-material/)
[![GitHub Pages](https://img.shields.io/badge/View%20on-GitHub%20Pages-blue?logo=github)](SITE_URL)
[![GitHub](https://img.shields.io/badge/GitHub-OWNER%2FREPO-blue?logo=github)](REPO_URL)
[![Claude Code](https://img.shields.io/badge/Built%20with-Claude%20Code-DA7857?logo=anthropic)](https://claude.ai/code)
[![Claude Skills](https://img.shields.io/badge/Uses-Claude%20Skills-DA7857?logo=anthropic)](https://github.com/dmccreary/claude-skills)
```

### Step 3: Add License Badge

Look for license information in:

1. `LICENSE` file in root
2. `docs/license.md`
3. `mkdocs.yml` (copyright field)

**Default to Creative Commons BY-NC-SA 4.0 if not specified:**

```markdown
[![License: CC BY-NC-SA 4.0](https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-sa/4.0/)
```

**Other common licenses:**

- MIT: `[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)`
- Apache 2.0: `[![License: Apache 2.0](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)`
- GPL-3.0: `[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)`

### Step 4: Create Website Link Section

After badges, add a prominent link to the live website (if deployed):

```markdown
## View the Live Site

Visit the interactive textbook at: [https://username.github.io/repo-name](https://username.github.io/repo-name)
```

### Step 5: Write Overview/Short Description

Create a compelling 1-3 paragraph overview that answers:

- What is this project?
- Who is it for?
- Why is it valuable?
- What makes it unique or special?

### Step 6: Add Site Status and Metrics

Gather and display project metrics to show completeness and scope.

### Step 7: Add Getting Started Section

Provide clear instructions for using and customizing the project.

### Step 8: Document Repository Structure

Create an ASCII tree diagram showing the repository structure with explanatory comments.

### Step 9: Add Issue Reporting Section

Direct users to the GitHub Issues page.

### Step 10: Add License Information

Reinforce licensing terms and attribution requirements.

### Step 11: Add Acknowledgements

Express gratitude to the open source community and key projects.

### Step 12: Add Contact Section

Provide a way for users to reach out.

### Step 13: Add Optional Sections

Include Contributing Guidelines, Citation Information, Changelog if relevant.

### Step 14: Validate and Format

Before finalizing the README:

1. Check all links
2. Validate markdown
3. Test locally
4. Spell check
5. Consistency check

### Step 15: Write README.md

Generate the final README.md file in the repository root with all sections in order:

1. Title (H1) with repository name
2. Badges
3. Live site link (if applicable)
4. Overview
5. Site Status and Metrics
6. Getting Started
7. Repository Structure
8. Reporting Issues
9. License
10. Acknowledgements
11. Contact
12. Optional sections (Contributing, Citation, Changelog)

## Supporting Scripts

The skill includes Python scripts for automated metrics collection:

**`scripts/collect-site-metrics.py`** - Scans the repository and generates a metrics report.

**`scripts/validate-readme.py`** - Validates README.md for required sections, working links, valid badge URLs, and proper formatting.

## Quality Standards

A high-quality README should have:

- All relevant badges displayed correctly
- Accurate, current metrics
- Clear, compelling overview (200-400 words)
- Complete getting started instructions
- Proper attribution and licensing
- Working links (100% functional)
- Professional formatting
- Contact information

## References

- [GitHub README Best Practices](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-readmes)
- [Shields.io Badge Documentation](https://shields.io/)
- [Creative Commons License Chooser](https://creativecommons.org/choose/)
- [MkDocs Documentation](https://www.mkdocs.org/)

---

*Note: Also includes `references/badges.md` with comprehensive badge reference guide for shields.io badges across technologies, licenses, hosting platforms, AI tools, and more.*
