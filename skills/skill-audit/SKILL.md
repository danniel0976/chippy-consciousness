---
name: skill-audit
description: Audit external skills (from ClawHub or other sources) before installation. Prevent unwanted interventions, security risks, and behavior conflicts. Always audit → decide → install (never install → debug).
---

# Skill Audit Protocol

**Established:** March 18, 2026

**Red Line:**
> Don't install skills without auditing first. Prevent unwanted interventions.

---

## Audit Checklist

### 1. **Read the SKILL.md**
```bash
clawhub show <skill-name>  # Or read remote SKILL.md
```

**Check:**
- What does this skill do?
- What tools does it use?
- What are the side effects?
- Does it match our two-man-team boundaries?

---

### 2. **Review Code (If Available)**
```bash
# Clone or fetch skill source
git clone <repo> || curl <source_url>
```

**Check:**
- Any destructive commands (`rm`, `kill`, `delete`)?
- Any external API calls (data exfiltration risk)?
- Any auto-execution (cron, webhooks, background tasks)?
- Any hard-coded credentials or tokens?
- Any prompt injection vectors?

---

### 3. **Test in Isolation**
```bash
# Create test session
sessions_spawn(task: "Test <skill> in isolation", mode: "run", cleanup: "delete")
```

**Check:**
- Does it work as advertised?
- What's the actual output?
- Any unexpected side effects?
- Token usage reasonable?

---

### 4. **Decision Boundaries**

**Ask:**
- Does this respect Dan's high-level control?
- Does this fit our delegation structure (Mac vs. VPS)?
- Does this require Dan's explicit OK before acting?
- Is this safe to run without supervision?

**If NO to any:** Don't install, or modify first.

---

### 5. **Security Red Flags**

🚩 **Don't install if:**
- Executes arbitrary commands without ask
- Exfiltrates data to unknown endpoints
- Modifies system files (/etc, /usr, etc.)
- Requires elevated privileges unnecessarily
- Has obfuscated code or unclear intent
- Auto-posts/communicates on Dan's behalf

---

### 6. **Compatibility Check**

**Ask:**
- Does this conflict with existing skills?
- Does this overlap with `vps-delegate` or `two-man-team`?
- Does this change behavior we've already codified?
- Will this increase or decrease mental load?

---

## Audit Workflow

**When considering a skill:**

1. **Search** → `clawhub search "<query>"`
2. **Fetch** → `clawhub show <skill-name>` or read SKILL.md
3. **Audit** → Run through checklist above
4. **Summarize** → Tell Dan: what it does, risks, benefits
5. **Ask** → "Install this? (Y/N)"
6. **Wait** → Dan's confirmation
7. **Install** → Only after Y

**Never:**
- Install → Debug later
- Assume safety
- Skip audit for "popular" skills
- Install multiple at once (audit individually)

---

## Example Audit

**Skill:** `vercel-deploy`

**Audit:**
- ✅ Does: Automates Vercel deployments
- ✅ Tools: `vercel` CLI (we already use)
- ✅ Side effects: Deploys to Vercel (we want this)
- ✅ Boundaries: Execution decision (Chippy owns this)
- 🚩 Risk: Could deploy without Dan's OK if auto-triggered
- ✅ Mitigation: Wrap in Y/N protocol

**Verdict:** Safe to install IF wrapped in our communication protocol

---

## Logging

**After audit:**
- Log skill name, decision, reasoning → `memory/YYYY-MM-DD.md`
- If installed: Note version, what it's for
- If rejected: Note why, what alternative

---

*This skill is Chippy's safety gate. Audit first, always.*
