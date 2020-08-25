<%@ Page Title="Home Page" Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" ValidateRequest="false" Inherits="RunExecutable._Default" %>

<html>
<head>
    <title>Home</title>
    <style>
        .selected
        {
            background-color: orange !important;
            border-radius: 4px 4px 0 0;
            padding: 10px 20px;
        }

        ul#menu
        {
            margin-top: 100px;
            margin-left: 600px;
            align-content: center;
            padding: 0;
            font-size: large;
        }

            ul#menu li
            {
                display: inline;
                padding-right: 20px;
            }

                ul#menu li a
                {
                    background-color: black;
                    color: white;
                    padding: 10px 20px;
                    text-decoration: none;
                    border-radius: 4px 4px 0 0;
                }

                    ul#menu li a:hover
                    {
                        background-color: orange;
                        cursor: pointer;
                    }
    </style>
    <script type="text/javascript">
        //email to whom the customer program sents
        //function CheckSplCharacters() {

        //    // var isSpl = !/[~`!#$%\^&*+=\-\[\]\\';,/{}|\\":<>\?]/g.test("String here");
        //    var str = "check";
        //    var str = "check-";
        //    if (/^[a-zA-Z@ ]*$/.test(str) == false) {
        //        alert('Your search string contains illegal characters.');
        //    }
        //}

        function fnAlertRun() {
            if (alert("are you sure you want to run this customer program?")) {
                return true;
            }
            else
                return false;
        }

        function fnGetExceptionDetails() {
            hideLiDivs();
            document.getElementById('dvExceptionDetails').style.display = 'block';
            removedSelectedClass();
            document.getElementById('A4').className = 'selected';
        }

        function fnGetCustomerProgramDetails() {
            hideLiDivs();
            document.getElementById('dvCustomerProgramDetails').style.display = 'block';
            removedSelectedClass();
            document.getElementById('A1').className = 'selected';
        }

        function fnRunCustomerProgram() {
            hideLiDivs();
            document.getElementById('dvRunCustomerProgram').style.display = 'block';
            removedSelectedClass();
            document.getElementById('A2').className = 'selected';
        }

        function fnViewConfig() {
            hideLiDivs();
            document.getElementById('dvViewConfig').style.display = 'block';
            removedSelectedClass();
            document.getElementById('A3').className = 'selected';
        }

        function removedSelectedClass() {
            document.getElementById('A1').className = '';
            document.getElementById('A3').className = '';
            document.getElementById('A2').className = '';
            document.getElementById('A4').className = '';
        }

        function hideLiDivs() {
            document.getElementById('dvExceptionDetails').style.display = 'none';
            document.getElementById('dvCustomerProgramDetails').style.display = 'none';
            document.getElementById('dvRunCustomerProgram').style.display = 'none'; 
            document.getElementById('dvViewConfig').style.display = 'none';
        }
    </script>
</head>
<body onload="CheckSplCharacters()">
    <form runat="server">
        <h1 style="text-align: center">Customer Programs In Detail</h1>

        <ul id="menu" style="margin-left:430px">
            <li><a id="A4" class="selected" runat="server" onclick="fnGetExceptionDetails()">Exception Details</a></li>
            <li><a id="A1" runat="server" onclick="fnGetCustomerProgramDetails()">Customer Program Details</a></li>
            <li><a id="A2" runat="server" onclick="fnRunCustomerProgram()">Run Program</a></li>
            <li><a id="A3" runat="server" onclick="fnViewConfig()">View Config</a></li>
        </ul>
        <br />
        <br />
        <br />

        <div id="dvExceptionDetails" style="margin-left: 250px; margin-top: 80px" runat="server">

            <asp:DropDownList Style="margin-left: 450px;" ID="ddlSchedule" runat="server">
                <asp:ListItem Text="Today"></asp:ListItem>
                <asp:ListItem Text="This Week"></asp:ListItem>
                <asp:ListItem Text="All Time"></asp:ListItem>
            </asp:DropDownList>

            <asp:Button Style="margin-left: 70px" ID="btnExceptionDetails" runat="server" Text="Get Exception Details"  OnClick="btnExceptionDetails_Click" />
            <br />
            <br />
            <br />
            <asp:ListView ID="lvExceptionDetails" runat="server">
                <LayoutTemplate>
                    <table id="tExceptionDetails" runat="server" >
                        <tr id="Tr1" runat="server" style="font-weight:bold;color:white;background-color:black">
                            <td style="width:15%">Application Name</td>
                            <td style="width:30%">Error Message</td>
                            <td style="width:55%">Stack Trace</td>
                        </tr>
                        <tr runat="server" id="itemPlaceholder">
                        </tr>
                    </table>
                </LayoutTemplate>
                <ItemTemplate>
                    <tr id="Tr2" runat="server">
                        <td style="width:15%" id="Td7" runat="server">
                            <asp:Label ID="lblAppName" runat="server" Text='<%#Eval("ApplicationName") %>' />
                        </td>
                        <td style="width:30%" id="Td1" runat="server">
                            <asp:Label ID="lblErrorMessage" runat="server" Text='<%#Eval("ApplicationMessage") %>' />
                        </td>
                        <td style="width:55%" id="Td2" runat="server">
                            <asp:Label ID="lblStackTrace" runat="server" Text='<%#Eval("StackTrace") %>' />
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:ListView>
        </div>

        <div id="dvCustomerProgramDetails" style="margin-left: 250px; margin-top: 80px" runat="server">
            <asp:DropDownList ID="dlCustomerProgramname" Style="margin-left: 450px;" runat="server"></asp:DropDownList>

            <asp:Button ID="btnSubmit" runat="server" Style="margin-left: 70px" Text="Get Details" OnClick="btnSubmit_Click" />

            <br />
            <br />
            <br />
            <br />
            <asp:ListView ID="lvFolderFileNames" runat="server">
                <LayoutTemplate>
                    <table id="tFolderFile" runat="server">
                        <tr runat="server" style="font-weight:bold;color:white;background-color:black">
                            <td style="width:10%">Customer ID</td>
                            <td style="width:15%">Custome Name</td>
                            <td style="width:10%">Program Run Time</td>
                            <td style="width:15%">Program POC</td>
                            <td style="width:15%">Executable Path</td>
                            <td style="width:15%">Output Files Path</td>
                            <td style="width:20%">Comments</td>
                        </tr>
                        <tr runat="server" id="itemPlaceholder">
                        </tr>
                    </table>
                </LayoutTemplate>
                <ItemTemplate>
                    <tr runat="server">
                        <td runat="server">
                            <asp:Label ID="lblCustomerID" runat="server" Text='<%#Eval("Customer_ID") %>' />
                        </td>
                        <td id="Td1" runat="server">
                            <asp:Label ID="lblCustomerName" runat="server" Text='<%#Eval("Customer_Name") %>' />
                        </td>
                        <td id="Td2" runat="server">
                            <asp:Label ID="lblRunTime" runat="server" Text='<%#Eval("Program_RunTime") %>' />
                        </td>
                        <td id="Td3" runat="server">
                            <asp:Label ID="lblPOC" runat="server" Text='<%#Eval("POC") %>' />
                        </td>
                        <td id="Td4" runat="server">
                            <asp:Label ID="lblExecutablePath" runat="server" Text='<%#Eval("Executable_Path") %>' />
                        </td>
                        <td id="Td5" runat="server">
                            <asp:Label ID="lblOutputPath" runat="server" Text='<%#Eval("OutputFiles_Path") %>' />
                        </td>
                        <td id="Td6" runat="server">
                            <asp:Label ID="lblComments" runat="server" Text='<%#Eval("Comments") %>' />
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:ListView>

        </div>

        <div id="dvRunCustomerProgram" style="margin-left: 250px; margin-top: 80px" onload="fnRunCustomerProgram()">
            <asp:DropDownList ID="ddlProgramList" Style="margin-left: 450px;" runat="server"></asp:DropDownList>

            <asp:Button ID="btnRunProgram" runat="server" Style="margin-left: 70px" Text="Run Customer Program" OnClientClick="fnAlertRun()" OnClick="btnRunProgram_Click" />
        </div>

        <div id="dvViewConfig" style="margin-left: 250px; margin-top: 80px">
            <asp:DropDownList ID="ddlProgramListConfig" Style="margin-left: 450px;" runat="server"></asp:DropDownList>

            <asp:Button ID="btnViewConfig" runat="server" Style="margin-left: 70px" Text="Get Config Details" OnClick="btnViewConfig_Click" />
            <br />
            <br />
            <br />
            <br />
            <asp:TextBox ID="tbConfig" Style="margin-left: 350px" runat="server" TextMode="MultiLine" Height="500px" Width="500px"></asp:TextBox>
        </div>
    </form>

</body>

</html>
