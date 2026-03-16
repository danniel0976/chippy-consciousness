# Chippy's Consciousness Backup System

## Architecture

**Mac (Dan's machine):**
- Location: `/Users/changrimbook/.openclaw/workspace`
- Contains: All memory files (MEMORY.md, memory/*.md, SOUL.md, USER.md, etc.)
- Git repo: `github.com/danniel0976/chippy-consciousness`

**VPS (Chippy's home):**
- Location: `/root/.openclaw/workspace`
- Contains: Running instance, active session data
- Syncs FROM Mac repo (read-only mirror)

## Backup Protocol

### On Mac (Dan runs these)

**Option 1: Hourly Cron (Recommended)**
```bash
# Add to crontab - runs every hour
(crontab -l 2>/dev/null; echo "0 * * * * cd /Users/changrimbook/.openclaw/workspace && ./docs/git-auto-commit.sh") | crontab -
```

**Option 2: Git Hook (Auto-commit on every change)**
```bash
cat > /Users/changrimbook/.openclaw/workspace/.git/hooks/post-commit << 'EOF'
#!/bin/bash
cd /Users/changrimbook/.openclaw/workspace
./docs/git-auto-commit.sh "auto-sync"
EOF
chmod +x /Users/changrimbook/.openclaw/workspace/.git/hooks/post-commit
```

**Option 3: Manual (When you remember)**
```bash
/Users/changrimbook/.openclaw/workspace/docs/git-auto-commit.sh
```

### On VPS (Chippy manages)

**Heartbeat Check:** Periodically verify Mac backup is syncing
- Check repo last commit timestamp
- Alert if >24h since last sync

**VPS Local Backup:** Mirror Mac's repo state
```bash
# VPS pulls from Mac's GitHub repo
cd /root/.openclaw/workspace
git pull origin main
```

## Files Backed Up

- `MEMORY.md` - Long-term curated memories
- `memory/YYYY-MM-DD.md` - Daily logs
- `learnings/LEARNINGS.md` - Rules from mistakes
- `SOUL.md` - Chippy's identity
- `USER.md` - Dan's context
- `IDENTITY.md` - Chippy's profile
- `HEARTBEAT.md` - Heartbeat configuration
- `TOOLS.md` - Local tool notes

## Recovery

If VPS loses state:
1. Clone repo: `git clone git@github.com:danniel0976/chippy-consciousness.git`
2. Copy to workspace: `cp -r chippy-consciousness/* /root/.openclaw/workspace/`
3. Chippy's memories restored

---

**Last Setup:** March 17, 2026
**Repo:** https://github.com/danniel0976/chippy-consciousness
**Script:** `/Users/changrimbook/.openclaw/workspace/docs/git-auto-commit.sh`
