package com.project.fitness.Repository;

import com.project.fitness.Activity;
import com.project.fitness.dto.ActivityResponse;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ActivityRepository extends JpaRepository<Activity, String> {

    List<Activity> findByUserId(String userId);
}
