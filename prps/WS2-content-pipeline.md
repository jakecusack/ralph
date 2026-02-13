# PRP — WS2: Content Repurposing Pipeline

## Overview
**Feature:** Content Repurposing Pipeline — Ingest, Enrich, Repurpose paid course content
**Priority:** P1
**Estimated Complexity:** Large (4 stories, each one Ralph iteration)
**PRD Source:** Stories 5–8 from `tasks/prd-deepify-content-brand.md`

## Context
Jake pays for multiple school.com subscriptions and other learning platforms but has no systematic way to capture, enrich, or repurpose that content into Deepify's own materials. Everything is consumed once with no extraction pipeline. The vision is the **"Buffalo Effect"** — use every piece (video, transcript, screenshots, slides) and make it "1% better" with real-world scenarios and practical demos, then publish under Deepify Academy.

**What exists today:**
- `skills/browser-auto/` — existing BrowserUse/browser automation skill (potential foundation)
- `skills/web-scraper/` — web scraping skill
- `capture/` — existing capture directory structure
- Voice brainstorms with pipeline design thinking: `capture/voice-brainstorms/2026-02-02-0710-ben-content-repurposing-pipeline-design.*`

**What's missing:** No content inventory, no extraction scripts for auth'd school.com content, no enrichment framework, no knowledge base ingestion process.

---

## Requirements

### Story 5: Map All Paid Subscriptions & Content Inventory
**Effort:** S (one Ralph iteration)

#### Must Have
1. Complete audit of all current school.com subscriptions with URLs
2. Content inventory per subscription (course names, module count, content types available)
3. Estimated total volume (hours of video, number of documents/modules)
4. Priority ranking: which courses to repurpose first based on alignment with Deepify's service areas

#### Nice to Have
1. Tagging by Deepify service area (second brains, AI dev, data science, voice, iOS, content)
2. Notes on content format per platform (video-only, video+slides, text+code, etc.)

### Story 6: BrowserUse Extraction POC — Single Course Module
**Effort:** L (one Ralph iteration)

#### Must Have
1. BrowserUse script that authenticates to school.com
2. Navigation to a specific course module
3. Extraction of: video file or stream URL, transcript text, screenshot captures of slides/visuals
4. Structured output directory under `capture/school/{course}/{module}/`
5. README with run instructions and known limitations

#### Nice to Have
1. Batch mode for multiple modules in sequence
2. Error recovery / resume capability

### Story 7: Define the "1% Better" Repurposing Playbook
**Effort:** M (one Ralph iteration)

#### Must Have
1. Written framework document defining the enrichment process
2. Template: original content → real-world scenario → improved explanation → demo concept
3. One fully worked example showing a module transformed through the framework
4. Measurable criteria for what "1% better" means

#### Nice to Have
1. Prompt templates for AI-assisted enrichment
2. Quality checklist for reviewing enriched content

### Story 8: Knowledge Base Ingestion — NotebookLM Integration
**Effort:** M (one Ralph iteration)

#### Must Have
1. Documented ingestion process (what format, what goes where, naming conventions)
2. One course module fully ingested into knowledge base
3. Content is searchable and retrievable
4. Tagging/categorization scheme defined and applied

#### Nice to Have
1. Automated ingestion script that reads from `capture/school/` and formats for NotebookLM
2. Cross-reference index linking source material to enriched content

---

## Technical Blueprint

### Files to Create

#### Story 5 — Content Inventory
- `tasks/ws2-content-pipeline/README.md` — Workstream overview and status tracker
- `tasks/ws2-content-pipeline/content-inventory.md` — Full audit of paid subscriptions, courses, modules, content types, volume estimates
- `tasks/ws2-content-pipeline/priority-matrix.md` — Ranked list of courses to repurpose first, with rationale

#### Story 6 — BrowserUse Extraction POC
- `skills/content-pipeline/SKILL.md` — Skill definition for the content pipeline
- `skills/content-pipeline/scripts/extract-school-module.py` — BrowserUse extraction script for school.com
- `skills/content-pipeline/scripts/requirements.txt` — Python dependencies (browseruse, playwright, etc.)
- `skills/content-pipeline/README.md` — Setup, usage, and known limitations
- `capture/school/{course}/{module}/video/` — Extracted video files (directory structure)
- `capture/school/{course}/{module}/transcript/` — Extracted transcript text
- `capture/school/{course}/{module}/screenshots/` — Slide/visual captures
- `capture/school/{course}/{module}/metadata.json` — Module metadata (title, duration, extraction date)

#### Story 7 — Repurposing Playbook
- `tasks/ws2-content-pipeline/one-percent-better-playbook.md` — The full enrichment framework
- `tasks/ws2-content-pipeline/enrichment-template.md` — Reusable template for transforming any module
- `tasks/ws2-content-pipeline/worked-example.md` — One complete before/after showing the framework in action

#### Story 8 — Knowledge Base Ingestion
- `skills/content-pipeline/scripts/ingest-to-kb.py` — Script to format and prepare content for NotebookLM ingestion
- `tasks/ws2-content-pipeline/ingestion-process.md` — Documented process: formats, naming, tagging scheme, where things go
- `tasks/ws2-content-pipeline/kb-taxonomy.md` — Tagging/categorization scheme for the knowledge base

### Files to Modify
- `skills/content-pipeline/SKILL.md` — Updated after each story with new capabilities
- `tasks/ws2-content-pipeline/README.md` — Status updated after each story completion

### Dependencies
- `browseruse` Python package (for Story 6)
- `playwright` (browser automation backend for BrowserUse)
- school.com credentials (stored in `.env`, never committed)
- NotebookLM access (Google account, for Story 8)
- Existing `skills/browser-auto/` and `skills/web-scraper/` for reference patterns

---

## Acceptance Criteria

### Story 5
- [ ] `tasks/ws2-content-pipeline/content-inventory.md` exists with all paid subscriptions listed
- [ ] Each subscription has: URL, course names, module count, content types
- [ ] Total volume estimated (hours of video, doc count)
- [ ] `tasks/ws2-content-pipeline/priority-matrix.md` exists with ranked courses and rationale

### Story 6
- [ ] `skills/content-pipeline/scripts/extract-school-module.py` runs without errors
- [ ] Script authenticates to school.com and navigates to a target module
- [ ] Outputs video (or stream URL), transcript, and screenshots to `capture/school/{course}/{module}/`
- [ ] `metadata.json` created with module info
- [ ] `skills/content-pipeline/README.md` has clear run instructions and limitations

### Story 7
- [ ] `tasks/ws2-content-pipeline/one-percent-better-playbook.md` defines the full framework
- [ ] `tasks/ws2-content-pipeline/enrichment-template.md` is a reusable template
- [ ] `tasks/ws2-content-pipeline/worked-example.md` shows one module fully transformed
- [ ] "1% better" criteria are defined and measurable

### Story 8
- [ ] `tasks/ws2-content-pipeline/ingestion-process.md` documents the full ingestion workflow
- [ ] `tasks/ws2-content-pipeline/kb-taxonomy.md` defines tagging/categorization scheme
- [ ] One module has been ingested and is searchable in the knowledge base
- [ ] `skills/content-pipeline/scripts/ingest-to-kb.py` exists and formats content for ingestion

---

## Validation Strategy

1. **Story 5:** Review `content-inventory.md` — does it cover all known subscriptions? Cross-reference with Jake's payment records.
2. **Story 6:** Run `extract-school-module.py` against one known module. Verify output directory has video/transcript/screenshots. Check `metadata.json` is valid JSON.
3. **Story 7:** Read through the worked example — does the "after" version genuinely add real-world context and better explanations? Would Jake publish it?
4. **Story 8:** Search the knowledge base for content from the ingested module. Can you find it by topic? By tag? Does the taxonomy make sense for future content?

---

## Out of Scope
- **Full automation of the entire pipeline** — this is POC/foundation work, not production automation
- **Publishing to Deepify Academy** — that's a downstream workstream after the pipeline exists
- **Bulk extraction of all courses** — Story 6 is one module only; batch comes later
- **Legal review of school.com ToS** — flagged as open question in PRD, needs Jake's decision separately
- **Building the Deepify Academy platform** — pipeline feeds content TO academy, doesn't build it
- **Multi-platform extraction** (YouTube courses, Udemy, etc.) — school.com only for now

---

## Success Criteria for Ralph
The agent should output `<promise>COMPLETE</promise>` ONLY when:
- All acceptance criteria for the current story are met
- No Python syntax errors in created scripts
- All files listed in Technical Blueprint exist and are non-empty
- Directory structure under `capture/school/` is created (for Story 6)
- Markdown files are well-formatted and contain substantive content (not placeholders)
- prd.json updated with `passes: true`
