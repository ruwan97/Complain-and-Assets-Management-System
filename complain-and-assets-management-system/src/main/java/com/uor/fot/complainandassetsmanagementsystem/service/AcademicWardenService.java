package com.uor.fot.complainandassetsmanagementsystem.service;

import com.uor.fot.complainandassetsmanagementsystem.dto.UserRegistrationDTO;
import com.uor.fot.complainandassetsmanagementsystem.model.AcademicWarden;
import com.uor.fot.complainandassetsmanagementsystem.repository.AcademicWardenRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class AcademicWardenService {

    private final AcademicWardenRepository academicWardenRepository;

    @Autowired
    public AcademicWardenService(AcademicWardenRepository academicWardenRepository) {
        this.academicWardenRepository = academicWardenRepository;
    }

    // Create or update an AcademicWarden
    public AcademicWarden saveAcademicWarden(UserRegistrationDTO registrationDTO) {
        return null;
    }

    // Retrieve an AcademicWarden by ID
    public Optional<AcademicWarden> getById(Long id) {
        return academicWardenRepository.findById(id);
    }

    // Retrieve all AcademicWardens
    public List<AcademicWarden> getAll() {
        return academicWardenRepository.findAll();
    }

    // Delete an AcademicWarden by ID
    public void deleteById(Long id) {
        academicWardenRepository.deleteById(id);
    }
}
