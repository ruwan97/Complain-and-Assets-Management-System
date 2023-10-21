package com.uor.fot.complainandassetsmanagementsystem.service;

import com.uor.fot.complainandassetsmanagementsystem.dto.UserRegistrationDTO;
import com.uor.fot.complainandassetsmanagementsystem.enums.UserStatus;
import com.uor.fot.complainandassetsmanagementsystem.model.Student;
import com.uor.fot.complainandassetsmanagementsystem.repository.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class StudentService {

    private final StudentRepository studentRepository;

    @Autowired
    public StudentService(StudentRepository studentRepository) {
        this.studentRepository = studentRepository;
    }

    public List<Student> getAllStudents() {
        return studentRepository.findAll();
    }

    public Optional<Student> getStudentById(Long id) {
        return studentRepository.findById(id);
    }

    public void saveStudent(UserRegistrationDTO registrationDTO) {
        // set default value as 0
        Integer userId = 0;
        studentRepository.registerStudent(
                registrationDTO.getTitleId(),
                registrationDTO.getFirstName(),
                registrationDTO.getLastName(),
                registrationDTO.getEmail(),
                registrationDTO.getPassword(),
                registrationDTO.getNic(),
                registrationDTO.getContact(),
                registrationDTO.getAddress(),
                registrationDTO.getRoleId(),
                registrationDTO.getFacultyId(),
                new Date(),
                UserStatus.ACTIVE.getId(),
                registrationDTO.getStudentRegNo(),
                registrationDTO.getRoomId(),
                userId
        );
    }


    public Student updateStudent(Long id, Student updateStudent) {
        Student student = null;
        if (studentRepository.existsById(id)) {
            updateStudent.setId(id);
            student = studentRepository.save(updateStudent);
        }
        return student;
    }

    public void deleteStudent(Long id) {
        studentRepository.deleteById(id);
    }

    public Student createStudent(Student student) {
        return studentRepository.save(student);
    }

    public Student getStudentByRegNo(String studentRegNo) {

        return null;
    }

    public boolean existsByStuRegNo(String studentRegNo) {
        return studentRepository.existsByStuRegNo(studentRegNo);
    }
}
