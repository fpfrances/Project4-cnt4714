/* Name: Filipe Pestana Frances
Course: CNT 4714 – Spring 2023 – Project Four
Assignment title: A Three-Tier Distributed Web-Based Application
Date: April 23, 2023
*/
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.util.Properties;
import java.io.*;
import java.sql.*;

public class SuppliersInsertServlet extends HttpServlet {
    private Connection connection;
    private Statement statement;
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String snum = request.getParameter("snum");
        String sname = request.getParameter("sname");
        String status = request.getParameter("status");
        String city = request.getParameter("city");
        String message = "";

        try {
            if (statement == null) {
                getDBConnection();
            }
            statement.executeUpdate("INSERT INTO project4.suppliers" + " (snum, sname, status, city) VALUES " + " ('" + snum + "', '" + sname + "', '" + status + "', '" + city + "');");
            StringBuilder html = new StringBuilder();
            html.append("<table style='border: 2px solid red;'><tr><td class='font-bold' style='font-size: 14px; padding: 8px; font-weight: bold; color: #FFFFFF; background-color: green;'>");
            html.append("New suppliers record:" + " (" + snum + ", " + sname + ", " + status + ", " + city + ") - ");
            html.append("sucessfully entered into database. </td></tr></font></table>");
            message = html.toString();

        } catch (SQLException error) {
            StringBuilder html = new StringBuilder();
            html.append("<table style='border: 2px solid red;'><tr><td class='font-bold' style='font-size: 14px; padding: 10px; font-weight: bold; color: #FFFFFF; background-color: red;'>");
            html.append("Error executing the SQL statement:<br>");
            html.append(error.getMessage());
            html.append("</td></tr></table>");
            message = html.toString();
            error.printStackTrace();
        }

        request.setAttribute("message", message);
        request.getRequestDispatcher("/dataentryHome.jsp").forward(request, response);
    }

    public void getDBConnection() throws ServletException {
        Properties props = new Properties();
        try {
            FileInputStream in = new FileInputStream("C:/Program Files/Apache Software Foundation/Tomcat 10.1/webapps/Project4/WEB-INF/lib/data.properties");
            props.load(in);
            in.close();
        } catch (IOException e) {
            throw new ServletException("Cannot load database properties", e);
        }

        String driver = props.getProperty("MYSQL_DB_DRIVER_CLASS");
        String url = props.getProperty("MYSQL_DB_URL");
        String dbUsername = props.getProperty("MYSQL_DB_USERNAME");
        String dbPassword = props.getProperty("MYSQL_DB_PASSWORD");

        try {
            Class.forName(driver);
            connection = DriverManager.getConnection(url, dbUsername, dbPassword);
            statement = connection.createStatement();
        } catch (ClassNotFoundException e) {
            throw new ServletException("Cannot load JDBC driver", e);
        } catch (SQLException e) {
            throw new ServletException("Cannot connect to database", e);
        }
    }
}