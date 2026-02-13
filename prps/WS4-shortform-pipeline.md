# PRP — WS4: Long-Form → Short-Form + Personal Site + YouTube

## Overview
**Feature:** Short-Form Content Conversion Pipeline, Personal Site Alignment, YouTube Strategy
**Priority:** P2
**Estimated Complexity:** Large (4 stories, each one Ralph iteration)
**PRD Source:** Stories 13–16 from `tasks/prd-deepify-content-brand.md`

## Context
Jake has a growing library of long-form content — 12 development journal sessions (6–7 min video, 13 min audio each), plus future tutorial and R&D content. There's no system to convert this into short-form social content (<60 sec clips, quote cards, carousels). Additionally, Jake's personal site needs alignment as a professional anchor, and the YouTube channel (Deepify HQ) needs a strategy distinct from LinkedIn content.

**What exists today:**
- 12 long-form development journal sessions (video + audio)
- `skills/youtube-transcript/` — existing YouTube transcript skill
- `skills/infographic-generator/` — could be adapted for quote cards
- Personal site repo (the "me" repo) — exists but may not be current
- No short-form conversion tooling
- No YouTube channel branding or content strategy

**What's missing:** Tool research, conversion skill/agent, personal site updates, YouTube strategy.

**Jake's concern:** *"I'm a bit worried because they are about six or seven minutes long and the audios are 13 minutes, so it is long form content. So I've got to think of a way of putting in short form content as well."*

---

## Requirements

### Story 13: Research Short-Form Conversion Tools & Methods
**Effort:** S (one Ralph iteration)

#### Must Have
1. Research report covering: AI clip extraction tools, manual editing approaches, avatar-based summarization
2. At least 3 tools evaluated with: pros, cons, pricing, platform compatibility
3. Recommended approach specifically for Deeperfire AI dev journal content
4. Estimated time per conversion (manual vs. semi-automated vs. fully automated)

#### Nice to Have
1. Comparison matrix (table format) for quick reference
2. Example outputs or demos from each tool (links/screenshots)
3. Assessment of avatar tools (Jake mentioned this as an option)

### Story 14: Build Short-Form Conversion Skill/Agent (POC)
**Effort:** L (one Ralph iteration)

#### Must Have
1. Skill that takes a long-form session (video + audio + transcript) as input
2. Outputs: 2–3 highlight clips (30–60 sec each) identified with timestamps
3. Outputs: 3 quote cards (text extracted, formatted for social)
4. Outputs: 1 LinkedIn text summary (~200 words)
5. Process is documented and repeatable

#### Nice to Have
1. Automatic clip extraction (vs. timestamp-only identification)
2. Quote card visual generation (using infographic-generator patterns)
3. Multiple output formats (LinkedIn, Twitter/X, Instagram)

### Story 15: Personal Site & CV Alignment
**Effort:** M (one Ralph iteration)

#### Must Have
1. Personal site content matches current CV
2. Blog section active or has placeholder with Daily Avatars integration plan
3. Cross-links to Deepify AI, Deeperfire AI, YouTube channel
4. Mobile responsive and professional appearance
5. Ready to share with recruiters/clients if employment changes

#### Nice to Have
1. SEO basics (meta tags, Open Graph, structured data)
2. Blog post template for future content
3. Portfolio section showcasing R&D work

### Story 16: YouTube Channel Strategy & Setup
**Effort:** M (one Ralph iteration)

#### Must Have
1. Content strategy document: what goes on YouTube vs. LinkedIn vs. website
2. YouTube channel branding spec (banner, profile image, description, keywords)
3. Playlist structure defined (e.g., "Dev Journals", "R&D Showcases", "Tutorials")
4. First upload plan: which content, what description, what thumbnail approach

#### Nice to Have
1. YouTube SEO research (keywords, tags, description optimization)
2. Thumbnail template/style guide
3. Cross-promotion strategy (YouTube ↔ LinkedIn ↔ website)

---

## Technical Blueprint

### Files to Create

#### Story 13 — Tool Research
- `tasks/ws4-shortform/README.md` — Workstream overview and status tracker
- `tasks/ws4-shortform/tool-research.md` — Comprehensive research report on short-form conversion tools
- `tasks/ws4-shortform/tool-comparison-matrix.md` — Side-by-side comparison table of evaluated tools
- `tasks/ws4-shortform/recommended-approach.md` — Final recommendation with rationale and implementation plan

#### Story 14 — Conversion Skill POC
- `skills/content-converter/SKILL.md` — Skill definition for the short-form conversion agent
- `skills/content-converter/scripts/extract-highlights.py` — Script to analyze long-form content and identify highlight clips with timestamps
- `skills/content-converter/scripts/generate-quote-cards.py` — Script to extract key quotes and format as social cards
- `skills/content-converter/scripts/generate-summary.py` — Script to produce LinkedIn-ready text summaries
- `skills/content-converter/scripts/requirements.txt` — Python dependencies
- `skills/content-converter/templates/quote-card.md` — Template for quote card content
- `skills/content-converter/templates/linkedin-summary.md` — Template for LinkedIn summary posts
- `skills/content-converter/README.md` — Setup, usage, input/output format documentation

#### Story 15 — Personal Site
- `tasks/ws4-shortform/personal-site-audit.md` — Audit of current personal site state vs. current CV
- `tasks/ws4-shortform/personal-site-updates.md` — Specific changes needed, with content for each section
- `tasks/ws4-shortform/daily-avatars-integration.md` — Plan for integrating Daily Avatars content into blog

#### Story 16 — YouTube Strategy
- `tasks/ws4-shortform/youtube-strategy.md` — Full content strategy: what goes where across platforms
- `tasks/ws4-shortform/youtube-branding-spec.md` — Channel branding: banner spec, profile, description, keywords
- `tasks/ws4-shortform/youtube-playlist-structure.md` — Playlist definitions with descriptions and content mapping
- `tasks/ws4-shortform/youtube-first-upload.md` — First upload plan: content selection, description, thumbnail, tags

### Files to Modify
- `tasks/ws4-shortform/README.md` — Status updated after each story completion
- `skills/content-converter/SKILL.md` — Updated as POC evolves

### Dependencies
- Transcript files from development journal sessions (or access to NotebookLM exports)
- `skills/youtube-transcript/` — reference for transcript handling patterns
- `skills/infographic-generator/` — reference for visual content generation patterns
- Personal site repo access (the "me" repo — Jake to confirm location)
- YouTube account access (Deepify HQ channel)
- `ffmpeg` (for any video/audio processing in Story 14)
- Current CV document (Jake to provide or confirm location)

---

## Acceptance Criteria

### Story 13
- [ ] `tasks/ws4-shortform/tool-research.md` exists with comprehensive research
- [ ] At least 3 tools evaluated with pros/cons/pricing
- [ ] Avatar-based summarization tools included in research
- [ ] `tasks/ws4-shortform/recommended-approach.md` has clear recommendation for Deeperfire AI content
- [ ] Time estimates provided for each approach (manual, semi-auto, auto)

### Story 14
- [ ] `skills/content-converter/SKILL.md` defines the skill clearly
- [ ] `skills/content-converter/scripts/extract-highlights.py` runs without errors on sample input
- [ ] Given one journal session, produces: 2–3 highlight timestamps, 3 quote card texts, 1 LinkedIn summary
- [ ] `skills/content-converter/README.md` has clear input/output docs and usage instructions
- [ ] Process is repeatable — running on a different session produces equivalent outputs

### Story 15
- [ ] `tasks/ws4-shortform/personal-site-audit.md` identifies all gaps between site and current CV
- [ ] `tasks/ws4-shortform/personal-site-updates.md` has specific content for each section needing updates
- [ ] Cross-links to Deepify AI, Deeperfire AI, and YouTube are specified
- [ ] `tasks/ws4-shortform/daily-avatars-integration.md` has a concrete integration plan

### Story 16
- [ ] `tasks/ws4-shortform/youtube-strategy.md` clearly delineates YouTube vs. LinkedIn vs. website content
- [ ] `tasks/ws4-shortform/youtube-branding-spec.md` has actionable specs (dimensions, copy, keywords)
- [ ] `tasks/ws4-shortform/youtube-playlist-structure.md` has at least 3 playlists defined
- [ ] `tasks/ws4-shortform/youtube-first-upload.md` identifies specific content for first upload with full metadata

---

## Validation Strategy

1. **Story 13:** Does the research cover the tools Jake would actually find if Googling? Are the comparisons fair? Is the recommendation justified for Jake's specific content (6–7 min dev journals, not generic)?
2. **Story 14:** Run the conversion skill on one development journal session. Review outputs: Are the highlight timestamps genuinely the best moments? Do quote cards read well standalone? Is the LinkedIn summary compelling and accurate?
3. **Story 15:** Compare `personal-site-updates.md` against the actual site — do the recommended changes make sense? Would a recruiter landing on this site get an accurate, professional picture?
4. **Story 16:** Read the YouTube strategy — is it clearly distinct from the LinkedIn strategy? Would the playlist structure make sense to a new subscriber? Is the first upload choice the strongest foot forward?

---

## Out of Scope
- **Actually editing/cutting video files** — Story 14 identifies clips with timestamps; video editing is a separate process
- **Building the personal site** — Story 15 produces the audit and content; actual site changes are implementation work
- **YouTube channel creation** — assumes channel exists; this is strategy and branding spec only
- **Monetization setup** (YouTube Partner Program, memberships) — too early, content first
- **Multi-platform short-form** (TikTok, Instagram Reels, Twitter/X video) — LinkedIn and YouTube focus for now
- **Avatar creation/training** — if avatar approach is recommended, building it is separate work
- **Deepify Academy platform** — YouTube is the video home for now; academy is a future workstream
- **Faceless YouTube channel** — Jake mentioned keeping this separate; it's a different project

---

## Success Criteria for Ralph
The agent should output `<promise>COMPLETE</promise>` ONLY when:
- All acceptance criteria for the current story are met
- No Python syntax errors in created scripts
- All files listed in Technical Blueprint exist and are non-empty
- Research documents contain real tool names, real URLs, real pricing (not fabricated)
- Skill scripts have proper error handling and documentation
- Strategy documents are actionable (specific enough to implement), not vague recommendations
- prd.json updated with `passes: true`
