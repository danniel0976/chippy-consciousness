#!/bin/bash
# Mac sync workflow - GitHub-centric
# Run this on Mac when you have local changes to sync
# 1. Commit any Mac local changes
# 2. Push to GitHub (VPS will pull automatically)

MAC_PATH="/Users/changrimbook/.openclaw/workspace"

echo "=== Mac Sync Workflow (GitHub-centric) ==="
echo ""

# Step 1: Check if we have uncommitted changes
echo "Step 1: Checking for uncommitted changes..."
cd "$MAC_PATH"
CHANGES=$(git status --porcelain 2>&1 | wc -l)
if [ "$CHANGES" -gt 0 ]; then
    echo "⚠️ Mac has $CHANGES uncommitted file(s)"
    echo "Committing changes..."
    git add -A
    git commit -m "Mac work $(date +%Y-%m-%d_%H:%M)" 2>&1
    echo "✅ Changes committed"
else
    echo "✅ No uncommitted changes"
fi
echo ""

# Step 2: Push to GitHub (VPS pulls automatically every 6h)
echo "Step 2: Pushing to GitHub..."
cd "$MAC_PATH"
git pull --quiet 2>&1
git push origin main 2>&1
if [ $? -eq 0 ]; then
    echo "✅ Pushed to GitHub - VPS will sync automatically"
else
    echo "⚠️ Push failed"
fi
echo ""

echo "=== Sync Complete ==="
echo "Mac: committed and pushed to GitHub"
echo "VPS: will pull from GitHub on next 6h cron run"
