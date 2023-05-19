/* Name: Filipe Pestana Frances
Course: CNT 4714 – Spring 2023 – Project Four
Assignment title: A Three-Tier Distributed Web-Based Application
Date: April 23, 2023
*/
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.util.Scanner;

public class AuthenticationServlet extends HttpServlet {

    // Process get request from client
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String inBoundUsername = request.getParameter("name");
        String inBoundPassword = request.getParameter("password");
        File credentialsFile = new File("C:/Program Files/Apache Software Foundation/Tomcat 10.1/webapps/Project4/WEB-INF/lib/credentials.txt");

        // Initialize FileReader, BufferedReader, and Scanner objects
        FileReader fileReader = null;
        BufferedReader bufferedReader = null;
        Scanner scanner = null;
        String credentials = null;
        boolean userCredentialsOK = false;

        try {
            fileReader = new FileReader(credentialsFile);
            bufferedReader = new BufferedReader(fileReader);
            scanner = new Scanner(bufferedReader);

            // Read the first line from credentials file
            if (scanner.hasNextLine()) {
                credentials = scanner.nextLine();
            }

            // While loop
            while (credentials != null && !userCredentialsOK) {
                // Loop until credentials match or EOF
                String[] usernamePassword = credentials.split(":");

                // Check if username and password match
                if (inBoundUsername.equals(usernamePassword[0]) && inBoundPassword.equals(usernamePassword[1])) {
                    userCredentialsOK = true;
                    break;
                } else if (scanner.hasNextLine()) {
                    // Read next line in file
                    credentials = scanner.nextLine();
                } else {
                    // No more lines in file
                    credentials = null;
                }
            }
        } catch (FileNotFoundException fileNotFoundException) {
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<html><body><h1>Error: File not found</h1></body></html>");
            return;
        } finally {
            if (scanner != null) {
                scanner.close();
            }
            if (bufferedReader != null) {
                bufferedReader.close();
            }
            if (fileReader != null) {
                fileReader.close();
            }
        }

        if (userCredentialsOK) {
            // Inbound user credentials matched those in credentials file - apply appropriate redirection
            if (inBoundUsername.equals("root")) {
                // Redirect to root page
                response.sendRedirect("rootHome.jsp");
            } else if (inBoundUsername.equals("client")) {
                // Redirect to user page
                response.sendRedirect("clientHome.jsp");
            } else if (inBoundUsername.equals("dataentry")) {
                // Redirect to dataentry page
                response.sendRedirect("dataentryHome.jsp");
            }
        } else {
            // User credentials match failed - access denied - redirect to error page
            response.sendRedirect("errorpage.html");
        }
    }
}