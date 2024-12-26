<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "yash", "455664");
    String username = request.getParameter("username");
    String sql = "DELETE FROM admins WHERE username = ?";
    PreparedStatement pstmt = con.prepareStatement(sql);
    pstmt.setString(1, username);
    int rowsDeleted = pstmt.executeUpdate();
    con.close();
    if (rowsDeleted > 0) {
        out.println("<script>alert('Staff member deleted successfully');window.location.href='staff.jsp';</script>");
    } else {
        out.println("<script>alert('No staff member found with the specified username');window.location.href='staff.jsp';</script>");
    }
} catch (Exception e) {
    out.println("<p>Error: " + e.getMessage() + "</p>");
}
%>
