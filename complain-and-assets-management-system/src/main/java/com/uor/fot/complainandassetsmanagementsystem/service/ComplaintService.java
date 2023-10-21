package com.uor.fot.complainandassetsmanagementsystem.service;

import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.uor.fot.complainandassetsmanagementsystem.enums.ComplaintStatus;
import com.uor.fot.complainandassetsmanagementsystem.model.Complaint;
import com.uor.fot.complainandassetsmanagementsystem.model.SubWarden;
import com.uor.fot.complainandassetsmanagementsystem.model.User;
import com.uor.fot.complainandassetsmanagementsystem.repository.ComplaintRepository;
import com.uor.fot.complainandassetsmanagementsystem.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityNotFoundException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class ComplaintService {

    private final ComplaintRepository complaintRepository;
    private EmailService emailService;
    private UserRepository userRepository;



    @Autowired
    public ComplaintService(ComplaintRepository complaintRepository, EmailService emailService, UserRepository userRepository) {
        this.complaintRepository = complaintRepository;
        this.emailService = emailService;
        this.userRepository = userRepository;
    }

    public List<Complaint> getAllComplaints() {
        return complaintRepository.findAll();
    }

    public Optional<Complaint> getComplaintById(Long id) {
        return complaintRepository.findById(id);
    }

    public void submitComplaint(Complaint complaint) {
        // Generate a unique QR code for the complaint
        String qrCodeText = "Complaint ID: " + complaint.getId();
        int width = 200;
        int height = 200;

        try {
            QRCodeWriter qrCodeWriter = new QRCodeWriter();
            BitMatrix bitMatrix = qrCodeWriter.encode(qrCodeText, com.google.zxing.BarcodeFormat.QR_CODE, width, height);

            // Save the QR code image to a file
            Path qrCodePath = Paths.get("images/qr-codes/" + complaint.getId() + ".png");
            MatrixToImageWriter.writeToPath(bitMatrix, "PNG", qrCodePath);

            // Associate the QR code URL or file path with the complaint and save it
            complaint.setQrCodeUrl(qrCodePath.toString());

            // save
            complaintRepository.saveComplaint(
                    complaint.getUser().getId(),
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
}
