package com.ensa.incident.client;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.Map;

@FeignClient(name = "ai-priority-service", url = "${ai-service.url}")
public interface AiClient {
    @PostMapping("/predict-priority")
    Map<String, String> getPriority(@RequestBody Map<String, String> request);
}