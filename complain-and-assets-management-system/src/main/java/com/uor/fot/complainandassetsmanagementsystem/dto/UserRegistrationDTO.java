package com.uor.fot.complainandassetsmanagementsystem.dto;

import lombok.Data;

@Data
public class UserRegistrationDTO {
    private Integer titleId;
    private String firstName;
    private String lastName;
    private String email;
    private String password;
    private String nic;
    private String contact;
    private String address;
    private Integer roleId;
    private Integer facultyId;
    private Integer userStatus;
    private String studentRegNo;
    private Integer roomNo;
    private Integer roomId;
}
