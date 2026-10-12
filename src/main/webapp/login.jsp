
<%@ page import="java.sql.*" %>
<%
    String userName = request.getParameter("userName");
    String password = request.getParameter("password");

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
                "SELECT * FROM USER WHERE username = ? AND password = ?")) {

            ps.setString(1, userName);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    session.setAttribute("userName", userName);
                    response.sendRedirect("success.jsp");
                } else {
                    out.println("Invalid username or password. "
                        + "<a href='index.jsp'>Try again</a>");
                }
            }
        }
    } catch (Exception e) {
        application.log("Login database error", e);
        response.sendError(500, "Unable to process your login request.");
    }
%>

