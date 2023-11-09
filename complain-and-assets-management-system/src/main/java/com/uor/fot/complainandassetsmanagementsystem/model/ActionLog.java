package com.uor.fot.complainandassetsmanagementsystem.model;

import lombok.Data;

import javax.persistence.*;
import java.util.Date;

@Data
@Entity
@Table(name = "action_log")
public class ActionLog {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "description")
    private String description;

    @Column(name = "log_type")
    private String logType;

    @Column(name = "action")
    private String action;

    @Column(name = "created_at")
    private Date createdAt;
}
