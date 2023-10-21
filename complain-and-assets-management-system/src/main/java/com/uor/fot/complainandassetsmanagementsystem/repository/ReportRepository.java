package com.uor.fot.complainandassetsmanagementsystem.repository;

import com.uor.fot.complainandassetsmanagementsystem.model.Report;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ReportRepository extends JpaRepository<Report, Long> {
}

