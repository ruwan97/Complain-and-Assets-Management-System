package com.uor.fot.complainandassetsmanagementsystem.controller;

import com.uor.fot.complainandassetsmanagementsystem.dto.ComplaintInfoResponseDto;
import com.uor.fot.complainandassetsmanagementsystem.dto.CreateComplaintDTO;
import com.uor.fot.complainandassetsmanagementsystem.dto.PriorityType;
import com.uor.fot.complainandassetsmanagementsystem.enums.ComplaintStatus;
import com.uor.fot.complainandassetsmanagementsystem.model.Asset;
import com.uor.fot.complainandassetsmanagementsystem.model.Complaint;
import com.uor.fot.complainandassetsmanagementsystem.model.Student;
import com.uor.fot.complainandassetsmanagementsystem.service.AssetService;
import com.uor.fot.complainandassetsmanagementsystem.service.ComplaintService;
import com.uor.fot.complainandassetsmanagementsystem.service.ImageService;
import com.uor.fot.complainandassetsmanagementsystem.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/complain")
public class ComplaintController {
    private final ComplaintService complaintService;
    private final AssetService assetService;
    private final StudentService studentService;

    @Autowired
    public ComplaintController(ComplaintService complaintService, AssetService assetService, StudentService studentService) {
        this.complaintService = complaintService;
        this.assetService = assetService;
        this.studentService = studentService;
    }

    @PostMapping("/submit")
    public String submitComplaint(@ModelAttribute CreateComplaintDTO complaintDTO, @RequestParam("image") MultipartFile image, RedirectAttributes redirectAttributes) {
        try {
            // Create a new complaint
            Complaint complaint = new Complaint();

            // Get Asset
            Asset asset = assetService.getAssetById(complaintDTO.getAssetId());
            if (asset == null) {
                throw new RuntimeException("Asset not found.");
            }
            complaint.setAsset(asset);

            // Get Student by registration no
            Student student = studentService.getStudentByRegNo(complaintDTO.getStudentRegNo());
            if (student == null) {
                throw new RuntimeException("Student not found.");
            }
            complaint.setStudent(student);

            complaint.setDescription(complaintDTO.getDescription());
            complaint.setQuantity(complaintDTO.getQuantity());
            complaint.setUrgency(PriorityType.getById(complaintDTO.getUrgency()).getId());
            complaint.setStatus(ComplaintStatus.ESCALATED_TO_SUB_WARDEN.getId());

            complaintService.submitComplaint(complaint, complaintDTO.getImage());

            redirectAttributes.addFlashAttribute("successMessage", "Complaint submitted successfully.");
            return "redirect:/complain/view/info";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to submit the complaint.");
            return "redirect:/add/complaint";
        }
    }

    @GetMapping("/view/info")
    public String getComplainsInfo(Model model) {
        List<ComplaintInfoResponseDto> complaints = complaintService.getComplaintInfo();
        model.addAttribute("complaints", complaints);
        return "complaint/view_complaint";
    }

    @PutMapping ("update")
    public String updateComplain(CreateComplaintDTO complaintDTO) {
        return null;
    }
}
