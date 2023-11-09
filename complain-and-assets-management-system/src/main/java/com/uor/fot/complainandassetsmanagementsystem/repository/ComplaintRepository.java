package com.uor.fot.complainandassetsmanagementsystem.repository;

import com.uor.fot.complainandassetsmanagementsystem.model.Complaint;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.Date;
import java.util.List;

@Repository
public interface ComplaintRepository extends JpaRepository<Complaint, Long> {
    @Transactional
    @Procedure(procedureName = "sp_register_complaint")
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

    @Query(value = "SELECT * FROM view_complaint_info", nativeQuery = true)
    List<Object[]> getComplaintInfo();
}

