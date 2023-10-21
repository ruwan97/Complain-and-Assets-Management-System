package com.uor.fot.complainandassetsmanagementsystem.enums;

public enum FloorLevel {
    GROUND_FLOOR(0, "Ground Floor"),
    FIRST_FLOOR(1, "1st Floor"),
    SECOND_FLOOR(2, "2nd Floor"),
    THIRD_FLOOR(3, "3rd Floor");

    private final int id;
    private final String description;

    FloorLevel(int id, String description) {
        this.id = id;
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public String getDescription() {
        return description;
    }

    public static FloorLevel getById(int id) {
        for (FloorLevel floorLevel : values()) {
            if (floorLevel.getId() == id) {
                return floorLevel;
            }
        }
        throw new IllegalArgumentException("Invalid FloorLevel ID: " + id);
    }
}

