<%@ page import="java.sql.*" %>
<%
String usern = request.getParameter("username");
String pass = request.getParameter("password");

try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    try (Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "yash", "455664")) {
        String query = "SELECT fullname,email,address,age,gender,mobile,password FROM users WHERE username=? AND password=?";
        try (PreparedStatement pst = con.prepareStatement(query)) {
            pst.setString(1, usern);
            pst.setString(2, pass);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    // User exists in the database, set session attributes and redirect to home page
                    String fullName = rs.getString("fullname");
                    String email = rs.getString("email");
                    String address = rs.getString("address");
                    String age = rs.getString("age");
                    String gender = rs.getString("gender");
                    String mobile = rs.getString("mobile");
                    String password = rs.getString("password");

                    session.setAttribute("fullname", fullName);
                    session.setAttribute("email", email);
                    session.setAttribute("address", address);
                    session.setAttribute("age", age);
                    session.setAttribute("gender", gender);
                    session.setAttribute("mobile", mobile);
                    session.setAttribute("username", usern);
                    session.setAttribute("password", password);

                    response.sendRedirect("profile.jsp"); // Redirect to profile page
                } else {
                    // User does not exist in the database, display login failed message
                    out.println("<script>alert('Login failed. Please check your username and password.'); window.location='login.html';</script>");
                }
            }
        }
    }
} catch (SQLException e) {
    out.println("<h1>Database error. Please try again later.</h1>");
    e.printStackTrace(); // Log the exception details
} catch (Exception e) {
    out.println("<h1>An unexpected error occurred.</h1>");
    e.printStackTrace(); // Log the exception details
}
%>
