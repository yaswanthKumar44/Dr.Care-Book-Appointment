<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<%
String username = (String) session.getAttribute("username");
String transactionId = request.getParameter("transaction_id");

try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    try (Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "yash", "455664")) {
        PreparedStatement pst = con.prepareStatement("DELETE FROM appointments WHERE username=? AND transaction_id=?");
        pst.setString(1, username);
        pst.setString(2, transactionId);
        int rowsDeleted = pst.executeUpdate();
        if (rowsDeleted > 0) {
            out.println("<script>alert('Appointment canceled successfully');</script>");
        } else {
            out.println("<script>alert('No appointments canceled');</script>");
        }
        out.println("<script>alert('Appointment canceled successfully');</script>");
        response.sendRedirect("appointments.jsp");
    }
} catch (Exception e) {
    out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
    e.printStackTrace();
}
%>
