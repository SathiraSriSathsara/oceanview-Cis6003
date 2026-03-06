package com.icbt.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.icbt.dao.DashboardDAO;
import com.icbt.dao.RoomDAO;
import com.icbt.dao.UserDAO;
import com.icbt.model.Reservation;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final DashboardDAO dashboardDAO = new DashboardDAO();
    private final RoomDAO roomDAO = new RoomDAO();
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int totalRooms = roomDAO.getTotalRoomsCount();
        int availableRooms = roomDAO.getRoomsByStatusCount("AVAILABLE");
        int occupiedRooms = roomDAO.getRoomsByStatusCount("OCCUPIED");
        int maintenanceRooms = roomDAO.getRoomsByStatusCount("MAINTENANCE");
        int cleaningRooms = roomDAO.getRoomsByStatusCount("CLEANING");

        int totalReservations = dashboardDAO.getTotalReservations();
        int todayCheckIns = dashboardDAO.getTodayCheckIns();
        int todayCheckOuts = dashboardDAO.getTodayCheckOuts();
        int activeReservations = dashboardDAO.getActiveReservations();
        int pendingBills = dashboardDAO.getPendingBillsCount();
        double totalRevenue = dashboardDAO.getTotalRevenue();
        int totalUsers = userDAO.getUserCount();

        List<Reservation> recentReservations = dashboardDAO.getRecentReservations(5);

        LocalDate today = LocalDate.now();
        request.setAttribute("todayBookings", dashboardDAO.getReservationCountForDate(today));
        request.setAttribute("tomorrowBookings", dashboardDAO.getReservationCountForDate(today.plusDays(1)));

        request.setAttribute("totalRooms", totalRooms);
        request.setAttribute("availableRooms", availableRooms);
        request.setAttribute("occupiedRooms", occupiedRooms);
        request.setAttribute("maintenanceRooms", maintenanceRooms);
        request.setAttribute("cleaningRooms", cleaningRooms);

        request.setAttribute("totalReservations", totalReservations);
        request.setAttribute("todayCheckIns", todayCheckIns);
        request.setAttribute("todayCheckOuts", todayCheckOuts);
        request.setAttribute("activeReservations", activeReservations);
        request.setAttribute("pendingBills", pendingBills);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("recentReservations", recentReservations);

        request.getRequestDispatcher("/views/dashboard.jsp").forward(request, response);
    }
}
