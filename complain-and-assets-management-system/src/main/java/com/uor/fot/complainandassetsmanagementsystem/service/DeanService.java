package com.uor.fot.complainandassetsmanagementsystem.service;

import com.uor.fot.complainandassetsmanagementsystem.dto.UserRegistrationDTO;
import com.uor.fot.complainandassetsmanagementsystem.model.Dean;
import com.uor.fot.complainandassetsmanagementsystem.repository.DeanRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class DeanService {

    private final DeanRepository deanRepository;

    @Autowired
    public DeanService(DeanRepository deanRepository) {
        this.deanRepository = deanRepository;
    }

    // Create or update a Dean
    public Dean saveDean(UserRegistrationDTO registrationDTO) {
        return null;
    }

    // Retrieve a Dean by ID
    public Optional<Dean> getById(Long id) {
        return deanRepository.findById(id);
    }

    // Retrieve all Deans
    public List<Dean> getAll() {
        return deanRepository.findAll();
    }

    // Delete a Dean by ID
    public void deleteById(Long id) {
        deanRepository.deleteById(id);
    }
}
