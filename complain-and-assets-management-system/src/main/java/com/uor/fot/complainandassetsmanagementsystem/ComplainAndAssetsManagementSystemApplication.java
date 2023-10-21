package com.uor.fot.complainandassetsmanagementsystem;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication(exclude = {SecurityAutoConfiguration.class })
public class ComplainAndAssetsManagementSystemApplication {

	public static void main(String[] args) {
		SpringApplication.run(ComplainAndAssetsManagementSystemApplication.class, args);
	}

}
