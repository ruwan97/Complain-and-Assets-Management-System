package com.uor.fot.complainandassetsmanagementsystem.model;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Data
@Table(name = "academic_warden")
public class AcademicWarden extends User {
}

