<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dr.Care - Edit Profile</title>
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
    
    <div class="container">
        <h2>Edit Profile</h2>
        <%-- Check if doctorid is not null --%>
        <%
        String doctorId = (String) session.getAttribute("doctorId");
        if (doctorId != null) {
        %>
            <form action="update-doctor-profile.jsp" method="post">
                <label for="doctorName">Name:</label>
                <input type="text" id="doctorName" name="doctorName" value="<%= session.getAttribute("doctorName") %>"><br><br>
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="<%= session.getAttribute("email") %>"><br><br>
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" value="<%= session.getAttribute("password") %>" required pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=]).{8,14}" title="Must contain at least one number, one uppercase letter, one lowercase letter, one special character, and be between 8 and 14 characters long"><br><br>
                <label for="address">Address:</label>
                <input type="text" id="address" name="address" value="<%= session.getAttribute("address") %>"><br><br>
                <label for="age">Age:</label>
                <input type="number" id="age" name="age" value="<%= session.getAttribute("age") %>" min="18" max="100" required><br><br>
                <label for="gender">Gender:</label>
                <select id="gender" name="gender" required>
                    <option value="Male" <%= session.getAttribute("gender").equals("Male") ? "selected" : "" %>>Male</option>
                    <option value="Female" <%= session.getAttribute("gender").equals("Female") ? "selected" : "" %>>Female</option>
                    <option value="Other" <%= session.getAttribute("gender").equals("Other") ? "selected" : "" %>>Other</option>
                </select><br><br>
                <label for="mobile">Mobile Number:</label>
                <input type="text" id="mobile" name="mobile" value="<%= session.getAttribute("mobile") %>" pattern="[0-9]{10}" title="Please enter a 10-digit mobile number" required><br><br>
                <label for="experience">Experience:</label>
                <input type="text" id="experience" name="experience" value="<%= session.getAttribute("experience") %>"><br><br>
                <label for="specialist">Specialist In:</label>
                <select id="specialist" name="specialist">
                    <option value="Heart(Cardiology)" <%= session.getAttribute("specialist").equals("Heart(Cardiology)") ? "selected" : "" %>>Heart(Cardiology)</option>
                    <option value="Lungs(Pulmonology)" <%= session.getAttribute("specialist").equals("Lungs(Pulmonology)") ? "selected" : "" %>>Lungs(Pulmonology)</option>
                    <option value="Kidney(Nephrology)" <%= session.getAttribute("specialist").equals("Kidney(Nephrology)") ? "selected" : "" %>>Kidney(Nephrology)</option>
                    <option value="Brain(Neurology)" <%= session.getAttribute("specialist").equals("Brain(Neurology)") ? "selected" : "" %>>Brain(Neurology)</option>
                </select><br><br>
                <label for="availabilityStatus">Availability Status:</label>
                <input type="text" id="availabilityStatus" name="availabilityStatus" value="<%= session.getAttribute("availabilityStatus") %>" readonly><br><br>
                <label for="dateOfLeave1">Date of Leave 1:</label>
                <input type="date" id="dateOfLeave1" name="dateOfLeave1" value="<%= session.getAttribute("dateOfLeave1") %>"><br><br>
                <label for="dateOfLeave2">Date of Leave 2:</label>
                <input type="date" id="dateOfLeave2" name="dateOfLeave2" value="<%= session.getAttribute("dateOfLeave2") %>"><br><br>
                <label for="dateOfLeave3">Date of Leave 3:</label>
                <input type="date" id="dateOfLeave3" name="dateOfLeave3" value="<%= session.getAttribute("dateOfLeave3") %>"><br><br>
                <input type="submit" value="Update Profile">
            </form>
        <% 
        } else {
        %>
            <p>Please login to perform this action.</p>
            <p><a href="doctor-login.html">Login</a></p>
        <% 
        }
        %>
    </div>
</body>
</html>
