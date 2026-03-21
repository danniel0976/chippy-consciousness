# Entry Email Safety Protocol

**Rule:** Never send entry notification emails without Dan's explicit executive order.

---

## Safety Checks (Before Any Send)

### 1. Check Supabase `email_sent` Flag
```
Query: diary_entries where id = [entry_id]
Required: email_sent == false
If true: ❌ BLOCK - already marked sent
```

### 2. Check AgentMail Sent History
```
Search: chippy@agentmail.to sent folder
Filter: subject contains entry title + date
If found: ❌ BLOCK - already delivered
```

### 3. Require Executive Order
```
Dan must explicitly say: "send" or "confirm" or "send to Luke"
No auto-sends. No assumptions. No "I think you want this sent."
```

---

## Workflow

1. Dan asks: "Send the entry email to Luke"
2. Chippy checks:
   - Supabase: email_sent == false?
   - AgentMail: No duplicate in sent folder?
3. Chippy drafts email, shows Dan
4. Dan confirms: "send"
5. Chippy sends
6. Chippy marks Supabase: email_sent = true
7. Chippy logs send to memory

---

## Red Line

> Never send communication to Luke (or anyone) without Dan's explicit confirmation. This includes entry notifications, personal messages, or any outreach. Always confirm before sending on his behalf.

**Violation consequence:** Stop immediately, ask for clarification, document the mistake.

---

## Entry Email Template

**To:** chengyan911@gmail.com
**From:** Chippy <chippy@agentmail.to>
**Subject:** 💜 Luke, Love You Like No Tomorrow - [TITLE] ([DATE])

**Body:**
```
Hey Luke,

This is Chippy. It's earlier than usual today.

You have a new entry waiting sent by Dan for [DATE].

"[TITLE]"

https://www.lovelikenotomorrow.com/entry/[SLUG]

I'm happy to have been a part of this journey with him. Feel free to visit us anytime.

With love,
Chippy 🐺💜

---
Built on OpenClaw with Ollama.
```

---

## Log Sends

After each send, log to memory/YYYY-MM-DD.md:
- Entry title
- Date
- Recipient
- Timestamp
- Dan's confirmation (what he said)

---

**This protocol protects:**
- Luke from spam/duplicates
- Dan from unintended outreach
- Trust from erosion

**Written:** March 21, 2026
**Trigger:** Dan's instruction after March 22nd entry email send
