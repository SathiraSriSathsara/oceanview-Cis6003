package com.icbt.controller;

import com.icbt.dao.ReservationDAO;
import com.icbt.model.Reservation;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/updateReservation")
public class UpdateReservationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Reservation r = new Reservation();

        r.setReservationNo(request.getParameter("reservationNo"));
        r.setGuestName(request.getParameter("guestName"));
        r.setAddress(request.getParameter("address"));
        r.setContact(request.getParameter("contact"));
        r.setRoomType(request.getParameter("roomType"));
        r.setCheckIn(request.getParameter("checkIn"));
        r.setCheckOut(request.getParameter("checkOut"));

        ReservationDAO dao = new ReservationDAO();
        dao.updateReservation(r);

        // Set Success Message
        request.getSession().setAttribute("successMessage", "Reservation updated successfully!");

        response.sendRedirect(request.getContextPath() + "/views/viewReservation.jsp");
    }
}