package com.project.fitness.Controller;

import com.project.fitness.Recommendation;
import com.project.fitness.Service.RecommendationService;
import com.project.fitness.dto.RecommendationRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/recommendation")
@RequiredArgsConstructor
public class RecommendationController {

    private final RecommendationService recommendationService;



    @PostMapping("/generate")
    public ResponseEntity<Recommendation> generateRecommendation(
            @RequestBody RecommendationRequest request) {
         Recommendation recommendation = recommendationService.generateRecommendation(request);
                 return ResponseEntity.ok(recommendation);
    }


    @PostMapping("/user/{userId}")
    public ResponseEntity<List<Recommendation>> generateRecommendation(
            @PathVariable String userId
    ) {
        List<Recommendation> recommendationList
        =  recommendationService.getUserRecommendation(userId);
        return ResponseEntity.ok(recommendationList);
    }


    @PostMapping("/activity/{activityId}")
    public ResponseEntity<List<Recommendation>> getActivityRecommendation(
            @PathVariable String activityId
    ) {
        List<Recommendation> recommendationList
                =  recommendationService.getActivityRecommendation(activityId);
        return ResponseEntity.ok(recommendationList);
    }
}
