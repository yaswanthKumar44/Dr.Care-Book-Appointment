<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*, java.time.*, java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Appointment Details</title>
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
            color: white;
            padding: 10px 0;
            text-align: center;
            margin-bottom:  0px;
        }

        nav {
            background-color: #35ff02;
            padding: 10px 0;
            text-align: center;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
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
            margin-right: 10px;
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

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        input[type="text"],
        input[type="date"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        
        .cancel-button {
            padding: 8px 20px;
            margin-top: 10px;
            background-color: #f61616;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
        }
        .save-button
      {
            padding: 8px 20px;
            margin-top: 10px;
            background-color: #0cdf10;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
        }

       
        .cancel-button:hover {
            background-color: #e81313;
        }
        .save-button:hover
         {
            background-color: #2ce906;
        }
    </style>
</head>
<body>
    <header>
        <h1>Welcome to Dr.Care Hospital</h1>
        <p>Your trusted healthcare partner</p>
    </header>
    <nav style="display: flex; justify-content: space-between; align-items: center; padding: 10px; background-color: #f8f9fa;">
        <a href="admin-home.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px; ">Home</a>
        <a href="doctors.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Doctors</a>
        <a href="users.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Users</a>
        <a href="all-appointments.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px; background-color: #1af701fb;">All Appointments</a>
        <a href="contacts-received.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Contacts Received</a>
       
        <div class="profile" style="display: flex; align-items: center;">
            <img src="https://th.bing.com/th/id/OIP.KitsWvuPkcEUMv3Vd1yQ9QHaHa?rs=1&pid=ImgDetMain" alt="Profile Image" style="width: 50px; height: 50px; border-radius: 50%;">
            <a href="admin-profile.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Profile</a>
        </div>
        <a href="staff-logout.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Logout</a>
    </nav>
    <div class="container">
        <h2>Edit Appointment Details</h2>
        <form action="admin-save-changes.jsp" method="post">
            <% String username = request.getParameter("username");
            String transactionId = request.getParameter("transaction_id");

            if (username != null && !username.isEmpty() && transactionId != null && !transactionId.isEmpty()) {
                try {
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    try (Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "yash", "455664");
                         PreparedStatement pst = con.prepareStatement("SELECT * FROM appointments WHERE transaction_id=?")) {

                        pst.setString(1, transactionId);

                        try (ResultSet rs = pst.executeQuery()) {
                            if (rs.next()) {
                                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                                LocalDate today = LocalDate.now();
                                LocalDate minDate = today.minusDays(0);
                                LocalDate maxDate = today.plusDays(30);
                                String minDateString = minDate.format(formatter);
                                String maxDateString = maxDate.format(formatter);
                                %>
                                <input type="hidden" name="transaction_id" value="<%= transactionId %>">
                                <label for="name">Name:</label>
                                <input type="text" id="name" name="name" value="<%= rs.getString("name") %>">

                                <label for="issue">Issue:</label>
                                <input type="text" id="issue" name="issue" value="<%= rs.getString("issue") %>">
                                <label for="specialist">Specialist:</label>
<select id="specialist" name="specialist">
    <option value="Heart(Cardiology)" <%= rs.getString("SPECIALIST").equals("Heart(Cardiology)") ? "selected" : "" %>>Heart(Cardiology)</option>
    <option value="Lungs(Pulmonology)" <%= rs.getString("SPECIALIST").equals("Lungs(Pulmonology)") ? "selected" : "" %>>Lungs(Pulmonology)</option>
    <option value="Kidney(Nephrology)" <%= rs.getString("SPECIALIST").equals("Kidney(Nephrology)") ? "selected" : "" %>>Kidney(Nephrology)</option>
    <option value="Brain(Neurology)" <%= rs.getString("SPECIALIST").equals("Brain(Neurology)") ? "selected" : "" %>>Brain(Neurology)</option>
</select>


                                <label for="doctor">Doctor Name:</label>
                                <input type="text" id="doctor" name="doctor" value="<%= rs.getString("doctor") %>">

                                <label for="doctorId">Doctor ID:</label>
                                <input type="text" id="doctorId" name="doctorId" value="<%= rs.getString("doctor_id") %>">

                                <label for="day">Date of Appointment (Between <%= minDateString %> and <%= maxDateString %>):</label>
                                <input type="date" id="day" name="day" value="<%= rs.getString("day") %>" min="<%= minDateString %>" max="<%= maxDateString %>">

                                <label for="status">Status:</label>
                                <select id="status" name="status">
                                    <option value="Confirmed" <%= rs.getString("status").equals("Confirmed") ? "selected" : "" %>>Confirmed</option>
                                    <option value="Doctor on Leave your appointment date is modified" <%= rs.getString("status").equals("Doctor on Leave") ? "selected" : "" %>>Doctor on Leave your appointment date is modified</option>
                                    <option value="Completed" <%= rs.getString("status").equals("Completed") ? "selected" : "" %>>Completed</option>
                                </select>

                                <label for="age">Age:</label>
                                <input type="number" id="age" name="age" value="<%= rs.getString("age") %>" min="1" max="150">

                                <label for="mobile">Mobile:</label>
                                <input type="text" id="mobile" name="mobile" value="<%= rs.getString("mobile") %>" maxlength="10"><br>

                                <button type="submit" class="save-button">Save Changes</button>
                                <a href="admin-delete-appointment.jsp?transaction_id=<%= transactionId %>" class="cancel-button">Delete Appointment</a>
                            <% } else {
                                out.println("<p>No appointment found for the given username and transaction_id</p>");
                            }
                        }
                    }
                } catch (Exception e) {
                    out.println("<script>alert('Error: " + e.getMessage() + "');</script>");

                    e.printStackTrace();
                }
            }
            %>
        </form>
    </div>
</body>
</html>
