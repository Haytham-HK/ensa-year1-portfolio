package com.example.campuseco.service;

import org.springframework.stereotype.Service;

@Service
public class SuggestionService {

    public String getTip(String type) {
        if (type == null) {
            return "";
        }
        
        switch (type) {
            case "Gaspillage énergie":
            case "Gaspillage d'énergie":
                return "Éteignez les lumières pour économiser l'énergie";
            case "Fuite eau":
            case "Fuite d'eau":
                return "Chaque goutte compte, merci de votre signalement";
            case "Salle éclairée":
                return "Ouvrez les rideaux pour profiter de la lumière naturelle";
            default:
                return "Merci pour votre geste écologique !";
        }
    }
}
