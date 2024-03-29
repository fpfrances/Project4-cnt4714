<!DOCTYPE html>
<%-- Start servlet --%>
<%
String textBox = (String) session.getAttribute("textBox");
String message = (String) session.getAttribute("message");
if (message == null) { message = ""; }
if (textBox == null) { textBox = null; }
%>
<%-- End servlet --%>
<html>
    <head>
        <title>Project 4</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            h1 {
		        font-family: Arial, sans-serif;
                font-size: 34px;
	        	color: #e6f516;
	        	text-align: default;
	        }
            h2 {
                font-family: Arial, sans-serif;
                font-size: 30px;
                color: #00ff15;
                text-align: default;
            }
            h3 {
                font-family: Arial, sans-serif;
                font-size: 14px;
                color: white;
                background-color: red;
                text-align: default;
            }
            h4 {
                font-family: Arial, sans-serif;
                font-size: 14px;
                color: black;
                background-color: #00ff15;
                text-align: default;
            }
            p {
		        font-family: Arial, sans-serif;
		        font-size: 14px;
	            text-align: default;
		        color: #ffffff;
 	        }
            mark.red {
                color:#ff0000;
                background: none;
            }
            textarea {
                font-family: Arial, sans-serif;
                font-size: 14px;
                color:white;
                background:blue;
            }
            .submitbutton {
                font-family: Arial, sans-serif;
                font-size: 20px;
                text-align: default;
                background: #767575;
                color: #07f61f;
            }
            .resetbutton {
                font-family: Arial, sans-serif;
                font-size: 20px;
                text-align: default;
                background: #767575;
                color: #ff0000;
            }
            .clearbutton {
                font-family: Arial, sans-serif;
                font-size: 20px;
                text-align: default;
                background: #767575;
                color: #daf607;
            }
            th {
                border: 1px solid #000000;
                background-color: #ff0000;
                text-align: center;
                padding: 6px;
            }
            td {
                border: 1px solid #000000;
                text-align: center;
                padding: 6px;
            }
            tr:nth-child(odd) {
                background-color: #DCDCDC;
            }
            tr:nth-child(even) {
                background-color: #F8F8FF;
            }
        </style>
    </head>
    <body style="background-color: black;">
        <div style="text-align: center;">
            <h1>Welcome to the Spring 2023 Project 4 Enterprise Database System</h1>
            <h2>A Servlet/JSP-based Multi-tiered Enterprise Application Using A Tomcat Container</h2>
            <hr>
            <p>You are connected to the Project 4 Enterprise System database as a <mark class = "red">root-level</mark> user.</p>
            <p>Please enter any valid SQL query or update command in the box below.</p>
	        <br>
            <form method="post" action="/Project4/RootUserServlet">
            <textarea name="textBox" id="textBox" rows="20" cols="120"></textarea>
            <br>
	    	<br>
            <input type="submit" value="Execute Command" class="submitbutton" style="margin-right: 20px;">
	    	<input type="reset" onClick="resetForm();" value="Reset Form" class="resetbutton" style="margin-right: 20px;">
	    	<input type="button" onClick="resetResult();" value="Clear Results" class="clearbutton" style="margin-right: 20px;">
            </form>

            <br>
            <p>All execution results will appear below this line.</p>
            <hr>
            <p><b>Database Results:</b></p>
            <div id="databaseResult" class="block p-6 my-6 rounded-lg shadow-lg bg-green-400 max-w-2xl">
                <center><%=message%></center>
            </div>

            <div class="mb-16 text-sm tracking-tight">
                <script>
                    function resetForm() {
                        document.getElementById("textBox").innerHTML = '';
                    }
                    function resetResult() {
                        document.getElementById("databaseResult").innerHTML = '';
                    }
                </script>
            </div>
        </div>
    </body>
</html>