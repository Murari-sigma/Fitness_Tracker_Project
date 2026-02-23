package com.project.fitness.example;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
// 1. Sabhi beans (Services, etc.) scan karne ke liye
@ComponentScan(basePackages = "com.project.fitness")
// 2. Entities dhoondne ke liye (User, Activity, etc.)
@EntityScan(basePackages = "com.project.fitness")
// 3. Repositories dhoondne ke liye
@EnableJpaRepositories(basePackages = "com.project.fitness.Repository")
public class Main {
    public static void main(String[] args) {
        SpringApplication.run(Main.class, args);
    }
}