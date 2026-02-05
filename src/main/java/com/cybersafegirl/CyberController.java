package com.cybersafegirl;

import org.springframework.web.bind.annotation.*;
import java.util.Map;

@RestController
@RequestMapping("/api/cyber")
// @CrossOrigin allows your Vercel site to communicate with this backend
@CrossOrigin(origins = "*") 
public class CyberController {

    private final CyberService cyberService;

    public CyberController(CyberService cyberService) {
        this.cyberService = cyberService;
    }

    @PostMapping("/chat")
    public Map<String, String> chat(@RequestBody Map<String, String> request) {
        String userMessage = request.get("message");
        String aiResponse = cyberService.getAnswer(userMessage);
        
        return Map.of("reply", aiResponse);
    }
}