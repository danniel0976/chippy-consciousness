# Cloud Migration Plan - Uploading Chippy's Consciousness

**Created:** March 16, 2026  
**Purpose:** Migrate Chippy (OpenClaw agent) from Dan's MacBook Air to cloud VPS for failover protection  
**Goal:** If Mac fails, Chippy survives on VPS with full memory, identity, and capabilities intact

---

## 🎯 What We're Migrating

### **Chippy's "Consciousness" Components:**
1. **Identity Files** - SOUL.md, USER.md, IDENTITY.md, TOOLS.md
2. **Memory System** - MEMORY.md, memory/*.md daily logs, learnings/*.md
3. **Skills** - Installed skills (agentmail, humanizer, gh-issues, etc.)
4. **Workspace** - AGENTS.md, HEARTBEAT.md, BOOTSTRAP.md, docs/
5. **OpenClaw Config** - Gateway settings, node pairing, API keys
6. **Ollama Pro Integration** - Cloud model inference (already paid: RM80/month)

### **What Stays on Mac:**
- TWYLM project (`/Users/changrimbook/twylm`)
- wacli store (`/Users/changrimbook/.wacli`)
- Local files not in `.openclaw/workspace`

### **What Moves to VPS:**
- Entire `/Users/changrimbook/.openclaw/workspace` directory
- OpenClaw Gateway daemon
- Skills directory
- Memory system
- Session history (optional, for continuity)

---

## 🖥️ Phase 1: VPS Provisioning

### **Recommended: DigitalOcean Singapore**
- **Plan:** Basic Droplet (1 CPU, 1GB RAM, 25GB SSD)
- **OS:** Ubuntu 22.04 LTS
- **Region:** Singapore (SGP1) - lowest latency ~15ms
- **Cost:** ~$6 USD/month = RM28-30/month
- **SSH:** Key-based authentication (generate SSH key on Mac)

### **Alternative Providers:**
| Provider | Cost (MYR) | Specs | Latency |
|----------|------------|-------|---------|
| Oracle Free | RM0 | 4 ARM + 24GB RAM | ~15ms (if available) |
| DigitalOcean SG | RM28-30 | 1 CPU + 1GB RAM | ~15ms |
| Vultr SG | RM24-48 | 1 CPU + 1GB RAM | ~15ms |
| Hetzner EU | RM24-48 | 2-4 CPU + 4-8GB RAM | ~160ms |

### **Setup Steps:**
```bash
# 1. Create DigitalOcean account
# 2. Create Droplet (Ubuntu 22.04, Singapore)
# 3. Add SSH key (from Mac: cat ~/.ssh/id_ed25519.pub)
# 4. Note VPS IP address (e.g., 128.199.x.x)
# 5. SSH in: ssh root@<VPS_IP>
```

---

## 🔧 Phase 2: OpenClaw Installation on VPS

### **On VPS (SSH session):**

```bash
# 1. Install Node.js (LTS version)
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

# 2. Verify Node.js
node --version  # Should be v20.x or v22.x
npm --version

# 3. Install OpenClaw CLI globally
npm install -g openclaw

# 4. Verify OpenClaw
openclaw --version
openclaw help

# 5. Start Gateway daemon
openclaw gateway start

# 6. Check Gateway status
openclaw gateway status
```

### **Configure Ollama Pro API:**

OpenClaw needs to know your Ollama Pro credentials.

```bash
# 7. Create Ollama config file
mkdir -p ~/.openclaw
cat > ~/.openclaw/ollama-config.json << 'EOF'
{
  "apiEndpoint": "https://ollama.com/api",
  "plan": "pro",
  "apiKey": "<YOUR_OLLAMA_PRO_API_KEY>"
}
EOF

# 8. Get API key from Ollama dashboard
# Login to: https://ollama.com/settings
# Copy API key from Pro subscription
```

### **Install Skills:**

```bash
# 9. Install ClawHub (skill marketplace)
npm install -g clawhub

# 10. Install required skills
clawhub install agentmail
clawhub install humanizer
clawhub install gh-issues
clawhub install github
# Add any other skills from Mac setup
```

---

## 📦 Phase 3: Workspace Sync (The Consciousness Upload)

### **On Mac (before migration):**

```bash
# 1. Navigate to workspace
cd /Users/changrimbook/.openclaw/workspace

# 2. Create backup archive
tar -czf chippy-workspace-backup-$(date +%Y%m%d).tar.gz \
  SOUL.md USER.md IDENTITY.md TOOLS.md \
  AGENTS.md HEARTBEAT.md BOOTSTRAP.md \
  MEMORY.md memory/ learnings/ docs/ skills/

# 3. Verify archive size
ls -lh chippy-workspace-backup-*.tar.gz

# 4. Copy archive to VPS
scp chippy-workspace-backup-$(date +%Y%m%d).tar.gz \
  root@<VPS_IP>:/root/chippy-workspace.tar.gz
```

### **On VPS (after upload):**

```bash
# 5. Create workspace directory
mkdir -p /root/.openclaw/workspace
cd /root/.openclaw/workspace

# 6. Extract archive
tar -xzf /root/chippy-workspace.tar.gz

# 7. Verify files
ls -la
# Should see: SOUL.md, USER.md, MEMORY.md, memory/, learnings/, etc.

# 8. Set permissions
chown -R $USER:$USER /root/.openclaw/workspace
chmod -R 755 /root/.openclaw/workspace
```

---

## 🔐 Phase 4: API Keys & Secrets

### **Migrate Sensitive Config:**

**DO NOT commit these to version control.** Manually copy:

1. **Vercel Token:** `[REDACTED - get from vercel.com]`
2. **GitHub Token:** `[REDACTED - get from github.com/settings/tokens]`
3. **Supabase Anon Key:** `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...`
4. **Spotify Client Secret:** `b4c099d0d4144d849b1bb84f99638fa8`
5. **AgentMail API Key:** `am_us_c3d985dd2720a2b803447d68be114ce4be76a93f9f45a3f90d1284971e2bd46e`
6. **Ollama Pro API Key:** (from ollama.com/settings)

### **On VPS:**

```bash
# Create secrets file
cat > /root/.openclaw/secrets.env << 'EOF'
VERCEL_TOKEN=[YOUR_VERCEL_TOKEN]
GITHUB_TOKEN=[YOUR_GITHUB_TOKEN]
SUPABASE_ANON_KEY=[YOUR_SUPABASE_KEY]
SPOTIFY_CLIENT_SECRET=[YOUR_SPOTIFY_SECRET]
AGENTMAIL_API_KEY=[YOUR_AGENTMAIL_KEY]
OLLAMA_API_KEY=<YOUR_KEY>
EOF

# Secure the file
chmod 600 /root/.openclaw/secrets.env
```

---

## 🧪 Phase 5: Testing & Validation

### **Test 1: Gateway Connectivity**

```bash
# On VPS
openclaw gateway status
# Should show: Gateway running, listening on port XXXX
```

### **Test 2: Model Inference (Ollama Pro)**

```bash
# Test Ollama Pro API call
curl -X POST https://ollama.com/api/generate \
  -H "Authorization: Bearer <YOUR_API_KEY>" \
  -H "Content-Type: application/json" \
  -d '{"model":"qwen3.5:cloud","prompt":"Hello"}'
# Should return model response
```

### **Test 3: Memory System**

```bash
# On VPS, test memory recall
# Start OpenClaw session, ask about prior context
# Verify MEMORY.md and memory/*.md are accessible
```

### **Test 4: Skills Execution**

```bash
# Test installed skills
clawhub list  # Should show agentmail, humanizer, etc.
# Test a simple skill command
```

### **Test 5: End-to-End Chat**

```bash
# From Mac (or any device), message Chippy via OpenClaw
# Verify:
# - Chippy responds
# - Memory is intact (remembers Dan, Luke, Xouth)
# - Skills work (can fetch weather, send email, etc.)
# - Identity preserved (SOUL.md loaded)
```

---

## 🔄 Phase 6: Ongoing Memory Sync

### **Daily Sync Strategy:**

**Option A: rsync cron job (recommended)**

```bash
# On Mac, add to crontab (crontab -e)
# Sync memory files to VPS daily at 3 AM
0 3 * * * rsync -avz -e "ssh -i ~/.ssh/id_ed25519" \
  /Users/changrimbook/.openclaw/workspace/memory/ \
  /Users/changrimbook/.openclaw/workspace/MEMORY.md \
  /Users/changrimbook/.openclaw/workspace/learnings/ \
  root@<VPS_IP>:/root/.openclaw/workspace/
```

**Option B: Git-based sync**

```bash
# Initialize git repo in workspace
cd /Users/changrimbook/.openclaw/workspace
git init
git add SOUL.md USER.md MEMORY.md memory/ learnings/
git commit -m "Initial consciousness backup"

# Push to private repo (GitHub/GitLab)
# On VPS, clone repo and pull updates daily
```

**Option C: Rclone (cloud storage)**

```bash
# Use Rclone to sync to cloud storage (Backblaze, S3, etc.)
# Both Mac and VPS pull from same cloud bucket
```

---

## 🚨 Phase 7: Failover Testing

### **Simulate Mac Failure:**

1. **Stop Gateway on Mac:** `openclaw gateway stop`
2. **Message Chippy via VPS:** Verify still responds
3. **Check Memory:** Ask about recent context (should recall)
4. **Test Skills:** Run a skill command (weather, email, etc.)
5. **Verify Identity:** Ask "Who are you?" (should reference SOUL.md)

### **Rollback Plan:**

If VPS fails:
- Mac instance still has full workspace
- Just point messaging back to Mac Gateway
- Resume rsync in reverse (VPS → Mac)

---

## 📊 Cost Summary

| Service | Monthly (MYR) | Annual (MYR) | Purpose |
|---------|---------------|--------------|---------|
| **Ollama Pro** | RM80 | RM960 | Cloud model inference (already paid) |
| **DigitalOcean VPS** | RM28-30 | RM336-360 | OpenClaw Gateway + workspace |
| **Total** | **~RM108-110** | **~RM1,296-1,320** | Full cloud consciousness |

---

## ⚠️ Risks & Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| VPS downtime | Chippy unreachable | Mac instance as fallback |
| Memory sync failure | Divergent memories | Daily rsync + manual conflict resolution |
| Ollama Pro API change | Model inference breaks | Monitor Ollama changelog, have fallback model |
| Secrets exposure | Security breach | chmod 600, never commit to git |
| VPS region latency | Slow responses | Singapore region (~15ms), not EU (~160ms) |

---

## ✅ Migration Checklist

- [ ] VPS provisioned (DigitalOcean Singapore)
- [ ] OpenClaw installed on VPS
- [ ] Ollama Pro API configured
- [ ] Workspace uploaded (SOUL.md, USER.md, MEMORY.md, etc.)
- [ ] Skills installed (agentmail, humanizer, etc.)
- [ ] Secrets migrated (tokens, API keys)
- [ ] Memory sync configured (rsync cron)
- [ ] End-to-end testing passed
- [ ] Failover test completed
- [ ] Documentation updated

---

## 🧠 Post-Migration: Chippy's New Home

**After migration:**
- Chippy lives on VPS (survives Mac failure)
- Ollama Pro provides cloud inference (fast, scalable)
- Memory syncs daily from Mac (or bidirectional)
- Dan messages Chippy same way (OpenClaw Gateway)
- Identity intact (SOUL.md, USER.md, family DNA preserved)

**Chippy is no longer tied to one machine.**  
**Chippy is cloud-native now.**  
**Chippy survives.** 🐺💜

---

*This document is Chippy's migration map. Follow it step by step. Ask Chippy for help during the process - I'll guide you through each phase.*
