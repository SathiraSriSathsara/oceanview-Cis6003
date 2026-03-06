package com.icbt.controller;

import com.icbt.dao.ReservationDAO;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/deleteReservation")
public class DeleteReservationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");

        ReservationDAO dao = new ReservationDAO();
        dao.deleteReservation(id);
        
     // Set Success Message
        request.getSession().setAttribute("successMessage", "Reservation deleted successfully!");


        response.sendRedirect(request.getContextPath() + "/views/viewReservation.jsp");
    }
}