package com.uor.fot.complainandassetsmanagementsystem.enums;

import java.util.HashMap;
import java.util.Map;

public enum UserStatus {
    ACTIVE(1, "Active"),
    INACTIVE(2, "Inactive"),
    BLOCKED(3, "Blocked"),
    PENDING_ACTIVATION(4, "Pending Activation"),
    SUSPENDED(5, "Suspended");

    private final int id;
    private final String description;

    UserStatus(int id, String description) {
        this.id = id;
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public String getDescription() {
        return description;
    }

    // Map to store UserStatus by ID for quick retrieval
    private static final Map<Integer, UserStatus> BY_ID = new HashMap<>();

    static {
        for (UserStatus status : values()) {
            BY_ID.put(status.id, status);
        }
    }

    // Get UserStatus by ID
    public static UserStatus getById(int id) {
        return BY_ID.get(id);
    }
}

