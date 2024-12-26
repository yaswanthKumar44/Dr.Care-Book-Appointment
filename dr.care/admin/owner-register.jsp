<%@ page import="java.util.*,java.sql.*"%>
<%
String name = request.getParameter("fullname");
String mail = request.getParameter("email");
String ownerId = request.getParameter("ownerId"); // Corrected variable name
String pass = request.getParameter("password");
String add = request.getParameter("address");
int ag = Integer.parseInt(request.getParameter("age"));
String gen = request.getParameter("gender");
String mobi = request.getParameter("mobile");
try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    try (Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","yash","455664")) {
        String query = "insert into owners values(?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement pst = con.prepareStatement(query)) {
            pst.setString(1, name);
            pst.setString(2, mail);
            pst.setString(3, ownerId);
            pst.setString(4, pass);
            pst.setString(5, add);
            pst.setInt(6, ag); // Use setInt for integer values
            pst.setString(7, gen);
            pst.setString(8, mobi);
            pst.executeUpdate();
        }
        out.println("<script>alert('Admin Registered  successfully and Redirect to Admins page'); window.location='owners.jsp';</script>");
        con.commit();
    }
} catch (SQLException e) {
    if (e.getSQLState().equals("23000")) {
        out.println("<script>alert('Admin ID already exists. Please choose a different Admin ID.');</script>");
    } else {
        out.println("<h1>Error: " + e.getMessage() + "</h1>");
        e.printStackTrace(); // Log the exception details
    }
} catch (ClassNotFoundException e) {
    out.println("<h1>Error: "+e.getMessage()+"</h1>");
    e.printStackTrace(); // Log the exception details
}
%>

