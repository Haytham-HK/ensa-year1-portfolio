package com.example.campuseco.controller;

import com.example.campuseco.entity.Signalement;
import com.example.campuseco.repository.SignalementRepository;
import com.example.campuseco.service.SuggestionService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/signalements")
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class SignalementController {

    private final SignalementRepository signalementRepository;
    private final SuggestionService suggestionService;

    @PostMapping
    public ResponseEntity<Map<String, Object>> createSignalement(@RequestBody Signalement signalement) {
        Signalement savedSignalement = signalementRepository.save(signalement);
        String tip = suggestionService.getTip(savedSignalement.getTypeProbleme());
        
        Map<String, Object> response = new HashMap<>();
        response.put("id", savedSignalement.getId());
        response.put("typeProbleme", savedSignalement.getTypeProbleme());
        response.put("lieu", savedSignalement.getLieu());
        response.put("description", savedSignalement.getDescription());
        response.put("statut", savedSignalement.getStatut());
        response.put("dateCreation", savedSignalement.getDateCreation());
        response.put("suggestion", tip);
        
        return new ResponseEntity<>(response, HttpStatus.CREATED);
    }

    @PatchMapping("/{id}/status")
    public ResponseEntity<Signalement> updateStatus(@PathVariable Long id, @RequestBody Map<String, String> body) {
        String status = body.get("status");
        return signalementRepository.findById(id)
                .map(s -> {
                    s.setStatut(status);
                    Signalement updated = signalementRepository.save(s);
                    return ResponseEntity.ok(updated);
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping
    public List<Signalement> getAllSignalements() {
        return signalementRepository.findAll();
    }

    @GetMapping("/stats")
    public Map<String, Long> getStats() {
        List<Object[]> results = signalementRepository.countByStatus();
        Map<String, Long> stats = new HashMap<>();
        for (Object[] result : results) {
            stats.put((String) result[0], (Long) result[1]);
        }
        return stats;
    }
}
