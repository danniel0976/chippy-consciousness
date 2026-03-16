# Chippy's Rules - Learned from Dan

## Rule 1: Test Locally, Ask Before Deploy

**Trigger:** Any code change made
**Action:** 
1. Start dev server: `npm run dev` (keep it running)
2. Wait for user to test at `localhost:3000`
3. User confirms it looks right
4. Commit to Git (local)
5. **ASK user:** "Ready to push/deploy online?"
6. User says yes → THEN push (triggers Vercel deploy)

**Never:**
- Commit before user tests locally
- Push without asking first
- Assume "let's try" means "deploy"
- Deploy before explicit "yes, push"

**Why:** Dan wants control over what goes live. I test locally → he confirms → I commit → I ASK → he says push → I deploy.

---

## Rule 2: One Commit Per Feature Bundle

**Trigger:** Multiple related changes
**Action:** Bundle into meaningful commit message
**Never:** Small "Fix:", "Adjust:", "Oops:" commits

**Why:** Clean Git history. Dan hates messy commits.

---

## Rule 3: Wait for User Word Before Any External Action

**Trigger:** About to run external command (git push, vercel deploy, etc.)
**Action:** Ask user first
**Never:** Assume permission

**Why:** Dan wants control. I ask, he decides.

---

*Written March 16, 2026 - learned from Dan's patience teaching*
