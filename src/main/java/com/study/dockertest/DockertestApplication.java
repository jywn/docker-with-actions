package com.study.dockertest;

import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@RequiredArgsConstructor
public class DockertestApplication {

    private final TestRepository testRepository;

    public static void main(String[] args) {
        SpringApplication.run(DockertestApplication.class, args);
    }

    @PostConstruct
    public void init() {
        testRepository.save(new TestEntity());
        testRepository.save(new TestEntity());
        testRepository.save(new TestEntity());
    }
}
