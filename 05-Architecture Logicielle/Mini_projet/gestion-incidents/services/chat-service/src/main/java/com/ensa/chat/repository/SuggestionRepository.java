package com.ensa.chat.repository;

import com.ensa.chat.model.Suggestion;
import com.ensa.chat.model.ChatConversation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface SuggestionRepository extends JpaRepository<Suggestion, UUID> {
    List<Suggestion> findByConversation(ChatConversation conversation);
}