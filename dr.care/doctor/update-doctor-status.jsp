<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.sql.*,javax.sql.*,javax.naming.*,java.io.*,javax.servlet.*" %>

<%
    Connection con = null;
    PreparedStatement ps = null;

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "yash", "455664");

        String doctorId = (String) session.getAttribute("doctorId");
        String status = request.getParameter("status");
        String dateOfLeave1 = request.getParameter("dateOfLeave1");
        String dateOfLeave2 = request.getParameter("dateOfLeave2");
        String dateOfLeave3 = request.getParameter("dateOfLeave3");

        // Update the doctor's status and dates of leave in the database
        ps = con.prepareStatement("UPDATE doctors SET availability_status=?, date_of_leave1=?, date_of_leave2=?, date_of_leave3=? WHERE doctor_id=?");
        ps.setString(1, status);
        ps.setString(2, dateOfLeave1);
        ps.setString(3, dateOfLeave2);
        ps.setString(4, dateOfLeave3);
        ps.setString(5, doctorId);

        ps.executeUpdate();

        out.println("<script>alert('Doctor Status updated successfully'); window.location='doctor-status.jsp';</script>");
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        try {
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            out.println("<p>Error closing resources: " + e.getMessage() + "</p>");
        }
    }
%>
