<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Profile - Dr.Care</title>
</head>
<body>
    <%
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        int age = Integer.parseInt(request.getParameter("age"));
        String gender = request.getParameter("gender");
        String mobile = request.getParameter("mobile");
        String staffType = request.getParameter("staff_type");
        String username = (String) session.getAttribute("username");
        String password = request.getParameter("password");

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "yash", "455664");
            String query;
            if (password != null && !password.isEmpty()) {
                query = "UPDATE admins SET fullname=?, email=?, address=?, age=?, gender=?, mobile=?, staff_type=?, password=? WHERE username=?";
            } else {
                query = "UPDATE admins SET fullname=?, email=?, address=?, age=?, gender=?, mobile=?, staff_type=? WHERE username=?";
            }
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, fullname);
            pst.setString(2, email);
            pst.setString(3, address);
            pst.setInt(4, age);
            pst.setString(5, gender);
            pst.setString(6, mobile);
            pst.setString(7, staffType);
            if (password != null && !password.isEmpty()) {
                pst.setString(8, password);
                pst.setString(9, username);
            } else {
                pst.setString(8, username);
            }
            int rowsUpdated = pst.executeUpdate();
            if (rowsUpdated > 0) {
    %>
                <h1>Profile updated successfully</h1>
                <script>
                    setTimeout(() => {
                        window.location.href = "admin-profile.jsp";
                    }, 1500); // Redirect after 2 seconds
                </script>
    <%
            } else {
    %>
                <h1>Failed to update profile</h1>
    <%
            }
            con.commit();
            con.close();
        } catch(SQLException | ClassNotFoundException e) {
            out.println("<h1>Error: "+e.getMessage()+"</h1>");
        }
    %>
</body>
</html>
