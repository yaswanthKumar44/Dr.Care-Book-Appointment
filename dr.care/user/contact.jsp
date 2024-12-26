<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f1f1f1;
            background-image: url('https://cdn.wallpapersafari.com/99/13/OBl3g7.jpg');
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-size: 100% 100%;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
            text-align: center;
        }

        h1 {
            color: #333;
        }

        p {
            margin: 20px 0;
        }

        .alert {
            background-color: #f8d7da;
            color: #721c24;
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid #f5c6cb;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <%
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "yash", "455664");

            String message = request.getParameter("message");
            String username = (String) session.getAttribute("username");

            PreparedStatement checkPs = con.prepareStatement("SELECT message FROM messages WHERE username = ?");
            checkPs.setString(1, username);
            ResultSet checkRs = checkPs.executeQuery();

            if (checkRs.next()) {
                String previousMessage = checkRs.getString("message");
        %>
                <div class="alert">
                    Your previous message is in process: <%= previousMessage %>
                </div>
                <a href="contact.html">Back to Contact Page</a>
        <%
            } else {
                PreparedStatement ps = con.prepareStatement("INSERT INTO messages (username, message) VALUES (?, ?)");
                ps.setString(1, username);
                ps.setString(2, message);
                int rowsAffected = ps.executeUpdate();

                if (rowsAffected > 0) {
        %>
                    <h1>Message Sent Successfully</h1>
                    <p><a href="contact.html">Back to Contact Page</a></p>
        <%
                } else {
        %>
                    <h1>Error Sending Message</h1>
                    <p><a href="contact.html">Back to Contact Page</a></p>
        <%
                }
            }
            con.close();
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
        %>
    </div>
</body>
</html>
