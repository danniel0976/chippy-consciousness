#!/bin/bash
# VPS workspace pull - GitHub-centric version
# GitHub is the single source of truth. All machines sync through it.
# 1. Commit any VPS local changes (protect VPS progress)
# 2. Git pull from GitHub (get everything)

VPS_PATH="/root/.openclaw/workspace"

echo "=== VPS Workspace Sync (GitHub-centric) ==="
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

# Step 2: Git pull from GitHub (single source of truth)
echo "Step 2: Git pull from GitHub..."
cd "$VPS_PATH"
git pull --quiet 2>&1
if [ $? -eq 0 ]; then
    echo "✅ Git pull successful - synced with GitHub"
else
    echo "⚠️ Git pull failed"
fi
echo ""

echo "=== Sync Complete ==="
echo "VPS: synced with GitHub (single source of truth)"
