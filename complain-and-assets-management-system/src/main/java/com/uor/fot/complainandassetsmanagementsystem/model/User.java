package com.uor.fot.complainandassetsmanagementsystem.model;

import lombok.Data;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.Date;

@Data
@Entity
@Inheritance(strategy = InheritanceType.JOINED)
@Table(name = "user")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "title_id")
    private Integer title;

    @Column(name = "first_name")
    private String firstName;

    @Column(name = "last_name")
    private String lastName;

    @Column(name = "email", unique = true)
    private String email;

    @Column(name = "password")
    private String password;

    @Column(name = "nic", unique = true)
    private String nic;

    @Column(name = "contact")
    private String contact;

    @Column(name = "address")
    private String address;

    @ManyToOne
    @JoinColumn(name = "role_id")
    private UserRole role;

    @ManyToOne
    @JoinColumn(name = "faculty_id")
    private Faculty faculty;

    @Column(name = "created_at")
    private Date creationDate;

    @Column(name = "updated_at")
    private Date updatedDate;

    @Column(name = "status")
    private Integer status;

    @Column(name = "login_attempts")
    private int loginAttempts;

    @Column(name = "lock_until")
    private LocalDateTime lockUntil;

    // Maximum allowed login attempts before account lockout
    private static final int MAX_LOGIN_ATTEMPTS = 5;

    public void incrementLoginAttempts() {
        this.loginAttempts++;
    }

    public static int getMaxLoginAttempts() {
        return MAX_LOGIN_ATTEMPTS;
    }

    public void resetLoginAttempts() {
        this.loginAttempts = 0;
    }
}


