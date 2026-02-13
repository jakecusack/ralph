# PRP: iOS Habit Tracker Sprint — Stories HABIT-001 to HABIT-006

## Context
Jake is building a native iOS habit tracker based on Atomic Habits principles.
18 minutes/day = 100+ hours/year. "Never miss 2 days in a row."
Part of the "Life Skills" app suite.
Full PRD: tasks/ios-apps/PRD-habit-tracker.md

**IMPORTANT:** This sprint creates the Xcode project structure and Swift source files.
Freddie (iOS agent on Mac Mini) will compile and test later. We create the code.

## Project Structure
```
projects/habit-tracker/
├── HabitTracker.xcodeproj/     (Xcode project — create manually or via swift package init)
├── HabitTracker/
│   ├── App/
│   │   └── HabitTrackerApp.swift
│   ├── Models/
│   │   ├── Habit.swift          (SwiftData model)
│   │   ├── Goal.swift           (SwiftData model)
│   │   ├── HabitCompletion.swift
│   │   └── MotivationalMode.swift
│   ├── Views/
│   │   ├── ContentView.swift    (Tab bar: Today, Goals, Dashboard, Settings)
│   │   ├── TodayView.swift      (Today's habits checklist)
│   │   ├── GoalListView.swift
│   │   ├── GoalDetailView.swift
│   │   ├── HabitEditView.swift
│   │   ├── DashboardView.swift  (Charts + analytics)
│   │   ├── SettingsView.swift
│   │   └── Components/
│   │       ├── HabitRow.swift
│   │       ├── StreakBadge.swift
│   │       └── CheckInPrompt.swift
│   ├── ViewModels/
│   │   ├── HabitViewModel.swift
│   │   ├── GoalViewModel.swift
│   │   └── DashboardViewModel.swift
│   ├── Services/
│   │   ├── ReminderService.swift  (EventKit — Reminders)
│   │   ├── CalendarService.swift  (EventKit — Calendar)
│   │   ├── AIBreakdownService.swift (Apple Intelligence)
│   │   └── SpeechService.swift   (Voice input)
│   └── Utilities/
│       ├── StreakCalculator.swift
│       ├── Messages.swift        (Motivational copy per mode)
│       └── Constants.swift
├── HabitTrackerTests/
│   ├── StreakCalculatorTests.swift
│   └── HabitModelTests.swift
└── README.md
```

## HABIT-001: Core Habit Tracking Engine

### What to Build
SwiftData models + SwiftUI views for basic habit CRUD and tracking.

### Implementation
1. Create project structure under `projects/habit-tracker/`
2. `Habit.swift` — SwiftData @Model: id, name, description, frequency (daily/weekly/custom), createdAt, isPaused
3. `HabitCompletion.swift` — @Model: id, habitId, date, completed
4. `StreakCalculator.swift` — Pure function: given completions array, calculate current streak + detect "missed 2 days"
5. `TodayView.swift` — Shows today's habits, tap to complete, streak badge per habit
6. `HabitEditView.swift` — Create/edit/delete/pause habits
7. `HabitRow.swift` — Row component with name, streak count, completion toggle
8. Unit tests for StreakCalculator

### Validation
- All .swift files exist and have valid Swift syntax
- Models use @Model macro
- Views use SwiftUI structs
- Tests file exists

---

## HABIT-002: Goal Breakdown — AI-Powered Decomposition

### What to Build
Goal model + decomposition logic + AI integration.

### Implementation
1. `Goal.swift` — @Model: id, title, description, targetDate, status (active/completed/cancelled), habits (relationship)
2. `GoalViewModel.swift` — Decomposition logic: days remaining → monthly/weekly/daily breakdown
3. `AIBreakdownService.swift` — Calls Apple Intelligence Foundation Models for task suggestions (with fallback to rule-based if unavailable)
4. `GoalDetailView.swift` — Shows goal, suggested habits, accept/modify/reject
5. `GoalListView.swift` — All goals with status indicators

### Validation
- Goal model has relationship to habits
- Decomposition calculates time breakdowns
- Fallback logic exists for non-AI devices

---

## HABIT-003: Apple Reminders & Calendar Integration

### Implementation
1. `ReminderService.swift` — EventKit: request access, create/update/delete reminders, sync completion status
2. `CalendarService.swift` — EventKit: create calendar events for scheduled habits
3. Info.plist entries for NSRemindersUsageDescription, NSCalendarsUsageDescription
4. Bidirectional sync: app completion → mark reminder done, reminder done → update app

---

## HABIT-004: Motivational Modes

### Implementation
1. `MotivationalMode.swift` — enum: friendly, determined
2. `Messages.swift` — Dictionary of message templates per mode (10+ per mode)
   - Categories: reminder, streakLoss, checkIn, milestone, encouragement
3. `SettingsView.swift` — Mode selector with preview
4. `CheckInPrompt.swift` — Modal that adapts to mode

---

## HABIT-005: Progress Dashboard

### Implementation
1. `DashboardView.swift` — Swift Charts: streak bar chart, completion line chart
2. `DashboardViewModel.swift` — Aggregate data: daily/weekly/monthly
3. Toggle between time ranges
4. Per-habit and per-goal breakdown cards
5. Check-in triggers at milestones (7d, 30d, 2+ misses)

---

## HABIT-006: Voice Input

### Implementation
1. `SpeechService.swift` — SFSpeechRecognizer wrapper, on-device mode
2. Mic button on GoalDetailView
3. Extract goal title + deadline from transcription
4. Confirmation view before creating goal
5. NSMicrophoneUsageDescription + NSSpeechRecognitionUsageDescription in Info.plist
