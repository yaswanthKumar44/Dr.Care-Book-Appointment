<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dr.Care - Home</title>
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
        }

        .doctor-details {
            background-color: #f9f9f9;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .doctor-details h3 {
            margin-top: 0;
            color: #007bff;
        }

        .doctor-details p {
            margin-bottom: 10px;
        }

        .doctor-details button {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .doctor-details button:hover {
            background-color: #c82333;
        }

        .search-form {
            margin-bottom: 20px;
            text-align: center;
        }

        .search-form label {
            font-weight: bold;
            margin-right: 5px;
        }

        .search-form input[type="text"] {
            padding: 5px;
            width: 200px;
        }

        .search-form button {
            padding: 5px 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .search-form button:hover {
            background-color: #0056b3;
        }
    </style>
</head>

<body>
    <header>
        <h1>Dr.Care</h1>
    </header>
    <nav style="display: flex; justify-content: space-between; align-items: center; padding: 10px; background-color: #f8f9fa;">
        <a href="admin-home.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px; background-color: #1af701fb;">Home</a>
        <a href="doctors.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Doctors</a>
        <a href="users.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Users</a>
        <a href="all-appointments.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">All Appointments</a>
        <a href="contacts-received.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Contacts Received</a>
       
        <div class="profile" style="display: flex; align-items: center;">
            <img src="https://th.bing.com/th/id/OIP.KitsWvuPkcEUMv3Vd1yQ9QHaHa?rs=1&pid=ImgDetMain" alt="Profile Image" style="width: 50px; height: 50px; border-radius: 50%;">
            <a href="admin-profile.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Profile</a>
        </div>
        <a href="staff-logout.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Logout</a>
    </nav>
    <div class="container">
        <form class="search-form" method="GET" action="admin-home.jsp">
            <input type="text" id="searchQuery" name="searchQuery">
            <button type="submit">Search</button>
        </form>
        <% 
            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "yash", "455664");
                String searchQuery = request.getParameter("searchQuery");
                String query = "SELECT * FROM doctors";

                if (searchQuery != null && !searchQuery.isEmpty()) {
                    query += " WHERE LOWER(doctor_name) LIKE LOWER('%" + searchQuery + "%')"
                            + " OR LOWER(specialist) LIKE LOWER('%" + searchQuery + "%')"
                            + " OR LOWER(email) LIKE LOWER('%" + searchQuery + "%')"
                            + " OR LOWER(mobile) LIKE LOWER('%" + searchQuery + "%')";
                }

                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query);

                while (rs.next()) {
        %>
                    <div class="doctor-details">
                        <h3>Doctor ID: <%= rs.getString("doctor_id") %></h3>
                        <h3>Doctor Name: <%= rs.getString("doctor_name") %></h3>
                        <p>Specialization: <%= rs.getString("specialist") %></p>
                        <p>Age: <%= rs.getString("age") %></p>
                        <p>Dates Not Available On: <%= rs.getString("date_of_leave1") %>,<%= rs.getString("date_of_leave2") %>,<%= rs.getString("date_of_leave3") %></p>
                        <p>Mobile Number: <%= rs.getString("mobile") %></p>
                        <p>Email: <%= rs.getString("email") %></p>
                        <p>Experience: <%= rs.getString("experience") %> years</p>
                        <p>Availability: <%= rs.getString("availability_status") %></p>
                        <button onclick="window.location.href = 'admin-book-appointment.jsp?specialist=<%= rs.getString("specialist") %>&doctorName=<%= rs.getString("doctor_name") %>&doctorId=<%= rs.getString("doctor_id") %>'">Book Appointment</button>
                    </div>
        <%
                }
                rs.close();
                stmt.close();
                conn.close();
            } catch (Exception e) {
                out.println("<script>alert('Error: " + e.getMessage() + "');</script>");

            }
        %>
    </div>
</body>

</html>
