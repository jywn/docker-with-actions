package com.jjubul.dockertest;

import lombok.RequiredArgsConstructor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

public interface TestRepository extends JpaRepository<TestEntity, Long> {
}
