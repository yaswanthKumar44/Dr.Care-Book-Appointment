<%@ page import="java.util.*,java.sql.*"%>
<%
String name = request.getParameter("fullname");
String mail = request.getParameter("email");
String usern = request.getParameter("username");
String pass = request.getParameter("password");
String add = request.getParameter("address");
int ag = Integer.parseInt(request.getParameter("age"));
String gen = request.getParameter("gender");
String mobi = request.getParameter("mobile");

try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","yash","455664");
    String query = "insert into users values(?, ?, ?, ?, ?, ?, ?, ?)";
    PreparedStatement pst = con.prepareStatement(query);
    pst.setString(1, name);
    pst.setString(2, mail);
    pst.setString(3, usern);
    pst.setString(4, pass);
    pst.setString(5, add);
    pst.setInt(6, ag); // Use setInt for integer values
    pst.setString(7, gen);
    pst.setString(8, mobi);

    int rowsAffected = pst.executeUpdate();
    
    if(rowsAffected > 0) {
        // Registration successful
        out.println("<script>alert('Registration successful. Redirecting to login page.'); window.location.href='login.html';</script>");
    } else {
        // No rows affected, registration failed
        out.println("<script>alert('Registration failed. Please try again.'); window.location.href='register.html';</script>");
    }
    
    con.commit();
    con.close();
} catch(SQLException e) {
    // Exception occurred
    if(e.getErrorCode() == 1) {
        out.println("<script>alert('Username already exists. Please choose a different username.'); </script>");
    } else {
        out.println("<script>alert('Error: "+ e.getMessage() +"');</script>");
    }
}
%>
