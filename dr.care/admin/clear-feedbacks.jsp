<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "yash", "455664");
    Statement stmt = con.createStatement();
    int rowsAffected = stmt.executeUpdate("DELETE FROM feedback");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clear Feedbacks</title>
    <style>
        /* Your CSS styles here */
        body {
            background-image: url('https://cdn.wallpapersafari.com/99/13/OBl3g7.jpg');
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-size: 100% 100%;
        }

        header {
            background-color: #007bff;
            color: white;
            padding: 10px 0;
            text-align: center;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            text-align: center;
        }

        p {
            font-size: 20px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<header>
    <h1>Clear Feedbacks</h1>
</header>
<div class="container">
    <p><%= rowsAffected %> feedbacks cleared successfully.</p>
    <a href="feedbacks-received.jsp">Back to Feedbacks</a>
</div>
</body>
</html>
<%
    con.close();
} catch (Exception e) {
    out.println("<p>Error: " + e.getMessage() + "</p>");
}
%>
