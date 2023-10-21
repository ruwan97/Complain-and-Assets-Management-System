package com.uor.fot.complainandassetsmanagementsystem.model;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@PrimaryKeyJoinColumn(name = "user_id")
@Table(name = "student")
public class Student extends User {

    @Column(name = "registration_no", unique = true)
    private String regNo;

    @ManyToOne
    @JoinColumn(name = "room_id")
    private Room room;
}


