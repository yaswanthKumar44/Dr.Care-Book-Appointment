<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Appointments Booked</title>
    <style>
        /* Your CSS styles here */
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background-image: url('https://wallpapercave.com/wp/wp2968502.jpg');
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-size: cover;
        }
        header {
            background-color: #007bff;
            color: #fff;
            text-align: center;
            padding: 10px 0;
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
        .container {
            max-width: 800px;
            margin: 20px auto;
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
        form {
            margin-top: 20px;
            text-align: center;
        }
        label {
            display: block;
            margin-bottom: 10px;
        }
        select {
            padding: 5px;
            font-size: 16px;
        }
        input[type="submit"] {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
        p {
            text-align: center;
            font-weight: bold;
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

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: center;
        }

        th, td {
            padding: 8px;
            border: 1px solid #ddd;
        }

        th {
            background-color: #f2f2f2;
        }

        .current-day {
            background-color: lightgreen; /* or any other desired style */
        }
    </style>
</head>
<body>
<header>
    <h1>Dr.Care - Doctor Appointments</h1>
</header>
<nav style="display: flex; justify-content: space-between; align-items: center; padding: 10px; background-color: #f8f9fa;">
    <a href="doctor-status.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Status</a>
    <a href="appointments-booked.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px; background-color: #1af701fb;">Appointments Received</a>
    <div class="profile" style="display: flex; align-items: center;">
        <img src="https://th.bing.com/th/id/OIP.KitsWvuPkcEUMv3Vd1yQ9QHaHa?rs=1&pid=ImgDetMain" alt="Profile Image" style="width: 50px; height: 50px; border-radius: 50%;">
        <a href="doctor-profile.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Profile</a>
    </div>
    <a href="doctor-logout.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Logout</a>
</nav>


<form method="GET" action="appointments-booked.jsp">
   
    <input type="date" id="date" name="date">
    <input type="submit" value="Search">
</form>


<%
String loggedInDoctorId = (String) session.getAttribute("doctorId");
String searchQuery = null;
String currentDateString = "";
if (loggedInDoctorId == null) {
    out.println("No doctor logged in.");
} else {
    Connection conn = null;
    PreparedStatement pstmt = null;
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "yash", "455664");

        String query = "SELECT username, name, age, issue, mobile, day, transaction_id, status FROM appointments WHERE doctor_id = ? ";
        String dateFilter = "AND day = ?";
        String searchFilter = "AND (username LIKE ? OR name LIKE ? OR issue LIKE ? OR mobile LIKE ? OR day LIKE ? OR transaction_id LIKE ? OR status LIKE ?) ";

        if (request.getParameter("search") != null && !request.getParameter("search").isEmpty()) {
            searchQuery = "%" + request.getParameter("search") + "%";
            query += searchFilter + dateFilter;
            pstmt = conn.prepareStatement(query + " ORDER BY day");
            pstmt.setString(1, loggedInDoctorId);
            for (int i = 2; i <= 8; i++) {
                pstmt.setString(i, searchQuery);
            }
            pstmt.setString(9, request.getParameter("date"));
        } else if (request.getParameter("date") != null && !request.getParameter("date").isEmpty()) {
            query += dateFilter;
            pstmt = conn.prepareStatement(query + " ORDER BY day");
            pstmt.setString(1, loggedInDoctorId);
            pstmt.setString(2, request.getParameter("date"));
        } else {
            pstmt = conn.prepareStatement(query + " ORDER BY day");
            pstmt.setString(1, loggedInDoctorId);
        }

        ResultSet rs = pstmt.executeQuery();

        java.util.Date currentDate = new java.util.Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        currentDateString = sdf.format(currentDate);

        %>
        <!-- Rest of your code -->

    <center><h1>Appointments Booked for <%= session.getAttribute("doctorName") %> (ID: <%= session.getAttribute("doctorId") %>)</h1></center>

    <table border="1">
        <tr>
            <th>Patient Username</th>
            <th>Patient Name</th>
            <th>Age</th>
            <th>Issue</th>
            <th>Mobile</th>
            <th>Day</th>
            <th>Transaction ID</th>
            <th>Status</th>
        </tr>
        <%
                while (rs.next()) {
                    String appointmentDate = rs.getString("day");
                    boolean isCurrentDay = appointmentDate.equals(currentDateString);
                    String rowClass = isCurrentDay ? "current-day" : "";
        %>
        <tr class="<%= rowClass %>">
            <td><%= rs.getString("username") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("age") %></td>
            <td><%= rs.getString("issue") %></td>
            <td><%= rs.getString("mobile") %></td>
            <td><%= appointmentDate %></td>
            <td><%= rs.getString("transaction_id") %></td>
            <td><%= rs.getString("status") %></td>
        </tr>
        <%
                }
                rs.close();
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            } finally {
                try {
                    if (pstmt != null) {
                        pstmt.close();
                    }
                    if (conn != null) {
                        conn.close();
                    }
                } catch (SQLException ex) {
                    out.println("Error closing resources: " + ex.getMessage());
                }
            }
        }
    %>
    </table>
</body>
</html>
