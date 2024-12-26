<%@ page import="java.sql.*,java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Admin Profile</title>
    <style>
     body {
            background-image: url('https://torange.biz/photofxnew/209/HD/mirror-blur-left-side-209993.jpg');
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-size: cover;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
        }
        form {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"],
        input[type="email"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            padding: 10px 20px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Edit Admin Profile</h1>
        <%
            String ownerId = (String) session.getAttribute("ownerId");
            if (ownerId != null) {
                try {
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    try (Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "yash", "455664")) {
                        String query = "SELECT * FROM owners WHERE owner_id=?";
                        try (PreparedStatement pst = con.prepareStatement(query)) {
                            pst.setString(1, ownerId);
                            try (ResultSet rs = pst.executeQuery()) {
                                if (rs.next()) {
        %>
        <form action="update-owner-profile.jsp?owner-id=<%= ownerId %>" method="POST">
            <label for="fullname">Full Name:</label>
            <input type="text" id="fullname" name="fullname" value="<%= rs.getString("fullname") %>" required><br>
            
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" value="<%= rs.getString("email") %>" pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" required><br>
           
            <label for="address">Address:</label>
            <input type="text" id="address" name="address" value="<%= rs.getString("address") %>" required><br>
            
            <label for="age">Age:</label>
            <input type="number" id="age" name="age" value="<%= rs.getInt("age") %>" min="1" max="150" required><br>
            
            <label for="gender">Gender:</label>
            <select id="gender" name="gender" required>
                <option value="Male" <%= rs.getString("gender").equals("Male") ? "selected" : "" %>>Male</option>
                <option value="Female" <%= rs.getString("gender").equals("Female") ? "selected" : "" %>>Female</option>
                <option value="Other" <%= rs.getString("gender").equals("Other") ? "selected" : "" %>>Other</option>
            </select><br>
            
            <label for="mobile">Mobile Number:</label>
            <input type="tel" id="mobile" name="mobile" pattern="[0-9]{10}" value="<%= rs.getString("mobile") %>" required><br>
        
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" value="<%= session.getAttribute("password") %>" required><br>
           
            
        
            
            <input type="submit" value="Save Changes">
        </form>
        
        
        <%
                                } else {
        %>
                                    <p>Owner not found</p>
        <%
                                }
                            }
                        }
                    }
                } catch (SQLException | ClassNotFoundException e) {
                    out.println("<h1>Error: " + e.getMessage() + "</h1>");
                    e.printStackTrace();
                }
            } else {
        %>
                <p>Admin Id not found in session</p>
        <%
            }
        %>
    </div>
</body>
</html>
