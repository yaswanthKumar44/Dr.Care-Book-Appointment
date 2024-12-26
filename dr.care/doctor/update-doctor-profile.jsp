<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dr.Care - Update Profile</title>
    <script>
        function showAlert(message) {
            alert(message);
            window.location.replace("doctor-profile.jsp"); // Redirect to profile page
        }
    </script>
</head>
<body>
    <%
    Connection con = null;
    PreparedStatement ps = null;
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "yash", "455664");

        String doctorId = session.getAttribute("doctorId").toString();
        String doctorName = request.getParameter("doctorName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String address = request.getParameter("address");
        int age = Integer.parseInt(request.getParameter("age"));
        String gender = request.getParameter("gender");
        String mobile = request.getParameter("mobile");
        String experience = request.getParameter("experience");
        String specialist = request.getParameter("specialist");
        String availabilityStatus = request.getParameter("availabilityStatus");
        String dateOfLeave1 = request.getParameter("dateOfLeave1");
        String dateOfLeave2 = request.getParameter("dateOfLeave2");
        String dateOfLeave3 = request.getParameter("dateOfLeave3");
        
        String query = "UPDATE doctors SET doctor_name=?, email=?, password=?, address=?, age=?, gender=?, mobile=?, experience=?, specialist=?, availability_status=?, date_of_leave1=?, date_of_leave2=?, date_of_leave3=? WHERE doctor_id=?";
        ps = con.prepareStatement(query);
        ps.setString(1, doctorName);
        ps.setString(2, email);
        ps.setString(3, password);
        ps.setString(4, address);
        ps.setInt(5, age);
        ps.setString(6, gender);
        ps.setString(7, mobile);
        ps.setString(8, experience);
        ps.setString(9, specialist);
        ps.setString(10, availabilityStatus);
        ps.setString(11, dateOfLeave1);
        ps.setString(12, dateOfLeave2);
        ps.setString(13, dateOfLeave3);
        ps.setString(14, doctorId);
        
        ps.executeUpdate();
        

        int updatedRows = ps.executeUpdate();
        if (updatedRows > 0) {
            out.println("<script>showAlert('Profile updated successfully.');</script>");
        } else {
            out.println("<script>showAlert('Failed to update profile. Please try again.');</script>");
        }
    } catch (Exception e) {
        out.println("<script>showAlert('Error: " + e.getMessage() + "');</script>");
    } finally {
        try {
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        } catch (SQLException e) {
            out.println("<script>showAlert('Error closing resources: " + e.getMessage() + "');</script>");
        }
    }
    %>
</body>
</html>
