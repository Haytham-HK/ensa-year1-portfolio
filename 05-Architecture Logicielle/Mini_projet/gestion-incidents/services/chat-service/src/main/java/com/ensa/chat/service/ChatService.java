package com.ensa.chat.service;

import com.ensa.chat.client.IncidentClient;
import com.ensa.chat.dto.IncidentDTO;
import com.ensa.chat.model.*;
import com.ensa.chat.repository.ChatConversationRepository;
import com.ensa.chat.repository.ChatMessageRepository;
import com.ensa.chat.repository.SuggestionRepository;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class ChatService {

    private final ChatConversationRepository conversationRepository;
    private final ChatMessageRepository messageRepository;
    private final SuggestionRepository suggestionRepository;
    private final IncidentClient incidentClient;
    private final ObjectMapper objectMapper;

    public ChatService(ChatConversationRepository conversationRepository,
                       ChatMessageRepository messageRepository,
                       SuggestionRepository suggestionRepository,
                       IncidentClient incidentClient,
                       ObjectMapper objectMapper) {
        this.conversationRepository = conversationRepository;
        this.messageRepository = messageRepository;
        this.suggestionRepository = suggestionRepository;
        this.incidentClient = incidentClient;
        this.objectMapper = objectMapper;
    }

    @Transactional
    public ChatConversation startConversation(UUID userId) {
        ChatConversation conversation = new ChatConversation();
        conversation.setUserId(userId);
        conversation.setStatus(ConversationStatus.EN_COURS);
        return conversationRepository.save(conversation);
    }

    @Transactional
    public ChatMessage saveMessage(UUID conversationId, Sender sender, String content) {
        ChatConversation conversation = conversationRepository.findById(conversationId)
                .orElseThrow(() -> new RuntimeException("Conversation not found"));

        ChatMessage message = new ChatMessage();
        message.setConversation(conversation);
        message.setSender(sender);
        message.setContent(content);
        message.setTimestamp(LocalDateTime.now());
        return messageRepository.save(message);
    }

    public List<IncidentDTO> searchSimilarIncidents(String query) {
        return incidentClient.searchIncidents(query);
    }

    @Transactional
    public void saveSuggestions(UUID conversationId, List<IncidentDTO> incidents) {
        ChatConversation conversation = conversationRepository.findById(conversationId)
                .orElseThrow(() -> new RuntimeException("Conversation not found"));

        for (IncidentDTO incident : incidents) {
            Suggestion suggestion = new Suggestion();
            suggestion.setConversation(conversation);
            suggestion.setSimilarIncidentId(incident.getId());
            suggestion.setSimilarityScore(0.8f); // Mock score
            suggestion.setAccepted(false);
            suggestionRepository.save(suggestion);
        }
    }

    @Transactional
    public void resolveConversation(UUID conversationId) {
        ChatConversation conversation = conversationRepository.findById(conversationId)
                .orElseThrow(() -> new RuntimeException("Conversation not found"));
        conversation.setStatus(ConversationStatus.RESOLU);
        conversationRepository.save(conversation);
    }

    @Transactional
    public IncidentDTO createIncidentFromConversation(UUID conversationId, String summary, String token) throws JsonProcessingException {
        ChatConversation conversation = conversationRepository.findById(conversationId)
                .orElseThrow(() -> new RuntimeException("Conversation not found"));

        Map<String, String> incidentMap = new HashMap<>();
        incidentMap.put("title", "Incident from Chat: " + summary);
        incidentMap.put("description", "Conversation ID: " + conversationId + "\n" + summary);
        incidentMap.put("status", "NOUVEAU");

        String incidentJson = objectMapper.writeValueAsString(incidentMap);
        
        Map<String, Object> parts = new HashMap<>();
        parts.put("incident", incidentJson);

        IncidentDTO incident = incidentClient.createIncident(parts, token);

        conversation.setStatus(ConversationStatus.INCIDENT_CREE);
        conversation.setProblemSummary(summary);
        conversationRepository.save(conversation);

        return incident;
    }

    public List<ChatMessage> getConversationHistory(UUID conversationId) {
        ChatConversation conversation = conversationRepository.findById(conversationId)
                .orElseThrow(() -> new RuntimeException("Conversation not found"));
        return messageRepository.findByConversationOrderByTimestampAsc(conversation);
    }
}