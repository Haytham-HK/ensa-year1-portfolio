package com.ensa.incident.controller;

import com.ensa.incident.model.Incident;
import com.ensa.incident.repository.IncidentRepository;
import com.ensa.incident.service.FileStorageService;
import com.ensa.incident.client.AiClient;
import com.ensa.incident.client.NotificationClient;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.UUID;
import com.ensa.incident.model.Priority;

import com.ensa.incident.model.Status;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@RestController
@RequestMapping("/api/incidents")
public class IncidentController {

    private static final Logger logger = LoggerFactory.getLogger(IncidentController.class);

    private final IncidentRepository incidentRepository;
    private final AiClient aiClient;
    private final NotificationClient notificationClient;
    private final FileStorageService fileStorageService;
    private final ObjectMapper objectMapper;

    public IncidentController(IncidentRepository incidentRepository, AiClient aiClient, NotificationClient notificationClient, FileStorageService fileStorageService, ObjectMapper objectMapper) {
        this.incidentRepository = incidentRepository;
        this.aiClient = aiClient;
        this.notificationClient = notificationClient;
        this.fileStorageService = fileStorageService;
        this.objectMapper = objectMapper;
    }

    @PostMapping
    public ResponseEntity<Incident> createIncident(@RequestParam(value = "file", required = false) MultipartFile file, @RequestParam("incident") String incidentStr) {
        try {
            Incident incident = objectMapper.readValue(incidentStr, Incident.class);
            logger.info("Received request to create incident: {}", incident.getTitle());
            if (file != null && !file.isEmpty()) {
                logger.info("Uploading file: {}", file.getOriginalFilename());
                String fileUrl = fileStorageService.uploadFile(file);
                incident.setScreenshotUrl(fileUrl);
            }

            logger.info("Calling AI service for priority prediction...");
            Map<String, String> request = new HashMap<>();
            request.put("text", incident.getDescription());
            Map<String, String> aiResponse = aiClient.getPriority(request);
            String priorityString = aiResponse.get("priority");
            logger.info("AI service returned priority: {}", priorityString);
            
            if (priorityString != null) {
                incident.setPriority(Priority.valueOf(priorityString.toUpperCase().trim()));
            } else {
                incident.setPriority(Priority.LOW);
            }

            Incident savedIncident = incidentRepository.save(incident);
            logger.info("Incident saved with ID: {}", savedIncident.getId());

            // Send notification
            try {
                notificationClient.sendNotification("Un nouvel incident a été créé : " + savedIncident.getTitle());
            } catch (Exception e) {
                logger.error("Failed to send notification: ", e);
            }

            return new ResponseEntity<>(savedIncident, HttpStatus.CREATED);
        } catch (Exception e) {
            logger.error("Error creating incident: ", e);
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping
    public List<Incident> getAllIncidents() {
        return incidentRepository.findAll();
    }

    @GetMapping("/search")
    public List<Incident> searchIncidents(@RequestParam String query) {
        return incidentRepository.findByTitleContainingIgnoreCaseOrDescriptionContainingIgnoreCase(query, query);
    }

    @GetMapping("/stats")
    public Map<String, Object> getStats() {
        Map<String, Object> stats = new HashMap<>();
        stats.put("total", incidentRepository.count());
        
        Map<String, Long> statusDistribution = new HashMap<>();
        for (Status status : Status.values()) {
            statusDistribution.put(status.name(), incidentRepository.countByStatus(status));
        }
        stats.put("statusDistribution", statusDistribution);

        Map<String, Long> priorityDistribution = new HashMap<>();
        for (Priority priority : Priority.values()) {
            priorityDistribution.put(priority.name(), incidentRepository.countByPriority(priority));
        }
        stats.put("priorityDistribution", priorityDistribution);

        return stats;
    }

    @GetMapping("/{id}")
    public ResponseEntity<Incident> getIncidentById(@PathVariable UUID id) {
        return incidentRepository.findById(id)
                .map(incident -> new ResponseEntity<>(incident, HttpStatus.OK))
                .orElse(new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }

    @PutMapping("/{id}")
    public ResponseEntity<Incident> updateIncident(@PathVariable UUID id, @RequestBody Incident incidentDetails) {
        return incidentRepository.findById(id)
                .map(incident -> {
                    incident.setTitle(incidentDetails.getTitle());
                    incident.setDescription(incidentDetails.getDescription());
                    incident.setStatus(incidentDetails.getStatus());
                    incident.setPriority(incidentDetails.getPriority());
                    incident.setSolution(incidentDetails.getSolution());
                    Incident updatedIncident = incidentRepository.save(incident);
                    
                    if (updatedIncident.getStatus() == Status.RESOLU) {
                        try {
                            notificationClient.sendNotification("L'incident '" + updatedIncident.getTitle() + "' a été résolu.");
                        } catch (Exception e) {
                            logger.error("Failed to send notification: ", e);
                        }
                    }

                    return new ResponseEntity<>(updatedIncident, HttpStatus.OK);
                })
                .orElse(new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }

    @PutMapping("/{id}/status")
    public ResponseEntity<Incident> updateIncidentStatus(@PathVariable UUID id, @RequestParam Status status) {
        return incidentRepository.findById(id)
                .map(incident -> {
                    incident.setStatus(status);
                    Incident updatedIncident = incidentRepository.save(incident);

                    if (updatedIncident.getStatus() == Status.RESOLU) {
                        try {
                            notificationClient.sendNotification("L'incident '" + updatedIncident.getTitle() + "' a été résolu.");
                        } catch (Exception e) {
                            logger.error("Failed to send notification: ", e);
                        }
                    }

                    return new ResponseEntity<>(updatedIncident, HttpStatus.OK);
                })
                .orElse(new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteIncident(@PathVariable UUID id) {
        return incidentRepository.findById(id)
                .map(incident -> {
                    incidentRepository.delete(incident);
                    return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
                })
                .orElse(new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }

    @DeleteMapping("/all")
    @jakarta.transaction.Transactional
    public ResponseEntity<Void> deleteAllIncidents() {
        logger.info("Received request to delete all incidents");
        incidentRepository.deleteAllIncidents();
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}
