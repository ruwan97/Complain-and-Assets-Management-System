package com.uor.fot.complainandassetsmanagementsystem.service;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

@Service
public class ImageService {
    public String saveImage(MultipartFile image, String directory) {
        try {
            if (image.isEmpty()) {
                throw new IllegalArgumentException("Image file is empty");
            }

            // Generate a unique filename to avoid overwriting existing files
            String originalFilename = image.getOriginalFilename();
            String uniqueFilename = System.currentTimeMillis() + "_" + originalFilename;

            // Resolve the full path for the image file
            Path imagePath = Paths.get(directory, uniqueFilename);

            // Create the directories if they don't exist
            Files.createDirectories(imagePath.getParent());

            // Copy the uploaded file to the target path
            Files.copy(image.getInputStream(), imagePath, StandardCopyOption.REPLACE_EXISTING);

            // Return the path to the saved image
            return imagePath.toString();
        } catch (Exception e) {
            // Handle the exception, e.g., log the error
            e.printStackTrace();
            return null; // Return null if there was an error saving the image
        }
    }
}


