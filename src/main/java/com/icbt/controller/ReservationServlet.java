package com.icbt.controller;


import java.io.IOException;
import java.time.LocalDate;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.icbt.model.Reservation;
import com.icbt.service.ReservationService;

@WebServlet("/addReservation")
public class ReservationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ReservationService reservationService = new ReservationService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form data
    	String reservationNo = request.getParameter("reservationNo");
        String guestName = request.getParameter("guestName");
        String address = request.getParameter("address");
        String contact = request.getParameter("contact");
        String roomType = request.getParameter("roomType");
        String checkIn = request.getParameter("checkIn");
        String checkOut = request.getParameter("checkOut");

        // ✅ Convert to LocalDate for comparison
        LocalDate checkInDate = LocalDate.parse(checkIn);
        LocalDate checkOutDate = LocalDate.parse(checkOut);

        // ✅ VALIDATION
        if (checkOutDate.isBefore(checkInDate)) {

            request.setAttribute("errorMessage",
                    "Check-Out date cannot be before Check-In date!");

            // Keep form values
            request.setAttribute("reservationNo", reservationNo);
            request.setAttribute("guestName", guestName);
            request.setAttribute("address", address);
            request.setAttribute("contact", contact);
            request.setAttribute("roomType", roomType);
            request.setAttribute("checkIn", checkIn);
            request.setAttribute("checkOut", checkOut);

            request.getRequestDispatcher("views/addReservation.jsp")
                   .forward(request, response);
            return;
        }

        // ✅ If valid → Save
        Reservation reservation = new Reservation();
        reservation.setReservationNo(reservationNo);
        reservation.setGuestName(guestName);
        reservation.setAddress(address);
        reservation.setContact(contact);
        reservation.setRoomType(roomType);
        reservation.setCheckIn(checkIn);
        reservation.setCheckOut(checkOut);

        reservationService.addReservation(reservation);

        request.setAttribute("successMessage", "Reservation Added Successfully!");
        request.getRequestDispatcher("views/addReservation.jsp")
               .forward(request, response);
    }
}