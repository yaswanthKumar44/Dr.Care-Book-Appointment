<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*, java.io.*, javax.servlet.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Appointment Details</title>
    <script>
        function showAlert(message) {
            alert(message);
            window.location.href = "all-appointments.jsp"; // Redirect to admin home page after showing alert
        }
    </script>
</head>
<body>
    <% String transactionId = request.getParameter("transaction_id");
    String name = request.getParameter("name");
    String issue = request.getParameter("issue");
    String day = request.getParameter("day");
    String status = request.getParameter("status");
    String age = request.getParameter("age");

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "yash", "455664");
        PreparedStatement pst = con.prepareStatement("UPDATE appointments SET name=?, issue=?, day=?, status=?, age=? WHERE transaction_id=?");

        pst.setString(1, name);
        pst.setString(2, issue);
        pst.setString(3, day);
        pst.setString(4, status);
        pst.setString(5, age);
        pst.setString(6, transactionId);

        int rowsUpdated = pst.executeUpdate();

        if (rowsUpdated > 0) {
            out.println("<script>showAlert('Appointment details updated successfully');</script>");
        } else {
            out.println("<script>showAlert('Failed to update appointment details');</script>");
        }

        pst.close();
        con.close();
    } catch (Exception e) {
        out.println("<script>showAlert('Error: " + e.getMessage() + "');</script>");
        e.printStackTrace();
    }
    %>
</body>
</html>
