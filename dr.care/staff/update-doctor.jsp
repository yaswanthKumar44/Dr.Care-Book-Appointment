<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "yash", "455664");

        String doctorId = request.getParameter("doctorId");
        String doctorName = request.getParameter("doctorName");
        String gender = request.getParameter("gender");
        String specialization = request.getParameter("specialization");
        String experience = request.getParameter("experience");
        String availability = request.getParameter("availability");
        String date1 = request.getParameter("date1");
        String date2 = request.getParameter("date2");
        String date3 = request.getParameter("date3");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String age = request.getParameter("age");

        String query = "UPDATE doctors SET DOCTOR_NAME=?, GENDER=?, SPECIALIST=?, EXPERIENCE=?, AVAILABILITY_STATUS=?, DATE_OF_LEAVE1=?, DATE_OF_LEAVE2=?, DATE_OF_LEAVE3=?, EMAIL=?, MOBILE=?, AGE=? WHERE DOCTOR_ID=?";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setString(1, doctorName);
        pstmt.setString(2, gender);
        pstmt.setString(3, specialization);
        pstmt.setString(4, experience);
        pstmt.setString(5, availability);
        pstmt.setString(6, date1);
        pstmt.setString(7, date2);
        pstmt.setString(8, date3);
        pstmt.setString(9, email);
        pstmt.setString(10, mobile);
        pstmt.setString(11, age);
        pstmt.setString(12, doctorId);

        int rowsUpdated = pstmt.executeUpdate();
        if (rowsUpdated > 0) {
            out.println("<script>alert('Doctor Profile updated successfully'); window.location='doctors.jsp';</script>");
        } else {
            out.println("<script>alert('Failed to update doctor details');</script>");
        }

        pstmt.close();
        conn.close();
    } catch (Exception e) {
        out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
    }
%>
