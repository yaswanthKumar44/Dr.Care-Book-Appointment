<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.UUID" %>

<%
String username = request.getParameter("username");
String name = request.getParameter("name");
int age = Integer.parseInt(request.getParameter("age"));
String issue = request.getParameter("issue");
String mobile = request.getParameter("mobile"); // Added mobile field
String specialist = request.getParameter("specialty");
String doctor = request.getParameter("doctor");
String date = request.getParameter("date");
int fee = Integer.parseInt(request.getParameter("fee"));
String transactionId = UUID.randomUUID().toString().substring(0, 10); // Generate a unique transaction ID
String doctorId = request.getParameter("doctorId");
String status = request.getParameter("status");

Connection conn = null;
PreparedStatement statement = null;
ResultSet rs = null;
try {
    // Load the Oracle JDBC driver
    Class.forName("oracle.jdbc.driver.OracleDriver");
    conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "yash", "455664");

    // Create a SQL query to insert the data into the appointments table
    String sql = "INSERT INTO appointments (username, name, age, issue, mobile, specialist, doctor, day, fee, transaction_id, doctor_id, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    statement = conn.prepareStatement(sql);
    statement.setString(1, username);
    statement.setString(2, name);
    statement.setInt(3, age);
    statement.setString(4, issue);
    statement.setString(5, mobile); // Set mobile field
    statement.setString(6, specialist);
    statement.setString(7, doctor);
    statement.setString(8, date);
    statement.setInt(9, fee);
    statement.setString(10, transactionId);
    statement.setString(11, doctorId);
    statement.setString(12, status);

    // Execute the query
    int rowsInserted = statement.executeUpdate();

    // Check if the data was inserted successfully
    if (rowsInserted > 0) {
        out.println("<script>alert('Appointment booked successfully!'); window.location.href='all-appointments.jsp';</script>");
    } else {
        out.println("<h1>Error booking appointment!</h1>");
    }
} catch (SQLException e) {
    if (e.getMessage().contains("ORA-20001")) {
        out.println("<script>alert('Appointments are full for the selected day. Please choose another date.');</script>");
    } else {
        out.println("<h1>Error: " + e.getMessage() + "</h1>");
        e.printStackTrace();
    }
} catch (Exception e) {
    out.println("<h1>Error: " + e.getMessage() + "</h1>");
    e.printStackTrace();
} finally {
    try {
        if (rs != null) {
            rs.close();
        }
        if (statement != null) {
            statement.close();
        }
        if (conn != null) {
            conn.close();
        }
    } catch (SQLException e) {
        out.println("<h1>Error closing resources: " + e.getMessage() + "</h1>");
        e.printStackTrace();
    }
}
%>
