<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.*,java.util.UUID" %>

<%
String username = (String)session.getAttribute("username");
String name = request.getParameter("name");
int age = Integer.parseInt(request.getParameter("age"));
String issue = request.getParameter("issue");
String mobile = request.getParameter("mobile");
String specialist = request.getParameter("specialty");
String doctorIdStr = request.getParameter("doctorId");
String date = request.getParameter("date");
int fee = Integer.parseInt(request.getParameter("fee"));
String transactionId = UUID.randomUUID().toString().substring(0, 10);
String status = request.getParameter("status");

Connection conn = null;
PreparedStatement statement = null;
try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "yash", "455664");

    String sql = "INSERT INTO appointments (username, name, age, issue, mobile, specialist, doctor, day, fee, transaction_id, doctor_id, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    statement = conn.prepareStatement(sql);
    statement.setString(1, username);
    statement.setString(2, name);
    statement.setInt(3, age);
    statement.setString(4, issue);
    statement.setString(5, mobile);
    statement.setString(6, specialist);
    statement.setString(7, doctorIdStr);
    statement.setString(8, date);
    statement.setInt(9, fee);
    statement.setString(10, transactionId);
    statement.setString(11, doctorIdStr);
    statement.setString(12, status);

    int rowsInserted = statement.executeUpdate();

    if (rowsInserted > 0) {
        out.println("<script>alert('Appointment booked successfully!'); window.location.href='appointments.jsp';</script>");
    } else {
        out.println("<h1>Error booking appointment!</h1>");
    }
} catch (SQLException e) {
    if (e.getMessage().contains("ORA-20001")) {
        out.println("<script>alert('Appointments are full for the selected day. Please choose another date.');</script>");
    } else {
        out.println("<script>alert('Error booking appointment: " + e.getMessage() + "');</script>");
    }
} catch (Exception e) {
    out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
    e.printStackTrace();
} finally {
    try {
        if (statement != null) {
            statement.close();
        }
        if (conn != null) {
            conn.close();
        }
    } catch (SQLException e) {
        out.println("<script>alert('Error closing resources: " + e.getMessage() + "');</script>");
        e.printStackTrace();
    }
}
%>
