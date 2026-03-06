package com.icbt.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.icbt.dao.RoomDAO;
import com.icbt.model.Room;

@WebServlet("/rooms")
public class RoomManagementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        loadDataAndForward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("add".equalsIgnoreCase(action)) {
            Room room = new Room();
            room.setRoomNo(request.getParameter("roomNo"));
            room.setRoomType(request.getParameter("roomType"));
            room.setStatus(request.getParameter("status"));

            try {
                room.setPricePerNight(Double.parseDouble(request.getParameter("pricePerNight")));
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Invalid room price.");
                loadDataAndForward(request, response);
                return;
            }

            boolean saved = roomDAO.addRoom(room);
            request.setAttribute("successMessage", saved ? "Room added successfully." : "Unable to add room. Room number may already exist.");
        } else if ("status".equalsIgnoreCase(action)) {
            String roomNo = request.getParameter("roomNo");
            String status = request.getParameter("status");
            boolean updated = roomDAO.updateRoomStatus(roomNo, status);
            request.setAttribute("successMessage", updated ? "Room status updated." : "Unable to update room status.");
        }

        loadDataAndForward(request, response);
    }

    private void loadDataAndForward(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Room> rooms = roomDAO.getAllRooms();
        request.setAttribute("rooms", rooms);
        request.getRequestDispatcher("/views/rooms.jsp").forward(request, response);
    }
}
