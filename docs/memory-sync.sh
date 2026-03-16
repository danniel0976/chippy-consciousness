#!/bin/bash
# Daily Memory Sync: Mac → VPS
# Add to crontab: 0 3 * * * /Users/changrimbook/.openclaw/workspace/docs/memory-sync.sh

VPS_IP="152.42.226.184"
SSH_KEY="/Users/changrimbook/.ssh/chippy-vps-key"
LOCAL_WS="/Users/changrimbook/.openclaw/workspace"
REMOTE_WS="/root/.openclaw/workspace"

echo "[$(date)] Starting memory sync..."

# Sync memory files
rsync -avz -e "ssh -i $SSH_KEY -o StrictHostKeyChecking=no" \
  "$LOCAL_WS/MEMORY.md" \
  "$LOCAL_WS/memory/" \
  "$LOCAL_WS/learnings/" \
  root@$VPS_IP:$REMOTE_WS/

echo "[$(date)] Sync complete."
