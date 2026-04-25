package com.ensa.chat.controller;

import com.ensa.chat.dto.IncidentDTO;
import com.ensa.chat.model.*;
import com.ensa.chat.service.ChatService;
import com.fasterxml.jackson.core.JsonProcessingException;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@RestController
@RequestMapping("/api/chat")
public class ChatController {

    private static final Logger logger = LoggerFactory.getLogger(ChatController.class);
    private final ChatService chatService;
    private final SimpMessagingTemplate messagingTemplate;

    public ChatController(ChatService chatService, SimpMessagingTemplate messagingTemplate) {
        this.chatService = chatService;
        this.messagingTemplate = messagingTemplate;
    }

    @PostMapping("/start")
    public ChatConversation startConversation(@RequestParam UUID userId) {
        return chatService.startConversation(userId);
    }

    @GetMapping("/history/{conversationId}")
    public List<ChatMessage> getHistory(@PathVariable UUID conversationId) {
        return chatService.getConversationHistory(conversationId);
    }

    @MessageMapping("/chat/{conversationId}")
    public void handleMessage(@DestinationVariable UUID conversationId, ChatMessage message, java.security.Principal principal) throws JsonProcessingException {
        String tokenValue = null;
        String userName = "Anonymous";

        if (principal instanceof JwtAuthenticationToken) {
            JwtAuthenticationToken jwtToken = (JwtAuthenticationToken) principal;
            tokenValue = "Bearer " + jwtToken.getToken().getTokenValue();
            userName = jwtToken.getName();
            SecurityContextHolder.getContext().setAuthentication(jwtToken);
        }
        
        String userContent = message.getContent().trim().toLowerCase();
        logger.info("Chat: Msg from {} in {}: {}", userName, conversationId, userContent);

        // 1. Get history BEFORE saving new message
        List<ChatMessage> history = chatService.getConversationHistory(conversationId);
        
        // 2. Identify the last bot question
        String lastBotMsg = "";
        for (int i = history.size() - 1; i >= 0; i--) {
            if (history.get(i).getSender() == Sender.BOT) {
                lastBotMsg = history.get(i).getContent().toLowerCase();
                break;
            }
        }
        logger.info("Last bot msg found: {}", lastBotMsg);

        // 3. Save current user message
        chatService.saveMessage(conversationId, Sender.USER, message.getContent());

        String botResponse;
        
        // Robust context matching using keywords
        boolean isAskingToCreate = lastBotMsg.contains("crée") && lastBotMsg.contains("incident");
        boolean isAskingIfHelpful = lastBotMsg.contains("solutions") && lastBotMsg.contains("aident");
        boolean userSaidYes = userContent.matches(".*(oui|yes|ok|o|d'accord|da|si).*");

        if (isAskingToCreate) {
            if (userSaidYes) {
                if (tokenValue == null) {
                    botResponse = "Je suis désolé, je ne peux pas créer d'incident sans authentification valide.";
                } else {
                    try {
                        String summary = "Problème non résolu";
                        // Find original problem (skip recent yes/no)
                        for (int i = history.size() - 1; i >= 0; i--) {
                            String c = history.get(i).getContent().toLowerCase();
                            if (history.get(i).getSender() == Sender.USER && !c.matches(".*(oui|yes|non|no|ok|o|n).*")) {
                                summary = history.get(i).getContent();
                                break;
                            }
                        }
                        IncidentDTO created = chatService.createIncidentFromConversation(conversationId, summary, tokenValue);
                        botResponse = "C'est fait ! J'ai créé l'incident #" + created.getId().toString().substring(0,8) + ". Un technicien va s'en occuper.";
                    } catch (Exception e) {
                        logger.error("Failed to create incident from chat", e);
                        botResponse = "Désolé, une erreur technique a empêché la création de l'incident. Voulez-vous réessayer ?";
                    }
                }
            } else {
                botResponse = "Pas de souci. Je reste à votre disposition !";
            }
        } else if (isAskingIfHelpful) {
            if (userSaidYes) {
                chatService.resolveConversation(conversationId);
                botResponse = "Génial ! Ravi d'avoir pu vous aider. À bientôt !";
            } else {
                botResponse = "Je comprends. Souhaitez-vous que je crée un ticket d'incident pour vous ?";
            }
        } else {
            // Default search flow
            List<IncidentDTO> similar = chatService.searchSimilarIncidents(message.getContent());
            if (!similar.isEmpty()) {
                chatService.saveSuggestions(conversationId, similar);
                StringBuilder sb = new StringBuilder("J'ai trouvé des incidents qui pourraient vous aider :\n");
                for (IncidentDTO inc : similar) {
                    sb.append("- ").append(inc.getTitle()).append("\n");
                }
                sb.append("\nCes solutions sont-elles utiles ? (oui/non)");
                botResponse = sb.toString();
            } else {
                botResponse = "Je n'ai pas trouvé de solution dans notre base de connaissances. Voulez-vous que je crée un incident pour vous ?";
            }
        }

        ChatMessage responseMessage = chatService.saveMessage(conversationId, Sender.BOT, botResponse);
        messagingTemplate.convertAndSend("/topic/chat/" + conversationId, responseMessage);
    }

    @PostMapping("/resolve/{conversationId}")
    public void resolve(@PathVariable UUID conversationId) {
        chatService.resolveConversation(conversationId);
    }

    @PostMapping("/create-incident/{conversationId}")
    public IncidentDTO createIncident(@PathVariable UUID conversationId, @RequestParam String summary, JwtAuthenticationToken token) throws JsonProcessingException {
        String tokenValue = "Bearer " + token.getToken().getTokenValue();
        return chatService.createIncidentFromConversation(conversationId, summary, tokenValue);
    }
}
