
<%@ page import="java.sql.*" %>
<%
String userName = request.getParameter("userName");
String password = request.getParameter("password");

try {
    Class.forName("com.mysql.cj.jdbc.Driver");

    String url = "jdbc:mysql://" + System.getenv("DB_HOST")
               + ":3306/" + System.getenv("DB_NAME");

    try (Connection con = DriverManager.getConnection(
            url, System.getenv("DB_USER"), System.getenv("DB_PASSWORD"));
         PreparedStatement ps = con.prepareStatement(
            "SELECT * FROM USER WHERE username=? AND password=?")) {

        ps.setString(1, userName);
        ps.setString(2, password);

        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                session.setAttribute("userName", userName);
                response.sendRedirect("success.jsp");
            } else {
                out.println("Invalid password <a href='index.jsp'>Try again</a>");
            }
        }
    }
} catch (Exception e) {
    application.log("Login failed", e);
    response.sendError(500, "Login failed. Please try again.");
}
%>

