<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../common/auth-check.jsp" %>
<%@ page import="com.icbt.dao.DBConnection" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    // Format today's date
    LocalDate today = LocalDate.now();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEEE, MMMM dd, yyyy");
    String formattedDate = today.format(formatter);
    
    // Get statistics from database
    int totalReservations = 0;
    int todayCheckIns = 0;
    int todayCheckOuts = 0;
    int activeReservations = 0;
    int pendingBills = 0;
    
    try {
        Connection con = DBConnection.getConnection();
        
        // Total reservations
        PreparedStatement ps1 = con.prepareStatement("SELECT COUNT(*) FROM reservations");
        ResultSet rs1 = ps1.executeQuery();
        if (rs1.next()) totalReservations = rs1.getInt(1);
        
        // Today's check-ins
        PreparedStatement ps2 = con.prepareStatement("SELECT COUNT(*) FROM reservations WHERE check_in = ?");
        ps2.setDate(1, Date.valueOf(today));
        ResultSet rs2 = ps2.executeQuery();
        if (rs2.next()) todayCheckIns = rs2.getInt(1);
        
        // Today's check-outs
        PreparedStatement ps3 = con.prepareStatement("SELECT COUNT(*) FROM reservations WHERE check_out = ?");
        ps3.setDate(1, Date.valueOf(today));
        ResultSet rs3 = ps3.executeQuery();
        if (rs3.next()) todayCheckOuts = rs3.getInt(1);
        
        // Active reservations
        PreparedStatement ps4 = con.prepareStatement("SELECT COUNT(*) FROM reservations WHERE check_in <= ? AND check_out >= ?");
        ps4.setDate(1, Date.valueOf(today));
        ps4.setDate(2, Date.valueOf(today));
        ResultSet rs4 = ps4.executeQuery();
        if (rs4.next()) activeReservations = rs4.getInt(1);
        
        // Pending bills
        PreparedStatement ps5 = con.prepareStatement("SELECT COUNT(*) FROM bills WHERE payment_status = 'PENDING'");
        ResultSet rs5 = ps5.executeQuery();
        if (rs5.next()) pendingBills = rs5.getInt(1);
        
    } catch (Exception e) {
        e.printStackTrace();
    }
    
    // Calculate available rooms (assuming 80 total rooms)
    int totalRooms = 80;
    int availableRooms = totalRooms - activeReservations;
%>
<!DOCTYPE html>
<html>
<head>
    <title>Staff Dashboard · Ocean View Resort</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/dashboard.css">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>

<%@ include file="../common/navbar.jsp" %>

<!-- Main Content Area -->
<div class="main-content">
    
    <!-- Top Bar -->
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

    <!-- KPI Cards -->
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
                <span class="kpi-label">Available</span>
                <span class="kpi-value"><%= availableRooms %></span>
            </div>
        </div>

        <div class="kpi-card">
            <div class="kpi-icon" style="background: #fff3cd;">
                <i class="fas fa-sign-in-alt" style="color: #b45309;"></i>
            </div>
            <div class="kpi-content">
                <span class="kpi-label">Check-ins Today</span>
                <span class="kpi-value"><%= todayCheckIns %></span>
            </div>
        </div>

        <div class="kpi-card">
            <div class="kpi-icon" style="background: #fee2e2;">
                <i class="fas fa-sign-out-alt" style="color: #b91c1c;"></i>
            </div>
            <div class="kpi-content">
                <span class="kpi-label">Check-outs Today</span>
                <span class="kpi-value"><%= todayCheckOuts %></span>
            </div>
        </div>

        <div class="kpi-card">
            <div class="kpi-icon" style="background: #f3e8ff;">
                <i class="fas fa-calendar-check" style="color: #7e22ce;"></i>
            </div>
            <div class="kpi-content">
                <span class="kpi-label">Total Reservations</span>
                <span class="kpi-value"><%= totalReservations %></span>
            </div>
        </div>
    </div>

    <!-- Dashboard Grid -->
    <div class="dashboard-grid">
        <!-- Room Status Overview -->
        <div class="card">
            <div class="card-header">
                <h2><i class="fas fa-bed"></i> Room Status Overview</h2>
                <a href="<%= request.getContextPath() %>/views/viewReservation.jsp" class="link-view">View all <i class="fas fa-arrow-right"></i></a>
            </div>
            <div class="card-body">
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">
                    <div class="status-item" style="display: flex; align-items: center; gap: 10px;">
                        <span style="width: 12px; height: 12px; background: #28a745; border-radius: 50%;"></span>
                        <div><strong><%= availableRooms %></strong> Available</div>
                    </div>
                    <div class="status-item" style="display: flex; align-items: center; gap: 10px;">
                        <span style="width: 12px; height: 12px; background: #dc3545; border-radius: 50%;"></span>
                        <div><strong><%= activeReservations %></strong> Occupied</div>
                    </div>
                    <div class="status-item" style="display: flex; align-items: center; gap: 10px;">
                        <span style="width: 12px; height: 12px; background: #ffc107; border-radius: 50%;"></span>
                        <div><strong>6</strong> Maintenance</div>
                    </div>
                    <div class="status-item" style="display: flex; align-items: center; gap: 10px;">
                        <span style="width: 12px; height: 12px; background: #17a2b8; border-radius: 50%;"></span>
                        <div><strong>4</strong> Cleaning</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Today's Schedule -->
        <div class="card">
            <div class="card-header">
                <h2><i class="fas fa-calendar-day"></i> Today's Schedule</h2>
                <span class="badge" style="background: var(--gray-100); padding: 5px 10px; border-radius: 20px;">8 events</span>
            </div>
            <div class="card-body">
                <div style="display: flex; flex-direction: column; gap: 15px;">
                    <div style="display: flex; gap: 15px;">
                        <span style="font-weight: 600; min-width: 60px;">09:00</span>
                        <div>
                            <div style="font-weight: 500;">VIP Check-in · Presidential Suite</div>
                            <div style="font-size: 13px; color: var(--gray-600);">Mr. & Mrs. Thompson</div>
                        </div>
                    </div>
                    <div style="display: flex; gap: 15px;">
                        <span style="font-weight: 600; min-width: 60px;">10:30</span>
                        <div>
                            <div style="font-weight: 500;">Room Service · Deluxe Ocean View</div>
                            <div style="font-size: 13px; color: var(--gray-600);">Room 412</div>
                        </div>
                    </div>
                    <div style="display: flex; gap: 15px;">
                        <span style="font-weight: 600; min-width: 60px;">12:00</span>
                        <div>
                            <div style="font-weight: 500;">Late Check-out Request</div>
                            <div style="font-size: 13px; color: var(--gray-600);">Room 305</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Recent Bookings -->
        <div class="card">
            <div class="card-header">
                <h2><i class="fas fa-clock"></i> Recent Bookings</h2>
                <a href="#" class="link-view">View all</a>
            </div>
            <div class="card-body">
                <div style="display: flex; flex-direction: column; gap: 15px;">
                    <div style="display: flex; justify-content: space-between; align-items: center;">
                        <div>
                            <div style="font-weight: 500;">Michael Chen</div>
                            <div style="font-size: 13px; color: var(--gray-600);">Deluxe Suite · 3 nights</div>
                        </div>
                        <span style="background: #d4edda; color: #155724; padding: 5px 10px; border-radius: 20px; font-size: 12px;">Confirmed</span>
                    </div>
                    <div style="display: flex; justify-content: space-between; align-items: center;">
                        <div>
                            <div style="font-weight: 500;">Emma Watson</div>
                            <div style="font-size: 13px; color: var(--gray-600);">Ocean View · 2 nights</div>
                        </div>
                        <span style="background: #fff3cd; color: #856404; padding: 5px 10px; border-radius: 20px; font-size: 12px;">Pending</span>
                    </div>
                    <div style="display: flex; justify-content: space-between; align-items: center;">
                        <div>
                            <div style="font-weight: 500;">Robert Johnson</div>
                            <div style="font-size: 13px; color: var(--gray-600);">Presidential · 5 nights</div>
                        </div>
                        <span style="background: #d4edda; color: #155724; padding: 5px 10px; border-radius: 20px; font-size: 12px;">Confirmed</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="card">
            <div class="card-header">
                <h2><i class="fas fa-bolt"></i> Quick Actions</h2>
            </div>
            <div class="card-body">
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px;">
                    <button class="btn" style="background: var(--gray-100); color: var(--gray-700);">
                        <i class="fas fa-user-plus"></i> Check-in
                    </button>
                    <button class="btn" style="background: var(--gray-100); color: var(--gray-700);">
                        <i class="fas fa-user-minus"></i> Check-out
                    </button>
                    <button class="btn" style="background: var(--gray-100); color: var(--gray-700);">
                        <i class="fas fa-broom"></i> Housekeeping
                    </button>
                    <button class="btn" style="background: var(--gray-100); color: var(--gray-700);">
                        <i class="fas fa-clipboard-list"></i> Report
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="dashboard-footer">
        <p>© 2026 Ocean View Resort · Staff Dashboard v2.0</p>
    </footer>
</div>

</body>
</html>