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
            background-image: url('https://torange.biz/photofxnew/209/HD/mirror-blur-left-side-209993.jpg');
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-size: cover;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        header {
            background-color: #007bff;
            color: white;
            padding: 10px 0;
            text-align: center;
            margin-bottom:  0px;
        }

        nav {
    background-color: #6d0cf6;
    padding: 10px 0;
    text-align: center;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

        nav a {
            margin: 0 10px;
            text-decoration: none;
            color: #00eeff;
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
            background-color: #1126e3;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .doctor-details button:hover {
            background-color: #12e031;
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
        <a href="owners.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Admins</a>
        <a href="staff.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Staff</a>
        <a href="doctors.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px; background-color: #1af701fb;">Doctors</a>
        <a href="users.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Users</a>
        <a href="feedbacks-received.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">All Feedbacks</a>
        <div class="profile" style="display: flex; align-items: center;">
            <img src="https://th.bing.com/th/id/OIP.KitsWvuPkcEUMv3Vd1yQ9QHaHa?rs=1&pid=ImgDetMain" alt="Profile Image" style="width: 50px; height: 50px; border-radius: 50%;">
            <a href="owner-profile.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Profile</a>
        </div>
        <a href="owner-logout.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Logout</a>
    </nav>
    
    <div class="container">
        <form class="search-form" method="GET" action="doctors.jsp">
          
            <input type="text" id="searchQuery" name="searchQuery" placeholder="search doctor...">
            <button type="submit">Search</button>
            <a href="doctor-register.html" style="color: #00ff22; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px; background-color: #0d01f7fb;">Add Doctor</a>
        </form>
        <% 
    String ownerId = (String) session.getAttribute("ownerId");
    if (ownerId != null) {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "yash", "455664");
            Statement stmt = conn.createStatement();
            
            String searchQuery = request.getParameter("searchQuery");
            String query = "SELECT * FROM doctors";
            if (searchQuery != null && !searchQuery.isEmpty()) {
                query += " WHERE DOCTOR_NAME LIKE '%" + searchQuery + "%' OR GENDER LIKE '%" + searchQuery + "%' OR SPECIALIST LIKE '%" + searchQuery + "%' OR EXPERIENCE LIKE '%" + searchQuery + "%' OR AVAILABILITY_STATUS LIKE '%" + searchQuery + "%' OR DATE_OF_LEAVE1 LIKE '%" + searchQuery + "%' OR DATE_OF_LEAVE2 LIKE '%" + searchQuery + "%' OR DATE_OF_LEAVE3 LIKE '%" + searchQuery + "%' OR EMAIL LIKE '%" + searchQuery + "%' OR MOBILE LIKE '%" + searchQuery + "%' OR AGE LIKE '%" + searchQuery + "%'";
            }
            
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
    %>
        <div class="doctor-details">
            <h3>Doctor ID: <%= rs.getString("DOCTOR_ID") %></h3>
            <h3>Doctor Name: <%= rs.getString("DOCTOR_NAME") %></h3>
            <p>Gender: <%= rs.getString("GENDER") %></p>
            <p>Specialization: <%= rs.getString("SPECIALIST") %></p>
            <p>Experience: <%= rs.getString("EXPERIENCE") %> years</p>
            <p>Availability: <%= rs.getString("AVAILABILITY_STATUS") %></p>
            <p>Dates Not Available On: <%= rs.getString("DATE_OF_LEAVE1") %>, <%= rs.getString("DATE_OF_LEAVE2") %>, <%= rs.getString("DATE_OF_LEAVE3") %></p>
            <p>Email: <%= rs.getString("EMAIL") %></p>
            <p>Mobile Number: <%= rs.getString("MOBILE") %></p>
            <p>Age: <%= rs.getString("AGE") %></p>
          
            <button onclick="window.location.href = 'admin-edit-doctor.jsp?doctorId=<%= rs.getString("DOCTOR_ID") %>'">Edit</button>
        </div>
        
        <% 
    }
    rs.close();
    stmt.close();
    conn.close();
} catch (Exception e) {
    out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
}
} else {
%>
out.println("<script>alert('Please login to perform this action'); window.location.href = 'owner-login.html';</script>");
<% 
}
%>
</body>
