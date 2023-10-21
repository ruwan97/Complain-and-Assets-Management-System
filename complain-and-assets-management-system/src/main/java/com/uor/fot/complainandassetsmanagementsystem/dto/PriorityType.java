package com.uor.fot.complainandassetsmanagementsystem.dto;

public enum PriorityType {
    LOW(1, "Low"),
    MEDIUM(2, "Medium"),
    HIGH(3, "High");

    private final int id;
    private final String description;

    PriorityType(int id, String description) {
        this.id = id;
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public String getDescription() {
        return description;
    }

    public static PriorityType getById(int id) {
        for (PriorityType status : values()) {
            if (status.getId() == id) {
                return status;
            }
        }
        throw new IllegalArgumentException("Invalid PriorityType ID: " + id);
    }
}
