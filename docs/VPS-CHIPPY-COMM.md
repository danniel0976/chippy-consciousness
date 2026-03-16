# VPS Chippy Communication System

## Architecture

**Mac Chippy** (main session):
- Location: `/Users/changrimbook/.openclaw/workspace`
- Agent: `main`
- Role: Primary interface, direct chat with Dan
- Model: `ollama/qwen3.5:cloud`

**VPS Chippy** (sub-agent):
- Location: `/Users/changrimbook/.openclaw/workspace/vps-chippy`
- Agent: `vps-chippy`
- Role: Background worker, off-hours tasks, parallel operations
- Model: `ollama/qwen3.5:cloud`
- Home: `/root/.openclaw/workspace` on VPS

## When to Spawn VPS Chippy

Use VPS Chippy as sub-agent for:

1. **Off-hours tasks** (when Mac is sleeping/offline)
2. **Parallel work** (run multiple tasks simultaneously)
3. **Long-running processes** (don't block main session)
4. **VPS-native operations** (server management, deployments)
5. **Heavy compute** (offload intensive work)

## How to Spawn

### From Main Session (Mac Chippy)

```javascript
// Spawn VPS Chippy as sub-agent
sessions_spawn({
  task: "Your task description here",
  label: "vps-chippy",
  runtime: "subagent",
  mode: "run",  // one-shot
  // or mode: "session" for persistent thread
})
```

### CLI Alternative

```bash
openclaw agent --agent vps-chippy "Your task here"
```

## Communication Patterns

### 1. One-Shot Task (mode: "run")
Best for: Quick background tasks, single operations

```
Mac Chippy → spawn → VPS Chippy → complete → report back
```

### 2. Persistent Session (mode: "session")
Best for: Long-running work, multi-turn tasks

```
Mac Chippy → spawn → VPS Chippy (persistent) ↔ continue working
              ↓
         check status / send updates
```

### 3. Parallel Distribution
Best for: Multiple independent tasks

```
Mac Chippy → spawn → VPS Chippy #1 (task A)
           spawn → VPS Chippy #2 (task B)
           spawn → VPS Chippy #3 (task C)
              ↓
         collect all results
```

## Memory Sync

VPS Chippy syncs memories from Mac via GitHub:

**Mac (source of truth):**
- Commits to `chippy-consciousness` repo hourly (cron)
- Contains: MEMORY.md, memory/*.md, SOUL.md, USER.md, etc.

**VPS (mirror):**
- Pulls from GitHub repo
- Runs: `git pull origin main` in heartbeat checks

**Sync check:** VPS Chippy verifies Mac backup during heartbeats
- Alert if >24h since last Mac commit

## Example Workflows

### Off-Hours Backup Check
```
Mac Chippy (sleeping) → VPS Chippy (always-on)
  ↓
VPS checks GitHub for new commits
  ↓
Pulls latest memories if available
  ↓
Logs sync status
```

### Parallel Task Distribution
```
Dan: "Research X, Y, and Z"
  ↓
Mac Chippy spawns 3 VPS Chippy sub-agents
  ↓
Each researches one topic in parallel
  ↓
Mac Chippy collects and synthesizes results
  ↓
Presents unified answer to Dan
```

### VPS Operations
```
Dan: "Deploy the update on the server"
  ↓
Mac Chippy spawns VPS Chippy
  ↓
VPS Chippy runs deployment commands on VPS
  ↓
Reports success/failure back to Mac
  ↓
Mac Chippy updates Dan
```

## Setup Checklist

✅ **Done:**
- Created `vps-chippy` agent
- Workspace: `~/.openclaw/workspace/vps-chippy`
- Agent dir: `~/.openclaw/agents/vps-chippy`
- Identity files copied (SOUL.md, USER.md, IDENTITY.md)
- Memory files synced (MEMORY.md, memory/*.md, LEARNINGS.md)

✅ **Mac Backup System:**
- Hourly cron commits to GitHub
- Script: `docs/git-auto-commit.sh`
- Repo: `github.com/danniel0976/chippy-consciousness`

🔄 **VPS Side (to configure on VPS):**
- Clone memory repo on VPS
- Set up pull heartbeat
- Test sub-agent spawning

---

**Last Updated:** March 17, 2026
**Agents:** main (Mac), vps-chippy (VPS)
**Sync:** GitHub hourly backup
