package com.ensa.chat.repository;

import com.ensa.chat.model.ChatMessage;
import com.ensa.chat.model.ChatConversation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface ChatMessageRepository extends JpaRepository<ChatMessage, UUID> {
    List<ChatMessage> findByConversationOrderByTimestampAsc(ChatConversation conversation);
}