<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.sql.*,javax.sql.*,javax.naming.*" %>

<%
    String doctorName = request.getParameter("doctorName");
    String email = request.getParameter("email");
    String doctorId = request.getParameter("doctorId");
    String password = request.getParameter("password");
    String address = request.getParameter("address");
    int age = Integer.parseInt(request.getParameter("age"));
    String gender = request.getParameter("gender");
    String mobile = request.getParameter("mobile");
    int experience = Integer.parseInt(request.getParameter("experience"));
    String specialist = request.getParameter("specialist");
    String availabilityStatus = request.getParameter("availabilityStatus");
    String dateOfLeave1 = request.getParameter("dateOfLeave1");
    String dateOfLeave2 = request.getParameter("dateOfLeave2");
    String dateOfLeave3 = request.getParameter("dateOfLeave3");

    Connection con = null;
    PreparedStatement ps = null;
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "yash", "455664");

        ps = con.prepareStatement("INSERT INTO doctors (doctor_name, email, doctor_id, password, address, age, gender, mobile, experience, specialist, availability_status, date_of_leave1, date_of_leave2, date_of_leave3) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        ps.setString(1, doctorName);
        ps.setString(2, email);
        ps.setString(3, doctorId);
        ps.setString(4, password);
        ps.setString(5, address);
        ps.setInt(6, age);
        ps.setString(7, gender);
        ps.setString(8, mobile);
        ps.setInt(9, experience);
        ps.setString(10, specialist);
        ps.setString(11, availabilityStatus);
        ps.setString(12, dateOfLeave1);
        ps.setString(13, dateOfLeave2);
        ps.setString(14, dateOfLeave3);

        int rowsAffected = ps.executeUpdate();

        if (rowsAffected > 0) {
            // Display alert message
            out.println("<script>alert('Doctor added successfully'); window.location='doctors.jsp';</script>");
        }
    } catch (ClassNotFoundException e) {
        out.println("<script>alert('Error: Oracle JDBC Driver not found');</script>");
        e.printStackTrace();
    } catch (SQLException e) {
        if (e.getErrorCode() == 1) {
            // Unique constraint violation, doctor ID already exists
            out.println("<script>alert('Doctor ID Already exist change Doctor ID');</script>");
           
        } else {
            // Other SQL Exception
            out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
        }
        e.printStackTrace();
    }
    
    finally {
        if (ps != null) {
            try {
                ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
            }
        }
        if (con != null) {
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
            }
        }
    }
%>
