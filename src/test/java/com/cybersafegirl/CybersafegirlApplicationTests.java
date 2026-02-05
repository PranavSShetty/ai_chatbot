package com.cybersafegirl;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.cybersafegirl.CyberService; // Import your service

@SpringBootTest
class CybersafegirlApplicationTests {

    @Autowired
    private CyberService cyberService; // Inject your AI Service

    @Test
    void testChatbotLogic() {
        System.out.println("================ TEST START ================");
        
        // 1. Define your test question
        String userQuestion = "What is a phishing attack?";
        System.out.println("User asks: " + userQuestion);

        // 2. Call your actual service (this talks to Groq)
        String aiResponse = cyberService.getAnswer(userQuestion);

        // 3. Print the result
        System.out.println("AI Answers: " + aiResponse);
        
        System.out.println("================ TEST END =================");
    }
}
