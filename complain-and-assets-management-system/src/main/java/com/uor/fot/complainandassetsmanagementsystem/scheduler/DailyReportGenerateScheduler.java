package com.uor.fot.complainandassetsmanagementsystem.scheduler;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class DailyReportGenerateScheduler {

    // This method will be scheduled to run daily at midnight (00:00:00)
    @Scheduled(cron = "0 0 0 * * ?")
    public void generateAndSendDailyReports() {
        // Your logic to generate and send reports here
        // You can fetch complaints assigned to sub wardens, academic wardens, etc.
        // Generate reports and send them to the respective parties
    }
}

