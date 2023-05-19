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

public class RootUserServlet extends HttpServlet {
    private Connection connection;
    private Statement statement;


    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String textBox = request.getParameter("textBox");
        String message = null;

        if (textBox != null) {
            getDBConnection();
            if (textBox.contains("select")) {
                try {
                    message = doSelectQuery(textBox);
                } catch (SQLException error) {
                    StringBuilder html = new StringBuilder();
                    html.append("<table><tr><td align=\"center\" style=\"background-color: red;\">");
                    html.append("<h3 style='text-align: left;'><span class='font-bold'> Error executing the SQL statement:</span></h3>");
                    html.append("<h3 style='text-align: left;'>" + error.getMessage() + "</h3>");
                    html.append("</td></tr></table>");
                    message = html.toString();
                    error.printStackTrace();
                }

            } else {
                try {
                    message = doUpdateQuery(textBox);
                } catch (SQLException error) {
                    StringBuilder html = new StringBuilder();
                    html.append("<table><tr><td align=\"center\" style=\"background-color: red;\">");
                    html.append("<h3 style='text-align: left;'><span class='font-bold'> Error executing the SQL statement:</span></h3>");
                    html.append("<h3 style='text-align: left;'>" + error.getMessage() + "</h3>");
                    html.append("</td></tr></table>");
                    message = html.toString();
                    error.printStackTrace();
                }
            }
        }

        HttpSession session = request.getSession();
        session.setAttribute("message", message);
        session.setAttribute("textBox", textBox);
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/rootHome.jsp");
        dispatcher.forward(request, response);
    }

    private String doSelectQuery(String textBox) throws SQLException {
        String result;

        ResultSet table = statement.executeQuery(textBox);
        ResultSetMetaData metaData = table.getMetaData();

        int numOfColumns = metaData.getColumnCount();
        String tableOpeningHTML = "<table class='w-full text-left'>";
        String tableColumnsHTML = "<thead><tr>";
        for (int i = 1; i <= numOfColumns; i++) {
            tableColumnsHTML += "<th class='text-lg'>" + metaData.getColumnName(i) + "</th>";
        }
        tableColumnsHTML += "</tr></thead>";

        String tableBodyHTML = "<tbody>";
        int counter = 1;
        while (table.next()) {
            if (counter % 2 == 0) {
                tableBodyHTML += "<tr>";
            } else {
                tableBodyHTML += "<tr>";
            }
            for (int i = 1; i <= numOfColumns; i++) {
                tableBodyHTML += "<td class='p-1'>" + table.getString(i) + "</td>";
            }
            tableBodyHTML += "</tr>";
            counter += 1;
        }

        tableBodyHTML += "</tbody></table>";
        result = tableOpeningHTML + tableColumnsHTML + tableBodyHTML;
        return result;
    }

    private String doUpdateQuery(String textBox) throws SQLException {
        String result = null;
        int rowsAffected = 0;
        int rowsUpdated = 0;
        int quantity = 0;

        rowsAffected = statement.executeUpdate(textBox);
        StringBuilder html = new StringBuilder();
        html.append("<table><tr><td align=\"center\" style=\"background-color: #00ff15;\">");

        if (textBox.contains("shipments") || textBox.contains("suppliers") || textBox.contains("jobs") || textBox.contains("parts")) {
            rowsUpdated = statement.getUpdateCount();
            String[] check = textBox.split(",");
            if (check.length == 4) {
                try {
                    quantity = Integer.parseInt(check[3].replaceAll("[^\\d]", ""));
                } catch (NumberFormatException e) {
                    System.err.println("Error: Quantity must be an integer value.");
                }
            }

            if (textBox.contains("shipments") && textBox.contains("pnum = 'P3'")) {
                html.append("<h4>The statement executed successfully.</h4>");
                html.append("<h4>" + rowsAffected + "</span> row(s) affected.</h4>");
                html.append("<h4>Business Logic Detected! - Updating Supplier Status</h4>");
                html.append("<h4>Business Logic updated <span class='font-bold'>");
                html.append(rowsUpdated + "</span> shipment(s).</h4>");
            } else if (quantity >= 100) {
                statement.executeUpdate("UPDATE project4.suppliers SET status = status + 5 WHERE snum = 'S5'");
                html.append("<h4>The statement executed successfully.</h4>");
                html.append("<h4>" + rowsAffected + "</span> row(s) affected.</h4>");
                html.append("<h4>Business Logic Detected! - Updating Supplier Status</h4>");
                html.append("<h4>Business Logic updated <span class='font-bold'>");
                html.append(rowsUpdated + "</span> supplier status marks.</h4>");
            } else {
                html.append("<h4>The statement executed successfully. ");
                html.append("A total of " + rowsAffected + " row(s) were updated.</h4>");
                html.append("<h4>Business Logic Not Triggered! </h4><span class='font-bold'>");
            }
        }
        html.append("</span></h4></td>");
        html.append("</tr></table>");
        result = html.toString();
        return result;
    }

        private void getDBConnection () throws ServletException {
            Properties props = new Properties();
            try {
                FileInputStream in = new FileInputStream("C:/Program Files/Apache Software Foundation/Tomcat 10.1/webapps/Project4/WEB-INF/lib/root.properties");
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