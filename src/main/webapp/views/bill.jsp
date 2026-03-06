<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../common/auth-check.jsp" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<title>Billing</title>
		<link rel="stylesheet" href="../css/style.css">
		<link rel="stylesheet" href="../css/dashboard.css">
		<link rel="stylesheet" href="../css/bill.css">
	</head>

	<body>

		<%@ include file="../common/navbar.jsp" %>

			<div class="container">
				<div class="bill-card">
					<h2>Calculate Bill</h2>

					<form action="<%= request.getContextPath() %>/bill" method="post">

						<div class="form-group">
							<label>Reservation Number</label>
							<input type="text" name="reservationNo" placeholder="Enter reservation number" required>
						</div>

						<button type="submit" class="btn">Calculate Bill</button>

					</form>
				</div>
			</div>

	</body>

	</html>