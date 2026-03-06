package com.icbt.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.icbt.dao.UserDAO;
import com.icbt.model.User;

@WebServlet("/users")
public class UserManagementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserDAO userDAO = new UserDAO();

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
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String role = request.getParameter("role");

            User user = new User(username, password, role);
            boolean created = userDAO.addUser(user);
            request.setAttribute("successMessage", created ? "User account created." : "Unable to create user account.");
        } else if ("delete".equalsIgnoreCase(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean deleted = userDAO.deleteUser(id);
                request.setAttribute("successMessage", deleted ? "User account deleted." : "Unable to delete user account.");
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Invalid user id.");
            }
        }

        loadDataAndForward(request, response);
    }

    private void loadDataAndForward(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<User> users = userDAO.getAllUsers();
        request.setAttribute("users", users);
        request.getRequestDispatcher("/views/users.jsp").forward(request, response);
    }
}
