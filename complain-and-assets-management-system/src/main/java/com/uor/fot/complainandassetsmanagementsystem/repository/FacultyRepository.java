package com.uor.fot.complainandassetsmanagementsystem.repository;

import com.uor.fot.complainandassetsmanagementsystem.model.Faculty;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface FacultyRepository extends JpaRepository<Faculty, Long> {
}
