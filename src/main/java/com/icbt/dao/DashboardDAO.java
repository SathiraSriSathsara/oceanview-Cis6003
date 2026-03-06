package com.icbt.dao;

import java.sql.*;
import java.time.LocalDate;

public class DashboardDAO {

    // Get total reservations count
    public int getTotalReservations() {
        int count = 0;
        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT COUNT(*) FROM reservations";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    // Get today's check-ins
    public int getTodayCheckIns() {
        int count = 0;
        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT COUNT(*) FROM reservations WHERE check_in = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setDate(1, Date.valueOf(LocalDate.now()));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    // Get today's check-outs
    public int getTodayCheckOuts() {
        int count = 0;
        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT COUNT(*) FROM reservations WHERE check_out = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setDate(1, Date.valueOf(LocalDate.now()));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    // Get current active reservations (checked in but not checked out)
    public int getActiveReservations() {
        int count = 0;
        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT COUNT(*) FROM reservations WHERE check_in <= ? AND check_out >= ?";
            PreparedStatement ps = con.prepareStatement(sql);
            Date today = Date.valueOf(LocalDate.now());
            ps.setDate(1, today);
            ps.setDate(2, today);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    // Get total revenue from bills
    public double getTotalRevenue() {
        double total = 0.0;
        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT SUM(total_amount) FROM bills";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getDouble(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    // Get pending bills count
    public int getPendingBillsCount() {
        int count = 0;
        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT COUNT(*) FROM bills WHERE payment_status = 'PENDING'";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    // Get reservations by room type
    public int getReservationsByRoomType(String roomType) {
        int count = 0;
        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT COUNT(*) FROM reservations WHERE room_type = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, roomType);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
}
