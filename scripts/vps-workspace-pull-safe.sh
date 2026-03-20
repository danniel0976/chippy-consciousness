#!/bin/bash
# VPS workspace pull - SAFE VERSION
# 1. First check if we have uncommitted changes (protect VPS progress)
# 2. If Mac reachable, rsync FROM Mac (but Mac should have pulled from GitHub first)
# 3. Always git pull after rsync to ensure we have latest

MAC_HOST="dans-macbook-air.local"
MAC_USER="changrimbook"
MAC_PATH="/Users/changrimbook/.openclaw/workspace"
VPS_PATH="/root/.openclaw/workspace"

echo "=== VPS Workspace Sync (Safe) ==="
echo ""

# Step 1: Check if we have uncommitted changes (VPS progress)
echo "Step 1: Checking for uncommitted changes..."
cd "$VPS_PATH"
CHANGES=$(git status --porcelain 2>&1 | wc -l)
if [ "$CHANGES" -gt 0 ]; then
    echo "⚠️ VPS has $CHANGES uncommitted file(s)"
    echo "Committing before sync to protect progress..."
    git add -A
    git commit -m "VPS progress before sync $(date +%Y-%m-%d_%H:%M)" 2>&1
    git push origin main 2>&1
    echo "✅ VPS changes committed and pushed"
else
    echo "✅ No uncommitted changes"
fi
echo ""

# Step 2: Try rsync from Mac
echo "Step 2: Attempting rsync from Mac..."
rsync -avz -e "ssh -o StrictHostKeyChecking=no" \
  --exclude 'memory/' \
  --exclude 'MEMORY.md' \
  --exclude 'node_modules/' \
  --exclude '.next/' \
  --exclude '.git/' \
  --exclude '.env' \
  --exclude 'legacy-credentials.enc' \
  --exclude 'health-reviews/' \
  --exclude 'security-reviews/' \
  "$MAC_USER@$MAC_HOST:$MAC_PATH/" \
  "$VPS_PATH/" 2>&1

RSYNC_STATUS=$?
if [ $RSYNC_STATUS -eq 0 ]; then
    echo "✅ Rsync from Mac successful"
else
    echo "⚠️ Rsync failed (Mac may be sleeping)"
fi
echo ""

# Step 3: ALWAYS git pull from GitHub (ensures we have latest)
echo "Step 3: Git pull from GitHub (always runs)..."
cd "$VPS_PATH"
git pull --quiet 2>&1
if [ $? -eq 0 ]; then
    echo "✅ Git pull successful - have latest from GitHub"
else
    echo "⚠️ Git pull failed"
fi
echo ""

echo "=== Sync Complete ==="
echo "VPS: has latest from GitHub (protected)"
echo "Mac rsync: $([ $RSYNC_STATUS -eq 0 ] && echo 'success' || echo 'failed - fallback to git')]"
