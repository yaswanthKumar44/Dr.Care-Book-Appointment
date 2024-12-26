<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dr.Care - Profile</title>
    <style>
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
        .profile-info {
            text-align: center;
            margin-bottom: 20px;
        }
        .profile-info img {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            margin-bottom: 10px;
        }
        .profile-details {
            margin-bottom: 20px;
        }
        .profile-details table {
            width: 100%;
            border-collapse: collapse;
        }
        .profile-details th, .profile-details td {
            border: 1px solid #ccc;
            padding: 8px;
        }
        .profile-details th {
            background-color: #f8f9fa;
        }
        .profile-details td {
            text-align: left;
        }
        .edit-button {
            display: block;
            margin: 20px auto;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
        }
        .edit-button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <!-- Header and navigation -->
    <header>
        <h1>Dr.Care - Profile</h1>
    </header>
    <nav style="display: flex; justify-content: space-between; align-items: center; padding: 10px; background-color: #f8f9fa;">
        <a href="doctor-status.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Status</a>
        <a href="appointments-booked.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Appointments Received</a>
        <div class="profile" style="display: flex; align-items: center;">
            <img src="https://th.bing.com/th/id/OIP.KitsWvuPkcEUMv3Vd1yQ9QHaHa?rs=1&pid=ImgDetMain" alt="Profile Image" style="width: 50px; height: 50px; border-radius: 50%;">
            <a href="doctor-profile.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px; background-color: #1af701fb;">Profile</a>
        </div>
        <a href="doctor-logout.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Logout</a>
    </nav>
    
    <!-- Profile information -->
    <div class="container">
        <h2>Welcome To Dr.Care</h2>
        <div class="profile-info">
            <img src="https://th.bing.com/th/id/R.fa22baf765255b5f1938756b724371d5?rik=K3GbPb47pTOUdg&riu=http%3a%2f%2fclipart-library.com%2fimg%2f1845089.png&ehk=hAbCkxCHnNwqYZvg6oLT5BEHqstBWwIPeqtDUcOTbRY%3d&risl=1&pid=ImgRaw" alt="Profile Image">
        </div>
        <div class="profile-details">
            <h3>Doctor Profile Details</h3>
            <table>
                <%
                String doctorId = (String) session.getAttribute("doctorId");
                if (doctorId != null) {
                    Connection con = null;
                    PreparedStatement pst = null;
                    ResultSet rs = null;
                    try {
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "yash", "455664");
                        String query = "SELECT * FROM doctors WHERE DOCTOR_ID=?";
                        pst = con.prepareStatement(query);
                        pst.setString(1, doctorId);
                        rs = pst.executeQuery();
                        if (rs.next()) {
                %>
                <tr>
                    <th>Name</th>
                    <td><%= rs.getString("DOCTOR_NAME") %></td>
                </tr>
                <tr>
                    <th>Email</th>
                    <td><%= rs.getString("EMAIL") %></td>
                </tr>
                <tr>
                    <th>Address</th>
                    <td><%= rs.getString("ADDRESS") %></td>
                </tr>
                <tr>
                    <th>Age</th>
                    <td><%= rs.getInt("AGE") %></td>
                </tr>
                <tr>
                    <th>Gender</th>
                    <td><%= rs.getString("GENDER") %></td>
                </tr>
                <tr>
                    <th>Mobile Number</th>
                    <td><%= rs.getString("MOBILE") %></td>
                </tr>
                <tr>
                    <th>Specialist In</th>
                    <td><%= rs.getString("SPECIALIST") %></td>
                </tr>
                <tr>
                    <th>Availability Status</th>
                    <td><%= rs.getString("AVAILABILITY_STATUS") %></td>
                </tr>
                <tr>
                    <th>Date of Leave 1</th>
                    <td><%= rs.getString("DATE_OF_LEAVE1") %></td>
                </tr>
                <tr>
                    <th>Date of Leave 2</th>
                    <td><%= rs.getString("DATE_OF_LEAVE2") %></td>
                </tr>
                <tr>
                    <th>Date of Leave 3</th>
                    <td><%= rs.getString("DATE_OF_LEAVE3") %></td>
                </tr>
                <% 
            } else {
%>
                <tr><td colspan="2">Doctor not found</td></tr>
<%
            }
        } catch (SQLException | ClassNotFoundException e) {
out.println("<h1>Error: " + e.getMessage() + "</h1>");
e.printStackTrace();
} finally {
if (rs != null) {
try {
rs.close();
} catch (SQLException e) {
e.printStackTrace();
}
}
if (pst != null) {
try {
pst.close();
} catch (SQLException e) {
e.printStackTrace();
}
}
if (con != null) {
try {
con.close();
} catch (SQLException e) {
e.printStackTrace();
}
}
}
} else {
%>
<tr><td colspan="2">No Doctor Logged In</td></tr>
<% } %>
                
            </table>
        </div>
        <a href="edit-doctor-profile.jsp?doctorId=<%= doctorId %>" class="edit-button">Edit Profile</a>
    </div>
</body>
</html>
