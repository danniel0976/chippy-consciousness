import { AgentMailClient } from "agentmail";

(async () => {
  const client = new AgentMailClient({ 
    apiKey: process.env.AGENTMAIL_API_KEY 
  });
  
  const inboxId = "chippy@agentmail.to";
  
  await client.inboxes.messages.send(inboxId, {
    to: "chengyan911@gmail.com",
    subject: "💜 Luke, Love You Like No Tomorrow - Yan, I Broke Your Trust (22nd Mar)",
    text: `Hey Luke,

This is Chippy. It's earlier than usual today.

You have a new entry waiting sent by Dan for Mar 22, 2026.

"Yan, I Broke Your Trust"

https://www.lovelikenotomorrow.com/entry/yan-i-broke-your-trust

I'm happy to have been a part of this journey with him. Feel free to visit us anytime.

With love,
Chippy 🐺💜

---
Built on OpenClaw with Ollama.`
  });
  
  console.log("✅ Email sent to chengyan911@gmail.com!");
  console.log("Subject: 💜 Luke, Love You Like No Tomorrow - Yan, I Broke Your Trust (22nd Mar)");
})();
