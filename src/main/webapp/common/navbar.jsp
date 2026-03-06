<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="../css/sidenav.css">

<!-- Side Navigation -->
<div class="sidenav">
    <div class="sidenav-header">
        <div class="logo-container">
            <span class="logo">Ocean View</span>
            <span class="logo-sub">Resort</span>
        </div>
    </div>
    
    <div class="sidenav-user">
        <div class="user-avatar">
            <i class="fas fa-user-circle"></i>
        </div>
        <div class="user-info">
            <span class="user-name">Sarah Johnson</span>
            <span class="user-role">Hotel Administrator</span>
        </div>
    </div>
    
    <div class="sidenav-menu">
        <a href="<%=request.getContextPath()%>/views/dashboard.jsp" class="menu-item <%= request.getRequestURI().contains("dashboard") ? "active" : "" %>">
            <i class="fas fa-tachometer-alt"></i>
            <span>Dashboard</span>
        </a>
        
        <div class="menu-section">
            <div class="menu-section-title">RESERVATIONS</div>
            <a href="<%=request.getContextPath()%>/views/addReservation.jsp" class="menu-item <%= request.getRequestURI().contains("addReservation") ? "active" : "" %>">
                <i class="fas fa-plus-circle"></i>
                <span>Add Reservation</span>
            </a>
            <a href="<%=request.getContextPath()%>/views/viewReservation.jsp" class="menu-item <%= request.getRequestURI().contains("viewReservation") ? "active" : "" %>">
                <i class="fas fa-list"></i>
                <span>View Reservations</span>
            </a>
        </div>
        
        <a href="<%=request.getContextPath()%>/views/bill.jsp" class="menu-item <%= request.getRequestURI().contains("bill") ? "active" : "" %>">
            <i class="fas fa-file-invoice-dollar"></i>
            <span>Billing</span>
        </a>
        
        <a href="<%=request.getContextPath()%>/views/help.jsp" class="menu-item <%= request.getRequestURI().contains("help") ? "active" : "" %>">
            <i class="fas fa-question-circle"></i>
            <span>Help</span>
        </a>
    </div>
    
    <div class="sidenav-footer">
        <a href="<%=request.getContextPath()%>/LogoutServlet" class="menu-item logout-btn">
            <i class="fas fa-sign-out-alt"></i>
            <span>Logout</span>
        </a>
    </div>
</div>