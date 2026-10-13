
<%@ page import="java.sql.*" %>
<%
String userName = request.getParameter("userName");
String password = request.getParameter("password");
String firstName = request.getParameter("firstName");
String lastName = request.getParameter("lastName");
String email = request.getParameter("email");

try {
    Class.forName("com.mysql.cj.jdbc.Driver");

    String url = "jdbc:mysql://" + System.getenv("DB_HOST")
               + ":3306/" + System.getenv("DB_NAME");

    try (Connection con = DriverManager.getConnection(
            url, System.getenv("DB_USER"), System.getenv("DB_PASSWORD"));
         PreparedStatement ps = con.prepareStatement(
            "INSERT INTO USER (first_name, last_name, email, username, password, regdate) VALUES (?, ?, ?, ?, ?, CURDATE())")) {

        ps.setString(1, firstName);
        ps.setString(2, lastName);
        ps.setString(3, email);
        ps.setString(4, userName);
        ps.setString(5, password);

        if (ps.executeUpdate() > 0) {
            response.sendRedirect("welcome.jsp");
        } else {
            response.sendRedirect("index.jsp");
        }
    }
} catch (Exception e) {
    application.log("Registration failed", e);
    response.sendError(500, "Registration failed. Please try again.");
}
%>

