package com.ensa.incident.repository;

import com.ensa.incident.model.Incident;
import com.ensa.incident.model.Priority;
import com.ensa.incident.model.Status;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface IncidentRepository extends JpaRepository<Incident, UUID> {
    List<Incident> findByTitleContainingIgnoreCaseOrDescriptionContainingIgnoreCase(String title, String description);

    long countByStatus(Status status);
    long countByPriority(Priority priority);

    @org.springframework.data.jpa.repository.Modifying
    @org.springframework.data.jpa.repository.Query("DELETE FROM Incident")
    void deleteAllIncidents();
}
