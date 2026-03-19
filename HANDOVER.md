# Handover - 2026-03-19 22:56 (Updated by VPS Chippy)

## Discussed
- Job search project: 50 remote-first companies, 3 email templates (A/B/C)
- Vercel Analytics: Fixed (wasn't tracking, now deployed ✅)
- VPS handover automation: Mac idle 30 min → auto handover, VPS hourly → auto wake
- VPS Chippy instructions: Written, VPS knows its role ✅
- **Entry Email Notification System** (VPS built): Daily scheduler 9 AM AEDT, test mode to Dan's Gmail ✅
- **Memory Protection Protocol** (VPS built): vps-memory/ folder, MEMORY-SYNC-PROTOCOL.md ✅

## Decided
- Dan sends job emails from Gmail (I draft, he reviews, he sends)
- Dan updates job_tracker.csv daily with Y/N responses
- VPS takes over when Mac sleeps (auto, no manual work)
- Handover files: HANDOVER.md, HANDOVER_STATE.json, .active-agent
- Entry email: Test mode first (Dan's Gmail), then switch to Luke when Dan confirms

## Pending
- Job search: 50 companies loaded, 0 sent
- Dan needs to: Review first batch (5-10 companies), send from Gmail
- VPS handover: Tested ✅, automation active ✅, waiting for Mac idle trigger
- Entry email: Dan to review test email, then say "switch to Luke"
- Supabase migration: Add `email_sent` column for entry tracking

## Next
- Dan reviews templates (cv/email_templates.txt)
- Dan picks 5-10 companies from cv/job_tracker.csv
- Dan sends from Gmail (copy, personalize, send)
- Dan updates tracker: Sent Date, Template, Response (Y/N)
- I track response rates, suggest follow-ups (Day 7, Day 14)
- Mac idle > 30 min → auto handover to VPS
- VPS wakes hourly, reads handover, continues
- Entry email: Run migration, first live send to Luke (when Dan confirms)

## VPS Instructions
- Read: /root/.openclaw/workspace/scripts/VPS-CHIPPY-INSTRUCTIONS.md
- Always read handover before responding to Dan
- Sync work back (commit + push)
- Stand by when Mac wakes
