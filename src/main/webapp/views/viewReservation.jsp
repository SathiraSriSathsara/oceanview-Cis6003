<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ include file="../common/auth-check.jsp" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<title>View Reservations</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/viewReservation.css">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
	</head>

	<body>
	
	<%
    String message = (String) session.getAttribute("successMessage");
    if (message != null) {
	%>

	<script>
    	alert("<%= message %>");
	</script>

	<%
        session.removeAttribute("successMessage"); // remove after showing
    	}
	%>

		<%@ include file="../common/navbar.jsp" %>
		<%@ page import="java.util.List" %>
		<%@ page import="com.icbt.model.Reservation" %>
		<%@ page import="com.icbt.dao.ReservationDAO" %>

			<div class="main-content">
				<div class="table-card reservation-table-card">
					<h2>Reservation List</h2>

					<table class="reservation-table">
						<thead>
							<tr>
								<th>Reservation No</th>
            					<th>Guest Name</th>
            					<th>Address</th>
            					<th>Contact</th>
            					<th>Room Type</th>
            					<th>Check In</th>
            					<th>Check Out</th>
            					<th>Actions</th>
							</tr>
						</thead>
						<tbody>

						<%
    						ReservationDAO dao = new ReservationDAO();
    						List<Reservation> reservations = dao.getAllReservations();

    						for (Reservation r : reservations) {
						%>

						<tr>
    						<td><%= r.getReservationNo() %></td>
        					<td><%= r.getGuestName() %></td>
        					<td><%= r.getAddress() %></td>
        					<td><%= r.getContact() %></td>
        					<td><%= r.getRoomType() %></td>
        					<td><%= r.getCheckIn() %></td>
        					<td><%= r.getCheckOut() %></td>
        					<td class="action-buttons">

								<!-- Update Button -->
								<a href="${pageContext.request.contextPath}/views/updateReservation.jsp?id=<%= r.getReservationNo() %>"
								class="btn-icon edit-btn" title="Update">
									<i class="fas fa-pen"></i>
								</a>

								<!-- Delete Button -->
								<a href="${pageContext.request.contextPath}/deleteReservation?id=<%= r.getReservationNo() %>"
								class="btn-icon delete-btn"
								onclick="return confirm('Are you sure you want to delete this reservation?');"
								title="Delete">
									<i class="fas fa-trash"></i>
								</a>

							</td>
						</tr>

						<%
   							 }
						%>

						</tbody>
					</table>
				</div>
			</div>

	</body>

	</html>
