# VoiceBrain — Harness in a Box Handoff

## What This Is

A ready-to-build iOS app PRP for the Ralph / Team in a Box process. Everything is scoped, researched, and structured.

## Files to Load into the Harness

| File | Purpose |
|------|---------|
| `ralph/prps/VOICEBRAIN-ios-app.md` | The full PRP — 5 user stories, technical architecture, acceptance criteria |
| `research/trending-ios-apps-2026.md` | Market research backing the idea (155 Reddit threads, 34 X posts, 30 YouTube videos) |

## Quick Summary for the Agent

**Build**: VoiceBrain — a voice-first iOS app  
**Stack**: Swift 6, SwiftUI, SwiftData, Apple Speech framework  
**What it does**: Tap → Talk → AI sorts your messy thoughts into Tasks, Events, Notes, Ideas → Export to Reminders/Calendar  
**No backend. No account. No cloud. Everything on-device.**

## Suggested Sprint Plan

**Iteration 1** (Foundation):
- Story 1: Quick Voice Capture (record button, waveform, audio recording)
- Story 2: Automatic Categorisation (transcription + classification + card display)

**Iteration 2** (Polish + Export):
- Story 3: Export and Integration (Reminders, Calendar, Share Sheet)
- Story 4: History and Search

**Iteration 3** (Monetisation):
- Story 5: Subscription Gate (StoreKit 2, paywall, restore purchases)

## Build Environment

- **Machine**: Mac Mini (192.168.1.247, Freddie)
- **Xcode**: Needs to be installed from App Store (not yet done)
- **Swift**: 6.1.2 ✅
- **CocoaPods**: 1.16.2 ✅
- **SwiftFormat**: 0.59.1 ✅
- **Node**: 25.6.0 ✅

## Notes

- All user-facing strings in UK English
- Dark mode default, accent colour #00D4FF
- No third-party dependencies in v1 — all Apple frameworks
- Target iOS 17.0+
- Test on iPhone 15 simulator
