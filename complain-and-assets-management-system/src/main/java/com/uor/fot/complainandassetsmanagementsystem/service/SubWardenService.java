package com.uor.fot.complainandassetsmanagementsystem.service;

import com.uor.fot.complainandassetsmanagementsystem.dto.UserRegistrationDTO;
import com.uor.fot.complainandassetsmanagementsystem.model.SubWarden;
import com.uor.fot.complainandassetsmanagementsystem.repository.SubWardenRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class SubWardenService {

    private final SubWardenRepository subWardenRepository;

    @Autowired
    public SubWardenService(SubWardenRepository subWardenRepository) {
        this.subWardenRepository = subWardenRepository;
    }

    // Create or update a SubWarden
    public SubWarden saveSubWarden(UserRegistrationDTO registrationDTO) {
        return null;
    }

    // Retrieve a SubWarden by ID
    public Optional<SubWarden> getById(Long id) {
        return subWardenRepository.findById(id);
    }

    // Retrieve all SubWardens
    public List<SubWarden> getAll() {
        return subWardenRepository.findAll();
    }

    // Delete a SubWarden by ID
    public void deleteById(Long id) {
        subWardenRepository.deleteById(id);
    }
}
