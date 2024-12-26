<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
String transactionId = request.getParameter("transaction_id");

try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    try (Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "yash", "455664")) {
        PreparedStatement pst = con.prepareStatement("DELETE FROM appointments WHERE transaction_id=?");
        pst.setString(1, transactionId);
        int rowsDeleted = pst.executeUpdate();
        pst.close(); // Close the PreparedStatement
        if (rowsDeleted > 0) {
            out.println("<script>alert('Appointment canceled successfully');</script>");
        } else {
            out.println("<script>alert('No appointments canceled');</script>");
        }
        out.println("<script> window.location='all-appointments.jsp';</script>");
    }
} catch (Exception e) {
    out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
    e.printStackTrace();
}
%>
