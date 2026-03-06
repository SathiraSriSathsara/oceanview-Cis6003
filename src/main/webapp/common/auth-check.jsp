<%
    // Check if user is logged in
    if (session.getAttribute("username") == null) {
        response.sendRedirect(request.getContextPath() + "/views/login.jsp?error=session");
        return;
    }
%>
