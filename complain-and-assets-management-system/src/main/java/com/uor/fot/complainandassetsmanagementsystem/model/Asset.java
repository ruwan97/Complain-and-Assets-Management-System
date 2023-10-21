package com.uor.fot.complainandassetsmanagementsystem.model;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "asset")
public class Asset {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "name")
    private String name;

    @Column(name = "description")
    private String description;

    @Column(name = "asset_condition")
    private String condition;

    @Column(name = "quantity")
    private int quantity;
}

