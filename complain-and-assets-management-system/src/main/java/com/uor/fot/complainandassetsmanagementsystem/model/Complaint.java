package com.uor.fot.complainandassetsmanagementsystem.model;

import lombok.Data;

import javax.persistence.*;
import java.util.Date;

@Data
@Entity
@Table(name = "complaint")
public class Complaint {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @ManyToOne
    @JoinColumn(name = "asset_id")
    private Asset asset;

    @Column(name = "description")
    private String description;

    @Column(name = "is_resolved")
    private boolean isResolved;

    @Column(name = "status")
    private Integer status;

    @Column(name = "urgency")
    private Integer urgency;

    @Column(name = "quantity")
    private Integer quantity;

    @Column(name = "image_url")
    private String imageURL;

    @Column(name = "qr_code_url")
    private String qrCodeUrl;

    @Column(name = "escalation_count")
    private Integer escalationCount;

    @Column(name = "submission_date")
    private Date submission_date;

    @Column(name = "escalation_date")
    private Date escalationDate;

    @Column(name = "sub_warden_action_date")
    private Date subWardenActionDate;

    @Column(name = "academic_warden_action_date")
    private Date academicWardenActionDate;
}


