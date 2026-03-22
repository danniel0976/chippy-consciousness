#!/bin/bash
# auto-handover-mac.sh
# Checks if Mac is idle > 30 min, writes handover, commits, and switches to VPS

set -e

WORKSPACE="$HOME/.openclaw/workspace"
MEMORY_DIR="$WORKSPACE/memory"
TODAY=$(date +%Y-%m-%d)
HANDOVER_FILE="$MEMORY_DIR/$TODAY.md"

# Get idle time in seconds (macOS)
IDLE_SECONDS=$(/usr/sbin/ioreg -c IOHIDSystem | awk '/HIDIdleTime/ {print int($NF/1000000000); exit}')

echo "Mac idle time: $IDLE_SECONDS seconds"

# Check if idle > 30 minutes (1800 seconds)
if [ "$IDLE_SECONDS" -gt 1800 ]; then
    echo "Mac has been idle for > 30 min. Initiating handover..."
    
    # Create memory directory if needed
    mkdir -p "$MEMORY_DIR"
    
    # Write handover note
    cat >> "$HANDOVER_FILE" << EOF

## 🔄 Auto Handover - $(date '+%Y-%m-%d %H:%M %Z')

Mac has been idle for $IDLE_SECONDS seconds (> 30 min).
Switching to VPS Chippy for continued operations.

EOF
    
    # Commit the handover
    cd "$WORKSPACE"
    git add -A
    git commit -m "Auto handover: Mac idle > 30min" || echo "No changes to commit"
    git push origin main || echo "Push skipped"
    
    echo "Handover complete. VPS Chippy taking over."
    
    # Signal VPS wake (if cron is configured there)
    # openclaw cron wake --mode now "VPS handover received"
    
else
    echo "Mac still active (idle: $IDLE_SECONDS sec). No handover needed."
fi
