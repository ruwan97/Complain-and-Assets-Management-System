package com.uor.fot.complainandassetsmanagementsystem.model;

import lombok.Data;

import javax.persistence.*;
import java.util.List;

@Data
@Entity
@Table(name = "room")
public class Room {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "room_no", unique = true)
    private Integer roomNo;

    @Column(name = "floor_id")
    private Integer floor;

    @Column(name = "no_of_students")
    private int noOfStudents;
}


