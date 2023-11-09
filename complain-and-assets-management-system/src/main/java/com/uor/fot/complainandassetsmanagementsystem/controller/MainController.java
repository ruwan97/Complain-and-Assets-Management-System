package com.uor.fot.complainandassetsmanagementsystem.controller;

import com.uor.fot.complainandassetsmanagementsystem.dto.UserRegistrationDTO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.view.RedirectView;

@Controller
public class MainController {

    @RequestMapping("/")
    public RedirectView main() {
        return new RedirectView("/login");
    }

    @GetMapping("/login")
    public String getLoginPage(Model model) {
        // handle the flash attribute for the success message
        if (model.containsAttribute("registrationSuccess")) {
            boolean registrationSuccess = (boolean) model.getAttribute("registrationSuccess");
            if (registrationSuccess) {
                // success message to be displayed in the login page
                model.addAttribute("registrationSuccessMessage", "Registration successful! Please log in with your credentials.");
            }
        }
        return "auth/login";
    }

    @GetMapping("/registration")
    public String getRegistrationForm(Model model) {
        model.addAttribute("userRegistrationDTO", new UserRegistrationDTO());
        return "auth/register";
    }

    @GetMapping("/dashboard")
    public String getDashboard() {
        return "dashboard";
    }

    @GetMapping("/home/complaint")
    public String getComplaintPage() {
        return "complaint/complaint";
    }

    @GetMapping("/home/user")
    public String getUserPage() {
        return "user/user";
    }

    @GetMapping("/home/asset")
    public String getAssetPage() {
        return "asset/assets";
    }

    @GetMapping("/home/room")
    public String getRoomPage() {
        return "room/rooms";
    }

    @GetMapping("/home/report")
    public String getReportPage() {
        return "report/reports";
    }

    @GetMapping("/add/complaint")
    public String getComplaintAddForm(Model model) {
        model.addAttribute("errorMessage", "");
        model.addAttribute("successMessage", "");
        return "complaint/add_complaint";
    }

    @GetMapping("/view/complaint")
    public String getViewComplaint() {
        return "complaint/view_complaint";
    }

    @GetMapping("/add/user")
    public String getUserAddForm() {
        return "user/add_user";
    }

    @GetMapping("/view/user")
    public String getViewUser() {
        return "user/view_user";
    }

    @GetMapping("/add/room")
    public String getRoomAddForm() {
        return "room/add_room";
    }

    @GetMapping("/generate/daily-report")
    public String getGenerateDailyReport() {
        return "report/generate_daily_report";
    }

    @GetMapping("/generate/monthly-report")
    public String getGenerateMonthlyReport() {
        return "report/generate_monthly_report";
    }

    @GetMapping("/view/daily-report")
    public String viewDailyReport() {
        return "report/view_daily_report";
    }

    @GetMapping("/view/monthly-report")
    public String viewMonthlyReport() {
        return "report/generate_monthly_report";
    }

    @GetMapping("/add/asset")
    public String getAddAssetForm() {
        return "asset/add_assets";
    }

    @GetMapping("/view/asset")
    public String viewAsset() {
        return "asset/view_assests";
    }

    @GetMapping("/update/complaint")
    public String getComplaintUpdateForm() {
        return "complaint/update_complaint";
    }
}
