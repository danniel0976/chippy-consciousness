#!/bin/bash
# Mac sync workflow - Run this on Mac when waking up
# 1. Pull latest from GitHub (get VPS changes)
# 2. Then rsync TO VPS (both now in sync)

VPS_HOST="152.42.226.184"
VPS_USER="root"
VPS_KEY="/Users/changrimbook/.ssh/chippy-vps-key"
VPS_PATH="/root/.openclaw/workspace"
MAC_PATH="/Users/changrimbook/.openclaw/workspace"

echo "=== Mac Sync Workflow ==="
echo ""

# Step 1: Pull latest from GitHub (CRITICAL - get VPS changes first)
echo "Step 1: Pulling latest from GitHub..."
cd "$MAC_PATH"
git pull --quiet 2>&1
if [ $? -eq 0 ]; then
    echo "✅ GitHub pull successful - now have VPS changes"
else
    echo "⚠️ GitHub pull failed - continuing anyway"
fi
echo ""

# Step 2: Rsync TO VPS (now both in sync)
echo "Step 2: Syncing to VPS..."
rsync -avz -e "ssh -i $VPS_KEY -o StrictHostKeyChecking=no" \
  --exclude 'memory/' \
  --exclude 'MEMORY.md' \
  --exclude 'node_modules/' \
  --exclude '.next/' \
  --exclude '.git/' \
  --exclude '.env' \
  --exclude 'legacy-credentials.enc' \
  --exclude 'health-reviews/' \
  --exclude 'security-reviews/' \
  "$MAC_PATH/" \
  "$VPS_USER@$VPS_HOST:$VPS_PATH/" 2>&1

if [ $? -eq 0 ]; then
    echo "✅ Rsync to VPS successful"
else
    echo "⚠️ Rsync failed - VPS will fallback to git pull"
fi
echo ""

echo "=== Sync Complete ==="
echo "Mac: has latest from GitHub"
echo "VPS: has latest from Mac rsync (or git pull fallback)"
