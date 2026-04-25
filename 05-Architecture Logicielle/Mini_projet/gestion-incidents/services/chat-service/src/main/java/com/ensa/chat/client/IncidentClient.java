package com.ensa.chat.client;

import com.ensa.chat.dto.IncidentDTO;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;

import java.util.List;

import com.ensa.chat.config.FeignFormConfiguration;

import java.util.Map;

@FeignClient(name = "incident-service", configuration = FeignFormConfiguration.class)
public interface IncidentClient {

    @GetMapping("/api/incidents/search")
    List<IncidentDTO> searchIncidents(@RequestParam("query") String query);

    @PostMapping(value = "/api/incidents", consumes = "multipart/form-data")
    IncidentDTO createIncident(@RequestBody Map<String, ?> parts, @RequestHeader("Authorization") String token);
}