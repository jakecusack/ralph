# PRP — Product Requirement Prompt Template

## Overview
**Feature:** [Name]
**Priority:** [P0-P3]
**Estimated Complexity:** [Small / Medium / Large]

## Context
What exists today? What problem does this solve?

[Describe current state and why this feature matters]

## Requirements

### Must Have
1. [Requirement]
2. [Requirement]

### Nice to Have
1. [Requirement]

## Technical Blueprint

### Files to Modify
- `path/to/file.ext` — [what changes]

### Files to Create
- `path/to/new-file.ext` — [purpose]

### Dependencies
- [External packages, APIs, services needed]

## Acceptance Criteria
- [ ] [Specific testable criterion]
- [ ] [Specific testable criterion]
- [ ] [Specific testable criterion]

## Validation Strategy
How do we know this works?
1. [Manual test steps]
2. [Automated test if applicable]

## Out of Scope
What this does NOT include (prevents overengineering):
- [Explicitly excluded thing]
- [Explicitly excluded thing]

## Success Criteria for Ralph
The agent should output `<promise>COMPLETE</promise>` ONLY when:
- All acceptance criteria are met
- No JavaScript/Python syntax errors
- Files exist and are non-empty
- prd.json updated with `passes: true`

---

## How to Use

1. Copy this template
2. Fill in for your feature
3. Save as `ralph/prps/[feature-name].md`
4. Reference from prd.json user story
5. Run Ralph with `./ralph-claude.sh`
