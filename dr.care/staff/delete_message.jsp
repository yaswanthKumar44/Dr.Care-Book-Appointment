<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "yash", "455664");

    String username = request.getParameter("username");

    PreparedStatement ps = con.prepareStatement("DELETE FROM messages WHERE username = ?");
    ps.setString(1, username);
    int rowsAffected = ps.executeUpdate();

    if (rowsAffected > 0) {
%>
        <script>
            alert("Message deleted successfully");
            window.location.href = "contacts-received.jsp";
        </script>
<%
    } else {
%>
        <script>
            alert("Failed to delete message");
            window.location.href = "contacts-received.jsp";
        </script>
<%
    }
    con.close();
} catch (Exception e) {
    out.println("<p>Error: " + e.getMessage() + "</p>");
}
%>
