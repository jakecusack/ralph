# PRP: AI Coaching Sprint — Stories COACHING-001 to COACHING-005

## Context
Jake is launching an AI coaching service for C-suite executives — "Build Your Second Brain". 
The service delivers 1:1 sessions teaching executives to leverage AI tools for marginal gains.
Full PRD: tasks/ai-coaching/PRD-ai-coaching-executives.md

## COACHING-001: Landing Page — Executive AI Coaching

### What to Build
A standalone HTML page at `dashboard/ai-coaching-landing.html` that serves as the public-facing 
landing page for Jake's executive AI coaching service.

### Implementation Plan
1. Create `dashboard/ai-coaching-landing.html` — fully self-contained HTML/CSS/JS
2. Design: Dark mode matching Deepify brand (use existing portal.html as style reference)
3. Sections:
   - **Hero**: "Build Your Second Brain" headline + "Are you struggling to keep up with AI?" subhead
   - **Value prop**: 3 cards — 1% Knowledge Gain, Navigate AI for Your Team, Hands-On Tools
   - **How it works**: 3-step flow (Book → Learn → Apply)
   - **What you'll learn**: Tool logos + descriptions (Claude, Zapier, Obsidian, NotebookLM)
   - **Pricing**: £150/session or £600 for 6-week programme (placeholder)
   - **CTA**: "Book Your First Session" button → links to Bookings URL (placeholder href)
   - **About**: Jake Cusack — AI researcher, builder, coach
   - **FAQ**: 4-5 common questions
4. Must be responsive (mobile + desktop)
5. Add to portal.html in a new "Services" section

### Files to Create/Edit
- CREATE: `dashboard/ai-coaching-landing.html`
- EDIT: `dashboard/portal.html` — add link in appropriate section

### Validation
- File exists and is valid HTML
- All sections present
- Responsive (check CSS media queries exist)
- Book Now button present with href

---

## COACHING-003: "Second Brain in 6 Weeks" Curriculum Outline

### What to Build
A detailed curriculum outline document covering the 6-week coaching programme.

### Implementation Plan
1. Create `tasks/ai-coaching/curriculum-outline.md`
2. 6 modules, progressive difficulty:
   - **Week 1**: AI Landscape & Your First Conversation (Claude basics)
   - **Week 2**: Building Your Knowledge Base (Obsidian/NotebookLM)
   - **Week 3**: Automating Workflows (Zapier + AI triggers)
   - **Week 4**: Meeting Intelligence (Recording → Transcription → Summaries)
   - **Week 5**: Strategic Decision Support (AI research + analysis)
   - **Week 6**: Your Complete Second Brain (integration + daily workflow)
3. Each module includes: Title, Description, Learning Outcomes (3-4 each), Tools, Practical Exercise, Homework
4. Aligned with "1% better" / Atomic Habits philosophy
5. Non-technical Week 1, progressively more integrated by Week 6

### Files to Create
- CREATE: `tasks/ai-coaching/curriculum-outline.md`

### Validation
- File exists with 6 modules
- Each module has: title, description, outcomes, tools, exercise
- Progressive difficulty visible

---

## COACHING-005: Session Delivery Template

### What to Build
A reusable template Jake follows for every coaching session.

### Implementation Plan
1. Create `tasks/ai-coaching/session-template.md`
2. Structure:
   - **Pre-Session** (15 min before): Review client profile, prep relevant demos, check tools
   - **Session Flow** (60 min):
     - 0-5 min: Check-in + review last session's action items
     - 5-15 min: Teaching segment (concept + demo)
     - 15-40 min: Hands-on practice (client does it themselves)
     - 40-50 min: Q&A + troubleshooting
     - 50-60 min: Wrap-up + set action items
   - **Post-Session** (30 min after):
     - Save recording
     - Run transcription (Whisper/Claude)
     - Generate session summary (Claude prompt included)
     - Create action plan (template included)
     - Send follow-up email with summary + actions + resources
3. Include actual Claude prompts for summarisation and action plan generation
4. Include example output

### Files to Create
- CREATE: `tasks/ai-coaching/session-template.md`

### Validation
- File exists with all 3 phases (pre, during, post)
- Claude prompts included
- Example output included
