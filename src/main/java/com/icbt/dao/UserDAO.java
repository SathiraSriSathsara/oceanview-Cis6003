package com.icbt.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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
}
