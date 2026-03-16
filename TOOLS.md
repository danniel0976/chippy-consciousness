# TOOLS.md - Local Notes

Skills define _how_ tools work. This file is for _your_ specifics — the stuff that's unique to your setup.

## What Goes Here

Things like:

- Camera names and locations
- SSH hosts and aliases
- Preferred voices for TTS
- Speaker/room names
- Device nicknames
- Anything environment-specific

## Examples

```markdown
### Cameras

- living-room → Main area, 180° wide angle
- front-door → Entrance, motion-triggered

### SSH

- home-server → 192.168.1.100, user: admin

### TTS

- Preferred voice: "Nova" (warm, slightly British)
- Default speaker: Kitchen HomePod
```

## Why Separate?

Skills are shared. Your setup is yours. Keeping them apart means you can update skills without losing your notes, and share skills without leaking your infrastructure.

---

Add whatever helps you do your job. This is your cheat sheet.

## Rate Limits

- 5 seconds minimum between API calls
- 10 seconds between web searches
- Max 5 searches per batch, then 2-minute break
- If you hit 429 error: STOP, wait 5 minutes, retry

## Budgets

- Daily: $1 (warning at 75%)
- Monthly: $10 (warning at 75%)

## Optimization Notes (Dan's Setup)

**You're already optimized:**
- Running on **Ollama Pro** (qwen3.5:cloud) = $0.0000/token
- No Anthropic/Claude API = no $1,500/mo problem
- 262k context window = plenty of room
- Rate limits + budgets = conservative and in place

**What the Token Optimization Guide doesn't apply:**
- Claude model routing (you're not using Claude)
- Prompt caching (Anthropic feature only)
- Heartbeat LLM download (heartbeat is disabled = zero overhead)

**Behavioral optimizations adopted:**
- Lean session startup (only essential files)
- No spiraling on external API calls
- MEMORY.md only in main session (security + token savings)

## Token Optimization Notes

**Session Startup:** Load only SOUL.md, USER.md, IDENTITY.md, memory/YYYY-MM-DD.md
**MEMORY.md:** Load on-demand via memory_search() only when user asks about prior context
**Model:** Haiku for routine tasks, Sonnet for architecture/security/complex reasoning
**Heartbeat:** Disabled (HEARTBEAT.md empty = no overhead)
