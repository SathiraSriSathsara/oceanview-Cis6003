package com.icbt.dao;

import java.sql.*;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;

import com.icbt.model.Bill;
import com.icbt.model.Room;

public class RoomDAO {

    private void ensureRoomInventoryTable(Connection con) throws SQLException {
        String createTable = "CREATE TABLE IF NOT EXISTS room_inventory ("
                + "room_no VARCHAR(20) PRIMARY KEY,"
                + "room_type VARCHAR(50) NOT NULL,"
                + "price_per_night DOUBLE NOT NULL,"
                + "status VARCHAR(20) NOT NULL DEFAULT 'AVAILABLE',"
                + "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP"
                + ")";

        try (PreparedStatement ps = con.prepareStatement(createTable)) {
            ps.execute();
        }
    }

    public boolean addRoom(Room room) {
        String sql = "INSERT INTO room_inventory (room_no, room_type, price_per_night, status) VALUES (?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection()) {
            if (con == null) {
                return false;
            }

            ensureRoomInventoryTable(con);

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, room.getRoomNo());
                ps.setString(2, room.getRoomType());
                ps.setDouble(3, room.getPricePerNight());
                ps.setString(4, room.getStatus());

                return ps.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Room> getAllRooms() {
        List<Room> rooms = new ArrayList<>();
        String sql = "SELECT room_no, room_type, price_per_night, status FROM room_inventory ORDER BY room_no";

        try (Connection con = DBConnection.getConnection()) {
            if (con == null) {
                return rooms;
            }

            ensureRoomInventoryTable(con);

            try (PreparedStatement ps = con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    Room room = new Room();
                    room.setRoomNo(rs.getString("room_no"));
                    room.setRoomType(rs.getString("room_type"));
                    room.setPricePerNight(rs.getDouble("price_per_night"));
                    room.setStatus(rs.getString("status"));
                    rooms.add(room);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rooms;
    }

    public boolean updateRoomStatus(String roomNo, String status) {
        String sql = "UPDATE room_inventory SET status = ? WHERE room_no = ?";

        try (Connection con = DBConnection.getConnection()) {
            if (con == null) {
                return false;
            }

            ensureRoomInventoryTable(con);

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, status);
                ps.setString(2, roomNo);
                return ps.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int getTotalRoomsCount() {
        return countRoomsBySql("SELECT COUNT(*) FROM room_inventory");
    }

    public int getRoomsByStatusCount(String status) {
        String sql = "SELECT COUNT(*) FROM room_inventory WHERE status = ?";
        try (Connection con = DBConnection.getConnection()) {
            if (con == null) {
                return 0;
            }

            ensureRoomInventoryTable(con);

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, status);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    private int countRoomsBySql(String sql) {
        try (Connection con = DBConnection.getConnection()) {
            if (con == null) {
                return 0;
            }

            ensureRoomInventoryTable(con);

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

    public Bill calculateBill(String reservationNo) {

        Bill bill = null;

        String sql = "SELECT r.reservation_no, r.guest_name, r.room_type, " +
                     "r.check_in, r.check_out, rm.price_per_night " +
                     "FROM reservations r " +
                     "JOIN rooms rm ON r.room_type = rm.room_type " +
                     "WHERE r.reservation_no = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, reservationNo);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    bill = new Bill();

                    bill.setReservationNo(rs.getString("reservation_no"));
                    bill.setGuestName(rs.getString("guest_name"));
                    bill.setRoomType(rs.getString("room_type"));

                    Date checkInDate = rs.getDate("check_in");
                    Date checkOutDate = rs.getDate("check_out");

                    LocalDate checkIn = checkInDate.toLocalDate();
                    LocalDate checkOut = checkOutDate.toLocalDate();

                    bill.setCheckIn(checkIn);
                    bill.setCheckOut(checkOut);

                    long nights = ChronoUnit.DAYS.between(checkIn, checkOut);
                    bill.setNumberOfNights(nights);

                    double price = rs.getDouble("price_per_night");
                    bill.setPricePerNight(price);

                    double total = nights * price;
                    bill.setTotalAmount(total);

                    bill.setBillDate(LocalDate.now());
                    bill.setPaymentStatus("PENDING");

                    // ✅ Save only if bill not already generated
                    if (!billExists(con, reservationNo)) {
                        saveBill(con, bill);
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return bill;
    }

    // ✅ Check if bill already exists
    private boolean billExists(Connection con, String reservationNo) throws SQLException {

        String checkSql = "SELECT bill_id FROM bills WHERE reservation_no = ?";

        try (PreparedStatement ps = con.prepareStatement(checkSql)) {

            ps.setString(1, reservationNo);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); // true if record exists
            }
        }
    }

    // ✅ Save bill into database
    private void saveBill(Connection con, Bill bill) throws SQLException {

        String insertSql = "INSERT INTO bills " +
                "(reservation_no, guest_name, room_type, check_in, check_out, " +
                "number_of_nights, price_per_night, total_amount, bill_date, payment_status) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = con.prepareStatement(insertSql)) {

            ps.setString(1, bill.getReservationNo());
            ps.setString(2, bill.getGuestName());
            ps.setString(3, bill.getRoomType());
            ps.setDate(4, Date.valueOf(bill.getCheckIn()));
            ps.setDate(5, Date.valueOf(bill.getCheckOut()));
            ps.setLong(6, bill.getNumberOfNights());
            ps.setDouble(7, bill.getPricePerNight());
            ps.setDouble(8, bill.getTotalAmount());
            ps.setDate(9, Date.valueOf(bill.getBillDate()));
            ps.setString(10, bill.getPaymentStatus());

            ps.executeUpdate();
        }
    }
}