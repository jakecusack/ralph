# PRP — WS3: Deeperfire AI LinkedIn Content

## Overview
**Feature:** Deeperfire AI LinkedIn Developer Journey — First 4 weeks of content
**Priority:** P0 (closest to ready, highest immediate impact per PRD sprint priority)
**Estimated Complexity:** Large (4 stories, each one Ralph iteration)
**PRD Source:** Stories 9–12 from `tasks/prd-deepify-content-brand.md`

## Context
Deeperfire AI is Jake's iOS development brand — an empathetic app for dyslexic thinkers and ADHD users, built by "Alex the iOS dev" with an AI agent team ("team in a box"). There are already **12 NotebookLM development journal sessions** with audio overlays (~13 min each) and visual overlays (~6–7 min each), plus deep research from 40+ sources on accessibility and empathetic design. This is the most publish-ready content Jake has, but it's sitting uncataloged and unpublished.

**What exists today:**
- 12 development journal sessions in NotebookLM (audio + video overlays)
- Deep research: 40+ sources on dyslexic/ADHD design from national/world organizations and dyslexic societies
- Deeperfire AI LinkedIn business account (exists but empty/placeholder)
- Voice brainstorm with content strategy: `capture/voice-brainstorms/2026-02-03-0644-ben-deeperfire-ai-content-strategy.*`
- Voice brainstorm with brand vision: `capture/voice-brainstorms/2026-02-01-1059-ben-deepify-ai:-brand-vision.*`

**What's missing:** No catalog of the 12 sessions, no intro script, no content calendar, nothing published.

**Key narrative principles (from Jake):**
- *"Because it's been there from the beginning. It's not an afterthought."* — empathetic design was foundational
- *"Instead of the legacy programming to make money, it's more for empathy and about people."*
- Education, not sales. Show what's possible with AI-augmented development.

---

## Requirements

### Story 9: Audit & Prep 12 Development Journal Sessions
**Effort:** M (one Ralph iteration)

#### Must Have
1. Catalog of all 12 sessions with: title, duration (audio + video), topic summary, key quotes/moments
2. Publishability assessment for each (ready / needs editing / needs context)
3. Suggested publish order based on narrative arc and audience engagement
4. Identification of any sessions with sensitive content needing review

#### Nice to Have
1. Timestamp markers for the best 2–3 moments in each session (for future short-form clips)
2. Cross-reference which sessions relate to which research sources

### Story 10: Write Introductory Script — "Why Empathetic Design Matters"
**Effort:** S (one Ralph iteration)

#### Must Have
1. Complete script: 60–90 seconds for video OR ~300 words for LinkedIn text post
2. Opens with the problem: sensory overload for dyslexic/ADHD users
3. States empathetic design was foundational from day one, cites research base (40+ sources)
4. Introduces Alex and the team-in-a-box concept
5. Ends with a compelling hook to follow the journey
6. Written in Jake's authentic voice (not corporate, not salesy)

#### Nice to Have
1. Two versions: one for video/audio delivery, one for text-only LinkedIn post
2. Suggested visual accompaniment (what to show while reading the script)

### Story 11: LinkedIn Content Calendar — First 4 Weeks
**Effort:** M (one Ralph iteration)

#### Must Have
1. 4-week calendar with 2–3 posts per week (8–12 posts total)
2. Each post defined: type (video/audio/text/carousel), source session, topic, draft description
3. Intro post scheduled first (from Story 10)
4. Mix of content types — not all video, not all text
5. Hashtag strategy and tagging approach

#### Nice to Have
1. Optimal posting times for LinkedIn developer/tech audience
2. Engagement prompts (questions, polls) woven into some posts
3. Series/theme structure (e.g., "Empathy Monday", "Dev Journal Thursday")

### Story 12: Publish First 3 LinkedIn Posts
**Effort:** M (one Ralph iteration)

#### Must Have
1. 3 fully drafted posts ready for Deeperfire AI LinkedIn
2. Post 1: Introductory piece (from Story 10 script, adapted for LinkedIn)
3. Posts 2–3: Development journal content with rich descriptions
4. All posts have: description, hashtags, accessibility considerations (alt text, readability)
5. Publishing checklist and instructions

#### Nice to Have
1. Engagement monitoring template (what to track in first 48 hours)
2. Response templates for likely comments/questions

---

## Technical Blueprint

### Files to Create

#### Story 9 — Session Audit
- `tasks/ws3-linkedin/README.md` — Workstream overview and status tracker
- `tasks/ws3-linkedin/session-audit.md` — Full catalog of all 12 dev journal sessions with metadata, summaries, key moments, publishability status
- `tasks/ws3-linkedin/publish-order.md` — Recommended publishing sequence with narrative rationale

#### Story 10 — Intro Script
- `tasks/ws3-linkedin/intro-script.md` — The "Why Empathetic Design Matters" script (video + text versions)
- `tasks/ws3-linkedin/intro-visual-notes.md` — Visual accompaniment suggestions for the intro

#### Story 11 — Content Calendar
- `tasks/ws3-linkedin/content-calendar.md` — Full 4-week calendar with post definitions
- `tasks/ws3-linkedin/hashtag-strategy.md` — Hashtag research, tagging approach, and LinkedIn best practices
- `tasks/ws3-linkedin/post-templates.md` — Reusable templates for different post types (video post, text insight, carousel, etc.)

#### Story 12 — First 3 Posts
- `tasks/ws3-linkedin/posts/post-01-intro.md` — Full draft: introductory post with description, hashtags, alt text
- `tasks/ws3-linkedin/posts/post-02-devjournal.md` — Full draft: first dev journal post
- `tasks/ws3-linkedin/posts/post-03-devjournal.md` — Full draft: second dev journal post
- `tasks/ws3-linkedin/publishing-checklist.md` — Step-by-step publishing instructions and quality checks
- `tasks/ws3-linkedin/engagement-tracker.md` — Template for monitoring first 48h engagement per post

### Files to Modify
- `tasks/ws3-linkedin/README.md` — Status updated after each story completion
- `tasks/ws3-linkedin/content-calendar.md` — Updated in Story 12 with actual publish dates

### Dependencies
- Access to the 12 NotebookLM development journal sessions (Jake provides access/exports)
- Deeperfire AI LinkedIn business account credentials
- Deep research sources document (40+ sources on empathetic design) — Jake to share or point to location
- Voice brainstorm transcripts for tone/voice reference: `capture/voice-brainstorms/2026-02-03-0644-ben-deeperfire-ai-content-strategy.md`

---

## Acceptance Criteria

### Story 9
- [ ] `tasks/ws3-linkedin/session-audit.md` exists with all 12 sessions cataloged
- [ ] Each session has: title, duration (audio + video), topic summary, 2–3 key quotes/moments
- [ ] Each session has publishability assessment (ready / needs editing / needs context)
- [ ] `tasks/ws3-linkedin/publish-order.md` exists with sequenced order and rationale

### Story 10
- [ ] `tasks/ws3-linkedin/intro-script.md` exists with complete script
- [ ] Script is 60–90 seconds / ~300 words
- [ ] Script opens with the problem (sensory overload), states empathy-first mission, introduces Alex, ends with hook
- [ ] Script cites research foundation (40+ sources, organizations)
- [ ] Tone matches Jake's voice — authentic, not corporate

### Story 11
- [ ] `tasks/ws3-linkedin/content-calendar.md` has 4 weeks with 2–3 posts per week
- [ ] Each post has: type, source session, topic, draft description
- [ ] Intro post is scheduled first
- [ ] Mix of content types present (video, text, at least 2 types)
- [ ] `tasks/ws3-linkedin/hashtag-strategy.md` exists with researched hashtags

### Story 12
- [ ] `tasks/ws3-linkedin/posts/post-01-intro.md` — complete draft with description, hashtags, alt text
- [ ] `tasks/ws3-linkedin/posts/post-02-devjournal.md` — complete draft with description, hashtags
- [ ] `tasks/ws3-linkedin/posts/post-03-devjournal.md` — complete draft with description, hashtags
- [ ] All posts have accessibility considerations documented
- [ ] `tasks/ws3-linkedin/publishing-checklist.md` exists with step-by-step instructions

---

## Validation Strategy

1. **Story 9:** Cross-reference session audit against the actual NotebookLM sessions — are all 12 accounted for? Are summaries accurate?
2. **Story 10:** Read the script aloud — does it land in 60–90 seconds? Does it sound like Jake, not a press release? Would it make someone want to follow?
3. **Story 11:** Review calendar — is the cadence sustainable (2–3/week)? Is there variety? Does the narrative build over 4 weeks?
4. **Story 12:** Review each post as if scrolling LinkedIn — would you stop and read? Is the description compelling? Are hashtags relevant but not spammy? Is alt text present for any images/videos?

---

## Out of Scope
- **Actually publishing to LinkedIn** — Story 12 prepares drafts and checklist; Jake publishes manually (needs his review/approval)
- **LinkedIn account setup/branding** — assumes profile is already configured; this is content only
- **Short-form clip creation** — that's WS4; this workstream focuses on LinkedIn-native posts
- **Paid promotion / LinkedIn ads** — organic content only
- **Deepify AI LinkedIn** (separate from Deeperfire AI) — this is the Deeperfire AI account only
- **Responding to comments/DMs** — post-publish engagement is outside this workstream
- **Video editing of the journal sessions** — posts reference existing sessions; editing is separate

---

## Success Criteria for Ralph
The agent should output `<promise>COMPLETE</promise>` ONLY when:
- All acceptance criteria for the current story are met
- All files listed in Technical Blueprint exist and are non-empty
- Markdown files contain substantive content (not placeholder text)
- Post drafts are complete, polished, and ready for human review (not outlines)
- Content calendar has specific dates, not just "week 1 / week 2"
- Tone is authentic to Jake's voice (reference brainstorm transcripts for calibration)
- prd.json updated with `passes: true`
