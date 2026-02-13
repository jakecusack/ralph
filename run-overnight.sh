#!/bin/bash
# Ralph Overnight Sprint Runner
# Runs 3 swarm stories with auto mode

set -e

RALPH_DIR="/home/deepifyai/Documents/code/ralph"
cd "$RALPH_DIR"

echo "=== Ralph Overnight Sprint ===" > overnight-log.txt
echo "Started: $(date)" >> overnight-log.txt
echo "" >> overnight-log.txt

# Initialize status
cat > overnight-status.json <<EOF
{
  "started": "$(date -Iseconds)",
  "status": "running",
  "stories_total": 3,
  "stories_completed": 0,
  "current_story": "SWARM-001",
  "errors": []
}
EOF

# Run Ralph with auto mode (3 iterations)
echo "Running Ralph (3 iterations, auto mode)..." >> overnight-log.txt
./ralph-claude.sh --auto 3 >> overnight-log.txt 2>&1 || true

# Update final status
COMPLETED=$(cat prd.json | grep -c '"passes": true' || echo "0")
cat > overnight-status.json <<EOF
{
  "started": "$(cat overnight-status.json | grep started | cut -d'"' -f4)",
  "completed": "$(date -Iseconds)",
  "status": "complete",
  "stories_total": 3,
  "stories_completed": $COMPLETED,
  "log_file": "overnight-log.txt",
  "prd_file": "prd.json"
}
EOF

echo "" >> overnight-log.txt
echo "Completed: $(date)" >> overnight-log.txt
echo "Stories passed: $COMPLETED/3" >> overnight-log.txt

exit 0
