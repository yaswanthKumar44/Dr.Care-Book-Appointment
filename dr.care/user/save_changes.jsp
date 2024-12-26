<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<%
String transactionId = request.getParameter("transaction_id");
String name = request.getParameter("name");
String issue = request.getParameter("issue");
String day = request.getParameter("day");
String mobile = request.getParameter("mobile");

try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    try (Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "yash", "455664")) {
        String updateQuery = "UPDATE appointments SET name=?, issue=?, day=?, mobile=? WHERE transaction_id=?";
        try (PreparedStatement pst = con.prepareStatement(updateQuery)) {
            pst.setString(1, name);
            pst.setString(2, issue);
            pst.setString(3, day);
            pst.setString(4, mobile);
            pst.setString(5, transactionId);

            int rowsUpdated = pst.executeUpdate();
            if (rowsUpdated > 0) {
                out.println("<script>alert('Update successful');</script>");
                con.commit(); // Commit changes
            } else {
                out.println("<script>alert('No rows updated');</script>");
            }
        }
        response.sendRedirect("appointments.jsp");
    }
} catch (Exception e) {
    out.println("<script>alert('" + e.getMessage() + "');</script>");
    e.printStackTrace();
}
%>
