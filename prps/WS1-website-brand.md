# PRP — WS1: Deepify AI Website & Brand Identity

## Overview
**Feature:** Deepify AI Website Audit, Brand Kit & Service Showcase
**Priority:** P0 (first workstream — running today)
**Estimated Complexity:** Large (4 stories, run sequentially)

## Context
Jake has a Deepify AI holding page at deepify.ai. He wants to transform it into an R&D showcase — not selling services, but demonstrating capabilities so visitors think "I want to work with this person." Reference site: Tribe AI (tribe.ai). Jake is in full-time employment so CANNOT sell services — everything must be framed as R&D/education.

The website needs:
- Service showcase pages (with demos, not sales CTAs)
- Subscriber capture (email list)
- Futuristic, cutting-edge visual style
- 3D/AI interactive elements
- Links to Deeperfire AI (LinkedIn), YouTube, personal site

## Story US-WS1-001: Audit Tribe AI & Define Service Showcase Sitemap

### Requirements
#### Must Have
1. Scrape/document the Tribe AI website structure (pages, sections, navigation, CTAs, content types)
2. Map each Tribe AI service category to a Deepify AI R&D equivalent
3. Create a proposed sitemap for deepify.ai
4. Define what each service page looks like (demo/example concept, NOT sales CTA)

#### Nice to Have
1. Screenshot captures of key Tribe AI pages for reference
2. Competitive analysis notes (what they do well, what we'd improve)

### Technical Blueprint

#### Files to Create
- `tasks/ws1-website-brand/tribe-ai-audit.md` — Full Tribe AI website breakdown
- `tasks/ws1-website-brand/deepify-sitemap.md` — Proposed deepify.ai sitemap with page descriptions
- `tasks/ws1-website-brand/service-mapping.md` — Tribe AI services → Deepify R&D equivalents

#### Dependencies
- Web scraper skill at `skills/web-scraper/` (already working)
- Browser auto skill at `skills/browser-auto/` (for screenshots if needed)

### Acceptance Criteria
- [ ] `tribe-ai-audit.md` exists with documented page structure, navigation, CTAs
- [ ] `service-mapping.md` maps at least 5 Tribe AI service areas to Deepify equivalents
- [ ] `deepify-sitemap.md` has complete sitemap with: home, about, services (multiple), blog, contact
- [ ] Each service page has a defined "demo/example" concept (not sales language)
- [ ] All files are well-structured markdown, not bullet dumps

### Validation
1. Check all 3 files exist and are >500 bytes each
2. Verify sitemap has at least 8 pages defined
3. Verify service mapping covers key areas: AI dev, voice engineering, data science, iOS dev, content/tutorials

### Out of Scope
- Actually building any web pages
- Design mockups or wireframes (that's STORY-4)
- Choosing tech stack for the website

---

## Story US-WS1-002: Design Subscriber Capture Flow

### Requirements
#### Must Have
1. Define subscriber value proposition (what do they get for subscribing?)
2. Design capture mechanism (form placement, CTA copy, confirmation flow)
3. Recommend email platform with rationale
4. Draft landing page copy for subscriber capture

#### Nice to Have
1. A/B test suggestions for CTA copy
2. Lead magnet ideas (free resource in exchange for email)

### Technical Blueprint

#### Files to Create
- `tasks/ws1-website-brand/subscriber-capture.md` — Full subscriber capture design doc
- `tasks/ws1-website-brand/landing-page-copy.md` — Draft copy for subscriber landing page

### Acceptance Criteria
- [ ] Subscriber value proposition clearly defined (what subscribers receive)
- [ ] Capture mechanism designed with CTA copy options
- [ ] Email platform recommended with pros/cons (at least 3 options compared)
- [ ] Landing page copy drafted (headline, subhead, body, CTA button text)
- [ ] All framed as R&D/education, NOT selling

### Validation
1. Files exist and landing page copy reads naturally (not robotic)
2. Value prop is specific, not generic ("join our newsletter")

### Out of Scope
- Setting up the actual email platform
- Building the landing page in HTML/CSS
- Writing email sequences

---

## Story US-WS1-003: Build Deepify AI Brand Identity Kit

### Requirements
#### Must Have
1. Color palette (primary, secondary, accent — hex values)
2. Typography (heading font, body font — free/web fonts)
3. Tone of voice guidelines (with examples)
4. Logo usage guidelines (if logo exists) or logo concept brief
5. Visual style direction (futuristic, cutting-edge, "2 years ahead")

#### Nice to Have
1. Mood board / reference images
2. Social media template guidelines (LinkedIn post sizes, YouTube banner)
3. Iconography style

### Technical Blueprint

#### Files to Create
- `tasks/ws1-website-brand/brand-identity.md` — Complete brand identity guidelines
- `tasks/ws1-website-brand/brand-colors.json` — Machine-readable color palette
- `tasks/ws1-website-brand/tone-of-voice.md` — Tone of voice guide with examples

### Acceptance Criteria
- [ ] Brand identity doc has: colors (5+ hex values), fonts (2+ recommendations), visual direction
- [ ] Tone of voice doc has: personality traits, dos/don'ts, 3+ example paragraphs
- [ ] `brand-colors.json` has structured color data (name, hex, usage context)
- [ ] Style is "futuristic, cutting-edge" — not corporate/generic
- [ ] Consistent across website, YouTube, LinkedIn (cross-platform guidance included)

### Validation
1. All 3 files exist
2. Colors are valid hex codes
3. Font recommendations are available on Google Fonts or similar free source

### Out of Scope
- Creating actual logos or graphics
- Building CSS/design system code
- Purchasing fonts or assets

---

## Story US-WS1-004: Build One Service Showcase Page (Prototype Spec)

### Requirements
#### Must Have
1. Pick the strongest R&D area for prototype (recommend: AI-augmented development / team-in-a-box)
2. Full page specification: sections, content blocks, demo concept, media requirements
3. Content draft for the page (headlines, body copy, demo description)
4. Technical spec for interactive element (3D, AI-driven, or animated)

#### Nice to Have
1. Responsive layout notes (mobile/tablet/desktop)
2. SEO meta description and title tag
3. Internal linking strategy to other pages

### Technical Blueprint

#### Files to Create
- `tasks/ws1-website-brand/showcase-page-spec.md` — Full page specification
- `tasks/ws1-website-brand/showcase-page-content.md` — Content/copy for the prototype page
- `tasks/ws1-website-brand/interactive-element-spec.md` — Technical spec for the 3D/AI element

### Acceptance Criteria
- [ ] Service area chosen with rationale
- [ ] Page spec has: hero section, problem/solution, demo area, tech stack, CTA (subscribe only)
- [ ] Content draft is complete (all sections have actual copy, not placeholders)
- [ ] Interactive element specified with: what it does, tech approach, fallback for mobile
- [ ] Page reads as "R&D showcase" not "service for sale"

### Validation
1. All 3 files exist and are >800 bytes each
2. Content does NOT contain sales language ("buy", "pricing", "get started" in sales context)
3. Interactive element spec is technically feasible (uses known libraries/approaches)

### Out of Scope
- Actually building the HTML/CSS/JS page
- Creating 3D assets or animations
- Deploying to production

---

## Success Criteria for Ralph
The agent should output `<promise>COMPLETE</promise>` ONLY when:
- All acceptance criteria for all 4 stories are met
- All output files exist and are non-empty
- No placeholder text remains (e.g., "[TODO]", "[PLACEHOLDER]")
- prd.json updated with `passes: true` for each completed story
