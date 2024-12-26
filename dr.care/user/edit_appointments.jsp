<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*, java.time.*, java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Appointment</title>
    <style>
        /* Your CSS styles */
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

        label {
            display: block;
            margin-top: 10px;
        }

        input[type="text"],
        input[type="date"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .save-button, .cancel-button {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            margin-right: 10px;
        }

        .cancel-button {
            background-color: red;
        }

        .save-button:hover, .cancel-button:hover {
            background-color: #0056b3;
        }
        .profile {
            display: flex;
            align-items: center;
            margin-right: 10px;
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
        <h1>Edit Appointment</h1>
    </header>
    <nav style="display: flex; justify-content: space-between; align-items: center; padding: 10px; background-color: #f8f9fa;">
        <a href="home.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Home</a>
        <a href="appointments.jsp" style="color: #ef0a0a; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px; background-color: #1af701fb;">Appointments</a>
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
        <h2>Edit Appointment Details</h2>
        <form action="save_changes.jsp" method="post">
            <label for="transaction_id"></label>
            <%-- Display appointment details here --%>
            <%
            String username = (String) session.getAttribute("username"); // Get the username from the session
            String transactionId = request.getParameter("transaction_id");

            // Ensure username and transaction_id are not null and display appointment details only if they are valid
            if (username != null && !username.isEmpty() && transactionId != null && !transactionId.isEmpty()) {
                try {
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    try (Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "yash", "455664");
                         PreparedStatement pst = con.prepareStatement("SELECT * FROM appointments WHERE username=? AND transaction_id=?")) {
    
                        pst.setString(1, username);
                        pst.setString(2, transactionId);
    
                        try (ResultSet rs = pst.executeQuery()) {
                            if (rs.next()) {
                                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                                LocalDate today = LocalDate.now();
                                LocalDate minDate = today.minusDays(0); // Two days in the past
                                LocalDate maxDate = today.plusDays(5);  // One day in the future
                                String minDateString = minDate.format(formatter);
                                String maxDateString = maxDate.format(formatter);
                            %>
                                <form action="save_changes.jsp" method="post">
                                    <input type="hidden" name="transaction_id" value="<%= transactionId %>">
                                    <label for="name">Name:</label>
                                    <input type="text" id="name" name="name" value="<%= rs.getString("name") %>">
    
                                    <label for="issue">Issue:</label>
                                    <input type="text" id="issue" name="issue" value="<%= rs.getString("issue") %>">
                                    <label for="mobile">Mobile Number:</label>
                                    <input type="text" id="mobile" name="mobile" value="<%= rs.getString("mobile") %>" maxlength="10">

    
                      
                                    <input type="date" id="day" name="day" value="<%= rs.getString("day") %>" min="<%= minDateString %>" max="<%= maxDateString %>" readonly>
    
                                    <button type="submit" class="save-button">Save Changes</button>
                                </form>
                            <%
                            } else {
                                out.println("<p>No appointment found for the given username and transaction_id</p>");
                            }
                        }
                    }
                } catch (Exception e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                    e.printStackTrace();
                }
            }
            %>
        </div>
    </body>
    </html>