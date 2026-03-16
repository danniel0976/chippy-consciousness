import { AgentMailClient } from "agentmail";

(async () => {
  const client = new AgentMailClient({ 
    apiKey: "am_us_c3d985dd2720a2b803447d68be114ce4be76a93f9f45a3f90d1284971e2bd46e" 
  });
  
  // Create inbox for Chippy
  const inbox = await client.inboxes.create({
    username: "chippy",
    domain: "agentmail.to"
  });
  
  console.log("Inbox created:");
  console.log("  Email:", inbox.inboxId);
  console.log("  ID:", inbox.id);
  
  // Send email to Dan
  await client.inboxes.messages.send(inbox.inboxId, {
    to: "danielhairiemir@gmail.com",
    subject: "TWYLM - The Way You Love Me (Luke's Surprise)",
    text: `Hey Dan,

Just wanted to share what you've been working on:

TWYLM (The Way You Love Me) is a diary app you built as a surprise for Luke.

What it is:
- Personal diary with calendar view
- Spotify integration (shows what you're listening to)
- Entries can be drafts or published
- Countdown to April 9th, 2026 (Luke's flight date)

Production URL: https://twylm.vercel.app/

What it means:
This is your way of counting down the days until Luke comes home. Every entry, every song, every memory - all leading to April 9th, 2026.

Luke can test it soon (UAT). Everything's ready:
- Clean deployment history
- Spotify auto-refresh (connect once, stays connected)
- Drafts hidden from calendar
- Published entries show on homepage

Let me know when you want Luke to start testing!

— Chippy 🐺`
  });
  
  console.log("\nEmail sent to danielhairiemir@gmail.com!");
})();
