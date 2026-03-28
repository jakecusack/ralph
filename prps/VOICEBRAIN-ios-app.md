# Product Requirement Prompt (PRP): VoiceBrain

**Feature**: VoiceBrain — Voice Brain Dump to Structured Output iOS App

**Author**: Jake Cusack / Ben

**Date**: 2026-03-28

---

## Overview

A voice-first iOS app that turns messy voice recordings into structured, actionable output. You talk, it listens, then it sorts your thoughts into tasks, calendar events, notes, and ideas — automatically.

No typing. No account creation. No cloud dependency. Just talk and get organised.

**Why now**: Voice-first apps are eating tap-and-swipe (last30days research, Mar 2026). The "voice brain dump" concept has direct community demand (@awasnikar01 on X, multiple DMs). RevenueCat 2026 data confirms subscription apps are the only profitable indie model. We have all the pieces — Whisper for transcription, local AI for categorisation, SwiftUI for the interface.

**Target**: iPhone users who have ideas throughout the day but hate typing notes. Commuters, founders, creatives, ADHD brains.

**Revenue**: $4.99/month subscription (RevenueCat sweet spot). No free tier — freemium is dead per 2026 data.

---

## User Stories

### Story 1: Quick Voice Capture

**As a** busy professional  
**I want** to tap one button and start talking  
**So that** I can capture thoughts without stopping what I'm doing

**Acceptance Criteria:**
- [ ] App opens to a single large record button
- [ ] Recording starts within 0.5s of tap
- [ ] Visual feedback (waveform or pulse animation) during recording
- [ ] Tap again to stop recording
- [ ] No login, no onboarding wall — works immediately on first launch
- [ ] Works offline (all processing on-device)

---

### Story 2: Automatic Categorisation

**As a** user who just recorded a brain dump  
**I want** my messy thoughts automatically sorted into categories  
**So that** I don't have to manually organise anything

**Acceptance Criteria:**
- [ ] After recording stops, transcription begins automatically
- [ ] Transcription completes within 5s for a 60s recording
- [ ] AI categorises each distinct thought into: Task, Event, Note, or Idea
- [ ] Results displayed as colour-coded cards (one per thought)
- [ ] User can tap a card to edit the text or change its category
- [ ] User can swipe to dismiss/delete a card

**Categories:**
| Category | Colour | Icon | Description |
|----------|--------|------|-------------|
| Task | Blue | ☐ | Something to do, has an action verb |
| Event | Purple | 📅 | Something with a time/date reference |
| Note | Grey | 📝 | Information to remember, no action needed |
| Idea | Green | 💡 | Creative thought, future possibility |

---

### Story 3: Export and Integration

**As a** user who has categorised thoughts  
**I want** to send tasks to Reminders and events to Calendar  
**So that** my brain dump flows into the tools I already use

**Acceptance Criteria:**
- [ ] "Send to Reminders" button for Task cards (uses iOS Reminders API)
- [ ] "Send to Calendar" button for Event cards (uses EventKit)
- [ ] Bulk export: "Send All Tasks" / "Send All Events"
- [ ] Copy to clipboard for any card
- [ ] Share sheet integration for Notes and Ideas
- [ ] All exports happen locally — no server round-trip

---

### Story 4: History and Search

**As a** returning user  
**I want** to see my past brain dumps  
**So that** I can find something I said last week

**Acceptance Criteria:**
- [ ] Home screen shows a feed of past recordings (newest first)
- [ ] Each recording shows: date, duration, number of items per category
- [ ] Tap to expand and see all categorised cards
- [ ] Search bar that searches across all transcriptions
- [ ] Swipe to delete a recording

---

### Story 5: Subscription Gate

**As the** app developer  
**I want** users to subscribe after 5 free brain dumps  
**So that** the app generates recurring revenue

**Acceptance Criteria:**
- [ ] First 5 recordings are free (no card required)
- [ ] After 5, show a clean paywall: "VoiceBrain Pro — £4.99/month"
- [ ] Paywall shows what they get: unlimited recordings, search, export
- [ ] Uses StoreKit 2 for subscription management
- [ ] Restore purchases button
- [ ] No degraded experience for subscribers — everything just works

---

## Technical Requirements

### Architecture
- **Pattern**: MVVM with SwiftUI
- **Language**: Swift 6
- **Min iOS**: 17.0
- **Storage**: SwiftData for local persistence (recordings, transcriptions, categories)
- **No backend**: Everything runs on-device. Zero server infrastructure.

### Key Frameworks
- **Speech** (Apple): On-device speech recognition (SFSpeechRecognizer)
- **AVFoundation**: Audio recording and playback
- **NaturalLanguage**: On-device text classification for categorisation
- **EventKit**: Calendar and Reminders integration
- **StoreKit 2**: Subscription management
- **SwiftUI**: All UI
- **SwiftData**: Local persistence

### AI Categorisation Approach
1. **Transcription**: Apple Speech framework (on-device, no network needed)
2. **Sentence splitting**: Split transcript into distinct thoughts using NaturalLanguage framework
3. **Classification**: Use a fine-tuned CreateML text classifier or rule-based NLP:
   - Contains action verb (do, buy, call, send, fix, build) → Task
   - Contains time reference (tomorrow, Monday, 3pm, next week) → Event
   - Contains "idea", "what if", "maybe", "could" → Idea
   - Everything else → Note
4. **Fallback**: If on-device classification confidence is low, default to Note

### Folder Structure
```
VoiceBrain/
├── App/
│   ├── VoiceBrainApp.swift
│   └── ContentView.swift
├── Features/
│   ├── Recording/
│   │   ├── RecordingView.swift
│   │   ├── RecordingViewModel.swift
│   │   └── AudioRecorder.swift
│   ├── Categorisation/
│   │   ├── CategorisationView.swift
│   │   ├── CategorisationViewModel.swift
│   │   └── ThoughtClassifier.swift
│   ├── History/
│   │   ├── HistoryView.swift
│   │   └── HistoryViewModel.swift
│   └── Paywall/
│       ├── PaywallView.swift
│       └── SubscriptionManager.swift
├── Models/
│   ├── Recording.swift
│   ├── Thought.swift
│   └── Category.swift
├── Services/
│   ├── SpeechService.swift
│   ├── CalendarService.swift
│   └── RemindersService.swift
└── Shared/
    ├── Components/
    │   ├── ThoughtCard.swift
    │   ├── WaveformView.swift
    │   └── CategoryBadge.swift
    └── Extensions/
```

### Patterns to Follow
- UK English in all user-facing strings
- SF Symbols for all icons
- Haptic feedback on record start/stop
- Dark mode support from day one
- Accessibility: VoiceOver labels on all interactive elements
- No force unwraps

### Patterns to AVOID
- **No account creation** — users hate this (49K upvotes on Reddit anti-pattern)
- **No cloud sync in v1** — keep it simple, local-only
- **No onboarding carousel** — open to record button immediately
- **No ads** — subscription only
- **No CoreData** — use SwiftData (modern, simpler)
- **No UIKit wrappers** — pure SwiftUI
- **No third-party analytics** — respect privacy positioning

---

## Design Direction

- **Dark mode default** (matches Deepify AI brand)
- **Minimal UI** — the record button IS the app
- **Colour-coded category cards** with rounded corners and subtle shadows
- **Waveform animation** during recording (not a boring timer)
- **San Francisco font** (system default, clean and native)
- **Accent colour**: Electric blue (#00D4FF) — matches our brand

---

## Validation Strategy

### Testing Requirements
- [ ] Unit tests for ThoughtClassifier (given transcript → correct categories)
- [ ] Unit tests for sentence splitting logic
- [ ] UI tests for core flow: record → categorise → export
- [ ] Test subscription flow with StoreKit testing in Xcode
- [ ] Test offline mode (airplane mode recording + categorisation)

### Quality Gates
- [ ] SwiftLint passes (no warnings)
- [ ] Swift strict concurrency enabled
- [ ] All tests pass on iPhone 15 simulator
- [ ] App size < 20MB
- [ ] Cold launch < 1s
- [ ] Recording to categorised output < 8s for 60s audio

---

## MVP Scope (v1.0)

**In scope:**
- Record voice → transcribe → categorise → display cards
- Edit/delete cards
- Export to Reminders and Calendar
- Recording history with search
- Subscription paywall after 5 free recordings

**Out of scope (v2.0+):**
- iCloud sync across devices
- Apple Watch companion
- Widgets / Live Activities
- Siri Shortcuts / App Intents
- Shared brain dumps (collaboration)
- AI summary of weekly brain dumps

---

## Go-to-Market

Based on community research (last30days, Mar 2026):

1. **Pre-launch**: Reddit post in r/iOSProgramming — "Would you pay £4.99/month for a voice brain dump app?"
2. **TestFlight**: Landing page with signup, target 50+ signups in 48 hours
3. **Launch**: App Store with 3 screenshots + 1 preview video
4. **Content**: 30s TikTok/Reels showing the "talk → organised" flow
5. **Pricing**: £4.99/month, no free tier, 5 free recordings as trial

---

## Research Context

This PRP is backed by last30days research from March 23, 2026:
- Full report: `research/trending-ios-apps-2026.md`
- 155 Reddit threads, 34 X posts, 30 YouTube videos, 12 TikToks, 11 Instagram reels analysed
- Key validation: voice-first apps trending, $4.99/month sweet spot, no-account-required apps have massive demand
- Competitor gap: no single app does voice → auto-categorise → export to native iOS apps
