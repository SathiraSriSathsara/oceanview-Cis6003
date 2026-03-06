<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ include file="../common/auth-check.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<%@ page import="com.icbt.model.Reservation" %>
<%
    LocalDate today = LocalDate.now();
    String formattedDate = today.format(DateTimeFormatter.ofPattern("EEEE, MMMM dd, yyyy"));

    int totalRooms = request.getAttribute("totalRooms") != null ? (Integer) request.getAttribute("totalRooms") : 0;
    int availableRooms = request.getAttribute("availableRooms") != null ? (Integer) request.getAttribute("availableRooms") : 0;
    int occupiedRooms = request.getAttribute("occupiedRooms") != null ? (Integer) request.getAttribute("occupiedRooms") : 0;
    int maintenanceRooms = request.getAttribute("maintenanceRooms") != null ? (Integer) request.getAttribute("maintenanceRooms") : 0;
    int cleaningRooms = request.getAttribute("cleaningRooms") != null ? (Integer) request.getAttribute("cleaningRooms") : 0;

    int totalReservations = request.getAttribute("totalReservations") != null ? (Integer) request.getAttribute("totalReservations") : 0;
    int todayCheckIns = request.getAttribute("todayCheckIns") != null ? (Integer) request.getAttribute("todayCheckIns") : 0;
    int todayCheckOuts = request.getAttribute("todayCheckOuts") != null ? (Integer) request.getAttribute("todayCheckOuts") : 0;
    int activeReservations = request.getAttribute("activeReservations") != null ? (Integer) request.getAttribute("activeReservations") : 0;
    int pendingBills = request.getAttribute("pendingBills") != null ? (Integer) request.getAttribute("pendingBills") : 0;
    int totalUsers = request.getAttribute("totalUsers") != null ? (Integer) request.getAttribute("totalUsers") : 0;
    double totalRevenue = request.getAttribute("totalRevenue") != null ? (Double) request.getAttribute("totalRevenue") : 0.0;
    int todayBookings = request.getAttribute("todayBookings") != null ? (Integer) request.getAttribute("todayBookings") : 0;
    int tomorrowBookings = request.getAttribute("tomorrowBookings") != null ? (Integer) request.getAttribute("tomorrowBookings") : 0;

    List<Reservation> recentReservations = (List<Reservation>) request.getAttribute("recentReservations");

    int occupancyPercent = totalRooms > 0 ? (occupiedRooms * 100 / totalRooms) : 0;
%>
<!DOCTYPE html>
<html>
<head>
    <title>Staff Dashboard Â· Ocean View Resort</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>

<%@ include file="../common/navbar.jsp" %>

<div class="main-content">
    <div class="top-bar">
        <h1 class="page-title">
            <i class="fas fa-tachometer-alt"></i>
            Dashboard
        </h1>
        <div class="top-bar-actions">
            <div class="notification-badge">
                <i class="fas fa-bell"></i>
                <span class="badge-count"><%= pendingBills %></span>
            </div>
            <div class="date-display">
                <i class="far fa-calendar-alt"></i>
                <%= formattedDate %>
            </div>
        </div>
    </div>

    <div class="kpi-grid">
        <div class="kpi-card">
            <div class="kpi-icon" style="background: #e0f2fe;">
                <i class="fas fa-door-open" style="color: #0284c7;"></i>
            </div>
            <div class="kpi-content">
                <span class="kpi-label">Total Rooms</span>
                <span class="kpi-value"><%= totalRooms %></span>
            </div>
        </div>

        <div class="kpi-card">
            <div class="kpi-icon" style="background: #dcfce7;">
                <i class="fas fa-check-circle" style="color: #16a34a;"></i>
            </div>
            <div class="kpi-content">
                <span class="kpi-label">Available Rooms</span>
                <span class="kpi-value"><%= availableRooms %></span>
            </div>
        </div>

        <div class="kpi-card">
            <div class="kpi-icon" style="background: #fff3cd;">
                <i class="fas fa-bed" style="color: #b45309;"></i>
            </div>
            <div class="kpi-content">
                <span class="kpi-label">Occupancy</span>
                <span class="kpi-value"><%= occupancyPercent %>%</span>
            </div>
        </div>

        <div class="kpi-card">
            <div class="kpi-icon" style="background: #f3e8ff;">
                <i class="fas fa-users" style="color: #7e22ce;"></i>
            </div>
            <div class="kpi-content">
                <span class="kpi-label">User Accounts</span>
                <span class="kpi-value"><%= totalUsers %></span>
            </div>
        </div>

        <div class="kpi-card">
            <div class="kpi-icon" style="background: #fee2e2;">
                <i class="fas fa-money-bill-wave" style="color: #b91c1c;"></i>
            </div>
            <div class="kpi-content">
                <span class="kpi-label">Revenue</span>
                <span class="kpi-value">Rs. <%= String.format("%,.0f", totalRevenue) %></span>
            </div>
        </div>
    </div>

    <div class="dashboard-grid">
        <div class="card">
            <div class="card-header">
                <h2><i class="fas fa-bed"></i> Room Status Overview</h2>
                <a href="${pageContext.request.contextPath}/rooms" class="link-view">Manage rooms <i class="fas fa-arrow-right"></i></a>
            </div>
            <div class="card-body">
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">
                    <div style="display: flex; align-items: center; gap: 10px;">
                        <span style="width: 12px; height: 12px; background: #28a745; border-radius: 50%;"></span>
                        <div><strong><%= availableRooms %></strong> Available</div>
                    </div>
                    <div style="display: flex; align-items: center; gap: 10px;">
                        <span style="width: 12px; height: 12px; background: #dc3545; border-radius: 50%;"></span>
                        <div><strong><%= occupiedRooms %></strong> Occupied</div>
                    </div>
                    <div style="display: flex; align-items: center; gap: 10px;">
                        <span style="width: 12px; height: 12px; background: #ffc107; border-radius: 50%;"></span>
                        <div><strong><%= maintenanceRooms %></strong> Maintenance</div>
                    </div>
                    <div style="display: flex; align-items: center; gap: 10px;">
                        <span style="width: 12px; height: 12px; background: #17a2b8; border-radius: 50%;"></span>
                        <div><strong><%= cleaningRooms %></strong> Cleaning</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="card">
            <div class="card-header">
                <h2><i class="fas fa-calendar-day"></i> Today's Operation Snapshot</h2>
                <span class="badge" style="background: var(--gray-100); padding: 5px 10px; border-radius: 20px;"><%= todayBookings + tomorrowBookings %> planned check-ins</span>
            </div>
            <div class="card-body">
                <div style="display: flex; flex-direction: column; gap: 12px;">
                    <div style="display: flex; justify-content: space-between;">
                        <span>Check-ins Today</span><strong><%= todayCheckIns %></strong>
                    </div>
                    <div style="display: flex; justify-content: space-between;">
                        <span>Check-outs Today</span><strong><%= todayCheckOuts %></strong>
                    </div>
                    <div style="display: flex; justify-content: space-between;">
                        <span>Active Reservations</span><strong><%= activeReservations %></strong>
                    </div>
                    <div style="display: flex; justify-content: space-between;">
                        <span>New Bookings Today</span><strong><%= todayBookings %></strong>
                    </div>
                    <div style="display: flex; justify-content: space-between;">
                        <span>Expected Tomorrow</span><strong><%= tomorrowBookings %></strong>
                    </div>
                </div>
            </div>
        </div>

        <div class="card">
            <div class="card-header">
                <h2><i class="fas fa-clock"></i> Recent Reservations</h2>
                <a href="${pageContext.request.contextPath}/views/viewReservation.jsp" class="link-view">View all</a>
            </div>
            <div class="card-body">
                <div style="display: flex; flex-direction: column; gap: 14px;">
                    <%
                        if (recentReservations != null && !recentReservations.isEmpty()) {
                            for (Reservation r : recentReservations) {
                                long nights = 0;
                                try {
                                    nights = ChronoUnit.DAYS.between(LocalDate.parse(r.getCheckIn()), LocalDate.parse(r.getCheckOut()));
                                } catch (Exception ignored) {
                                }
                    %>
                    <div style="display: flex; justify-content: space-between; align-items: center;">
                        <div>
                            <div style="font-weight: 600;"><%= r.getGuestName() %></div>
                            <div style="font-size: 13px; color: var(--gray-600);"><%= r.getRoomType() %> Â· <%= nights %> nights</div>
                        </div>
                        <span style="background: #d4edda; color: #155724; padding: 5px 10px; border-radius: 20px; font-size: 12px;">Booked</span>
                    </div>
                    <%      }
                        } else {
                    %>
                    <div style="color: var(--gray-600);">No recent reservations found.</div>
                    <% } %>
                </div>
            </div>
        </div>

        <div class="card">
            <div class="card-header">
                <h2><i class="fas fa-bolt"></i> Quick Actions</h2>
            </div>
            <div class="card-body">
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px;">
                    <a href="${pageContext.request.contextPath}/views/addReservation.jsp" class="btn" style="background: var(--gray-100); color: var(--gray-700); text-decoration:none;">
                        <i class="fas fa-calendar-plus"></i> Add Booking
                    </a>
                    <a href="${pageContext.request.contextPath}/rooms" class="btn" style="background: var(--gray-100); color: var(--gray-700); text-decoration:none;">
                        <i class="fas fa-door-open"></i> Manage Rooms
                    </a>
                    <a href="${pageContext.request.contextPath}/users" class="btn" style="background: var(--gray-100); color: var(--gray-700); text-decoration:none;">
                        <i class="fas fa-user-cog"></i> User Accounts
                    </a>
                    <a href="${pageContext.request.contextPath}/views/bill.jsp" class="btn" style="background: var(--gray-100); color: var(--gray-700); text-decoration:none;">
                        <i class="fas fa-file-invoice"></i> Generate Invoice
                    </a>
                </div>
            </div>
        </div>
    </div>

    <footer class="dashboard-footer">
        <p>Ocean View Resort Â· Operational Dashboard</p>
    </footer>
</div>

</body>
</html>

