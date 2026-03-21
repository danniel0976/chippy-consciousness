import { AgentMailClient } from "agentmail";

(async () => {
  const client = new AgentMailClient({ 
    apiKey: process.env.AGENTMAIL_API_KEY 
  });
  
  // List inboxes
  const inboxes = await client.inboxes.list();
  console.log("Inboxes:", JSON.stringify(inboxes.inboxes, null, 2));
  
  // Get messages from chippy inbox
  if (inboxes.inboxes.length > 0) {
    const chippyInbox = inboxes.inboxes.find(i => i.inboxId.includes("chippy"));
    if (chippyInbox) {
      console.log("\nMessages from", chippyInbox.inboxId);
      const messages = await client.inboxes.messages.list(chippyInbox.inboxId);
      console.log(JSON.stringify(messages, null, 2));
    }
  }
})();
