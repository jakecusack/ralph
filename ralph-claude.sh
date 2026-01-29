#!/bin/bash
# Ralph Wiggum (Claude Code version) - With validation and progress tracking
# Based on lessons from Cole Medin's analysis
# Usage: ./ralph-claude.sh [max_iterations]

set -e

MAX_ITERATIONS=${1:-10}
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PRD_FILE="$SCRIPT_DIR/prd.json"
PROGRESS_FILE="$SCRIPT_DIR/progress.txt"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check for claude CLI
if ! command -v claude &> /dev/null; then
    echo -e "${RED}Error: claude CLI not found${NC}"
    exit 1
fi

# Check PRD exists
if [ ! -f "$PRD_FILE" ]; then
    echo -e "${RED}Error: prd.json not found at $PRD_FILE${NC}"
    exit 1
fi

# Initialize progress file
if [ ! -f "$PROGRESS_FILE" ]; then
  echo "# Ralph Progress Log (Claude Code)" > "$PROGRESS_FILE"
  echo "Started: $(date)" >> "$PROGRESS_FILE"
  echo "PRD: $(jq -r '.description' "$PRD_FILE")" >> "$PROGRESS_FILE"
  echo "---" >> "$PROGRESS_FILE"
fi

# Show PRD summary
echo -e "${GREEN}═══════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}  Ralph Loop Starting${NC}"
echo -e "${GREEN}═══════════════════════════════════════════════════════${NC}"
echo ""
echo "PRD: $(jq -r '.project' "$PRD_FILE")"
echo "Branch: $(jq -r '.branchName' "$PRD_FILE")"
echo "Stories: $(jq '.userStories | length' "$PRD_FILE")"
echo "Max iterations: $MAX_ITERATIONS"
echo ""

# Show incomplete stories
echo -e "${YELLOW}Incomplete stories:${NC}"
jq -r '.userStories[] | select(.passes == false) | "  - \(.id): \(.title)"' "$PRD_FILE"
echo ""

# Confirm before starting
read -p "Start Ralph loop? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 0
fi

for i in $(seq 1 $MAX_ITERATIONS); do
  echo ""
  echo -e "${GREEN}═══════════════════════════════════════════════════════${NC}"
  echo -e "${GREEN}  Iteration $i of $MAX_ITERATIONS${NC}"
  echo -e "${GREEN}═══════════════════════════════════════════════════════${NC}"
  
  # Log iteration start
  echo "" >> "$PROGRESS_FILE"
  echo "## Iteration $i — $(date)" >> "$PROGRESS_FILE"
  
  # Run claude with the ralph prompt
  OUTPUT=$(cat "$SCRIPT_DIR/prompt.md" | claude --dangerously-skip-permissions 2>&1) || true
  echo "$OUTPUT"
  
  # Log output summary (first 500 chars)
  echo "Output summary: ${OUTPUT:0:500}..." >> "$PROGRESS_FILE"
  
  # Check for completion signal
  if echo "$OUTPUT" | grep -q "<promise>COMPLETE</promise>"; then
    echo "" >> "$PROGRESS_FILE"
    echo "✅ COMPLETED at iteration $i" >> "$PROGRESS_FILE"
    
    echo ""
    echo -e "${GREEN}✅ Ralph completed all tasks!${NC}"
    echo "Completed at iteration $i of $MAX_ITERATIONS"
    
    # Show final PRD status
    echo ""
    echo -e "${GREEN}Final status:${NC}"
    jq -r '.userStories[] | "\(.id): \(.title) — passes: \(.passes)"' "$PRD_FILE"
    
    exit 0
  fi
  
  # Show progress between iterations
  echo ""
  echo -e "${YELLOW}Current PRD status:${NC}"
  PASSED=$(jq '[.userStories[] | select(.passes == true)] | length' "$PRD_FILE")
  TOTAL=$(jq '.userStories | length' "$PRD_FILE")
  echo "  Completed: $PASSED / $TOTAL"
  
  # Optional: Human checkpoint every 3 iterations
  if [ $((i % 3)) -eq 0 ] && [ $i -lt $MAX_ITERATIONS ]; then
    echo ""
    echo -e "${YELLOW}Human checkpoint — Review progress?${NC}"
    read -p "Continue? (y/n/q to quit) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Qq]$ ]]; then
        echo "Stopped by user at iteration $i"
        echo "Stopped by user at iteration $i" >> "$PROGRESS_FILE"
        exit 0
    fi
  fi
  
  echo "Iteration $i complete. Continuing..."
  sleep 2
done

echo ""
echo -e "${YELLOW}⚠️ Ralph reached max iterations ($MAX_ITERATIONS)${NC}"
echo "Check $PROGRESS_FILE for status."
echo "Max iterations reached" >> "$PROGRESS_FILE"
exit 1
