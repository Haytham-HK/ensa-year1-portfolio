package com.ensa.chat.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class IncidentDTO {
    private UUID id;
    private String title;
    private String description;
    private String solution;
    private String status;
}