package com.uor.fot.complainandassetsmanagementsystem.model;

import lombok.Data;

import javax.persistence.*;
import java.util.Date;

@Data
@Entity
@Table(name = "report")
public class Report {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @Column(name = "report_type")
    private String reportType;

    @Column(name = "report_date")
    private Date reportDate;

    @Column(name = "report_content")
    private String reportContent;
}


