<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.io.IOException" %>

<%
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "yash", "455664");

        String doctorId = request.getParameter("doctorId");
        String query = "DELETE FROM doctors WHERE DOCTOR_ID=?";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setString(1, doctorId);
        pstmt.executeUpdate();
        response.sendRedirect("doctors.jsp"); // Redirect to doctors.jsp after deletion
        pstmt.close();
        conn.close();
    } catch (Exception e) {
        out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
    }
%>
