package com.uor.fot.complainandassetsmanagementsystem.dto;

import lombok.Data;

@Data
public class UserUpdateDTO {
    private String firstName;
    private String lastName;
    private String email;
    private String password;
    private String contact;
    private Long role;
}
