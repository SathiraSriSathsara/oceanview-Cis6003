package com.icbt.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.icbt.model.User;

public class UserDAO {

    // Login validation
    public boolean validateUser(String username, String password) {

        boolean status = false;
        String sql = "SELECT 1 FROM users WHERE username=? AND password=? LIMIT 1";

        try {
            Connection con = DBConnection.getConnection();

            if (con == null) {
                System.out.println("Database connection is unavailable.");
                return false;
            }

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, username);
                ps.setString(2, password);

                try (ResultSet rs = ps.executeQuery()) {
                    status = rs.next();
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return status;
    }

    public boolean addUser(User user) {
        String sql = "INSERT INTO users (username, password, role) VALUES (?, ?, ?)";

        try (Connection con = DBConnection.getConnection()) {
            if (con == null) {
                return false;
            }

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, user.getUsername());
                ps.setString(2, user.getPassword());
                ps.setString(3, user.getRole());
                return ps.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT id, username, role FROM users ORDER BY id DESC";

        try (Connection con = DBConnection.getConnection()) {
            if (con == null) {
                return users;
            }

            try (PreparedStatement ps = con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setRole(rs.getString("role"));
                    users.add(user);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return users;
    }

    public boolean deleteUser(int id) {
        String sql = "DELETE FROM users WHERE id = ?";

        try (Connection con = DBConnection.getConnection()) {
            if (con == null) {
                return false;
            }

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, id);
                return ps.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int getUserCount() {
        String sql = "SELECT COUNT(*) FROM users";
        try (Connection con = DBConnection.getConnection()) {
            if (con == null) {
                return 0;
            }

            try (PreparedStatement ps = con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
