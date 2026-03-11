# othneildrew/Best-README-Template

> Source: https://github.com/othneildrew/Best-README-Template
> Format: Pure Markdown template (not an AI skill)
> Stars: 15k+ — the most popular README template on GitHub

---

## Template Structure

### Above the Fold
1. **Back-to-top anchor** — `<a id="readme-top"></a>`
2. **Project Shields** — Reference-style badge links (contributors, forks, stars, issues, license, LinkedIn)
3. **Project Logo** — Centered `<div>` with logo image
4. **Project Title** — `<h3>` centered
5. **Project Description** — Centered paragraph
6. **Quick Links** — "Explore the docs", "View Demo", "Report Bug", "Request Feature"

### Table of Contents
- Collapsible `<details><summary>` element
- Nested `<ol>` with `<li>` and `<ul>` for sub-sections

### Main Sections
1. **About The Project** — Screenshot + description + "Built With" sub-section (tech badges)
2. **Getting Started** — Prerequisites + Installation steps
3. **Usage** — Examples, screenshots, link to docs
4. **Roadmap** — Checkbox list of features
5. **Contributing** — Fork + branch + commit + push + PR workflow
6. **License** — License type + link to LICENSE.txt
7. **Contact** — Name, social links, email
8. **Acknowledgments** — Bulleted list of resources

### Footer
- Reference-style link definitions for all badges and URLs

## Key Design Patterns

### Reference-Style Links
All badges and URLs defined at bottom of file for cleaner markdown:
```markdown
[contributors-shield]: https://img.shields.io/github/contributors/user/repo.svg?style=for-the-badge
[contributors-url]: https://github.com/user/repo/graphs/contributors
```

### Centered Layout
Uses raw HTML `<div align="center">` for logo and title section.

### Back-to-Top Links
Every section ends with `<p align="right">(<a href="#readme-top">back to top</a>)</p>`.

### Top Contributors Widget
Uses `contrib.rocks` for auto-generated contributor avatars:
```html
<a href="https://github.com/user/repo/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=user/repo" />
</a>
```

## Strengths
- Extremely well-known and battle-tested
- Clean visual hierarchy
- Reference-style links keep source readable
- Back-to-top navigation for long READMEs
- Comprehensive section coverage

## Weaknesses
- HTML-heavy (not pure Markdown)
- No dark/light mode logo switching
- No collapsible detail sections (except TOC)
- Static placeholder approach — requires manual find-and-replace
- No AI-aware structure (no trigger phrases, no skill metadata)
- "Built With" section uses badge images for frameworks — heavy
