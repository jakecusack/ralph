# PRP: StudyScribe — AI Study Notes App

## Context
StudyScribe is an iOS app that records lectures and turns them into structured study materials (notes, flashcards, quizzes). Built on SermonScribe's proven audio pipeline. Target: UK students during revision season.

- **Full MVP Spec:** `projects/ios-apps/scribe-general/MVP-SPEC.md`
- **Telos Framework:** `projects/ios-apps/scribe-general/TELOS.md`
- **Lessons Learned:** `projects/ios-apps/scribe-general/LESSONS-LEARNED.md`
- **ASC Template:** `projects/sermonscribe-portal/press-pack/text/ASC-SUBMISSION-TEMPLATE.md`

## Technical Foundation
- **Language:** Swift / SwiftUI
- **Min iOS:** 17.0
- **Architecture:** MVVM
- **Storage:** SwiftData (local-first)
- **Sync:** iCloud (CloudKit) — optional, user-controlled
- **Subscriptions:** RevenueCat
- **Audio:** AVFoundation
- **Transcription:** Whisper API (initial), move to on-device later
- **AI Analysis:** Claude API (Haiku for speed)
- **Bundle ID:** `ai.deepify.studyscribe`

## What We're Reusing from SermonScribe
The SermonScribe codebase provides ~90% of the foundation:
- Audio recording with background mode
- Whisper transcription pipeline
- RevenueCat subscription infrastructure
- Basic MVVM architecture
- SwiftUI patterns and components

## What's New (StudyScribe-specific)
- Flashcard UI + spaced repetition logic
- Quiz generation + scoring system
- Course/module organisation
- Academic-focused AI prompts
- Timestamp-synced transcript playback
- New branding, icon, colour scheme

---

# SPRINT 1: Foundation & Core Recording
**Priority:** P0
**Estimated Complexity:** Medium
**Duration:** ~4-5 days

## Requirements

### Must Have
1. Fork SermonScribe codebase into new Xcode project
2. Update bundle ID to `ai.deepify.studyscribe`
3. Remove ALL church/sermon branding, references, icons, and copy
4. New app icon placeholder (can be simple "SS" text for now)
5. New colour scheme: education-focused (blues/teals — academic but modern)
6. Rename all "Sermon" references to "Lecture" in code and UI
7. Home screen: "My Lectures" library view
   - List of all processed lectures
   - Grouped by Course (user-created folders)
   - Search bar
   - Empty state: "Record your first lecture"
   - FAB: "Record New" button
8. Record screen working:
   - Large record button (centred)
   - Live audio waveform visualisation
   - Timer showing duration
   - Pause/resume
   - Course selector (pick which course this lecture belongs to)
   - "Import from Files" option for pre-recorded audio
9. Background audio recording working (can lock phone)
10. Basic "Processing..." state with progress indicator after recording

### Nice to Have
- Haptic feedback on record/stop
- Recording quality indicator

## Technical Blueprint

### Files to Create
- `StudyScribe.xcodeproj` — new Xcode project (forked from SermonScribe)
- `StudyScribe/App/StudyScribeApp.swift` — app entry point
- `StudyScribe/Models/Lecture.swift` — SwiftData model for lectures
- `StudyScribe/Models/Course.swift` — SwiftData model for courses
- `StudyScribe/Views/Home/HomeView.swift` — lecture library
- `StudyScribe/Views/Home/LectureRow.swift` — list row component
- `StudyScribe/Views/Record/RecordView.swift` — recording screen
- `StudyScribe/Views/Record/WaveformView.swift` — audio waveform
- `StudyScribe/Views/Components/CoursePickerView.swift` — course selector
- `StudyScribe/Services/AudioRecorder.swift` — recording service (from SermonScribe)
- `StudyScribe/Services/TranscriptionService.swift` — Whisper pipeline (from SermonScribe)
- `StudyScribe/Theme/Theme.swift` — colours, fonts, spacing
- `StudyScribe/Assets.xcassets/` — new colour set, placeholder icon

### Files to Modify (from SermonScribe base)
- Strip all sermon-specific terminology
- Update Info.plist with new bundle ID, app name
- Add `ITSAppUsesNonExemptEncryption = NO` to Info.plist
- Update background modes capability (audio)

### Dependencies
- RevenueCat SDK (existing)
- No new dependencies for Sprint 1

## Acceptance Criteria
- [ ] App compiles and runs on iOS 17+ simulator
- [ ] No references to "sermon", "church", "bible" anywhere in UI or user-facing strings
- [ ] Home screen shows empty state for new users
- [ ] Can create a Course (e.g. "Biology 101")
- [ ] Can start recording, see waveform, pause/resume, stop
- [ ] Recording continues when phone is locked (background audio)
- [ ] Recording saved and appears in lecture library
- [ ] Can import audio file from Files app
- [ ] "Processing..." state shown after recording stops
- [ ] App icon is placeholder but not SermonScribe's

## Out of Scope (Sprint 1)
- AI transcription and note generation (Sprint 2)
- Flashcards (Sprint 3)
- Quiz mode (Sprint 3)
- Paywall/subscriptions (Sprint 4)
- App Store assets (Sprint 5)

---

# SPRINT 2: AI Transcription & Structured Notes
**Priority:** P0
**Estimated Complexity:** Medium
**Duration:** ~4-5 days

## Requirements

### Must Have
1. After recording, "Process" button triggers transcription pipeline
2. Whisper API transcription (reuse SermonScribe pipeline)
3. Full transcript stored and displayed with timestamps
4. AI note structuring: send transcript to Claude API (Haiku) with academic prompt
5. Structured notes displayed with:
   - Summary (3-4 sentences at top)
   - Sections with headers (auto-detected from lecture content)
   - Key concepts in bold
   - Important points flagged (anything the lecturer emphasised)
6. Lecture detail view with tabs:
   - **Notes tab** — structured AI notes (editable)
   - **Transcript tab** — full raw transcript, searchable
7. Tap a timestamp in transcript → plays audio from that point
8. Notes are editable (student can add their own annotations)
9. Search across all notes (full-text search from home screen)
10. Export as PDF (basic formatting)

### Nice to Have
- Timestamp linking in notes (not just transcript)
- Copy individual sections to clipboard

## AI Prompts

### Note Structuring Prompt
```
You are an academic note-taking assistant. Given this lecture transcript, create structured study notes.

Rules:
1. Start with a 3-4 sentence summary of the lecture
2. Break the content into logical sections with clear headers
3. Bold key concepts, definitions, and important facts
4. Note any examples or case studies mentioned
5. Flag anything the lecturer emphasised ("this will be on the exam", "important", "remember", "key point")
6. Use bullet points for lists
7. Keep the language clear and concise — these are revision notes, not an essay
8. If the lecturer referenced page numbers, chapters, or readings, note them

Subject/Module: {course_name}
Lecture title: {lecture_title}
Date: {date}

Transcript:
{transcript}
```

## Technical Blueprint

### Files to Create
- `StudyScribe/Views/Lecture/LectureDetailView.swift` — main lecture view with tabs
- `StudyScribe/Views/Lecture/NotesTabView.swift` — structured notes display
- `StudyScribe/Views/Lecture/TranscriptTabView.swift` — raw transcript with timestamps
- `StudyScribe/Services/AIService.swift` — Claude API integration for note structuring
- `StudyScribe/Services/PDFExporter.swift` — export notes as PDF
- `StudyScribe/Models/LectureNotes.swift` — structured notes data model
- `StudyScribe/Models/TranscriptSegment.swift` — timestamped transcript segments

### Files to Modify
- `Lecture.swift` — add relationship to notes, transcript
- `HomeView.swift` — add search functionality
- `RecordView.swift` — connect "Process" to transcription pipeline

### Dependencies
- Claude API (Haiku model) — via direct HTTPS calls or Anthropic Swift SDK
- Whisper API — already in SermonScribe base

## Acceptance Criteria
- [ ] Recording triggers transcription when "Process" tapped
- [ ] Full transcript displayed with timestamps
- [ ] Tapping timestamp plays audio from that point
- [ ] AI-structured notes generated with summary, sections, bold key terms
- [ ] Notes tab and Transcript tab both functional
- [ ] Notes are editable (user can type additions)
- [ ] Search finds text across all lectures
- [ ] Export as PDF produces readable document
- [ ] Processing shows progress indicator (not frozen UI)
- [ ] Error handling: shows message if API call fails (network, quota)

## Out of Scope (Sprint 2)
- Flashcards (Sprint 3)
- Quiz mode (Sprint 3)
- Offline AI processing (future — on-device models)

---

# SPRINT 3: Flashcards & Quiz Mode
**Priority:** P0
**Estimated Complexity:** Medium
**Duration:** ~4-5 days

## Requirements

### Must Have — Flashcards
1. "Generate Flashcards" button on lecture detail view
2. AI generates 10-20 flashcards from the lecture notes
3. Flashcard UI: swipeable card deck
   - Front: question or term
   - Back: answer or definition (tap to flip)
   - Swipe right: "Got it"
   - Swipe left: "Review again"
4. Simple spaced repetition: cards marked "Review again" appear more frequently
5. Flashcard count badge on tab
6. Can manually add/edit/delete flashcards

### Must Have — Quiz Mode
1. "Take Quiz" button on lecture detail view
2. AI generates 10 questions from the lecture notes
   - 7 multiple choice (4 options each)
   - 3 short answer
3. Quiz UI:
   - One question per screen
   - Progress bar (1 of 10)
   - Select answer → next question
   - Short answer: text field
4. Score screen at the end
   - X/10 correct
   - Show wrong answers with correct answer
   - "Retry missed questions" button
5. Quiz history: can retake, see previous scores

### Nice to Have
- Difficulty levels (easy/medium/hard)
- Combine flashcards from multiple lectures in same course
- Share flashcard deck with classmates

## AI Prompts

### Flashcard Generation
```
From these lecture notes, generate flashcards for exam revision.

Rules:
1. Create 15 flashcards covering the key concepts
2. Format: JSON array of {"front": "question or term", "back": "answer or definition"}
3. Mix types: definitions (40%), concept explanations (30%), comparisons (20%), applications (10%)
4. Prioritise anything flagged as important or "exam material"
5. Keep answers concise (1-3 sentences max)
6. Use the student's language level — clear, not academic jargon

Subject: {course_name}
Lecture: {lecture_title}

Notes:
{structured_notes}

Output ONLY valid JSON. No markdown, no explanation.
```

### Quiz Generation
```
From these lecture notes, generate an exam-style quiz.

Rules:
1. Create 10 questions total
2. 7 multiple choice with 4 options each (mark correct answer)
3. 3 short answer questions
4. Cover the full range of topics in the lecture
5. Include 1 "deeper understanding" question that requires connecting ideas
6. Format: JSON array
   MC: {"type": "mc", "question": "...", "options": ["A","B","C","D"], "correct": 1, "explanation": "..."}
   Short: {"type": "short", "question": "...", "answer": "...", "explanation": "..."}

Subject: {course_name}
Lecture: {lecture_title}

Notes:
{structured_notes}

Output ONLY valid JSON. No markdown, no explanation.
```

## Technical Blueprint

### Files to Create
- `StudyScribe/Views/Flashcards/FlashcardDeckView.swift` — swipeable deck
- `StudyScribe/Views/Flashcards/FlashcardView.swift` — single card (flip animation)
- `StudyScribe/Views/Quiz/QuizView.swift` — quiz flow controller
- `StudyScribe/Views/Quiz/QuizQuestionView.swift` — single question display
- `StudyScribe/Views/Quiz/QuizResultsView.swift` — score + review screen
- `StudyScribe/Models/Flashcard.swift` — SwiftData model
- `StudyScribe/Models/Quiz.swift` — SwiftData model for quiz + questions
- `StudyScribe/Models/QuizAttempt.swift` — quiz history

### Files to Modify
- `LectureDetailView.swift` — add Flashcards and Quiz tabs
- `AIService.swift` — add flashcard and quiz generation methods

## Acceptance Criteria
- [ ] "Generate Flashcards" produces 10-20 cards from lecture
- [ ] Cards display front/back with flip animation
- [ ] Swipe right = "Got it", swipe left = "Review again"
- [ ] Cards marked for review reappear more frequently
- [ ] Can manually add a flashcard
- [ ] "Take Quiz" generates 10 questions (7 MC + 3 short)
- [ ] Quiz flows one question at a time with progress bar
- [ ] Score shown at end with correct/wrong breakdown
- [ ] "Retry missed" works correctly
- [ ] Quiz history saved (can see previous scores)
- [ ] JSON parsing handles AI output robustly (retry on malformed JSON)

## Out of Scope (Sprint 3)
- Spaced repetition algorithm (just simple "review again" flag for MVP)
- Cross-lecture flashcard decks (v1.1)
- Sharing with classmates (v1.1)

---

# SPRINT 4: Paywall, Subscription & Course Organisation
**Priority:** P0
**Estimated Complexity:** Small-Medium
**Duration:** ~3 days

## Requirements

### Must Have — Paywall
1. RevenueCat integration with new product IDs:
   - `ai.deepify.studyscribe.pro.monthly` — £3.99/month
   - `ai.deepify.studyscribe.pro.annual` — £24.99/year
2. Paywall screen shown when:
   - User tries to process 4th lecture in a month (limit: 3 free/month)
   - User taps Flashcards or Quiz tab (Pro-only features)
3. Paywall UI:
   - Monthly / Annual toggle
   - Feature comparison (free vs pro)
   - "Start 7-day free trial" CTA
   - Restore purchases link
   - Terms/privacy links at bottom
4. Pro badge on home screen when subscribed
5. Lecture count tracker (X of 3 free this month)

### Must Have — Course Organisation
1. Course manager screen:
   - Create new course (name, colour, optional emoji)
   - Edit course name/colour
   - Delete course (moves lectures to "Uncategorised")
2. Assign lecture to course during or after recording
3. Home screen groups lectures by course
4. Course progress: "5 lectures, 23 flashcards, 3 quizzes taken"

### Must Have — Settings
1. Settings screen:
   - Subscription status and manage
   - Audio quality (standard/high)
   - Theme (light/dark/auto)
   - Export all data
   - About / version
   - Support link
   - Privacy policy link

## Technical Blueprint

### Files to Create
- `StudyScribe/Views/Paywall/PaywallView.swift` — subscription screen
- `StudyScribe/Views/Courses/CourseManagerView.swift` — CRUD courses
- `StudyScribe/Views/Courses/CourseDetailView.swift` — single course view
- `StudyScribe/Views/Settings/SettingsView.swift` — app settings
- `StudyScribe/Services/SubscriptionService.swift` — RevenueCat wrapper
- `StudyScribe/Services/LectureCountTracker.swift` — free tier tracking

### Files to Modify
- `HomeView.swift` — group by course, show Pro badge
- `LectureDetailView.swift` — gate flashcards/quiz behind paywall
- `RecordView.swift` — check lecture count before processing

### Dependencies
- RevenueCat SDK (configure with new API key and product IDs)
- StoreKit 2 configuration file matching ASC product IDs

## Acceptance Criteria
- [ ] Free users can process 3 lectures per month
- [ ] 4th lecture shows paywall
- [ ] Tapping Flashcards/Quiz on free tier shows paywall
- [ ] Monthly and annual subscription options displayed
- [ ] Purchase flow works in sandbox
- [ ] Restore purchases works
- [ ] Subscription status persists across app launches
- [ ] Course CRUD works (create, rename, delete)
- [ ] Lectures grouped by course on home screen
- [ ] Settings screen functional with all links

---

# SPRINT 5: Polish, App Store Prep & Submission
**Priority:** P0
**Estimated Complexity:** Medium
**Duration:** ~5 days

## Requirements

### Must Have — Polish
1. Dark mode support (full pass on all screens)
2. Empty states for all lists (lectures, flashcards, quizzes, courses)
3. Loading states / skeleton views during AI processing
4. Error handling with user-friendly messages
5. Haptic feedback on key interactions
6. Accessibility: VoiceOver labels on all interactive elements
7. App icon (proper design — notebook + waveform concept)
8. Launch screen

### Must Have — App Store Prep
1. Generate 5 screenshots (iPhone 15 Pro Max — 1290x2796):
   - Screenshot 1: Recording in progress (hero shot)
   - Screenshot 2: Structured notes output
   - Screenshot 3: Flashcards in action
   - Screenshot 4: Quiz mode
   - Screenshot 5: Course organisation
2. Write App Store copy (using ASC template):
   - App name: "StudyScribe: AI Study Notes" (30 chars)
   - Subtitle: "Record lectures. Ace exams." (27 chars)
   - Promotional text (170 chars)
   - Full description (4000 chars)
   - Keywords (100 chars)
3. App Review notes explaining:
   - Core flow (record → transcribe → notes → flashcards → quiz)
   - Background audio justification
   - AI processing explanation
   - Subscription tiers
4. Privacy nutrition label: "Data Not Collected" (if all on-device) or declare API usage

### Must Have — Portal Site
1. Create GitHub repo: `StudyScribeApp/Portal`
2. Pages:
   - `index.html` — landing page
   - `privacy.html` — privacy policy
   - `terms.html` — terms of service
   - `support.html` — FAQ + contact
3. Deploy to GitHub Pages

### Must Have — Submission
1. Create App ID in Apple Developer portal
2. Create app in App Store Connect
3. Configure subscription group and products
4. Upload build via Xcode
5. Complete all ASC fields (use checklist from ASC-SUBMISSION-TEMPLATE.md)
6. **Jake approves, then submit**

## Acceptance Criteria
- [ ] Dark mode works on all screens
- [ ] No placeholder text or icons in production build
- [ ] 5 screenshots generated and look professional
- [ ] App Store description written and reviewed
- [ ] Portal site live with privacy policy and support
- [ ] All subscription products configured in ASC
- [ ] Build uploaded and processing complete
- [ ] App Review notes written clearly
- [ ] Pre-submit checklist 100% complete
- [ ] Jake has approved submission

## Out of Scope (v1.0 — future versions)
- iPad support
- Apple Watch recording
- visionOS
- On-device transcription (Whisper local)
- Cross-lecture flashcard decks
- Sharing/collaboration
- Widget support
- Siri Shortcuts integration
- Multiple languages

---

# Post-Launch Roadmap (v1.1+)

| Version | Features | Priority |
|---------|----------|----------|
| v1.1 | Cross-lecture flashcards, share deck, improved spaced repetition | High |
| v1.2 | Widgets (next quiz due, study streak), Siri "Record lecture" | Medium |
| v1.3 | On-device Whisper (no API needed), offline mode | High |
| v1.4 | iPad support, Split View | Medium |
| v1.5 | Apple Watch quick-record | Low |
| v2.0 | Study groups (share notes/flashcards with classmates) | High |
