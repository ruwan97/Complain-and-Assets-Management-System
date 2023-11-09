package com.uor.fot.complainandassetsmanagementsystem.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CreateComplaintDTO {
    private String studentRegNo;
    private Long assetId;
    private String description;
    private Integer quantity;
    private MultipartFile image; // MultipartFile for handling image uploads
    private Integer urgency; // Low, Medium, High, etc.
}


