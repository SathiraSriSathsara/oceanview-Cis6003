package com.icbt.dao;

import java.sql.*;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

import com.icbt.model.Bill;

public class RoomDAO {

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