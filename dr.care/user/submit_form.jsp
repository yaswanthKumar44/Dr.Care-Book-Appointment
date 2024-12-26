<%@ page import="java.sql.*" %>
<%
String name = request.getParameter("name");
String email = request.getParameter("email");
String message = request.getParameter("message");

try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "yash", "455664");
    String query = "INSERT INTO contact_form (name, email, message, submission_time) VALUES (?, ?, ?, SYSDATE)";
    PreparedStatement pst = con.prepareStatement(query);
    pst.setString(1, name);
    pst.setString(2, email);
    pst.setString(3, message);
    int rowsInserted = pst.executeUpdate();

    if (rowsInserted > 0) {
        response.sendRedirect("home.html");
        out.println("<h1>Message Sent Successfully!</h1>");
    } else {
        out.println("<h1>Failed to Send Message.</h1>");
    }

    pst.close();
    con.close();
} catch (ClassNotFoundException e) {
    out.println("<h1>Error: Oracle JDBC Driver not found</h1>");
} catch (SQLException e) {
    out.println("<h1>Error: " + e.getMessage() + "</h1>");
}
%>

<%---
SQL> CREATE TABLE contact_form (id number(20),name VARCHAR(255) NOT NULL,email VARCHAR(255) NOT NULL,message varchar2(1000) NOT NULL,submission_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

Table created.
---%>