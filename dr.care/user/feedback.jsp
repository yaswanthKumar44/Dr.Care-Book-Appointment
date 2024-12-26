<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,javax.servlet.http.*" %>
<%@ page import="java.sql.*" %>

<%
    HttpSession sessionObj = request.getSession();
    String username = (String) sessionObj.getAttribute("username");

    if (username == null) {
        // Redirect to login page or display an error message
        response.sendRedirect("login.html");
    } else {
        String treatment = request.getParameter("treatment");
        String opSection = request.getParameter("op-section");
        String wheelchair = request.getParameter("wheelchair");
        int facilityRating = Integer.parseInt(request.getParameter("facility-rating"));
        int doctorRating = Integer.parseInt(request.getParameter("doctor-rating"));
        int hospitalStaffRating = Integer.parseInt(request.getParameter("hospital-staff-rating"));
        String watchmanBehaviour = request.getParameter("watchman-behaviour");
        int overallRating = Integer.parseInt(request.getParameter("overall-rating"));

        // Assuming you have a database connection
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "yash", "455664");
        Statement stmt = conn.createStatement();

        // Check if the user has already submitted feedback
        String checkSql = "SELECT * FROM feedback WHERE username = '" + username + "'";
        ResultSet rs = stmt.executeQuery(checkSql);
        if (rs.next()) {
            // User has already submitted feedback
            out.println("<script>alert('You have already submitted feedback!');</script>");
        } else {
            // User has not submitted feedback, proceed with insertion
            String sql = "INSERT INTO feedback (username, treatment, op_section, wheelchair, facility_rating, doctor_rating, hospital_staff_rating, watchman_behaviour, overall_rating) VALUES ('" + username + "', '" + treatment + "', '" + opSection + "', '" + wheelchair + "', " + facilityRating + ", " + doctorRating + ", " + hospitalStaffRating + ", '" + watchmanBehaviour + "', " + overallRating + ")";
            stmt.executeUpdate(sql);
        }

        stmt.close();
        conn.close();
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dr.Care - Feedback Submitted</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            color: #333;
            margin: 0;
            padding: 0;
            text-align: center;
          
            background-image: url('https://cdn.wallpapersafari.com/99/13/OBl3g7.jpg');
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-size: 100% 100%;
        

        }

        .container {
            max-width: 800px;
            margin: 100px auto;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
        }

        h2 {
            margin-top: 0;
        }

        p {
            margin-bottom: 20px;
        }

        a {
            color: #007bff;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>
    <div class="container">
        <h2>Feedback Submitted</h2>
        <p>Thank you for your feedback!</p>
        <p><a href="home.jsp">Go back to Home</a></p>
    </div>
</body>

</html>
