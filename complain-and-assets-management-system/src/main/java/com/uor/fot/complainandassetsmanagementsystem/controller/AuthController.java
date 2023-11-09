package com.uor.fot.complainandassetsmanagementsystem.controller;

import com.uor.fot.complainandassetsmanagementsystem.enums.UserStatus;
import com.uor.fot.complainandassetsmanagementsystem.model.User;
import com.uor.fot.complainandassetsmanagementsystem.service.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
@RequestMapping("/auth")
public class AuthController {

    private final UserService userService;
    private final BCryptPasswordEncoder passwordEncoder;

    public AuthController(UserService userService, BCryptPasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
    }

    @PostMapping("/login")
    public String login(@RequestParam String email, @RequestParam String password, Model model, HttpServletResponse response) {
        try {
            User user = userService.findByEmail(email);

            if (user == null) {
                model.addAttribute("errorMessage", "Incorrect email address");
                return "auth/login";
            }

            if (user.getStatus() == UserStatus.INACTIVE.getId()) {
                model.addAttribute("errorMessage", "Account is not active. Please contact support center");
                return "auth/login";
            }

            if (user.getStatus() == UserStatus.BLOCKED.getId()) {
                if (userService.isAccountLocked(user)) {
                    model.addAttribute("errorMessage", "Account is locked. Please contact support center");
                    return "auth/login";
                }
            }

            if (passwordEncoder.matches(password, user.getPassword())) {
                if (user.getStatus() != UserStatus.ACTIVE.getId()) {
                    model.addAttribute("errorMessage", "User is not active. Please contact support center");
                    return "auth/login";
                }

                response.sendRedirect("/cams/dashboard");
            } else {
                userService.incrementLoginAttempts(user);
                model.addAttribute("errorMessage", "Incorrect Password");
            }
            return "auth/login";
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


