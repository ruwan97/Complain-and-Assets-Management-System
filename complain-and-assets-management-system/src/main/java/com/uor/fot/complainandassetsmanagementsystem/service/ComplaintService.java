package com.uor.fot.complainandassetsmanagementsystem.service;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.uor.fot.complainandassetsmanagementsystem.dto.ComplaintInfoResponseDto;
import com.uor.fot.complainandassetsmanagementsystem.enums.ComplaintStatus;
import com.uor.fot.complainandassetsmanagementsystem.model.Complaint;
import com.uor.fot.complainandassetsmanagementsystem.model.User;
import com.uor.fot.complainandassetsmanagementsystem.repository.ComplaintRepository;
import com.uor.fot.complainandassetsmanagementsystem.repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.EntityNotFoundException;
import java.math.BigInteger;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;

@Service
public class ComplaintService {
    private static final Logger logger = LoggerFactory.getLogger(ComplaintService.class);

    private final ComplaintRepository complaintRepository;
    private EmailService emailService;
    private UserRepository userRepository;
    private final ImageService imageService;

    @Autowired
    public ComplaintService(ComplaintRepository complaintRepository, EmailService emailService, UserRepository userRepository, ImageService imageService) {
        this.complaintRepository = complaintRepository;
        this.emailService = emailService;
        this.userRepository = userRepository;
        this.imageService = imageService;
    }

    @Value("${complain.image.save.path}")
    private String complaintImageSavePath;

    @Value("${qr.code.save.path}")
    private String qrCodeSavePath;

    public List<Complaint> getAllComplaints() {
        return complaintRepository.findAll();
    }

    public Optional<Complaint> getComplaintById(Long id) {
        return complaintRepository.findById(id);
    }

    public void submitComplaint(Complaint complaint, MultipartFile image) {
        // Save the complaint image
        String imageUrl = imageService.saveImage(image, complaintImageSavePath);

        // Generate a unique QR code for the complaint
        String qrCodeText = "Complaint ID: " + complaint.getId() +
                ", Asset ID: " + complaint.getAsset().getId() +
                ", Description: " + complaint.getDescription() +
                ", Status: " + complaint.getStatus() +
                ", Urgency: " + complaint.getUrgency() +
                ", Quantity: " + complaint.getQuantity();
        int width = 200;
        int height = 200;

        try {
            QRCodeWriter qrCodeWriter = new QRCodeWriter();
            BitMatrix bitMatrix = qrCodeWriter.encode(qrCodeText, BarcodeFormat.QR_CODE, width, height);

            // Save the QR code image to a file
            String qrCodeFileName = "complaint_qr_" + UUID.randomUUID() + ".png"; // Example of a custom file name
            Path qrCodePath = Paths.get(qrCodeSavePath, qrCodeFileName);
            Files.createDirectories(qrCodePath.getParent());
            MatrixToImageWriter.writeToPath(bitMatrix, "PNG", qrCodePath);

            // Associate the QR code URL or file path with the complaint and save it
            complaint.setQrCodeUrl(qrCodePath.toString());
            complaint.setImageURL(imageUrl);

            // save
            complaintRepository.saveComplaint(
                    complaint.getStudent().getId(),
                    complaint.getAsset().getId(),
                    complaint.getDescription(),
                    complaint.getStatus(),
                    complaint.getUrgency(),
                    complaint.getQuantity(),
                    complaint.getImageURL(),
                    complaint.getQrCodeUrl(),
                    new Date()
            );
        } catch (Exception e) {
            // Handle QR code generation error
            e.printStackTrace();
        }
    }

    public void updateComplaint(Long id, Complaint updatedComplaint) {
        if (complaintRepository.existsById(id)) {
            updatedComplaint.setId(id);
            complaintRepository.save(updatedComplaint);
        }
    }

    public void deleteComplaint(Long id) {
        complaintRepository.deleteById(id);
    }

    public void handleEscalatedComplaint(Long complaintId) {
        // Retrieve the escalated complaint from the database
        Complaint escalatedComplaint = complaintRepository.findById(complaintId)
                .orElseThrow(() -> new EntityNotFoundException("Complaint not found"));

        // Check if the complaint is already resolved
        if (escalatedComplaint.getStatus() == ComplaintStatus.RESOLVED.getId()) {
            throw new IllegalStateException("Complaint is already resolved");
        }

        // Implement logic for academic wardens to take appropriate action
        // For example, send notifications, assign actions, update status, etc.

        // Update the status to "Resolved" after taking appropriate action
        escalatedComplaint.setStatus(ComplaintStatus.RESOLVED.getId());
        complaintRepository.save(escalatedComplaint);
    }

    public void sendEmailToUser(Complaint complaint) {
        // Prepare the subject and message for the email
        String subject = "Complaint Notification";
        String message = "A new complaint has been assigned to you. Complaint ID: " + complaint.getId();

        List<User> users = userRepository.findAll();
        for (User user : users) {
            // Send the email
            emailService.sendEmailToUser(user.getEmail(), subject, message);
        }
    }

    public List<ComplaintInfoResponseDto> getComplaintInfo() {
        List<ComplaintInfoResponseDto> results = new ArrayList<>();
        List<Object[]> data = complaintRepository.getComplaintInfo();

        for (Object[] row : data) {
            ComplaintInfoResponseDto dto = new ComplaintInfoResponseDto();
            dto.setCpId(((BigInteger) row[0]).intValue());
            dto.setFirstName((String) row[1]);
            dto.setLastName((String) row[2]);
            dto.setRoleName((String) row[3]);
            dto.setFacultyName((String) row[4]);
            dto.setCreatedAt((Date) row[5]);
            dto.setUpdatedAt((Date) row[6]);
            dto.setAssetName((String) row[7]);
            dto.setDescription((String) row[8]);
            dto.setSubmissionDate((Date) row[9]);
            dto.setQuantity((Integer) row[10]);

            int statusId = (int) row[11]; // assuming row[11] is already an Integer
            String status;
            switch (statusId) {
                case 1:
                    status = "Escalated to Sub-Warden";
                    break;
                case 2:
                    status = "Escalated to Academic Warden";
                    break;
                case 3:
                    status = "Resolved";
                    break;
                default:
                    status = "Unknown";
                    break;
            }
            dto.setStatus(status);

            results.add(dto);
        }

        return results;
    }
}
