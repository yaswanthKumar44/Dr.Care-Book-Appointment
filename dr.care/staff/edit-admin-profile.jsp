<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile - Dr.Care</title>
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
            max-width: 800px;
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

        form {
            margin-top: 20px;
        }

        label {
            display: block;
            margin-bottom: 5px;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        input[type="number"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            box-sizing: border-box;
        }

        select {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

    #staff_type {
        display: none;
    }



    </style>
</head>

<body>
<header>
    <h1>Edit Profile</h1>
</header>
<nav style="display: flex; justify-content: space-between; align-items: center; padding: 10px; background-color: #f8f9fa;">
    <a href="admin-home.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px; ">Home</a>
    <a href="doctors.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Doctors</a>
    <a href="users.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Users</a>
    <a href="all-appointments.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">All Appointments</a>
    <a href="contacts-received.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Contacts Received</a>
   
    <div class="profile" style="display: flex; align-items: center;">
        <img src="https://th.bing.com/th/id/OIP.KitsWvuPkcEUMv3Vd1yQ9QHaHa?rs=1&pid=ImgDetMain" alt="Profile Image" style="width: 50px; height: 50px; border-radius: 50%;">
        <a href="admin-profile.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px; background-color: #1af701fb;">Profile</a>
    </div>
    <a href="staff-logout.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Logout</a>
</nav>
<div class="container">
    <h2>Edit Profile</h2>
    <form action="update-admin-profile.jsp" method="post">
        <label for="fullname">Full Name</label>
        <input type="text" id="fullname" name="fullname" value="<%= session.getAttribute("fullname") %>">

        <label for="email">Email</label>
        <input type="email" id="email" name="email" value="<%= session.getAttribute("email") %>">

        <label for="address">Address</label>
        <input type="text" id="address" name="address" value="<%= session.getAttribute("address") %>">

        <label for="age">Age</label>
        <input type="number" id="age" name="age" value="<%= session.getAttribute("age") %>" min="18" max="100">

        <label for="gender">Gender</label>
        <select id="gender" name="gender" required>
            <option value="Male" <%= session.getAttribute("gender") != null && session.getAttribute("gender").equals("Male") ? "selected" : "" %>>Male</option>
            <option value="Female" <%= session.getAttribute("gender") != null && session.getAttribute("gender").equals("Female") ? "selected" : "" %>>Female</option>
            <option value="Other" <%= session.getAttribute("gender") != null && session.getAttribute("gender").equals("Other") ? "selected" : "" %>>Other</option>
            
        </select>

        <label for="mobile">Mobile Number</label>
        <input type="text" id="mobile" name="mobile" value="<%= session.getAttribute("mobile") %>">
        
       
        <select id="staff_type" name="staff_type" required>
            <option value="Jr. Doctor" <%= session.getAttribute("staff_type") != null && session.getAttribute("staff_type").equals("Jr. Doctor") ? "selected" : "" %>>Jr. Doctor</option>
            <option value="Appointment Department" <%= session.getAttribute("staff_type") != null && session.getAttribute("staff_type").equals("Appointment Department") ? "selected" : "" %>>Appointment Department</option>
            <option value="Help Center" <%= session.getAttribute("staff_type") != null && session.getAttribute("staff_type").equals("Help Center") ? "selected" : "" %>>Help Center</option>
        </select>
        

        <label for="password">Password</label>
       
    <input type="password" id="password" name="password" value="<%= session.getAttribute("password") %>" minlength="8" maxlength="14" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)(?!.*\s).*$" title="Password must contain at least one uppercase letter, one lowercase letter, one number, one special character, and be between 8 and 14 characters long" placeholder="Enter new password (optional)">

        

        <input type="submit" value="Save Changes">
    </form>
</div>
</body>
</html>
