package com.icbt.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.icbt.dao.UserDAO;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Create UserDAO instance
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Show login page
        response.sendRedirect(request.getContextPath() + "/views/login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get username and password from form
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Validate user using UserDAO
        boolean isValidUser = userDAO.validateUser(username, password);

        if (isValidUser) {
            // Login success
            HttpSession session = request.getSession();
            session.setAttribute("username", username); // store user info in session
            response.sendRedirect(request.getContextPath() + "/views/dashboard.jsp");
        } else {
            // Login failed → redirect back with error
            response.sendRedirect(request.getContextPath() + "/views/login.jsp?error=1");
        }
    }
}
