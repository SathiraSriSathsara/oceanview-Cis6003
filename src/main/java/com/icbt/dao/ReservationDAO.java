package com.icbt.dao;

import com.icbt.model.Reservation;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {

    // SAVE
    public void saveReservation(Reservation reservation) {

        try (Connection con = DBConnection.getConnection()) {

            String sql = "INSERT INTO reservations (reservation_no, guest_name, address, contact, room_type, check_in, check_out) VALUES (?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, reservation.getReservationNo());
            ps.setString(2, reservation.getGuestName());
            ps.setString(3, reservation.getAddress());
            ps.setString(4, reservation.getContact());
            ps.setString(5, reservation.getRoomType());
            ps.setString(6, reservation.getCheckIn());
            ps.setString(7, reservation.getCheckOut());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // GET ALL
    public List<Reservation> getAllReservations() {

        List<Reservation> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {

            String sql = "SELECT * FROM reservations";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Reservation r = new Reservation();
                r.setReservationNo(rs.getString("reservation_no"));
                r.setGuestName(rs.getString("guest_name"));
                r.setAddress(rs.getString("address"));
                r.setContact(rs.getString("contact"));
                r.setRoomType(rs.getString("room_type"));
                r.setCheckIn(rs.getString("check_in"));
                r.setCheckOut(rs.getString("check_out"));
                list.add(r);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // GET BY ID
    public Reservation getReservationById(String id) {

        Reservation r = null;

        try (Connection con = DBConnection.getConnection()) {

            String sql = "SELECT * FROM reservations WHERE reservation_no = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                r = new Reservation();
                r.setReservationNo(rs.getString("reservation_no"));
                r.setGuestName(rs.getString("guest_name"));
                r.setAddress(rs.getString("address"));
                r.setContact(rs.getString("contact"));
                r.setRoomType(rs.getString("room_type"));
                r.setCheckIn(rs.getString("check_in"));
                r.setCheckOut(rs.getString("check_out"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return r;
    }

    // UPDATE
    public void updateReservation(Reservation r) {

        try (Connection con = DBConnection.getConnection()) {

            String sql = "UPDATE reservations SET guest_name=?, address=?, contact=?, room_type=?, check_in=?, check_out=? WHERE reservation_no=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, r.getGuestName());
            ps.setString(2, r.getAddress());
            ps.setString(3, r.getContact());
            ps.setString(4, r.getRoomType());
            ps.setString(5, r.getCheckIn());
            ps.setString(6, r.getCheckOut());
            ps.setString(7, r.getReservationNo());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // DELETE
    public void deleteReservation(String id) {

        try (Connection con = DBConnection.getConnection()) {

            String sql = "DELETE FROM reservations WHERE reservation_no = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, id);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}