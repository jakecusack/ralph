# Ralph Overnight Plan

## How to Run Tonight

```bash
cd ~/Documents/code/ralph && ./ralph-claude.sh 3
```

This will iterate 3 times through the current PRD (dashboard API stories).

## Current PRD: Dashboard & Skills

| Story | Description | Priority |
|-------|-------------|----------|
| US-001 | Dashboard diagram generation API endpoint | 1 |
| US-002 | Wire diagram-viewer Generate button to API | 2 |
| US-003 | Auto-scan diagrams folder for viewer | 3 |

## Estimated Runtime
- ~2 min per story × 3 stories = ~6-10 minutes
- Cost: ~$1-3 Claude API

## Pre-flight Checklist
- [x] Claude CLI authenticated (`claude /login`)
- [x] PRD saved to `ralph/prd.json`
- [x] prompt.md points at correct files
- [x] ralph-claude.sh tested and working
- [ ] Run `git stash` if there are uncommitted changes

## After Run
1. Check `ralph/progress.txt` for results
2. Check `ralph/prd.json` — all `passes: true`?
3. Test dashboard at `localhost:8888`
4. Commit: `git add . && git commit -m "Ralph overnight: dashboard API"`

## Automate with Moltbot Cron

To set up nightly Ralph runs:

```bash
moltbot cron add \
  --name "Overnight Ralph" \
  --cron "0 22 * * *" \
  --session isolated \
  --message "Run the Ralph loop. Execute: cd ~/Documents/code/ralph && ./ralph-claude.sh 5. Check prd.json for results and report what was completed." \
  --deliver \
  --delete-after-run false
```

This runs at 22:00 UTC nightly as an isolated session and reports results back.

To test manually:
```bash
moltbot cron run <jobId> --force
```

To check run history:
```bash
moltbot cron runs --id <jobId> --limit 10
```
