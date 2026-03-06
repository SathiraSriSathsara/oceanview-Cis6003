<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ include file="../common/auth-check.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="com.icbt.model.User" %>
<%
    List<User> users = (List<User>) request.getAttribute("users");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Accounts Â· Ocean View Resort</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/management.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>

<%@ include file="../common/navbar.jsp" %>

<div class="main-content">
    <div class="top-bar">
        <h1 class="page-title"><i class="fas fa-users"></i> User Accounts</h1>
    </div>

    <div class="split-grid">
        <div class="form-card">
            <h2>Create User Account</h2>

            <% if (request.getAttribute("successMessage") != null) { %>
                <div class="success-message"><%= request.getAttribute("successMessage") %></div>
            <% } %>

            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="error-message"><%= request.getAttribute("errorMessage") %></div>
            <% } %>

            <form action="${pageContext.request.contextPath}/users" method="post">
                <input type="hidden" name="action" value="add">

                <div class="form-group">
                    <label>Username</label>
                    <input type="text" name="username" required>
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" required>
                </div>

                <div class="form-group">
                    <label>Role</label>
                    <select name="role" required>
                        <option value="admin">admin</option>
                        <option value="staff">staff</option>
                        <option value="manager">manager</option>
                    </select>
                </div>

                <button type="submit" class="btn">Create User</button>
            </form>
        </div>

        <div class="table-card">
            <h2>System Users</h2>
            <table class="reservation-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Role</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (users != null && !users.isEmpty()) {
                        for (User user : users) { %>
                            <tr>
                                <td><%= user.getId() %></td>
                                <td><%= user.getUsername() %></td>
                                <td><%= user.getRole() %></td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/users" method="post" class="inline-form" onsubmit="return confirm('Delete this user account?');">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="<%= user.getId() %>">
                                        <button type="submit" class="btn btn-sm danger">Delete</button>
                                    </form>
                                </td>
                            </tr>
                    <%  }
                    } else { %>
                        <tr>
                            <td colspan="4">No users available.</td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>

