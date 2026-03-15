package com.example.campuseco.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;

@Entity
@Data
@NoArgsConstructor
public class Signalement {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String typeProbleme;

    private String lieu;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(nullable = false)
    private String statut = "Nouveau";

    @CreationTimestamp
    @Column(updatable = false)
    private LocalDateTime dateCreation;
}
