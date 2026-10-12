
<%@ page import="java.sql.*" %>
<%
    String userName = request.getParameter("userName");
    String password = request.getParameter("password");
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String email = request.getParameter("email");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        String dbHost = System.getenv("DB_HOST");
        String dbName = System.getenv("DB_NAME");
        String dbUser = System.getenv("DB_USER");
        String dbPassword = System.getenv("DB_PASSWORD");

        String url = "jdbc:mysql://" + dbHost + ":3306/" + dbName;

        try (Connection con = DriverManager.getConnection(
                url, dbUser, dbPassword);
             PreparedStatement ps = con.prepareStatement(
                "INSERT INTO USER (first_name, last_name, email, username, password, regdate) VALUES (?, ?, ?, ?, ?, CURDATE())")) {

            ps.setString(1, firstName);
            ps.setString(2, lastName);
            ps.setString(3, email);
            ps.setString(4, userName);
            ps.setString(5, password);

            int result = ps.executeUpdate();

            if (result > 0) {
                response.sendRedirect("welcome.jsp");
            } else {
                response.sendRedirect("index.jsp");
            }
        }
    } catch (Exception e) {
        application.log("Registration database error", e);
        response.sendError(500, "Unable to process your registration.");
    }
%>
