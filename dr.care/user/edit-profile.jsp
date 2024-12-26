<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            background-image: url('https://cdn.wallpapersafari.com/99/13/OBl3g7.jpg');
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
            background-color: rgba(255, 255, 255, 0.8); /* Semi-transparent white background */
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3); /* Shadow effect */
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
        input[type="date"],
        input[type="number"],
        input[type="tel"],
        select {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .save-button {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            display: block;
        }

        .save-button:hover {
            background-color: #0056b3;
        }

    </style>
</head>
<body>
    <header>
        <h1>Edit Profile - Dr.Care</h1>
    </header>
    <nav style="display: flex; justify-content: space-between; align-items: center; padding: 10px; background-color: #f8f9fa;">
        <a href="home.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Home</a>
        <a href="appointments.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Appointments</a>
        <a href="about.html" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">About</a>
        <a href="contact.html" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Contact</a>
        <a href="feedback.html" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Feedback</a>
        <div class="profile" style="display: flex; align-items: center;">
            <img src="https://th.bing.com/th/id/OIP.KitsWvuPkcEUMv3Vd1yQ9QHaHa?rs=1&pid=ImgDetMain" alt="Profile Image" style="width: 50px; height: 50px; border-radius: 50%;">
            <a href="profile.jsp" style="color: #ef0a0a; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px; background-color: #1af701fb;">Profile</a>
        </div>
        <a href="logout.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Logout</a>
    </nav>
    <div class="container">
        <h2>Edit Profile</h2>
        <form id="editProfileForm" action="update-profile.jsp" method="POST">
            <table>
                <tr>
                    <th><label for="name">Name</label></th>
                    <td><input type="text" id="name" name="name" value="${sessionScope.fullname}" required></td>
                </tr>
                <tr>
                    <th><label for="email">Email</label></th>
                    <td><input type="email" id="email" name="email" value="${sessionScope.email}" required></td>
                </tr>
                <tr>
                    <th><label for="address">Address</label></th>
                    <td><input type="text" id="address" name="address" value="${sessionScope.address}" required></td>
                </tr>
                <tr>
                    <th><label for="age">Age</label></th>
                    <td><input type="number" id="age" name="age" value="${sessionScope.age}" min="1" max="150" required></td>
                </tr>
                <tr>
                    <th><label for="gender">Gender</label></th>
                    <td>
                        <select id="gender" name="gender" required>
                            <option value="Male" ${sessionScope.gender == 'Male' ? 'selected' : ''}>Male</option>
                            <option value="Female" ${sessionScope.gender == 'Female' ? 'selected' : ''}>Female</option>
                            <option value="Other" ${sessionScope.gender == 'Other' ? 'selected' : ''}>Other</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th><label for="mobile">Mobile Number</label></th>
                    <td><input type="tel" id="mobile" name="mobile" value="${sessionScope.mobile}" pattern="[0-9]{10}" title="Mobile number must be 10 digits" required></td>
                </tr>
                <!-- Remove the password field from the form -->
            </table>
            <button type="submit" class="save-button">Save</button>
        </form>
        <%
        try {
            if (session.getAttribute("username") != null) {
        %>
                <!-- Your existing code for form fields -->
        <%
            } else {
        %>
                <p>Username not found</p>
        <%
            }
        } catch (Exception e) {
            out.println("<h1>Error: " + e.getMessage() + "</h1>");
            e.printStackTrace();
        }
        %>
    </div>
</body>
</html>
