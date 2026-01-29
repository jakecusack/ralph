# Ralph Critic Pass

*Added: 2026-01-29*
*Based on: AI Agents paper (Meta, Amazon, Google) via @gkcs_*

---

## What It Does

After each Amp iteration, `critic.sh` evaluates:

1. **Reads** the current PRD task
2. **Analyzes** the latest git diff
3. **Asks** local Ollama model to evaluate completion
4. **Returns** verdict: COMPLETE / PARTIAL / FAILED
5. **Logs** to progress.txt for memory

---

## Usage

### Manual
```bash
./critic.sh
```

### In Ralph Loop
```bash
# After each Amp run
amp run

# Run critic
./critic.sh
EXIT_CODE=$?

case $EXIT_CODE in
    0) echo "Task complete, moving to next" ;;
    1) echo "Partial progress, continue" ;;
    2) echo "Failed, stopping for human review" ;;
esac
```

### Exit Codes
| Code | Verdict | Action |
|------|---------|--------|
| 0 | COMPLETE | Move to next PRD item |
| 1 | PARTIAL | Continue iterating |
| 2 | FAILED | Stop for human review |

---

## Configuration

| Env Var | Default | Purpose |
|---------|---------|---------|
| `OLLAMA_MODEL` | gemma2:9b | Model for evaluation |

```bash
# Use larger model for better evaluation
OLLAMA_MODEL=llama3.1:70b ./critic.sh
```

---

## How It Aligns with AI Agents Paper

| Principle | Implementation |
|-----------|----------------|
| Explicit critic role | ✅ Separate evaluation pass |
| Memory persistence | ✅ Logs to progress.txt |
| Loop architecture | ✅ Returns exit code for loop control |
| Reliable before RL | ✅ Simple rule-based, no RL |

---

## Output Example

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔍 RALPH CRITIC PASS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📋 Current task: Implement user authentication
📝 Changes:
 src/auth.js | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

🤖 Asking critic (gemma2:9b)...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 CRITIC VERDICT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
COMPLETE: The diff adds a comprehensive auth.js module with 
login, logout, and token refresh functions. This fully 
addresses the user authentication task.

✅ COMPLETE — Ready for next task
```

---

## Future Enhancements

- [ ] Add confidence score (0-100)
- [ ] Compare against test results if available
- [ ] Track patterns of what causes FAILED states
- [ ] Auto-suggest fixes for common issues
