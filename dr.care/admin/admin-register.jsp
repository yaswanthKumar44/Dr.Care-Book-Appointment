<%@ page import="java.util.*,java.sql.*"%>
<%
String name = request.getParameter("fullname");
String mail = request.getParameter("email");
String usern = request.getParameter("username");
String pass = request.getParameter("password");
String add = request.getParameter("address");
int ag = Integer.parseInt(request.getParameter("age"));
String gen = request.getParameter("gender");
String staffType = request.getParameter("staff");
String mobi = request.getParameter("mobile");
try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","yash","455664");
    String query = "insert into admins values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
    PreparedStatement pst = con.prepareStatement(query);
    pst.setString(1, name);
    pst.setString(2, mail);
    pst.setString(3, usern);
    pst.setString(4, pass);
    pst.setString(5, add);
    pst.setInt(6, ag); // Use setInt for integer values
    pst.setString(7, gen);
    pst.setString(8, staffType);
    pst.setString(9, mobi);
    pst.executeUpdate();
    
    con.commit();
    con.close();
    
    // Display success alert and redirect
    out.println("<script>alert('Staff added successfully'); window.location.href='staff.jsp';</script>");
} catch(SQLException e) {
    if(e.getErrorCode() == 1) { // Check if the error is due to unique constraint violation
        out.println("<script>alert('Username already exists'); </script>");
    } else {
        out.println("<h1>Error: "+e.getMessage()+"</h1>");
    }
} catch(Exception e) {
    out.println("<h1>Error: "+e.getMessage()+"</h1>");
}
%>
