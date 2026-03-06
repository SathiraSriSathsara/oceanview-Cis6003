<%@ page import="com.icbt.dao.ReservationDAO" %>
<%@ page import="com.icbt.model.Reservation" %>
<%@ include file="../common/auth-check.jsp" %>

<%
	String id = request.getParameter("id");
	ReservationDAO dao = new ReservationDAO();
	Reservation r = dao.getReservationById(id);
%>
<html>
<head>
<meta charset="UTF-8">
<title>Update Reservation</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/dashboard.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/form.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>

<%@ include file="../common/navbar.jsp" %>

<div class="main-content">
    <div class="top-bar">
        <h1 class="page-title">
            <i class="fas fa-edit"></i>
            Update Reservation
        </h1>
    </div>

<div class="container-form">
    <div class="form-card">

        <h2>Update Reservation Details</h2>

        <form action="<%=request.getContextPath()%>/updateReservation" method="post">

            <input type="hidden" name="reservationNo" value="<%= r.getReservationNo() %>">

            <label>Reservation Number</label>
            <input type="text" value="<%= r.getReservationNo() %>" disabled style="background-color: #f5f5f5;">

            <label>Guest Name</label>
            <input type="text" name="guestName" value="<%= r.getGuestName() %>" required>

            <label>Address</label>
            <input type="text" name="address" value="<%= r.getAddress() %>" required>

            <label>Contact</label>
            <input type="text" name="contact" value="<%= r.getContact() %>" required pattern="[0-9]{10}" title="Please enter a valid 10-digit phone number">

            <label>Room Type</label>
            <select name="roomType" required>
                <option value="Standard" <%= "Standard".equals(r.getRoomType()) ? "selected" : "" %>>Standard</option>
                <option value="Deluxe" <%= "Deluxe".equals(r.getRoomType()) ? "selected" : "" %>>Deluxe</option>
                <option value="Suite" <%= "Suite".equals(r.getRoomType()) ? "selected" : "" %>>Suite</option>
            </select>

            <label>Check In</label>
            <input type="date" name="checkIn" value="<%= r.getCheckIn() %>" required>

            <label>Check Out</label>
            <input type="date" name="checkOut" value="<%= r.getCheckOut() %>" required>

            <div style="display: flex; gap: 10px; margin-top: 20px;">
                <button type="submit" style="flex: 1;">
                    <i class="fas fa-save"></i> Update Reservation
                </button>
                <a href="<%=request.getContextPath()%>/views/viewReservation.jsp" 
                   style="flex: 1; background: #6c757d; color: white; padding: 12px; text-align: center; 
                          text-decoration: none; border-radius: 8px; display: inline-flex; 
                          align-items: center; justify-content: center; gap: 8px;">
                    <i class="fas fa-times"></i> Cancel
                </a>
            </div>

        </form>

    </div>
</div>
</div>

</body>
</html>