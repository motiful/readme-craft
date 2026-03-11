# Community Skill Evaluation

Evaluation of 4 community README generation tools, scored on 5 dimensions.

---

## 1. dmccreary/claude-skills — readme-generator

**Source:** https://github.com/dmccreary/claude-skills/tree/main/skills/readme-generator

### Completeness: 9/10
The most thorough of all skills examined. Covers 15 explicit steps from repository analysis through validation. Includes supporting Python scripts for metrics collection and README validation. Also ships a comprehensive `references/badges.md` with copy-paste badge templates for 40+ technologies.

### Quality of Instructions: 7/10
Very detailed step-by-step workflow, but the instructions are **heavily biased toward MkDocs textbook projects**. An agent following these instructions for a React app or CLI tool would produce a README with irrelevant sections (MicroSims, learning graphs, Bloom's Taxonomy). The skill conflates a general-purpose README generator with a domain-specific documentation system.

### Specificity vs Generality: 3/10 (too specific)
Optimized for one person's use case (MkDocs-based intelligent textbooks). The metric collection, chapter counting, glossary tracking, and quiz statistics are useless for 95% of projects. The badge ordering puts MkDocs and Material badges first. The license defaults to CC BY-NC-SA 4.0 instead of MIT/Apache.

### What's Missing
- No tiered layout strategy (everything is flat)
- No dark/light mode logo pattern
- No collapsible sections
- No understanding of "above the fold" priority
- No skill metadata for AI agent activation
- No separation between universal and domain-specific concerns

### What's Good (borrow these)
- **badges.md reference file** — Comprehensive, well-organized badge library. Worth adapting.
- **Validation scripts** — `validate-readme.py` checks links, required sections, badge URLs. Good idea.
- **Metrics table pattern** — The concept of auto-generating a project metrics table is useful (just not the MkDocs-specific metrics).
- **User Dialog Triggers** — Explicitly tells the agent when to ask questions vs proceed.
- **15-step numbered workflow** — Clear execution sequence, easy for an agent to follow.

---

## 2. GLINCKER/claude-code-marketplace — readme-generator

**Source:** https://github.com/GLINCKER/claude-code-marketplace/blob/main/skills/documentation/readme-generator/SKILL.md

### Completeness: 6/10
Covers the basics: project discovery, content analysis, README generation, writing style, output. Has examples for Python and Node.js projects. Missing deeper guidance on layout, visual hierarchy, badge strategy, and quality validation.

### Quality of Instructions: 6/10
Reasonable but generic. The "Required Sections" and "Optional Sections" split is sensible. The language detection via config file patterns is practical. However, the instructions read more like a specification than actionable guidance — an agent would know *what* to include but not *how* to write compelling content.

### Specificity vs Generality: 7/10 (good balance)
More general-purpose than dmccreary. Adapts to project type via a config file detection table (Python, Node.js, Rust, Go, Generic). Does not over-index on any specific domain.

### What's Missing
- No layout/hierarchy strategy
- No badge reference (just "Badge shields for status indicators")
- No dark/light mode, no collapsible sections
- No validation step
- No tone/voice guidelines beyond "professional but approachable"
- No awareness of README space constraints (above-fold, scan-ability)
- The "Limitations" section is good but should be in the skill definition, not the README output

### What's Good (borrow these)
- **Config file detection table** — Clean mapping from project type to key files to focus areas.
- **Error Handling section** — Explicit edge case handling (no project files, multiple languages, existing README, missing info). Good practice.
- **Tool Requirements declaration** — Explicitly lists which tools the skill needs (Read, Glob, Grep, Write).
- **"Offer to" pattern** — After generating, offer to write, adjust, or add sections. Good agent UX.

---

## 3. holasoymalva/README-Generator-Toolkit

**Source:** https://github.com/holasoymalva/README-Generator-Toolkit

### Completeness: 7/10
Three complementary tools covering the full lifecycle: create from scratch, create from codebase, and improve existing. The combination is more complete than any single skill. Each tool has a clear workflow, analysis framework, and output structure.

### Quality of Instructions: 5/10
Written for Cursor's .mdc format, not Claude SKILL.md. The instructions are more like "rules" than "workflows" — they describe what a good README looks like but give less step-by-step agent guidance. The "improve" tool has the best analytical framework (content, structure, visual, technical analysis).

### Specificity vs Generality: 8/10 (most general)
The most generic of all skills. Works for any project type, any language, any framework. The trade-off is that it lacks the depth to produce truly outstanding output for any specific context.

### What's Missing
- No badge reference or templates
- No visual hierarchy / layout strategy
- No dark/light mode awareness
- No validation scripts
- No skill metadata (it's .mdc, not SKILL.md)
- Heavy on emojis in the "from description" tool — may not match all project tones
- No understanding of agent skill ecosystems

### What's Good (borrow these)
- **Three-tool lifecycle** — "Create from description", "Create from codebase", "Improve existing" is a powerful trifecta. Our skill should support all three modes.
- **4-phase codebase analysis** — Structure, Tech Stack, Functionality, Documentation extraction. Well-sequenced.
- **File Priority order** — Config files > Entry points > Core app > Docs > Tests > Config. Practical and agent-friendly.
- **Improvement strategies matrix** — Different strategies for incomplete, outdated, unclear, and boring READMEs. Very actionable.
- **Output Options** — Complete rewrite, section-by-section, incremental, side-by-side. Good UX.

---

## 4. othneildrew/Best-README-Template

**Source:** https://github.com/othneildrew/Best-README-Template

### Completeness: 8/10
The most popular README template on GitHub (15k+ stars). Covers all standard sections. The section ordering is well-tested and widely adopted.

### Quality of Instructions: N/A (template, not skill)
This is a static template, not an AI skill. No agent instructions. Requires manual find-and-replace of placeholders. Evaluated here for structural patterns only.

### Specificity vs Generality: 6/10
General-purpose but assumes a web application project (the "Built With" section lists frontend frameworks). The structure itself is universal.

### What's Missing
- No AI/agent integration
- No dark/light mode logo (`<picture>` element)
- No collapsible details sections (except TOC)
- No skill metadata
- HTML-heavy — harder to maintain than pure Markdown
- Static placeholders require manual editing

### What's Good (borrow these)
- **Reference-style links** — All URLs defined at bottom. Keeps source clean. Very readable.
- **Back-to-top navigation** — Every section has a "back to top" link. Good for long READMEs.
- **Collapsible TOC** — Using `<details><summary>` for table of contents. Smart space management.
- **contrib.rocks widget** — Auto-generated contributor avatars. Nice social proof.
- **Centered logo + title pattern** — Clean visual hierarchy with `<div align="center">`.
- **Quick action links** — "Explore docs / View Demo / Report Bug / Request Feature" immediately after title. High-value above-the-fold content.

---

## Comparative Summary

| Dimension | dmccreary | GLINCKER | holasoymalva | othneildrew |
|-----------|-----------|----------|--------------|-------------|
| Completeness | 9 | 6 | 7 | 8 |
| Instruction Quality | 7 | 6 | 5 | N/A |
| Generality | 3 | 7 | 8 | 6 |
| Layout Awareness | 2 | 2 | 3 | 7 |
| Agent-Readiness | 6 | 7 | 4 | 1 |
| Badge/Visual Support | 9 | 2 | 2 | 6 |

### Key Takeaways for readme-craft

1. **No existing skill addresses layout hierarchy.** None of them think about "above the fold", tiered information, or space budgets. This is the biggest gap.

2. **Badge reference is valuable.** dmccreary's badges.md is the best resource. We should adapt and extend it.

3. **Three operation modes are needed.** holasoymalva's trifecta (create from scratch, create from codebase, improve) covers the full lifecycle. We need all three.

4. **Validation is underserved.** Only dmccreary includes validation. A README quality checklist with automated checks (links, sections, badge URLs) is high value.

5. **Dark/light mode logos are absent everywhere.** The `<picture>` element pattern for GitHub dark/light theme switching is not in any of these skills. We should include it.

6. **Collapsible sections are underused.** Only othneildrew uses `<details>` and only for TOC. We should use it for Tier 3 content.

7. **Tone guidance is weak.** GLINCKER says "professional but approachable", dmccreary has no tone guidance, holasoymalva says "professional but approachable" again. Skill-forge's rules ("you" for reader, third person for software, no "we") are far more precise.

8. **Promise-Capability Alignment is unique to skill-forge.** None of the community skills verify that README claims match actual capabilities. This is a differentiator worth keeping.
