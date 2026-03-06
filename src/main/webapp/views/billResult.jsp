<%@ page import="com.icbt.model.Bill" %>
<%@ page import="java.time.LocalDate" %>
<%
    Bill bill = (Bill) request.getAttribute("bill");
%>

<html>
<head>
<title>Bill Result</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/bill.css">
</head>
<body>

<div class="invoice-container">

    <div class="invoice-card">

        <!-- Header -->
        <div class="invoice-header">
            <div class="logo-section">
                <img src="<%=request.getContextPath()%>/images/logo.jpg" alt="Ocean View Resort Logo" class="logo">
                <h1>Ocean View Resort</h1>
                <p>Beach Road, Galle, Sri Lanka</p>
                <p>Phone: +94 71 123 4567</p>
            </div>

            <div class="invoice-info">
                <h2>INVOICE</h2>
                <p><strong>Date:</strong> <%= LocalDate.now() %></p>
                <p><strong>Reservation No:</strong> <%= bill.getReservationNo() %></p>
            </div>
        </div>

        <hr>

        <!-- Guest Info -->
        <div class="guest-section">
            <p><strong>Guest Name:</strong> <%= bill.getGuestName() %></p>
            <p><strong>Room Type:</strong> <%= bill.getRoomType() %></p>
            <p><strong>Check-In:</strong> <%= bill.getCheckIn() %></p>
            <p><strong>Check-Out:</strong> <%= bill.getCheckOut() %></p>
        </div>

        <!-- Table -->
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
                    <td><%= bill.getRoomType() %> Room Stay</td>
                    <td><%= bill.getNumberOfNights() %></td>
                    <td><%= bill.getPricePerNight() %></td>
                    <td><%= bill.getTotalAmount() %></td>
                </tr>
            </tbody>
        </table>

        <!-- Total Section -->
        <div class="total-area">
            <h3>Grand Total: Rs. <%= bill.getTotalAmount() %></h3>
        </div>

        <!-- Buttons -->
        <div class="btn-group no-print">
            <a href="<%=request.getContextPath()%>/views/bill.jsp" class="btn btn-secondary">Back</a>
            <button onclick="window.print()" class="btn btn-primary">Print Invoice</button>
        </div>

    </div>
</div>

</body>
</html>