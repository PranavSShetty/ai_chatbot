package com.cybersafegirl;

import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.openai.OpenAiChatOptions;
import org.springframework.stereotype.Service;

@Service
public class CyberService {

    private final ChatClient heavyClient; // Smart 70B Model
    private final ChatClient lightClient; // Fast 8B Model (High Limits)

    // Master Prompt
    private static final String SYSTEM_PROMPT = """
        You are 'CyberSentinel', a senior cybersecurity expert.
        Your goal is to answer questions about web security, network defense, and AI threats.
        
        RULES:
        1. If asked about illegal hacking, strictly refuse and explain the ethical mitigation.
        2. Keep answers professional, technical, and concise.
        3. If the topic is not cybersecurity, politely decline to answer.
        """;

    public CyberService(ChatClient.Builder builder) {
        // FIX: Use .model() instead of .withModel()
        
        // 1. Configure the Smart Model (70B)
        this.heavyClient = builder
                .defaultSystem(SYSTEM_PROMPT)
                .defaultOptions(OpenAiChatOptions.builder()
                        .model("llama-3.3-70b-versatile") // <--- CHANGED HERE
                        .build())
                .build();

        // 2. Configure the Backup Model (8B)
        this.lightClient = builder
                .defaultSystem(SYSTEM_PROMPT)
                .defaultOptions(OpenAiChatOptions.builder()
                        .model("llama-3.1-8b-instant")   // <--- CHANGED HERE
                        .build())
                .build();
    }

    public String getAnswer(String userMessage) {
        try {
            // Attempt to use the Smart Model
            return heavyClient.prompt(userMessage).call().content();
        } catch (Exception e) {
            // If we hit a Rate Limit (429), automatically switch to Backup
            System.err.println("Smart Model Failed. Switching to Backup: " + e.getMessage());
            return lightClient.prompt(userMessage).call().content();
        }
    }
}