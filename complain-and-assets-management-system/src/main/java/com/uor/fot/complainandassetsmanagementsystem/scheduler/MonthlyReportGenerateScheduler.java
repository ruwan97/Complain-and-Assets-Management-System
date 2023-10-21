package com.uor.fot.complainandassetsmanagementsystem.scheduler;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class MonthlyReportGenerateScheduler {

    // This method will be scheduled to run on the 1st day of every month at midnight (00:00:00)
    @Scheduled(cron = "0 0 0 1 * ?")
    public void generateAndSendMonthlySummaryReport() {
        // Your logic to generate and send the monthly summary report here
        // Calculate statistics on the number of complaints, resolved complaints, escalated complaints, etc.
        // Generate the summary report and send it to the dean
    }
}
