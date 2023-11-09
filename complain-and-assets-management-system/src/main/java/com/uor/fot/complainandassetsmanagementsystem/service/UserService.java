package com.uor.fot.complainandassetsmanagementsystem.service;

import com.uor.fot.complainandassetsmanagementsystem.dto.UserRegistrationDTO;
import com.uor.fot.complainandassetsmanagementsystem.enums.UserRoleType;
import com.uor.fot.complainandassetsmanagementsystem.enums.UserStatus;
import com.uor.fot.complainandassetsmanagementsystem.model.Room;
import com.uor.fot.complainandassetsmanagementsystem.model.User;
import com.uor.fot.complainandassetsmanagementsystem.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class UserService {

    private final UserRepository userRepository;
    private final UserRoleService userRoleService;
    private final FacultyService facultyService;
    private final SeniorStudentCounselorService seniorStudentCounselorService;
    private final StudentService studentService;
    private final RoomService roomService;
    private final DeanService deanService;
    private final AcademicWardenService academicWardenService;
    private final SubWardenService subWardenService;
    private final BCryptPasswordEncoder passwordEncoder;


    @Autowired
    public UserService(UserRepository userRepository, UserRoleService userRoleService, FacultyService facultyService, SeniorStudentCounselorService seniorStudentCounselorService, StudentService studentService, RoomService roomService, DeanService deanService, AcademicWardenService academicWardenService, SubWardenService subWardenService, BCryptPasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.userRoleService = userRoleService;
        this.facultyService = facultyService;
        this.seniorStudentCounselorService = seniorStudentCounselorService;
        this.studentService = studentService;
        this.roomService = roomService;
        this.deanService = deanService;
        this.academicWardenService = academicWardenService;
        this.subWardenService = subWardenService;
        this.passwordEncoder = passwordEncoder;
    }

    public boolean createUser(UserRegistrationDTO userRegistrationDTO) {
        // validate unique fields
        validateUniqueFields(userRegistrationDTO);

        UserRoleType roleType = UserRoleType.getById(Math.toIntExact(userRegistrationDTO.getRoleId()));

        // Determine the user's role type and register accordingly
        switch (roleType) {
            case STUDENT:
                return registerStudent(userRegistrationDTO);
            case DEAN:
                return registerDean(userRegistrationDTO);
            case SUB_WARDEN:
                return registerSubWarden(userRegistrationDTO);
            case ACADEMIC_WARDEN:
                return registerAcademicWarden(userRegistrationDTO);
            case SENIOR_STUDENT_COUNSELOR:
                return registerSeniorStudentCounselor(userRegistrationDTO);
            default:
                throw new IllegalStateException("Unexpected value: " + roleType);
        }
    }

    private void validateUniqueFields(UserRegistrationDTO userRegistrationDTO) {
        if (userRegistrationDTO.getEmail() != null && userRepository.existsByEmail(userRegistrationDTO.getEmail())) {
            throw new IllegalArgumentException("Email already exists.");
        }

        if (userRegistrationDTO.getContact() != null && userRepository.existsByMobile(userRegistrationDTO.getContact())) {
            throw new IllegalArgumentException("Mobile number already exists.");
        }

        if (userRegistrationDTO.getStudentRegNo() != null && studentService.existsByStuRegNo(userRegistrationDTO.getStudentRegNo())) {
            throw new IllegalArgumentException("Mobile number already exists.");
        }
    }

    private boolean registerSeniorStudentCounselor(UserRegistrationDTO userRegistrationDTO) {
        // password encode
        String encodedPassword = passwordEncoder.encode(userRegistrationDTO.getPassword());
        userRegistrationDTO.setPassword(encodedPassword);

        // save
        seniorStudentCounselorService.saveSeniorStudentCounselor(userRegistrationDTO);
        return true;
    }

    private boolean registerAcademicWarden(UserRegistrationDTO userRegistrationDTO) {
        // password encode
        String encodedPassword = passwordEncoder.encode(userRegistrationDTO.getPassword());
        userRegistrationDTO.setPassword(encodedPassword);

        // save
        academicWardenService.saveAcademicWarden(userRegistrationDTO);
        return true;
    }

    private boolean registerSubWarden(UserRegistrationDTO userRegistrationDTO) {
        // password encode
        String encodedPassword = passwordEncoder.encode(userRegistrationDTO.getPassword());
        userRegistrationDTO.setPassword(encodedPassword);

        // save
        subWardenService.saveSubWarden(userRegistrationDTO);
        return true;
    }

    private boolean registerDean(UserRegistrationDTO userRegistrationDTO) {
        // password encode
        String encodedPassword = passwordEncoder.encode(userRegistrationDTO.getPassword());
        userRegistrationDTO.setPassword(encodedPassword);

        // save
        deanService.saveDean(userRegistrationDTO);
        return true;
    }

    private boolean registerStudent(UserRegistrationDTO userRegistrationDTO) {
        // password encode
        String encodedPassword = passwordEncoder.encode(userRegistrationDTO.getPassword());
        userRegistrationDTO.setPassword(encodedPassword);

        // get room
        Room room = roomService.getRoomByRoomNo(userRegistrationDTO.getRoomNo());
        userRegistrationDTO.setRoomId(Math.toIntExact(room.getId()));

        // save
        studentService.saveStudent(userRegistrationDTO);
        return true;
    }

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public User getUserById(Long id) {
        Optional<User> userOptional = userRepository.findById(id);
        return userOptional.orElse(null);
    }

    public User updateUser(Long id, User updatedUser) {
        Optional<User> userOptional = userRepository.findById(id);
        if (userOptional.isPresent()) {
            User existingUser = userOptional.get();

            // Update the fields of existingUser with values from updatedUser
            existingUser.setFirstName(updatedUser.getFirstName());
            existingUser.setLastName(updatedUser.getLastName());
            existingUser.setEmail(updatedUser.getEmail());
            existingUser.setPassword(updatedUser.getPassword());
            existingUser.setContact(updatedUser.getContact());
            existingUser.setRole(updatedUser.getRole());

            // Add any other fields you want to update

            return userRepository.save(existingUser);
        } else {
            return null; // User not found
        }
    }

    public boolean deleteUser(Long id) {
        Optional<User> userOptional = userRepository.findById(id);
        if (userOptional.isPresent()) {
            userRepository.delete(userOptional.get());
            return true;
        } else {
            return false; // User not found
        }
    }

    public User findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    public boolean isAccountLocked(User user) {
        LocalDateTime lockUntil = user.getLockUntil();

        if (lockUntil == null || lockUntil.isBefore(LocalDateTime.now())) {
            return false; // Account is not locked
        } else {
            return true; // Account is still locked
        }
    }

    public void incrementLoginAttempts(User user) {
        if (user.getLoginAttempts() == 0) {
            user.setLoginAttempts(1);
        } else {
            user.setLoginAttempts(user.getLoginAttempts() + 1);
        }
        if (user.getLoginAttempts() >= User.getMaxLoginAttempts()) {
            lockAccount(user);
        }
        userRepository.save(user);
    }

    public void lockAccount(User user) {
        LocalDateTime lockUntil = LocalDateTime.now().plusMinutes(10);
        user.setLockUntil(lockUntil);
        user.setStatus(UserStatus.BLOCKED.getId());
        userRepository.save(user);
    }
}

