package com.uor.fot.complainandassetsmanagementsystem.model;

import lombok.Data;
import javax.persistence.*;

@Data
@Entity
@PrimaryKeyJoinColumn(name = "user_id")
@Table(name = "sub_warden")
public class SubWarden extends User {
}

