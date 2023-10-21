package com.uor.fot.complainandassetsmanagementsystem.controller;

import com.uor.fot.complainandassetsmanagementsystem.dto.LoginRequestDto;
import com.uor.fot.complainandassetsmanagementsystem.enums.UserStatus;
import com.uor.fot.complainandassetsmanagementsystem.model.User;
import com.uor.fot.complainandassetsmanagementsystem.service.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@RestController
@RequestMapping("/auth")
public class AuthController {

    private final UserService userService;
    private final BCryptPasswordEncoder passwordEncoder;

    public AuthController(UserService userService, BCryptPasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
    }

    @PostMapping("/login")
    public ResponseEntity<String> login(@RequestBody LoginRequestDto loginRequest, HttpServletResponse response) {
        try {
            User user = userService.findByEmail(loginRequest.getEmail());

            if (user == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Incorrect email address");
            }

            if (user.getStatus() == UserStatus.INACTIVE.getId()) {
                return ResponseEntity.status(HttpStatus.LOCKED).body("Account is not active. Please contact support center");
            }

            if (user.getStatus() == UserStatus.BLOCKED.getId()) {
                if (userService.isAccountLocked(user)) {
                    return ResponseEntity.status(HttpStatus.LOCKED).body("Account is locked. Please contact support center");
                }
            }

            if (passwordEncoder.matches(loginRequest.getPassword(), user.getPassword())) {
                if (user.getStatus() != UserStatus.ACTIVE.getId()) {
                    return ResponseEntity.status(HttpStatus.NOT_ACCEPTABLE).body("User is not active. Please contact support center");
                }

                response.sendRedirect("/home");
                return ResponseEntity.ok("Login successful");
            } else {
                userService.incrementLoginAttempts(user);
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Incorrect Password");
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    @GetMapping("/logout")
    public ResponseEntity<String> logout(HttpServletRequest request, HttpServletResponse response) {
        try {
            // Invalidate the user's session
            request.getSession().invalidate();

            // Clear the SecurityContext
            SecurityContextHolder.clearContext();

            // Redirect the user to a login page
            response.sendRedirect("/login");

            return ResponseEntity.ok("Logout successful");
        } catch (Exception e) {
            // Handle exceptions that may occur during logout
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Logout failed");
        }
    }
}


