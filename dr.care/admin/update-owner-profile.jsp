<%@ page import="java.sql.*,java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Admin Profile</title>
    <script>
        function redirectToProfile() {
            window.location.href = "owner-profile.jsp";
        }

        function showAlert(message) {
            alert(message);
        }

        function updateProfile() {
            showAlert("Profile updated successfully");
            setTimeout(() => {
                redirectToProfile();
            }, 0); // Redirect after 1.5 seconds
        }
    </script>
</head>
<body>
   
    <%
        String ownerId = (String) session.getAttribute("ownerId");
        if (ownerId != null) {
            String fullname = request.getParameter("fullname");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            int age = Integer.parseInt(request.getParameter("age"));
            String gender = request.getParameter("gender");
            String mobile = request.getParameter("mobile");
            String password = request.getParameter("password");

            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                try (Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "yash", "455664")) {
                    String query = "UPDATE owners SET fullname=?, email=?, address=?, age=?, gender=?, mobile=?, password=? WHERE owner_id=?";
                    try (PreparedStatement pst = con.prepareStatement(query)) {
                        pst.setString(1, fullname);
                        pst.setString(2, email);
                        pst.setString(3, address);
                        pst.setInt(4, age);
                        pst.setString(5, gender);
                        pst.setString(6, mobile);
                        pst.setString(7, password); // Consider hashing the password for security
                        pst.setString(8, ownerId);

                        int rowsUpdated = pst.executeUpdate();
                        if (rowsUpdated > 0) {
    %>
                            <script>
                                updateProfile();
                            </script>
    <%
                        } else {
    %>
                            <p>Failed to update profile</p>
    <%
                        }
                    }
                }
            } catch (SQLException | ClassNotFoundException e) {
                out.println("<h1>Error: " + e.getMessage() + "</h1>");
                e.printStackTrace();
            }
        } else {
    %>
            <p>Admin ID not found in session</p>
    <%
        }
    %>
</body>
</html>
