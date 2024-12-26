<%@ page import="java.sql.*, java.io.*" %>
<%
String username = (String) session.getAttribute("username"); // Assuming username is stored in session
String password = (String) session.getAttribute("password"); // Assuming password is stored in session

if (username != null && password != null) {
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        try (Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "yash", "455664")) {
            boolean updated = false; // Flag to track if any field is updated

            // Update name
            String name = request.getParameter("name");
            if (name != null && !name.isEmpty()) {
                String query = "UPDATE users SET fullname=? WHERE username=?";
                try (PreparedStatement pst = con.prepareStatement(query)) {
                    pst.setString(1, name);
                    pst.setString(2, username);
                    pst.executeUpdate();
                }
                updated = true;
            }

            // Update email
            String email = request.getParameter("email");
            if (email != null && !email.isEmpty()) {
                String query = "UPDATE users SET email=? WHERE username=?";
                try (PreparedStatement pst = con.prepareStatement(query)) {
                    pst.setString(1, email);
                    pst.setString(2, username);
                    pst.executeUpdate();
                }
                updated = true;
            }

            // Update password
            String newPassword = request.getParameter("password");
            if (newPassword != null && !newPassword.isEmpty()) {
                String query = "UPDATE users SET password=? WHERE username=?";
                try (PreparedStatement pst = con.prepareStatement(query)) {
                    pst.setString(1, newPassword);
                    pst.setString(2, username);
                    pst.executeUpdate();
                }
                updated = true;
            }

            // Update address
            String address = request.getParameter("address");
            if (address != null && !address.isEmpty()) {
                String query = "UPDATE users SET address=? WHERE username=?";
                try (PreparedStatement pst = con.prepareStatement(query)) {
                    pst.setString(1, address);
                    pst.setString(2, username);
                    pst.executeUpdate();
                }
                updated = true;
            }

            // Update age
            String ageStr = request.getParameter("age");
            if (ageStr != null && !ageStr.isEmpty()) {
                int age = Integer.parseInt(ageStr);
                if (age >= 18 && age <= 150) {
                    String query = "UPDATE users SET age=? WHERE username=?";
                    try (PreparedStatement pst = con.prepareStatement(query)) {
                        pst.setInt(1, age);
                        pst.setString(2, username);
                        pst.executeUpdate();
                    }
                    updated = true;
                   
                } else {
                    out.println("<script>alert('Please enter an age between 18 and 150');</script>");
                }
            }

            // Update gender
            String gender = request.getParameter("gender");
            if (gender != null && !gender.isEmpty()) {
                String query = "UPDATE users SET gender=? WHERE username=?";
                try (PreparedStatement pst = con.prepareStatement(query)) {
                    pst.setString(1, gender);
                    pst.setString(2, username);
                    pst.executeUpdate();
                }
                updated = true;
               
            }

            // Update mobile
            String mobile = request.getParameter("mobile");
            if (mobile != null && !mobile.isEmpty()) {
                if (mobile.matches("\\d{10}")) {
                    String query = "UPDATE users SET mobile=? WHERE username=?";
                    try (PreparedStatement pst = con.prepareStatement(query)) {
                        pst.setString(1, mobile);
                        pst.setString(2, username);
                        pst.executeUpdate();
                    }
                    updated = true;
                  
                } else {
                    out.println("<script>alert('Please enter a valid 10-digit mobile number');</script>");
                }
            }

            // Display profile updated message and redirect to profile.jsp
            if (updated) {
                out.println("<script>alert('Profile updated successfully'); window.location='profile.jsp';</script>");

            }
        } catch (SQLException e) {
            out.println("<script>alert('Database error. Please try again later.');</script>");
            out.println("<p>Error details: " + e.getMessage() + "</p>");
            e.printStackTrace(); // Log the exception details
        }
    } catch (ClassNotFoundException e) {
        out.println("<script>alert('Database driver not found.');</script>");
        out.println("<p>Error details: " + e.getMessage() + "</p>");
        e.printStackTrace(); // Log the exception details
    }
} else {
    out.println("<script>alert('Username or password not found in session. Please log in again.');</script>");
}
%>
