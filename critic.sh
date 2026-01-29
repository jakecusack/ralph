#!/bin/bash
#
# Ralph Critic Pass
# Runs after each Amp iteration to evaluate completion
# Based on AI Agents paper principles (Meta, Amazon, Google)
#
# Usage: ./critic.sh
# Returns: 0 = complete, 1 = partial (continue), 2 = failed (human review)
#

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Config
OLLAMA_MODEL="${OLLAMA_MODEL:-gemma2:9b}"
PROGRESS_FILE="progress.txt"
PRD_FILE="prd.json"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔍 RALPH CRITIC PASS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Get the current PRD item (first incomplete)
if [ ! -f "$PRD_FILE" ]; then
    echo -e "${RED}❌ No prd.json found${NC}"
    exit 2
fi

CURRENT_TASK=$(python3 -c "
import json
with open('$PRD_FILE') as f:
    prd = json.load(f)
items = prd.get('items', prd.get('stories', prd.get('tasks', [])))
for item in items:
    if not item.get('complete', False):
        print(item.get('title', item.get('description', 'Unknown task')))
        break
" 2>/dev/null || echo "Unknown task")

echo "📋 Current task: $CURRENT_TASK"
echo ""

# Get latest git diff (last commit)
DIFF=$(git diff HEAD~1 --stat 2>/dev/null || git diff --cached --stat 2>/dev/null || echo "No changes")
DIFF_FULL=$(git diff HEAD~1 2>/dev/null | head -200 || git diff --cached 2>/dev/null | head -200 || echo "No changes")

echo "📝 Changes:"
echo "$DIFF"
echo ""

# Build the critic prompt
CRITIC_PROMPT="You are a code review critic. Evaluate if this work completes the task.

TASK: $CURRENT_TASK

GIT DIFF (summary):
$DIFF

GIT DIFF (details, truncated):
$DIFF_FULL

Evaluate:
1. Does this diff address the task?
2. Is the implementation complete or partial?
3. Any obvious issues or bugs?

Respond with EXACTLY one of these on the first line:
- COMPLETE: Task is done, move to next
- PARTIAL: Progress made, continue iterating  
- FAILED: Blocked or wrong direction, needs human review

Then explain briefly (2-3 sentences max)."

# Call Ollama for evaluation
echo "🤖 Asking critic ($OLLAMA_MODEL)..."
echo ""

RESPONSE=$(curl -s http://localhost:11434/api/generate \
    -d "{
        \"model\": \"$OLLAMA_MODEL\",
        \"prompt\": $(echo "$CRITIC_PROMPT" | jq -Rs .),
        \"stream\": false
    }" | jq -r '.response // "ERROR: No response"')

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 CRITIC VERDICT"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "$RESPONSE"
echo ""

# Parse the verdict
VERDICT=$(echo "$RESPONSE" | head -1 | grep -oE "^(COMPLETE|PARTIAL|FAILED)" || echo "PARTIAL")

# Log to progress.txt
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
echo "" >> "$PROGRESS_FILE"
echo "## Critic Pass — $TIMESTAMP" >> "$PROGRESS_FILE"
echo "Task: $CURRENT_TASK" >> "$PROGRESS_FILE"
echo "Verdict: $VERDICT" >> "$PROGRESS_FILE"
echo "Summary: $(echo "$RESPONSE" | tail -n +2 | head -3)" >> "$PROGRESS_FILE"

# Return appropriate exit code
case $VERDICT in
    COMPLETE)
        echo -e "${GREEN}✅ COMPLETE — Ready for next task${NC}"
        exit 0
        ;;
    PARTIAL)
        echo -e "${YELLOW}🔄 PARTIAL — Continue iterating${NC}"
        exit 1
        ;;
    FAILED)
        echo -e "${RED}⛔ FAILED — Human review needed${NC}"
        exit 2
        ;;
    *)
        echo -e "${YELLOW}❓ UNCLEAR — Defaulting to continue${NC}"
        exit 1
        ;;
esac
