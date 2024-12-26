<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
String ownerId = (String) session.getAttribute("ownerId");
if (ownerId != null) {
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "yash", "455664");
        String searchQuery = request.getParameter("search");
        String sql = "SELECT * FROM admins";
        if (searchQuery != null && !searchQuery.isEmpty()) {
            sql += " WHERE fullname LIKE '%" + searchQuery + "%'"
                    + " OR email LIKE '%" + searchQuery + "%'"
                    + " OR username LIKE '%" + searchQuery + "%'"
                    + " OR password LIKE '%" + searchQuery + "%'"
                    + " OR address LIKE '%" + searchQuery + "%'"
                    + " OR age LIKE '%" + searchQuery + "%'"
                    + " OR gender LIKE '%" + searchQuery + "%'"
                    + " OR staff_type LIKE '%" + searchQuery + "%'"
                    + " OR mobile LIKE '%" + searchQuery + "%'";
        }
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery(sql);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff</title>
    <style>
        /* Your CSS styles here */
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
            color: rgb(209, 9, 9);
            padding: 10px 0;
            text-align: center;
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
            border: 1px solid #ccc;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f8f9fa;
        }

        .edit-link {
            text-decoration: none;
            color: #007bff;
        }

        .edit-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<header>
    <h1>Dr.Care-Staff</h1>
</header>
<nav style="display: flex; justify-content: space-between; align-items: center; padding: 10px; background-color: #f8f9fa;">
    <a href="owners.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Admins</a>
    <a href="staff.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px; background-color: #1af701fb;">Staff</a>
    <a href="doctors.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px; ">Doctors</a>
    <a href="users.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Users</a>
    <a href="feedbacks-received.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">All Feedbacks</a>
    <div class="profile" style="display: flex; align-items: center;">
        <img src="https://th.bing.com/th/id/OIP.KitsWvuPkcEUMv3Vd1yQ9QHaHa?rs=1&pid=ImgDetMain" alt="Profile Image" style="width: 50px; height: 50px; border-radius: 50%;">
        <a href="owner-profile.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Profile</a>
    </div>
    <a href="owner-logout.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Logout</a>
</nav>
<div class="container">
    <form method="GET" action="staff.jsp">
        <input type="text" id="search" name="search" value="<%= searchQuery != null ? searchQuery : "" %>">
        <button type="submit">Search</button>
        <a href="admin-register.html" style="color: #00ff22; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px; background-color: #0d01f7fb;">Add Staff</a>
    </form>
    <table border="3">
        <thead>
        <tr>
            <th>Full Name</th>
            <th>Email</th>
            <th>Username</th>
            <th>Password</th>
            <th>Address</th>
            <th>Age</th>
            <th>Gender</th>
            <th>Staff Type</th>
            <th>Mobile</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <% while (rs.next()) { %>
        <tr>
            <td><%= rs.getString("fullname") %></td>
            <td><%= rs.getString("email") %></td>
            <td><%= rs.getString("username") %></td>
            <td><%= rs.getString("password") %></td>
            <td><%= rs.getString("address") %></td>
            <td><%= rs.getString("age") %></td>
            <td><%= rs.getString("gender") %></td>
            <td><%= rs.getString("staff_type") %></td>
            <td><%= rs.getString("mobile") %></td>
            <td>
                <form method="POST" action="deleteStaff.jsp">
                    <input type="hidden" name="username" value="<%= rs.getString("username") %>">
                    <button type="submit">Delete</button>
                </form>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
<%
        con.close();
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }
} else {
%>
<script>
    alert('Please login to perform this action');
    window.location.href = 'owner-login.html';
</script>
<%
}
%>
