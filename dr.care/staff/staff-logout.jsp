<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
try {
    // Get the session
    HttpSession userSession = request.getSession(false);
    if (userSession != null) {
        // Invalidate the session
        userSession.invalidate();
    }

    // Display an alert message
    out.println("<script>alert('Logout successful. Thank you for visiting!'); window.location='admin-login.html';</script>");
} catch (Exception e) {
    // Display an error message
    out.println("<h1>Error occurred during logout. Please try again later.</h1>");
    e.printStackTrace(); // Log the exception details
}
%>
