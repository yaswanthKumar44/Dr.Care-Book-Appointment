<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dr.Care - Edit Doctor</title>
    <style>
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
            margin-bottom: 0px;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }

        .edit-form {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
            max-width: 600px;
            margin: 20px auto;
        }

        .edit-form label {
            display: block;
            margin-bottom: 5px;
        }

        .edit-form input[type="text"],
        .edit-form input[type="password"] {
            width: calc(100% - 12px);
            padding: 6px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }

        .edit-form button {
            padding: 8px 16px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-right: 10px;
        }

        .edit-form button:hover {
            background-color: #0056b3;
        }
        #specialization {
        display: none;
    }
    </style>
</head>

<body>
    <header>
        <h1>Edit Doctor</h1>
    </header>
    <div class="container">
        <div class="edit-form">
            <%
            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "yash", "455664");

                String doctorId = request.getParameter("doctorId");
                String query = "SELECT * FROM doctors WHERE DOCTOR_ID=?";
                PreparedStatement pstmt = conn.prepareStatement(query);
                pstmt.setString(1, doctorId);
                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
            %>
            <form method="POST" action="update-doctor.jsp" onsubmit="return validateForm()">
                <input type="hidden" name="doctorId" value="<%= doctorId %>">
                <label for="doctorName">Doctor Name:</label>
                <input type="text" id="doctorName" name="doctorName" value="<%= rs.getString("DOCTOR_NAME") %>">
                <label for="gender">Gender:</label>
                <select id="gender" name="gender">
                    <option value="Male" <%= rs.getString("GENDER").equals("Male") ? "selected" : "" %>>Male</option>
                    <option value="Female" <%= rs.getString("GENDER").equals("Female") ? "selected" : "" %>>Female</option>
                    <option value="Other" <%= rs.getString("GENDER").equals("Other") ? "selected" : "" %>>Other</option>
                </select>
                
               
                <select id="specialization" name="specialization">
                    <option value="Heart(Cardiology)" <%= rs.getString("SPECIALIST").equals("Heart(Cardiology)") ? "selected" : "" %>>Heart(Cardiology)</option>
                    <option value="Lungs(Pulmonology)" <%= rs.getString("SPECIALIST").equals("Lungs(Pulmonology)") ? "selected" : "" %>>Lungs(Pulmonology)</option>
                    <option value="Kidney(Nephrology)" <%= rs.getString("SPECIALIST").equals("Kidney(Nephrology)") ? "selected" : "" %>>Kidney(Nephrology)</option>
                    <option value="Brain(Neurology)" <%= rs.getString("SPECIALIST").equals("Brain(Neurology)") ? "selected" : "" %>>Brain(Neurology)</option>
                </select>
                <label for="experience">Experience:</label>
                <input type="text" id="experience" name="experience" value="<%= rs.getString("EXPERIENCE") %>">
                <label for="availability">Availability:</label>
                <select id="availability" name="availability">
                    <option value="available" <%= rs.getString("AVAILABILITY_STATUS").equals("available") ? "selected" : "" %>>Available</option>
                    <option value="not available" <%= rs.getString("AVAILABILITY_STATUS").equals("not available") ? "selected" : "" %>>Not Available</option>
                </select>
                <label for="date1">Date of Leave 1:</label>
                <input type="date" id="date1" name="date1" value="<%= rs.getString("DATE_OF_LEAVE1") %>">
                <label for="date2">Date of Leave 2:</label>
                <input type="date" id="date2" name="date2" value="<%= rs.getString("DATE_OF_LEAVE2") %>">
                <label for="date3">Date of Leave 3:</label>
                <input type="date" id="date3" name="date3" value="<%= rs.getString("DATE_OF_LEAVE3") %>">
                <label for="email">Email:</label>
                <input type="text" id="email" name="email" value="<%= rs.getString("EMAIL") %>">
                <label for="mobile">Mobile Number:</label>
                <input type="text" id="mobile" name="mobile" value="<%= rs.getString("MOBILE") %>" maxlength="10" >
                <label for="age">Age:</label>
                <input type="text" id="age" name="age" value="<%= rs.getString("AGE") %>">
                <button type="submit">Update</button>
            </form>

            <script>
            function validateForm() {
                var email = document.getElementById("email").value;
                var mobile = document.getElementById("mobile").value;
                var age = document.getElementById("age").value;

                var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                var mobilePattern = /^\d{10}$/;

                if (!emailPattern.test(email)) {
                    alert("Please enter a valid email address");
                    return false;
                }

                if (!mobilePattern.test(mobile)) {
                    alert("Please enter a valid 10-digit mobile number");
                    return false;
                }

                if (age < 18 || age > 150) {
                    alert("Please enter an age between 18 and 150");
                    return false;
                }

                return true;
            }
            </script>

            <% } else { %>
            <p>Doctor not found.</p>
            <% } %>
        </div>
    </div>
</body>

</html>
<%
    rs.close();
    pstmt.close();
    conn.close();
} catch (Exception e) {
    out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
}
%>
