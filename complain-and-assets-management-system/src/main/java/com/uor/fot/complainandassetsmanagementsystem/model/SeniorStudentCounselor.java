package com.uor.fot.complainandassetsmanagementsystem.model;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

@Data
@Entity
@PrimaryKeyJoinColumn(name = "user_id")
@Table(name = "senior_student_counselor")
public class SeniorStudentCounselor extends User {
}

