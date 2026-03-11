# holasoymalva/README-Generator-Toolkit

> Source: https://github.com/holasoymalva/README-Generator-Toolkit
> Format: Cursor .mdc (Markdown Command) files, not Claude SKILL.md
> Contains 3 .mdc rules for Cursor AI editor

---

## Tool 1: create-readme-from-codebase.mdc

### Goal

Guide an AI assistant in creating a comprehensive, accurate README.md file by analyzing an existing codebase. The README should reflect the actual project structure, dependencies, and functionality found in the code.

### Codebase Analysis Strategy

**Phase 1: Project Structure Analysis**
- Examine root directory files (package.json, requirements.txt, Cargo.toml, etc.)
- Identify main entry points (main.js, index.html, app.py, etc.)
- Map directory structure and organization patterns
- Identify configuration files and environment settings

**Phase 2: Technology Stack Detection**
- Parse dependency files to identify frameworks and libraries
- Analyze import/require statements to understand usage patterns
- Identify build tools, bundlers, and development tools
- Detect testing frameworks and CI/CD configurations

**Phase 3: Functionality Discovery**
- Examine main application files to understand core features
- Identify API endpoints, routes, or main functions
- Look for database schemas, models, or data structures
- Find example usage in tests or sample files

**Phase 4: Documentation Extraction**
- Extract existing comments, docstrings, or inline documentation
- Identify any existing README or documentation files
- Look for example usage in test files
- Find configuration examples or sample files

### README Structure (Code-Informed)

1. Header Section (title from package.json etc., badges for detected technologies)
2. About / Overview (purpose inferred from code, architecture overview, key technologies)
3. Features (functionality discovered through code analysis)
4. Installation & Setup (dependencies from package files, environment requirements)
5. Usage (examples based on discovered entry points)
6. Project Structure (directory layout explanation)
7. Development (build processes, testing instructions)
8. API Documentation (if applicable)
9. Configuration (environment variables, config files)
10. Contributing (development setup, code style from linting configs)
11. Technology Stack (complete list of detected technologies)
12. License & Contact

### File Priority (examine in order)
1. Configuration Files: package.json, requirements.txt, Cargo.toml, setup.py
2. Entry Points: main.js, index.js, app.py, main.py, index.html
3. Core Application: src/, lib/, app/, components/
4. Documentation: existing README, docs/, comments in code
5. Tests: test/, spec/, __tests__/
6. Configuration: config/, .env files, settings files

---

## Tool 2: create-readme-from-description.mdc

### Goal

Guide an AI assistant in creating a comprehensive, professional README.md file based on a project description provided by the user.

### Process
1. Receive Project Description
2. Ask Clarifying Questions (purpose, features, tech stack, install, usage, status, contributing, visuals)
3. Generate README
4. Save File

### README Structure

1. Header Section (title with emoji, description, badges, links)
2. Table of Contents
3. About / Overview (what, why, benefits)
4. Features (bullet points with emojis)
5. Getting Started (prerequisites, install, quick start)
6. Usage (examples, common use cases, config)
7. Examples (optional - screenshots, GIFs)
8. Technology Stack
9. Roadmap (optional)
10. Contributing
11. License
12. Contact/Support
13. Acknowledgments (optional)

### Content Guidelines
- Tone: Professional but approachable
- Clarity: Clear, concise language
- Scannability: Headers, bullets, formatting for easy reading
- Completeness: Enough detail for users to get started
- Visual Appeal: Emojis, badges, formatting
- Actionable: Specific steps and examples

---

## Tool 3: improve-readme.mdc

### Goal

Analyze and improve an existing README.md file, making it more comprehensive, clear, and professional while maintaining the original intent and structure.

### Analysis Framework

**Content Analysis:** Completeness, accuracy, clarity, examples, context
**Structure Analysis:** Organization, navigation, hierarchy, scannability
**Visual Analysis:** Formatting, readability, visual elements, code blocks
**Technical Analysis:** Links, commands, dependencies, paths

### Improvement Strategies

- **For Incomplete READMEs:** Add missing sections, expand descriptions, add examples
- **For Outdated READMEs:** Update versions, fix links, revise instructions
- **For Unclear READMEs:** Rewrite confusing sections, add examples, break down paragraphs
- **For Boring READMEs:** Add visual elements, compelling descriptions, screenshots

### Output Options
1. Complete Rewrite
2. Section-by-Section improvement
3. Incremental Updates
4. Side-by-Side comparison
