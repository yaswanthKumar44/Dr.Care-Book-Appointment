<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*, java.text.SimpleDateFormat, java.util.Date" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <!-- Include your CSS styles and other meta tags -->
    <style>
        /* Your existing CSS styles here */
        body {
            background-image: url('https://cdn.wallpapersafari.com/99/13/OBl3g7.jpg');
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-size: 100% 100%;
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
            font-size: 32px; /* Increase the font size */
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
            max-width: 0 auto;
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

        .highlight {
            background-color: #d4edda; /* Light green shade for highlighting */
        }
        
        .today {
            background-color: #ffc107; /* Yellow for today's appointments */
        }
    </style>
</head>

<body>
    <!-- Your header and navigation -->
    <header>
        <h1>Dr.Care - Appointments</h1>
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
        <h2>Appointments</h2>
        <!-- Add search input fields -->
        <input type="text" id="searchInput" onkeyup="searchTable()" placeholder="Search for appointments...">
        <input type="date" id="dateInput" onchange="searchTable()" placeholder="Search by date...">
        <table>
            <tr>
                <th>Username</th>
                <th>Name</th>
                <th>Issue</th>
                <th>Mobile Number</th>
                <th>Doctor Name</th>
                <th>Doctor ID</th>
                <th>Transaction ID</th>
                <th>Date of Appointment</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
            <%-- Include Java code to fetch and display appointments --%>
            <%
            String username = (String) session.getAttribute("username");
            
            if (username != null) {
                try {
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    try (Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "yash", "455664");
                    PreparedStatement pst = con.prepareStatement("SELECT * FROM appointments WHERE username=? ORDER BY day")) {
            
                        pst.setString(1, username);
                        try (ResultSet rs = pst.executeQuery()) {
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                            Date currentDate = new Date();
                            while (rs.next()) {
                                String appointmentDateStr = rs.getString("day");
                                Date appointmentDate = sdf.parse(appointmentDateStr);
                                
                                // Compare dates without time component
                                if (sdf.format(appointmentDate).equals(sdf.format(currentDate))) {
                                    out.println("<tr class='highlight today'>");
                                } else {
                                    out.println("<tr>");
                                }
                                out.println("<td>" + rs.getString("username") + "</td>");
                                out.println("<td>" + rs.getString("name") + "</td>");
                                out.println("<td>" + rs.getString("issue") + "</td>");
                                out.println("<td>" + rs.getString("mobile") + "</td>"); // Display mobile number
                                out.println("<td>" + rs.getString("doctor") + "</td>");
                                out.println("<td>" + rs.getString("doctor_id") + "</td>");
                                out.println("<td>" + rs.getString("transaction_id") + "</td>");
                                out.println("<td>" + appointmentDateStr + "</td>");
                                out.println("<td>" + rs.getString("status") + "</td>");
                                out.println("<td><a href='edit_appointments.jsp?username=" + rs.getString("username") +
                                    "&name=" + rs.getString("name") +
                                    "&issue=" + rs.getString("issue") +
                                    "&doctor=" + rs.getString("doctor") +
                                    "&doctor_id=" + rs.getString("doctor_id") +
                                    "&transaction_id=" + rs.getString("transaction_id") +
                                    "&day=" + appointmentDateStr +
                                    "&status=" + rs.getString("status") +
                                    "&mobile=" + rs.getString("mobile") + // Include mobile number in the edit link
                                    "'>Edit</a></td>");
            
                                out.println("</tr>");
                            }
                        }
                    }
                } catch (Exception e) {
                    out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
                }
            } else {
                response.sendRedirect("login.html");
            }
            %>
            
        </table>
    </div>

    <script>
    function searchTable() {
        var input, dateInput, filter, dateFilter, table, tr, td, i, j, txtValue;
        input = document.getElementById("searchInput");
        dateInput = document.getElementById("dateInput");
        filter = input.value.toUpperCase();
        dateFilter = dateInput.value.toUpperCase();
        table = document.querySelector("table");
        tr = table.getElementsByTagName("tr");

        for (i = 1; i < tr.length; i++) {
            tds = tr[i].getElementsByTagName("td");
            var found = false;
            for (j = 0; j < tds.length; j++) {
                td = tds[j];
                if (td) {
                    txtValue = td.textContent || td.innerText;
                    if (txtValue.toUpperCase().indexOf(filter) > -1 && (dateFilter === "" || txtValue.toUpperCase().indexOf(dateFilter) > -1)) {
                        found = true;
                        break;
                    }
                }
            }
            if (found) {
                tr[i].style.display = "";
            } else {
                tr[i].style.display = "none";
            }
        }
    }
    </script>
</body>

</html>
