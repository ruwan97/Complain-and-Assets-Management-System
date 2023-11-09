package com.uor.fot.complainandassetsmanagementsystem.model;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

@Entity
@Data
@PrimaryKeyJoinColumn(name = "id")
@Table(name = "academic_warden")
public class AcademicWarden extends User {
}

