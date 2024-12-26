<%@ page import="java.sql.*,java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dr.Care - Profile</title>
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

        .profile-details th,
        .profile-details td {
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
    <header>
        <h1>Dr.Care - Profile</h1>
    </header>
    <nav style="display: flex; justify-content: space-between; align-items: center; padding: 10px; background-color: #f8f9fa;">
        <a href="admin-home.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px; ">Home</a>
        <a href="doctors.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Doctors</a>
        <a href="users.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Users</a>
        <a href="all-appointments.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">All Appointments</a>
        <a href="contacts-received.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Contacts Received</a>
       
        <div class="profile" style="display: flex; align-items: center;">
            <img src="https://th.bing.com/th/id/OIP.KitsWvuPkcEUMv3Vd1yQ9QHaHa?rs=1&pid=ImgDetMain" alt="Profile Image" style="width: 50px; height: 50px; border-radius: 50%;">
            <a href="admin-profile.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;background-color: #1af701fb;">Profile</a>
        </div>
        <a href="staff-logout.jsp" style="color: #007bff; font-size: 20px; text-decoration: none; padding: 5px 10px; border-radius: 5px;">Logout</a>
    </nav>
    <div class="container">
        <h2>Welcome To Dr.Care</h2>
        <!-- Display user's profile information -->
        <div class="profile-info">
            <img src="https://static.vecteezy.com/system/resources/previews/003/805/792/non_2x/medical-staff-group-vector.jpg" alt="Profile Image">
        </div>
        <div class="profile-details">
            <h3>Profile Details</h3>
            <table>
                <%
                String username = (String) session.getAttribute("username");
                if (username != null) {
                    Connection con = null;
                    PreparedStatement pst = null;
                    ResultSet rs = null;
                    try {
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "yash", "455664");
                        String query = "SELECT * FROM admins WHERE username=?";
                        pst = con.prepareStatement(query);
                        pst.setString(1, username);
                        rs = pst.executeQuery();
                        if (rs.next()) {
                %>
                <tr>
                    <th>Name</th> 
                    <td><%= rs.getString("fullname") %></td>
                </tr>
                <tr>
                    <th>Email</th>
                    <td><%= rs.getString("email") %></td>
                </tr>
                <tr>
                    <th>Address</th>
                    <td><%= rs.getString("address") %></td>
                </tr>
                <tr>
                    <th>Age</th>
                    <td><%= rs.getInt("age") %></td>
                </tr>
                <tr>
                    <th>Gender</th>
                    <td><%= rs.getString("gender") %></td>
                </tr>
                <tr>
                    <th>Mobile Number</th>
                    <td><%= rs.getString("mobile") %></td>
                </tr>
                <tr>
                    <th>Staff Type</th>
                    <td><%= rs.getString("staff_type") %></td>
                </tr>
                <%
                        } else {
                %>
                                        <tr><td colspan="2">User not found</td></tr>
                <%
                        }
                    } catch (SQLException | ClassNotFoundException e) {
                        out.println("<h1>Error: " + e.getMessage() + "</h1>");
                        e.printStackTrace();
                    } finally {
                        if (rs != null) {
                            try {
                                rs.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                        if (pst != null) {
                            try {
                                pst.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                        if (con != null) {
                            try {
                                con.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    }
                } else {
                %>
                    <tr><td colspan="2">User not found</td></tr>
                <% } %>
            </table>
        </div>

    
        <a href="edit-admin-profile.jsp?username=<%= session.getAttribute("username") %>" class="edit-button">Edit Profile</a>

    </div>
</body>

</html>
