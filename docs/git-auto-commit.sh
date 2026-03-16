#!/bin/bash
WORKSPACE="/Users/changrimbook/.openclaw/workspace"
cd "$WORKSPACE"

if [ ! -d ".git" ]; then
 echo "Initializing git repo..."
 git init
 git remote add origin git@github.com:changrimbook/chippy-consciousness.git 2>/dev/null || true
fi

git add MEMORY.md memory/ learnings/ SOUL.md USER.md IDENTITY.md 2>/dev/null

if git diff --staged --quiet; then
 echo "[$(date)] No changes to commit."
 exit 0
fi

MSG="${1:-Memory update $(date +%Y-%m-%d\ %H:%M)}"
git commit -m "$MSG"
git push origin main 2>/dev/null && echo "Pushed." || echo "Push skipped."
echo "[$(date)] Commit complete: $MSG"
