package com.uor.fot.complainandassetsmanagementsystem.enums;

public enum UserRoleType {
    STUDENT(1, "Student"),
    DEAN(2, "Dean"),
    SUB_WARDEN(3, "SubWarden"),
    ACADEMIC_WARDEN(4, "Academic Warden"),
    SENIOR_STUDENT_COUNSELOR(5, "Senior Student Counselor");

    private final int id;
    private final String description;

    UserRoleType(int id, String description) {
        this.id = id;
        this.description = description;
    }

    public long getId() {
        return id;
    }

    public String getDescription() {
        return description;
    }

    public static UserRoleType getById(int id) {
        for (UserRoleType userType : values()) {
            if (userType.getId() == id) {
                return userType;
            }
        }
        throw new IllegalArgumentException("Invalid UserType id: " + id);
    }
}

