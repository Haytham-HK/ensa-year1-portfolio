package com.ensa.comment.controller;

import com.ensa.comment.model.Comment;
import com.ensa.comment.repository.CommentRepository;
import com.ensa.comment.service.FileStorageService;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/comments")
public class CommentController {

    private static final Logger logger = LoggerFactory.getLogger(CommentController.class);

    private final CommentRepository commentRepository;
    private final FileStorageService fileStorageService;
    private final ObjectMapper objectMapper;

    public CommentController(CommentRepository commentRepository, FileStorageService fileStorageService, ObjectMapper objectMapper) {
        this.commentRepository = commentRepository;
        this.fileStorageService = fileStorageService;
        this.objectMapper = objectMapper;
    }

    @PostMapping
    public ResponseEntity<Comment> createComment(
            @RequestParam(value = "file", required = false) MultipartFile file,
            @RequestParam("comment") String commentStr) {
        try {
            Comment comment = objectMapper.readValue(commentStr, Comment.class);
            logger.info("Received request to create comment for incident: {}", comment.getIncidentId());

            if (file != null && !file.isEmpty()) {
                logger.info("Uploading attachment: {}", file.getOriginalFilename());
                String fileUrl = fileStorageService.uploadFile(file);
                comment.setAttachmentUrl(fileUrl);
            }

            Comment savedComment = commentRepository.save(comment);
            logger.info("Comment saved with ID: {}", savedComment.getId());
            return new ResponseEntity<>(savedComment, HttpStatus.CREATED);
        } catch (Exception e) {
            logger.error("Error creating comment: ", e);
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("/incident/{incidentId}")
    public List<Comment> getCommentsByIncidentId(@PathVariable UUID incidentId) {
        return commentRepository.findByIncidentId(incidentId);
    }
}
