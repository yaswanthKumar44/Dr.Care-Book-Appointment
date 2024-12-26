<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.sql.*,javax.sql.*,javax.naming.*,java.io.*,javax.servlet.*" %>

<%
    String doctorId = request.getParameter("doctorId");
    String password = request.getParameter("password");

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "yash", "455664");

        ps = con.prepareStatement("SELECT * FROM doctors WHERE doctor_id = ? AND password = ?");
        ps.setString(1, doctorId);
        ps.setString(2, password);

        rs = ps.executeQuery();

        if (rs.next()) {
            // Doctor login successful, set attributes including password
            request.getSession().setAttribute("doctorId", rs.getString("doctor_id"));
            request.getSession().setAttribute("doctorName", rs.getString("doctor_name"));
            request.getSession().setAttribute("email", rs.getString("email"));
            request.getSession().setAttribute("password", rs.getString("password"));
            request.getSession().setAttribute("address", rs.getString("address"));
            request.getSession().setAttribute("age", rs.getInt("age"));
            request.getSession().setAttribute("gender", rs.getString("gender"));
            request.getSession().setAttribute("mobile", rs.getString("mobile"));
            request.getSession().setAttribute("experience", rs.getString("experience"));
            request.getSession().setAttribute("specialist", rs.getString("specialist"));
            request.getSession().setAttribute("availabilityStatus", rs.getString("availability_status"));
            request.getSession().setAttribute("dateOfLeave1", rs.getDate("date_of_leave1"));
            request.getSession().setAttribute("dateOfLeave2", rs.getDate("date_of_leave2"));
            request.getSession().setAttribute("dateOfLeave3", rs.getDate("date_of_leave3"));
            
            // Redirect to profile.jsp
            response.sendRedirect("doctor-profile.jsp");
        } else {
            // User does not exist in the database, display login failed message
            out.println("<script>alert('Login failed. Please check your Doctor-Id and password.'); window.location='doctor-login.html';</script>");
        }
    } catch (SQLException e) {
        out.println("<h1>Database error. Please try again later.</h1>");
        e.printStackTrace(); // Log the exception details
    } catch (Exception e) {
        out.println("<h1>An unexpected error occurred.</h1>");
        e.printStackTrace(); // Log the exception details
    } finally {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (ps != null) {
            try {
                ps.close();
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
%>
