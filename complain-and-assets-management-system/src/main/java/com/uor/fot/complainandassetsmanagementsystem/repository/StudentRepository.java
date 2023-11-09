package com.uor.fot.complainandassetsmanagementsystem.repository;

import com.uor.fot.complainandassetsmanagementsystem.model.Student;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.Date;

@Repository
public interface StudentRepository extends JpaRepository<Student, Long> {
    @Transactional
    @Procedure(procedureName = "sp_register_student")
    void registerStudent(
            @Param("firstName") String firstName,
            @Param("lastName") String lastName,
            @Param("emailAddress") String email,
            @Param("userPassword") String password,
            @Param("nicNo") String nic,
            @Param("contactNo") String contact,
            @Param("userAddress") String address,
            @Param("roleId") int roleId,
            @Param("facultyId") int facultyId,
            @Param("createdAt") Date createdAt,
            @Param("userStatus") int status,
            @Param("studentRegNo") String regNo,
            @Param("roomId") int roomId,
            @Param("userId") Integer userId
    );

    @Query("SELECT CASE WHEN COUNT(s) > 0 THEN true ELSE false END FROM Student s WHERE s.regNo = :regNo")
    boolean existsByStuRegNo(@Param("regNo") String studentRegNo);

    Student getStudentByRegNo(String studentRegNo);
}

