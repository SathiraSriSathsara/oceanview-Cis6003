<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ page import="com.icbt.model.Bill" %>
<%@ page import="java.time.LocalDate" %>
<%@ include file="../common/auth-check.jsp" %>
<%
    Bill bill = (Bill) request.getAttribute("bill");
    if (bill == null) {
        response.sendRedirect(request.getContextPath() + "/views/bill.jsp");
        return;
    }

    double serviceCharge = bill.getTotalAmount() * 0.10;
    double tax = bill.getTotalAmount() * 0.05;
    double grandTotal = bill.getTotalAmount() + serviceCharge + tax;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Invoice Â· <%= bill.getReservationNo() %></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bill.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>

<%@ include file="../common/navbar.jsp" %>

<div class="main-content invoice-page">
    <div class="top-bar no-print">
        <h1 class="page-title"><i class="fas fa-receipt"></i> Invoice Preview</h1>
    </div>

    <div class="invoice-container">
        <div class="invoice-card">
            <div class="invoice-ribbon">PAID AT FRONT DESK</div>

            <div class="invoice-header">
                <div class="logo-section">
                    <h1>Ocean View Resort</h1>
                    <p>Beach Road, Galle, Sri Lanka</p>
                    <p>Phone: +94 71 123 4567</p>
                    <p>Email: billing@oceanview.lk</p>
                </div>

                <div class="invoice-info">
                    <h2>INVOICE</h2>
                    <p><strong>Invoice Date:</strong> <%= LocalDate.now() %></p>
                    <p><strong>Reservation No:</strong> <%= bill.getReservationNo() %></p>
                    <p><strong>Status:</strong> <span class="status-badge"><%= bill.getPaymentStatus() %></span></p>
                </div>
            </div>

            <div class="guest-section">
                <div class="guest-item"><span>Guest Name</span><strong><%= bill.getGuestName() %></strong></div>
                <div class="guest-item"><span>Room Type</span><strong><%= bill.getRoomType() %></strong></div>
                <div class="guest-item"><span>Check-In</span><strong><%= bill.getCheckIn() %></strong></div>
                <div class="guest-item"><span>Check-Out</span><strong><%= bill.getCheckOut() %></strong></div>
            </div>

            <table class="invoice-table">
                <thead>
                    <tr>
                        <th>Description</th>
                        <th>Nights</th>
                        <th>Rate (Rs.)</th>
                        <th>Total (Rs.)</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><%= bill.getRoomType() %> room stay</td>
                        <td><%= bill.getNumberOfNights() %></td>
                        <td><%= String.format("%,.2f", bill.getPricePerNight()) %></td>
                        <td><%= String.format("%,.2f", bill.getTotalAmount()) %></td>
                    </tr>
                    <tr>
                        <td colspan="3" class="summary-label">Service Charge (10%)</td>
                        <td><%= String.format("%,.2f", serviceCharge) %></td>
                    </tr>
                    <tr>
                        <td colspan="3" class="summary-label">Tax (5%)</td>
                        <td><%= String.format("%,.2f", tax) %></td>
                    </tr>
                </tbody>
            </table>

            <div class="total-area">
                <h3>Grand Total: Rs. <%= String.format("%,.2f", grandTotal) %></h3>
            </div>

            <div class="btn-group no-print">
                <a href="${pageContext.request.contextPath}/views/bill.jsp" class="btn btn-secondary">Back</a>
                <button onclick="window.print()" class="btn btn-primary">Print Invoice</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>

