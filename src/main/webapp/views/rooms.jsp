<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ include file="../common/auth-check.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="com.icbt.model.Room" %>
<%
    List<Room> rooms = (List<Room>) request.getAttribute("rooms");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Room Management  -  Ocean View Resort</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/management.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>

<%@ include file="../common/navbar.jsp" %>

<div class="main-content">
    <div class="top-bar">
        <h1 class="page-title"><i class="fas fa-bed"></i> Room Management</h1>
    </div>

    <div class="split-grid">
        <div class="form-card">
            <h2>Add New Room</h2>

            <% if (request.getAttribute("successMessage") != null) { %>
                <div class="success-message"><%= request.getAttribute("successMessage") %></div>
            <% } %>

            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="error-message"><%= request.getAttribute("errorMessage") %></div>
            <% } %>

            <form action="${pageContext.request.contextPath}/rooms" method="post">
                <input type="hidden" name="action" value="add">

                <div class="form-group">
                    <label>Room Number</label>
                    <input type="text" name="roomNo" placeholder="ex: A-101" required>
                </div>

                <div class="form-group">
                    <label>Room Type</label>
                    <select name="roomType" required>
                        <option value="">-- Select Type --</option>
                        <option value="Standard">Standard</option>
                        <option value="Deluxe">Deluxe</option>
                        <option value="Suite">Suite</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Price Per Night (Rs.)</label>
                    <input type="number" min="0" step="0.01" name="pricePerNight" required>
                </div>

                <div class="form-group">
                    <label>Status</label>
                    <select name="status" required>
                        <option value="AVAILABLE">AVAILABLE</option>
                        <option value="OCCUPIED">OCCUPIED</option>
                        <option value="MAINTENANCE">MAINTENANCE</option>
                        <option value="CLEANING">CLEANING</option>
                    </select>
                </div>

                <button type="submit" class="btn">Add Room</button>
            </form>
        </div>

        <div class="table-card">
            <h2>Room Inventory</h2>
            <table class="reservation-table">
                <thead>
                    <tr>
                        <th>Room No</th>
                        <th>Type</th>
                        <th>Price / Night</th>
                        <th>Status</th>
                        <th>Update Status</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (rooms != null && !rooms.isEmpty()) {
                        for (Room room : rooms) { %>
                            <tr>
                                <td><%= room.getRoomNo() %></td>
                                <td><%= room.getRoomType() %></td>
                                <td>Rs. <%= String.format("%,.2f", room.getPricePerNight()) %></td>
                                <td><span class="status-pill status-<%= room.getStatus().toLowerCase() %>"><%= room.getStatus() %></span></td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/rooms" method="post" class="inline-form">
                                        <input type="hidden" name="action" value="status">
                                        <input type="hidden" name="roomNo" value="<%= room.getRoomNo() %>">
                                        <select name="status">
                                            <option value="AVAILABLE" <%= "AVAILABLE".equals(room.getStatus()) ? "selected" : "" %>>AVAILABLE</option>
                                            <option value="OCCUPIED" <%= "OCCUPIED".equals(room.getStatus()) ? "selected" : "" %>>OCCUPIED</option>
                                            <option value="MAINTENANCE" <%= "MAINTENANCE".equals(room.getStatus()) ? "selected" : "" %>>MAINTENANCE</option>
                                            <option value="CLEANING" <%= "CLEANING".equals(room.getStatus()) ? "selected" : "" %>>CLEANING</option>
                                        </select>
                                        <button type="submit" class="btn btn-sm">Save</button>
                                    </form>
                                </td>
                            </tr>
                    <%  }
                    } else { %>
                        <tr>
                            <td colspan="5">No rooms available yet. Add your first room.</td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>


