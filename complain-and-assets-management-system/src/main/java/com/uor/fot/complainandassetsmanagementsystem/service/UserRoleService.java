package com.uor.fot.complainandassetsmanagementsystem.service;

import com.uor.fot.complainandassetsmanagementsystem.model.UserRole;
import com.uor.fot.complainandassetsmanagementsystem.repository.UserRoleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserRoleService {

    private final UserRoleRepository userRoleRepository;

    @Autowired
    public UserRoleService(UserRoleRepository userRoleRepository) {
        this.userRoleRepository = userRoleRepository;
    }

    public UserRole getUserRoleById(Long id) {
        return userRoleRepository.findById(id).orElse(null);
    }
}
