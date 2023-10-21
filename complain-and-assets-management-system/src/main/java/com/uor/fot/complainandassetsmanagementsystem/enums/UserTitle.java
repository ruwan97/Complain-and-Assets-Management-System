package com.uor.fot.complainandassetsmanagementsystem.enums;

public enum UserTitle {
    STUDENT(1, "Student"),
    PROFESSOR(2, "Professor"),
    STAFF(3, "Staff"),
    ADMIN(4, "Admin");

    private final int id;
    private final String description;

    UserTitle(int id, String description) {
        this.id = id;
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public String getDescription() {
        return description;
    }

    public static UserTitle getById(int id) {
        for (UserTitle title : values()) {
            if (title.id == id) {
                return title;
            }
        }
        throw new IllegalArgumentException("Invalid UserTitle id: " + id);
    }
}

