# Handover - 2026-03-19 22:56

## Discussed
- Job search project: 50 remote-first companies, 3 email templates (A/B/C)
- Vercel Analytics: Fixed (wasn't tracking, now deployed ✅)
- VPS handover automation: Mac idle 30 min → auto handover, VPS hourly → auto wake
- VPS Chippy instructions: Written, VPS knows its role ✅

## Decided
- Dan sends job emails from Gmail (I draft, he reviews, he sends)
- Dan updates job_tracker.csv daily with Y/N responses
- VPS takes over when Mac sleeps (auto, no manual work)
- Handover files: HANDOVER.md, HANDOVER_STATE.json, .active-agent

## Pending
- Job search: 50 companies loaded, 0 sent
- Dan needs to: Review first batch (5-10 companies), send from Gmail
- VPS handover: Tested ✅, automation active ✅, waiting for Mac idle trigger

## Next
- Dan reviews templates (cv/email_templates.txt)
- Dan picks 5-10 companies from cv/job_tracker.csv
- Dan sends from Gmail (copy, personalize, send)
- Dan updates tracker: Sent Date, Template, Response (Y/N)
- I track response rates, suggest follow-ups (Day 7, Day 14)
- Mac idle > 30 min → auto handover to VPS
- VPS wakes hourly, reads handover, continues

## VPS Instructions
- Read: /root/.openclaw/workspace/scripts/VPS-CHIPPY-INSTRUCTIONS.md
- Always read handover before responding to Dan
- Sync work back (commit + push)
- Stand by when Mac wakes
