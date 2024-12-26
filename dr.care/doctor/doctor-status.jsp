<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dr.Care - Doctor Status</title>
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
      
    </style>
</head>
<body>
    <header>
        <h1>Dr.Care - Doctor Status</h1>
    </header>
    <nav style="display: flex; justify-content: space-between; align-items: center; padding: 10px; background-color: #f8f9fa;">
        <a href="doctor-status.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px; background-color: #1af701fb;">Status</a>
        <a href="appointments-booked.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Appointments Received</a>
        <div class="profile" style="display: flex; align-items: center;">
            <img src="https://th.bing.com/th/id/OIP.KitsWvuPkcEUMv3Vd1yQ9QHaHa?rs=1&pid=ImgDetMain" alt="Profile Image" style="width: 50px; height: 50px; border-radius: 50%;">
            <a href="doctor-profile.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Profile</a>
        </div>
        <a href="doctor-logout.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Logout</a>
    </nav>
    
  <div class="container">
    <h2>Doctor Status</h2>
    <% 
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "yash", "455664");

        // Assuming you have the doctor's ID stored in a session attribute
        String doctorId = (String) session.getAttribute("doctorId");

        // Retrieve the doctor's status and dates of leave from the database
        ps = con.prepareStatement("SELECT availability_status, date_of_leave1, date_of_leave2, date_of_leave3 FROM doctors WHERE doctor_id = ?");
        ps.setString(1, doctorId);
        rs = ps.executeQuery();

        if (rs.next()) {
            String availabilityStatus = rs.getString("availability_status");
            String dateOfLeave1 = rs.getString("date_of_leave1");
            String dateOfLeave2 = rs.getString("date_of_leave2");
            String dateOfLeaves = rs.getString("date_of_leave3");

            out.println("<p>Your current availability status: " + availabilityStatus + "</p>");
            out.println("<p>Date of Leave 1: " + dateOfLeave1 + "</p>");
            out.println("<p>Date of Leave 2: " + dateOfLeave2 + "</p>");
            out.println("<p>Date of Leave 3: " + dateOfLeaves + "</p>");
     
        }else {
            out.println("<p>Doctor data not found.</p>");
        }
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            out.println("<p>Error closing resources: " + e.getMessage() + "</p>");
        }
    }
    %>
    <form action="update-doctor-status.jsp" method="post">
      
        <label for="dateOfLeaves">Change dates:</label>
        <label for="dateOfLeave1">Date of Leave 1:</label>
        <input type="date" id="dateOfLeave1" name="dateOfLeave1" value="<%= session.getAttribute("dateOfLeave1") %>"><br><br>
        
        <label for="dateOfLeave2">Date of Leave 2:</label>
        <input type="date" id="dateOfLeave2" name="dateOfLeave2" value="<%= session.getAttribute("dateOfLeave2") %>"><br><br>
        
        <label for="dateOfLeave3">Date of Leave 3:</label>
        <input type="date" id="dateOfLeave3" name="dateOfLeave3" value="<%= session.getAttribute("dateOfLeave3") %>"><br><br>
        
        <input type="submit" value="Update Status">
    </form>
</div>

</body>
</html>
