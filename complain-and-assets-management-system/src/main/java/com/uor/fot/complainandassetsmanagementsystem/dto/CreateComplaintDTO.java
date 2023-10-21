package com.uor.fot.complainandassetsmanagementsystem.dto;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

@Data
public class CreateComplaintDTO {
    private Long assetId;
    private String description;
    private Integer quantity;
    private String studentRegNo;
    private MultipartFile image; // MultipartFile for handling image uploads
    private Integer urgency; // Low, Medium, High, etc.
}


