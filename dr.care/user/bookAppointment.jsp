<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.UUID" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dr.Care - Home</title>
    <style>
        /* Your CSS styles here */
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
            color: #fff;
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
        h1 {
            text-align: center;
            margin-bottom: 20px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
        input[type="submit"] {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <header>
        <h1>Dr.Care</h1>
    </header>
    <nav style="display: flex; justify-content: space-between; align-items: center; padding: 10px; background-color: #f8f9fa;">
        <a href="home.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px; background-color: #1af701fb;">Home</a>
        <a href="appointments.jsp"  style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px; ">Appointments</a>
        <a href="about.html" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">About</a>
        <a href="contact.html" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Contact</a>
        <a href="feedback.html" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Feedback</a>
        <div class="profile" style="display: flex; align-items: center;">
            <img src="https://th.bing.com/th/id/OIP.KitsWvuPkcEUMv3Vd1yQ9QHaHa?rs=1&pid=ImgDetMain" alt="Profile Image" style="width: 50px; height: 50px; border-radius: 50%;">
            <a href="profile.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Profile</a>
        </div>
        <a href="logout.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Logout</a>
    </nav>
    
    <div class="container">
        <h1>Book Appointment</h1>
        <form id="appointmentForm" action="bookAppointment-user.jsp" method="post">
            <table>
                <tr>
                    <th>Username:</th>
                    <td><input type="text" id="username" name="username" value="<%= session.getAttribute("username") %>" readonly></td>
                </tr>
                <tr>
                    <th>Name:</th>
                    <td><input type="text" id="name" name="name" required></td>
                </tr>
                <tr>
                    <th>Age:</th>
                    <td><input type="text" id="age" name="age" pattern="^(?:1[0-4]\d|150|[1-9]?\d)$" required></td>
                </tr>
                <tr>
                    <th>Issue:</th>
                    <td><input type="text" id="issue" name="issue" required></td>
                </tr>
                <tr>
                    <th>Mobile Number:</th>
                    <td><input type="tel" id="mobile" name="mobile" pattern="[0-9]{10}" maxlength="10" required></td>
                </tr>
                
                <tr>
                    <th>Specialist In:</th>
                    <td>
                        <input type="text" id="specialty" name="specialty" value="<%= request.getParameter("specialist") %>" readonly>
                    </td>
                </tr>
                <tr>
                    <th>Doctor Name:</th>
                    <td>
                        <input type="text" id="doctor" name="doctor" value="<%= request.getParameter("doctorName") %>" readonly>
                    </td>
                </tr>
                <tr>
                    <th>Date:</th>
                    <td>
                        <input type="date" id="date" name="date" required 
                            min="<%= java.time.LocalDate.now() %>" 
                            max="<%= java.time.LocalDate.now().plusDays(20) %>"
                            oninput="checkDate()">
                        <span id="dateError" style="color: red;"></span>
                    </td>
                </tr>
                <tr>
                    <th>Appointment Fee:</th>
                    <td><input type="text" id="fee" name="fee" value="500" readonly></td>
                </tr>
                <tr>
                    <th>Scan QR and Pay:</th>
                    <td><img src="https://th.bing.com/th/id/OIP.mwrhTQWEEHHYT7Z5rzA0_AHaHa?rs=1&pid=ImgDetMain" height="100" width="100"></td>
                </tr>
                <tr>
                    <th>Doctor ID:</th>
                    <td><input type="text" id="doctorId" name="doctorId" value="<%= request.getParameter("doctorId") %>" readonly></td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align:center;">
                        <input type="submit" value="Confirm" class="button">
                    </td>
                </tr>
                <tr style="display: none;">
                    <th>Appointment Status:</th>
                    <td>
                        <input type="hidden" id="status" name="status" value="Confirmed">
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <script>
        var currentDate = new Date();
        // Calculate the maximum date (20 days from now)
        var maxDate = new Date(currentDate.getTime() + (20 * 24 * 60 * 60 * 1000));

        // Format the maximum date as YYYY-MM-DD
        var maxDateFormatted = maxDate.toISOString().split('T')[0];

        // Set the date input's min and max attributes
        document.getElementById("date").setAttribute("min", currentDate.toISOString().split('T')[0]);
        document.getElementById("date").setAttribute("max", maxDateFormatted);

        function checkDate() {
            var selectedDate = new Date(document.getElementById("date").value);
            var today = new Date();
            var futureDate = new Date();
            futureDate.setDate(today.getDate() + 20);

            if (selectedDate > futureDate) {
                document.getElementById("dateError").innerText = "Please select a date within the next 20 days.";
                document.getElementById("date").value = ""; // Clear the date input
            } else {
                document.getElementById("dateError").innerText = "";
            }
        }
    </script>
</body>
</html>
