package com.tactic;

import org.mindrot.jbcrypt.BCrypt;
import java.sql.*;

public class UserDAO {

    // Returns null if email/username/phone already exists, otherwise inserts and returns the new User
    public User registerUser(String username, String email, String phone, String password, String role) throws SQLException {
        String checkSQL = "SELECT user_id FROM users WHERE email = ? OR username = ? OR phone = ?";
        String insertSQL = "INSERT INTO users (username, email, phone, password, role) VALUES (?, ?, ?, ?, CAST(? AS user_role)) RETURNING user_id";

        try (Connection con = DBConnection.getConnection()) {

            // Check for duplicates
            try (PreparedStatement checkStmt = con.prepareStatement(checkSQL)) {
                checkStmt.setString(1, email);
                checkStmt.setString(2, username);
                checkStmt.setString(3, phone);
                ResultSet rs = checkStmt.executeQuery();
                if (rs.next()) return null; // duplicate found
            }

            // Hash password and insert
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
            try (PreparedStatement insertStmt = con.prepareStatement(insertSQL)) {
                insertStmt.setString(1, username);
                insertStmt.setString(2, email);
                insertStmt.setString(3, phone);
                insertStmt.setString(4, hashedPassword);
                insertStmt.setString(5, role);
                ResultSet rs = insertStmt.executeQuery();
                if (rs.next()) {
                    return new User(rs.getInt("user_id"), username, email, phone, role);
                }
            }
        }
        return null;
    }

    // Returns the User if credentials are valid, null otherwise
    public User loginUser(String email, String password) throws SQLException {
        String sql = "SELECT user_id, username, email, phone, password, role FROM users WHERE email = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String storedHash = rs.getString("password");
                if (BCrypt.checkpw(password, storedHash)) {
                    return new User(
                            rs.getInt("user_id"),
                            rs.getString("username"),
                            rs.getString("email"),
                            rs.getString("phone"),
                            rs.getString("role")
                    );
                }
            }
        }
        return null;
    }
}