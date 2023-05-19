<!DOCTYPE html>
<%-- Start servlet --%>
<%
    Object message = request.getAttribute("message");
    if (message == null) { message = ""; }
%>
<%-- End servlet --%>
<html>
<head>
    <title>Welcome to the Spring 2023 Project 4 Enterprise Database System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        h1 {
            font-family: Arial, sans-serif;
            font-size: 34px;
            color: #ff0000;
            text-align: default;
        }
        h2 {
            font-family: Arial, sans-serif;
            font-size: 30px;
            color: #00faff;
            text-align: default;
        }
        h3 {
            font-family: Arial, sans-serif;
            font-size: 14px;
            color: white;
            background-color: red;
            text-align: default;
        }
        p {
            font-family: Arial, sans-serif;
            font-size: 14px;
            text-align: default;
            color: #ffffff;
        }
        .clearbutton {
            font-family: Arial, sans-serif;
            font-size: 18px;
            text-align: default;
            color: #ff0000;
            background: #696969;
        }
        .submitbutton {
            font-family: Arial, sans-serif;
            font-size: 18px;
            text-align: default;
            color: #07f61f;
            background: #696969;
        }
        mark.red {
            color:#ff0000;
            background: none;
        }
        .queryinput {
            color: #ffffff;
            background: #000000;
            font-family: Arial, sans-serif;
            font-size: 18px;
            border:solid 1px #87CEFA;

        }
        .queryheader {
            color: #000000;
            background: #87CEFA;
            font-family: Arial, sans-serif;
            font-size: 18px;
            text-align: center;
            border:solid 1px #87CEFA;
        }
    </style>
</head>
<body style="background-color: black;">
<center>
    <h1>Welcome to the Spring 2023 Project 4 Enterprise Database System</h1>
    <h2>Data Entry Application</h2>
    <hr>
    <p>You are connected to the Project 4 Enterprise System database as a <mark class = "red">data-entry-level</mark> user.</p>
    <p>Please enter the data values in the form below to add a new record to the shipments table.</p>
    <hr>
    <br>
    <fieldset style="border: 3px solid white; border-radius: 10px;">
        <legend style="color: white;"><b>Suppliers Record Insert</b></legend>
        <br>
        <form method="post" action="/Project4/SuppliersInsertServlet">
            <table>
                <tr>
                    <td><textarea readonly rows="1" cols="20" class="queryheader">snum</textarea></td>
                    <td><textarea readonly rows="1" cols="20" class="queryheader">pname</textarea></td>
                    <td><textarea readonly rows="1" cols="20" class="queryheader">status</textarea></td>
                    <td><textarea readonly rows="1" cols="20" class="queryheader">city</textarea></td>
                <tr>
                    <td><textarea id="textarea1" name="snum" rows="1" cols="20" class="queryinput"></textarea></td>
                    <td><textarea id="textarea2" name="sname" rows="1" cols="20" class="queryinput"></textarea></td>
                    <td><textarea id="textarea3" name="status" rows="1" cols="20" class="queryinput"></textarea></td>
                    <td><textarea id="textarea4" name="city" rows="1" cols="20" class="queryinput"></textarea></td>
                </tr>
                <tr>
                    <td colspan="4" style="text-align: center;">
                        <input type="submit" value="Enter Supplier Record Into Database" class="submitbutton" style="margin-right: 20px;">
                        <input type="button" value="Clear Data and Results" class="clearbutton" onClick="clearDataAndResults();">
                    </td>
                </tr>
            </table>
            <br>
    </fieldset>
    </form>
    <br>
    <br>
    <fieldset style="border: 3px solid white; border-radius: 10px;">
        <legend style="color: white;"><b>Parts Record Insert</b></legend>
        <br>
        <form method="post" action="/Project4/PartsInsertServlet">
            <table>
                <tr>
                    <td><textarea readonly rows="1" cols="15" class="queryheader">pnum</textarea></td>
                    <td><textarea readonly rows="1" cols="15" class="queryheader">pname</textarea></td>
                    <td><textarea readonly rows="1" cols="15" class="queryheader">color</textarea></td>
                    <td><textarea readonly rows="1" cols="15" class="queryheader">weight</textarea></td>
                    <td><textarea readonly rows="1" cols="15" class="queryheader">city</textarea></td>
                <tr>
                    <td><textarea id="textarea5" name="pnum" rows="1" cols="15" class="queryinput"></textarea></td>
                    <td><textarea id="textarea6" name="pname" rows="1" cols="15" class="queryinput"></textarea></td>
                    <td><textarea id="textarea7" name="color" rows="1" cols="15" class="queryinput"></textarea></td>
                    <td><textarea id="textarea8" name="weight" rows="1" cols="15" class="queryinput"></textarea></td>
                    <td><textarea id="textarea9" name="city" rows="1" cols="15" class="queryinput"></textarea></td>
                </tr>
                <tr>
                    <td colspan="6" style="text-align: center;">
                        <input type="submit" value="Enter Part Record Into Dabatase" class="submitbutton" style="margin-right: 20px;">
                        <input type="button" value="Clear Data and Results" class="clearbutton" onClick="clearDataAndResults();">
                    </td>
                </tr>
            </table>
            <br>
    </fieldset>
    </form>
    <br>
    <br>
    <fieldset style="border: 3px solid white; border-radius: 10px;">
        <legend style="color: white;"><b>Jobs Record Insert</b></legend>
        <br>
        <form method="post" action="/Project4/JobsInsertServlet">
            <table>
                <tr>
                    <td><textarea readonly rows="1" cols="20" class="queryheader">jnum</textarea></td>
                    <td><textarea readonly rows="1" cols="20" class="queryheader">jname</textarea></td>
                    <td><textarea readonly rows="1" cols="20" class="queryheader">numworkers</textarea></td>
                    <td><textarea readonly rows="1" cols="20" class="queryheader">city</textarea></td>
                <tr>
                    <td><textarea id="textarea10" name="jnum" rows="1" cols="20" class="queryinput"></textarea></td>
                    <td><textarea id="textarea11" name="jname" rows="1" cols="20" class="queryinput"></textarea></td>
                    <td><textarea id="textarea12" name="numworkers" rows="1" cols="20" class="queryinput"></textarea></td>
                    <td><textarea id="textarea13" name="city" rows="1" cols="20" class="queryinput"></textarea></td>
                </tr>
                <tr>
                    <td colspan="4" style="text-align: center;">
                        <input type="submit" value="Enter Job Record Into Database" class="submitbutton" style="margin-right: 20px;">
                        <input type="button" value="Clear Data and Results" class="clearbutton" onClick="clearDataAndResults();">
                    </td>
                </tr>
            </table>
            <br>
    </fieldset>
    </form>
    <br>
    <br>
    <fieldset style="border: 3px solid white; border-radius: 10px;">
        <legend style="color: white;"><b>Shipment Record Insert</b></legend>
        <br>
        <form method="post" action="/Project4/ShipmentsInsertServlet">
            <table>
                <tr>
                    <td><textarea readonly rows="1" cols="20" class="queryheader">snum</textarea></td>
                    <td><textarea readonly rows="1" cols="20" class="queryheader">pnum</textarea></td>
                    <td><textarea readonly rows="1" cols="20" class="queryheader">jnum</textarea></td>
                    <td><textarea readonly rows="1" cols="20" class="queryheader">quantity</textarea></td>
                <tr>
                    <td><textarea id="textarea14" name="snum" rows="1" cols="20" class="queryinput"></textarea></td>
                    <td><textarea id="textarea15" name="pnum" rows="1" cols="20" class="queryinput"></textarea></td>
                    <td><textarea id="textarea16" name="jnum" rows="1" cols="20" class="queryinput"></textarea></td>
                    <td><textarea id="textarea17" name="quantity" rows="1" cols="20" class="queryinput"></textarea></td>
                </tr>
                <tr>
                    <td colspan="4" style="text-align: center;">
                        <input type="submit" value="Enter Shipment Record Into Database" class="submitbutton" style="margin-right: 20px;">
                        <input type="button" value="Clear Data and Results" class="clearbutton" onClick="clearDataAndResults();">
                    </td>
                </tr>
            </table>
            <br>
    </fieldset>
    </form>
    <br>
    <hr>
    <br>
    <p><b>Database Results:</b></p>
    <div id="databaseResult" class="block p-6 my-6 rounded-lg shadow-lg bg-gray-100 max-w-2xl">
        <center><%=message%></center>
    </div>

    <div class="mb-16 text-sm tracking-tight">
        <script>
            function clearDataAndResults() {
                for (i = 1; i <= 17; i++) {
                    document.getElementById("textarea" + i).value = "";
                    document.getElementById("databaseResult").innerHTML = "";
                }
            }
        </script>
    </div>
</body>
</html>