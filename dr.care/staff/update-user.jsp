<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
// Get form data from request
String username = request.getParameter("username");
String fullname = request.getParameter("fullname");
String email = request.getParameter("email");
String password = request.getParameter("password");
String address = request.getParameter("address");
int age = Integer.parseInt(request.getParameter("age"));
String gender = request.getParameter("gender");
String mobile = request.getParameter("mobile");

try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "yash", "455664");
    Statement stmt = con.createStatement();
    String query = "UPDATE users SET fullname=?, email=?, password=?, address=?, age=?, gender=?, mobile=? WHERE username=?";
    PreparedStatement pstmt = con.prepareStatement(query);
    pstmt.setString(1, fullname);
    pstmt.setString(2, email);
    pstmt.setString(3, password);
    pstmt.setString(4, address);
    pstmt.setInt(5, age);
    pstmt.setString(6, gender);
    pstmt.setString(7, mobile);
    pstmt.setString(8, username);

    int rowsAffected = pstmt.executeUpdate();

    if (rowsAffected > 0) {
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Updated</title>
</head>
<body>
    <script>
        alert("User Profile Updated Successfully");
        window.location.href = "users.jsp";
    </script>
    
</body>
</html>
<%
    } else {
        out.println("<p>Failed to update user. Please try again.</p>");
    }

    con.close();
} catch (Exception e) {
    out.println("<p>Error: " + e.getMessage() + "</p>");
}
%>
