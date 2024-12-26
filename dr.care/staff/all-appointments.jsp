<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.UUID" %>
<%@ page import="java.text.SimpleDateFormat" %>


<%
String searchQuery = request.getParameter("search");
String dateQuery = request.getParameter("date");

try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    String sql = "SELECT * FROM appointments";
    if ((searchQuery != null && !searchQuery.isEmpty()) || (dateQuery != null && !dateQuery.isEmpty())) {
        sql += " WHERE ";
        boolean needAnd = false;
        if (searchQuery != null && !searchQuery.isEmpty()) {
            sql += "(username LIKE ? OR name LIKE ? OR age LIKE ? OR issue LIKE ? OR mobile LIKE ? OR specialist LIKE ? OR doctor LIKE ? OR day LIKE ? OR transaction_id LIKE ? OR doctor_id LIKE ? OR status LIKE ?)";
            needAnd = true;
        }
        if (dateQuery != null && !dateQuery.isEmpty()) {
            if (needAnd) {
                sql += " AND ";
            }
            sql += "day = ?";
        }
    }
    sql += " ORDER BY day ASC";

    try (Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "yash", "455664");
         PreparedStatement stmt = con.prepareStatement(sql)) {
        int parameterIndex = 1;
        if (searchQuery != null && !searchQuery.isEmpty()) {
            for (int i = 1; i <= 11; i++) {
                stmt.setString(parameterIndex++, "%" + searchQuery + "%");
            }
        }
        if (dateQuery != null && !dateQuery.isEmpty()) {
            stmt.setString(parameterIndex++, dateQuery);
        }

        try (ResultSet rs = stmt.executeQuery()) {
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dr.Care - All Appointments</title>
    <style>
        /* Your existing CSS styles here */
        body {
            background-image: url('https://wallpapercave.com/wp/wp2386912.jpg');
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-size: 100% 100%;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }

        header {
            background-color: #007bff;
            color: rgb(209, 9, 9);
            padding: 10px 0;
            text-align: center;
        }

        nav {
            background-color: #35ff02;
            padding: 10px 0;
            text-align: center;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        nav a {
            margin: 0 10px;
            text-decoration: none;
            color: #007bff;
        }

        nav a:hover {
            text-decoration: underline;
        }

        .profile {
            display: flex;
            align-items: center;
        }

        .profile img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
        }

        .container {
            max-width: o auto;
            margin: 0 auto;
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.8);
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
        }

        h2 {
            color: #333;
            margin-top: 0;
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f8f9fa;
        }

        .edit-button {
            background-color: #007bff;
            color: white;
            padding: 5px 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
        }

        .edit-button:hover {
            background-color: #0056b3;
        }

        .delete-button {
            background-color: red;
            color: white;
            padding: 5px 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
        }

        .delete-button:hover {
            background-color: #b30000;
        }
    </style>
</head>
<body>
<header>
    <h1>Dr.Care - All Appointments</h1>
</header>
<nav style="display: flex; justify-content: space-between; align-items: center; padding: 10px; background-color: #f8f9fa;">
    <a href="admin-home.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px; ">Home</a>
    <a href="doctors.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Doctors</a>
    <a href="users.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Users</a>
    <a href="all-appointments.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;background-color: #1af701fb;">All Appointments</a>
    <a href="contacts-received.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Contacts Received</a>
   
    <div class="profile" style="display: flex; align-items: center;">
        <img src="https://th.bing.com/th/id/OIP.KitsWvuPkcEUMv3Vd1yQ9QHaHa?rs=1&pid=ImgDetMain" alt="Profile Image" style="width: 50px; height: 50px; border-radius: 50%;">
        <a href="admin-profile.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Profile</a>
    </div>
    <a href="staff-logout.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Logout</a>
</nav>
<div class="container">
    <h2>All Appointments</h2>
    <form method="GET" action="all-appointments.jsp">
        <input type="text" id="search" name="search" value="<%= searchQuery != null ? searchQuery : "" %>">
        <input type="date" id="date" name="date">
        <button type="submit">Search</button>
    </form>
    <table>
        <thead>
            <tr>
                <th>Username</th>
                <th>Name</th>
                <th>Age</th>
                <th>Issue</th>
                <th>Mobile</th>
                <th>Specialist In</th>
                <th>Doctor Name</th>
                <th>Doctor ID</th>
                <th>Date of Appointment</th>
                <th>Transaction ID</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <% 
            java.util.Date currentDate = new java.util.Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String currentDateString = sdf.format(currentDate);
            
            while (rs.next()) { 
                String appointmentDate = rs.getString("day");
            %>
            <tr <% if (currentDateString.equals(appointmentDate)) { %>style="background-color: #c8e6c9;"<% } %>>
                <td><%= rs.getString("username") %></td>
                <td><%= rs.getString("name") %></td>
                <td><%= rs.getInt("age") %></td>
                <td><%= rs.getString("issue") %></td>
                <td><%= rs.getString("mobile") %></td>
                <td><%= rs.getString("specialist") %></td>
                <td><%= rs.getString("doctor") %></td>
                <td><%= rs.getString("doctor_id") %></td>
                <td><%= appointmentDate %></td>
                <td><%= rs.getString("transaction_id") %></td>
                <td><%= rs.getString("status") %></td>
                <td>
                    <a href='edit-appointment.jsp?transaction_id=<%= rs.getString("transaction_id") %>&username=<%= rs.getString("username") %>&name=<%= rs.getString("name") %>&issue=<%= rs.getString("issue") %>&doctor=<%= rs.getString("doctor") %>&doctor_id=<%= rs.getString("doctor_id") %>&day=<%= appointmentDate %>&status=<%= rs.getString("status") %>&mobile=<%= rs.getString("mobile") %>&specialist=<%= rs.getString("specialist") %>' class="edit-button">Edit</a>
                </td>
            </tr>
            <% } %>
        </tbody>
        
    </table>
</div>
</body>
</html>
<%
        }
    }
} catch (Exception e) {
    out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
}
%>
