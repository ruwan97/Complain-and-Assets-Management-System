package com.uor.fot.complainandassetsmanagementsystem.controller;

import org.springframework.stereotype.Controller;
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
    public String getLoginPage() {
        return "user/login";
    }
}
