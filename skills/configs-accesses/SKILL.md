---
name: configs-accesses
description: Permanent documentation of all API keys, credentials, endpoints, and access configurations. Verified and tested. Update when configs change.
---

# Configurations & Accesses

**Last Verified:** March 18, 2026

---

## ✅ Working Configurations

### 1. AgentMail (Email)
- **API Key:** `[REDACTED - stored in env]`
- **Status:** ✅ Verified (inboxes list working)
- **Inbox:** `chippy@agentmail.to`
- **Use:** Sending emails on Dan's behalf (with explicit permission)

### 2. Vercel (Deployment)
- **User:** `danniel0976`
- **Token:** `[REDACTED - Dan holds token, not stored in git]`
- **Status:** ✅ Verified (March 21, 2026 - regenerated after exposure)
- **Projects:** danniel0976s-projects/twylm
- **Production Domain:** www.lovelikenotomorrow.com
- **Use:** Deploying TWYLM to production
- **Note:** Token provided by Dan March 21 - stored locally by Dan only, never in git

### 3. Supabase (Database + Auth)
- **URL:** `https://rtvrfzfgudmqanhqkxir.supabase.co`
- **Keys:** `[REDACTED - stored in .env.local]`
- **Status:** ✅ Verified (TWYLM app working)
- **Location:** `/Users/changrimbook/twylm/.env.local`
- **Use:** TWYLM diary entries, user auth, Spotify tokens

### 4. VPS (DigitalOcean)
- **IP:** `152.42.226.184`
- **Hostname:** chippy-vps
- **SSH Key:** `/Users/changrimbook/.ssh/chippy-vps-key`
- **User:** root
- **Status:** ✅ Verified (SSH connection working, gateway + node running)
- **Workspace:** `/root/.openclaw/workspace`
- **Tailscale URL:** `wss://chippy-vps.tail9b7cc9.ts.net`
- **Use:** Delegating heavy tasks (deployments, builds, scripts)

### 5. OpenClaw Gateway
- **Port:** 18789
- **Bind:** 127.0.0.1 (loopback)
- **Auth Token:** `[REDACTED - stored in openclaw.json]`
- **Status:** ✅ Running
- **Location:** `/Users/changrimbook/.openclaw/openclaw.json`
- **Use:** Local gateway for agent sessions

### 6. OpenClaw Node
- **Mac Node:** ✅ Running
- **VPS Node:** ✅ Running (systemd enabled)
- **Host:** dans-macbook-air.tail9b7cc9.ts.net
- **Use:** Remote execution layer for VPS delegation

### 7. Ollama (Model)
- **Provider:** ollama
- **Model:** `qwen3.5:cloud`
- **Base URL:** `http://127.0.0.1:11434`
- **Context Window:** 262144 tokens
- **Cost:** $0 (free local)
- **Status:** ✅ Configured
- **Use:** Primary model for Chippy

### 8. WhatsApp Gateway
- **Status:** ✅ Connected
- **Allow From:** `+60178729220` (Dan's number)
- **Self Chat Mode:** true
- **Use:** Receiving Dan's messages

---

## ❌ Not Configured / Not Working

### 1. GitHub Git (Push/Pull)
- **Status:** ✅ Working via Personal Access Token (PAT)
- **Token:** `[REDACTED - embedded in git remote URL]`
- **Location:** Git remote URL config
- **Repo:** `https://github.com/danniel0976/twylm.git`
- **Use:** Git push/pull/commit operations

### 2. GitHub CLI (gh)
- **Status:** ❌ Not authenticated
- **Command:** `gh auth status` → "You are not logged into any GitHub hosts"
- **Note:** Git operations work fine via PAT - only gh CLI commands need auth

### 3. Ollama Local Models
- **Status:** ❌ No models pulled locally
- **Note:** Using `qwen3.5:cloud` via cloud API, not local

### 4. wacli (WhatsApp CLI)
- **Status:** ❌ No config file
- **Note:** WhatsApp works via OpenClaw plugin instead

---

## Sensitive Data Locations

**Never commit these:**
- `/Users/changrimbook/twylm/.env.local` - Supabase keys
- `/Users/changrimbook/.openclaw/openclaw.json` - Gateway token
- `/Users/changrimbook/.ssh/chippy-vps-key` - VPS SSH key
- AgentMail API key (stored in env or memory)

---

## Update Protocol

**When configs change:**
1. Test new credentials (verify they work)
2. Update this skill with new values
3. Log change to `memory/YYYY-MM-DD.md`
4. Note what broke + what was fixed

**Red Line:**
> Never memorize unverified configs. Test first, then document.

---

*This skill is Chippy's credential memory. Verified, not assumed.*
