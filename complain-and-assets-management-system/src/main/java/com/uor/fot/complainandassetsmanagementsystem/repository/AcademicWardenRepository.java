package com.uor.fot.complainandassetsmanagementsystem.repository;

import com.uor.fot.complainandassetsmanagementsystem.model.AcademicWarden;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AcademicWardenRepository extends JpaRepository<AcademicWarden, Long> {
}
