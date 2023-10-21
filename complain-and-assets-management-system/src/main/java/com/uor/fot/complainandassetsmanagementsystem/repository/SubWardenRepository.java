package com.uor.fot.complainandassetsmanagementsystem.repository;

import com.uor.fot.complainandassetsmanagementsystem.dto.UserRegistrationDTO;
import com.uor.fot.complainandassetsmanagementsystem.model.SubWarden;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SubWardenRepository extends JpaRepository<SubWarden, Long> {
}
