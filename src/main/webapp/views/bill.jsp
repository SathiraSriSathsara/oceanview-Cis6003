<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ include file="../common/auth-check.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Billing  -  Ocean View Resort</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bill.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>

<%@ include file="../common/navbar.jsp" %>

<div class="main-content">
	<div class="top-bar">
		<h1 class="page-title"><i class="fas fa-file-invoice-dollar"></i> Billing Center</h1>
	</div>

	<div class="billing-hero">
		<div class="bill-card">
			<h2>Generate Guest Invoice</h2>
			<p class="bill-subtitle">Enter reservation number to calculate a professional invoice instantly.</p>

			<% if (request.getAttribute("error") != null) { %>
				<div class="error-message"><%= request.getAttribute("error") %></div>
			<% } %>

			<form action="${pageContext.request.contextPath}/bill" method="post">
				<div class="form-group">
					<label>Reservation Number</label>
					<input type="text" name="reservationNo" placeholder="ex: RSV-1001" required>
				</div>

				<button type="submit" class="btn">
					<i class="fas fa-calculator"></i>
					Calculate Bill
				</button>
			</form>
		</div>
	</div>
</div>

</body>
</html>

