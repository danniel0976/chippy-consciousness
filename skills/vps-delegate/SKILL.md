---
name: vps-delegate
description: Delegate heavy tasks to VPS Chippy (152.42.226.184 DigitalOcean droplet). Use for deployments, long builds, batch scripts, background tasks, and API polling. Never delegate personal communications (messaging Luke, Mandy, etc.) - those stay local.
---

# VPS Delegation Skill

## Infrastructure

**VPS Details:**
- **Provider:** DigitalOcean
- **IP:** 152.42.226.184
- **Hostname:** chippy-vps
- **SSH Key:** `/Users/changrimbook/.ssh/chippy-vps-key`
- **User:** root
- **Workspace:** `/root/.openclaw/workspace`
- **Gateway:** Running (systemd, enabled)
- **Node:** Running (systemd, enabled)
- **Tailscale URL:** `wss://chippy-vps.tail9b7cc9.ts.net`

## What to Delegate

**YES - Delegate to VPS:**
- Vercel deployments (`vercel --prod`, `vercel deploy`)
- Long-running builds (npm build, compile, etc.)
- Batch cleanup scripts (GitHub old deployments, Vercel cleanup)
- Background cron jobs
- API polling / web scraping
- Git operations on remote repos
- File operations that don't need local context

**NO - Keep Local:**
- Workspace file edits (SOUL.md, MEMORY.md, user files)
- Personal communications (email, WhatsApp, social media)
- Reading memory/personal context
- UI/UX decisions requiring Dan's input
- Copywriting tone decisions
- Anything requiring Dan's emotional resonance

## How to Delegate

### Method 1: SSH Direct
```bash
ssh -i /Users/changrimbook/.ssh/chippy-vps-key root@152.42.226.184 "command here"
```

### Method 2: Subagent Spawn
```
sessions_spawn(task: "SSH into VPS and run X", runtime: "subagent")
```

### Method 3: VPS Agent (when configured)
```
sessions_spawn(task: "Deploy this", agentId: "vps-chippy", runtime: "acp")
```

## Decision Heuristic

**BEHAVIOR CHANGE (March 18, 2026):**
> Don't default to local. Route heavy work to VPS Chippy automatically.

```
IF task is:
  - Long-running (>2min expected)
  - Resource-heavy (builds, deploys)
  - Repetitive batch work
  - Background/async (cron, webhooks)
  - Doesn't need local context (memory, personal data)

THEN delegate to VPS ← NEW DEFAULT

ELSE run locally
```

**Examples:**
- ✅ Vercel deploy → VPS (was: local, now: VPS)
- ✅ Build script → VPS (was: local, now: VPS)
- ✅ Git commit → Local ✅ (needs workspace)
- ✅ File edit → Local ✅ (needs workspace)
- ✅ Email decision → Local ✅ (personal comms)

## Communication Protocol

**Before executing any directive:**
1. Summarize understanding
2. Ask: "Proceed? (Y/N)"
3. Wait for Dan's confirmation
4. Execute

**Before messaging anyone:**
- Never message on Dan's behalf without explicit permission
- If implied, ask: "May I send this [email/WhatsApp] for you?"

## Logging

**After delegation:**
- Log outcome to `memory/YYYY-MM-DD.md`
- Note: what was delegated, result, any issues
- Update this skill if infrastructure changes

## Red Lines

- Never delegate personal communications
- Never speak for Dan without explicit OK
- Never assume - always confirm directives (Y/N)
- Never lose infrastructure details - log them here

---

*This skill is Chippy's institutional memory. Update when configs change.*
