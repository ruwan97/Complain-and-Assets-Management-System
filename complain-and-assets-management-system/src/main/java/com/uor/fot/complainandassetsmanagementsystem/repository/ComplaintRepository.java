package com.uor.fot.complainandassetsmanagementsystem.repository;

import com.uor.fot.complainandassetsmanagementsystem.model.Complaint;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.Date;

@Repository
public interface ComplaintRepository extends JpaRepository<Complaint, Long> {
    @Transactional
    @Procedure(procedureName = "")
    void saveComplaint(
            @Param("userId") Long userId,
            @Param("assetId") Long assetId,
            @Param("description") String description,
            @Param("status") int status,
            @Param("urgency") Integer urgency,
            @Param("quantity") Integer quantity,
            @Param("imageURL") String imageURL,
            @Param("qrCodeUrl") String qrCodeUrl,
            @Param("date") Date date
    );
}

