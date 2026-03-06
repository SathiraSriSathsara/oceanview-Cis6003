<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../common/auth-check.jsp" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<title>Help</title>
		<link rel="stylesheet" href="../css/style.css">
		<link rel="stylesheet" href="../css/dashboard.css">
		<link rel="stylesheet" href="../css/help.css">
	</head>

	<body>

		<%@ include file="../common/navbar.jsp" %>

			<div class="container">
    <div class="help-card">
        <h2>System Help Guide</h2>

        <h3>1. Login</h3>
        <p>
            Enter your registered username and password to access the system dashboard.
            If login fails, verify your credentials or contact the administrator.
        </p>

        <h3>2. Add Reservation</h3>
        <ul>
            <li>Navigate to <strong>Add Reservation</strong> from the dashboard.</li>
            <li>Enter guest details including name, address, and contact number.</li>
            <li>Select the appropriate room type (Standard, Deluxe, or Suite).</li>
            <li>Choose valid Check-In and Check-Out dates.</li>
            <li>Ensure Check-Out date is later than Check-In date.</li>
            <li>Click <strong>Save</strong> to confirm reservation.</li>
        </ul>

        <h3>3. View Reservations</h3>
        <ul>
            <li>Go to <strong>View Reservation</strong> to see all reservations.</li>
            <li>Use the Update button to modify reservation details.</li>
            <li>Use the Delete button to remove a reservation permanently.</li>
        </ul>

        <h3>4. Update Reservation</h3>
        <ul>
            <li>Edit guest information or dates as needed.</li>
            <li>Ensure date validation rules are followed.</li>
            <li>Click <strong>Update Reservation</strong> to save changes.</li>
        </ul>

        <h3>5. Billing</h3>
        <ul>
            <li>Navigate to the <strong>Billing</strong> section.</li>
            <li>Enter the Reservation Number.</li>
            <li>The system automatically calculates:</li>
            <ul>
                <li>Number of nights</li>
                <li>Room rate per night</li>
                <li>Total amount</li>
            </ul>
            <li>An invoice will be generated.</li>
            <li>You can print the invoice for the guest.</li>
            <li>The bill is automatically stored in the database.</li>
        </ul>

        <h3>Important Notes</h3>
        <ul>
            <li>All reservation and billing data are stored securely in the system database.</li>
            <li>Deleted reservations cannot be recovered.</li>
            <li>Ensure accurate guest information to avoid billing errors.</li>
        </ul>

    </div>
</div>

	</body>

	</html>