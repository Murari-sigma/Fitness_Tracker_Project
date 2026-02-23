package com.project.fitness.Controller;

import com.project.fitness.Service.ActivityService;
import com.project.fitness.dto.ActivityRequest;
import com.project.fitness.dto.ActivityResponse;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/activities")
public class ActivityController {

    private final ActivityService activityService;

    public ActivityController(ActivityService activityService) {
        this.activityService = activityService;
    }

    @PostMapping
    public ResponseEntity<ActivityResponse> trackActivity(
            @RequestBody ActivityRequest request) {

        return ResponseEntity.ok(activityService.trackActivity(request));
    }
//    @PostMapping
//    public ResponseEntity<String> test(
//            @RequestBody(required = false) ActivityRequest request) {
//
//        System.out.println("Request: " + request);
//        return ResponseEntity.ok("Working");
//    }

    @GetMapping
    public ResponseEntity<List<ActivityResponse>> getUserActivities(
          @RequestHeader(value = "X-User-ID")  String userId
    ) {
        return ResponseEntity.ok(activityService.getUserActivities(userId));
    }
}
