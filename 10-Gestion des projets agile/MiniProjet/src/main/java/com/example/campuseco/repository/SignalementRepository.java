package com.example.campuseco.repository;

import com.example.campuseco.entity.Signalement;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SignalementRepository extends JpaRepository<Signalement, Long> {
    @Query("SELECT s.statut, COUNT(s) FROM Signalement s GROUP BY s.statut")
    List<Object[]> countByStatus();
}
