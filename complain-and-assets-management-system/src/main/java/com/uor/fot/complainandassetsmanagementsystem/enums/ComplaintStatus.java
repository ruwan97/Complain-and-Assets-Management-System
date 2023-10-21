package com.uor.fot.complainandassetsmanagementsystem.enums;

public enum ComplaintStatus {
    NEW(1, "New"),
    ESCALATED_TO_SUB_WARDEN(2, "Escalated to Sub-Warden"),
    ESCALATED_TO_ACADEMIC_WARDEN(3, "Escalated to Academic Warden"),
    RESOLVED(4, "Resolved");

    private final int id;
    private final String description;

    ComplaintStatus(int id, String description) {
        this.id = id;
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public String getDescription() {
        return description;
    }

    public static ComplaintStatus getById(int id) {
        for (ComplaintStatus status : values()) {
            if (status.getId() == id) {
                return status;
            }
        }
        throw new IllegalArgumentException("Invalid ComplaintStatus ID: " + id);
    }

    public static ComplaintStatus getByDescription(String description) {
        for (ComplaintStatus status : values()) {
            if (status.getDescription() == description) {
                return status;
            }
        }
        throw new IllegalArgumentException("Invalid ComplaintStatus Description: " + description);
    }
}

