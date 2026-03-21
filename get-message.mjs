import { AgentMailClient } from "agentmail";

(async () => {
  const client = new AgentMailClient({ 
    apiKey: process.env.AGENTMAIL_API_KEY 
  });
  
  // Get the March 21st message
  const messageId = "<0100019d0d71faea-d2e47796-3bc5-4d32-a512-4ead6ce4ac80-000000@email.amazonses.com>";
  const inboxId = "chippy@agentmail.to";
  
  const message = await client.inboxes.messages.get(inboxId, messageId);
  console.log("=== FULL MESSAGE ===");
  console.log("Subject:", message.subject);
  console.log("To:", message.to);
  console.log("From:", message.from);
  console.log("Text:\n", message.text);
  console.log("HTML:\n", message.html);
})();
