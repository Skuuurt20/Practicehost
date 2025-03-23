<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="Pulsepoint.Reports" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PulsePoint - Reports & Analytics</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        /* Secretary color scheme:
           - Glow color: #004aad (blue)
           - Headings/links: #1f2b5b (dark blue)
           - Logout button: #5e17eb (violet)
        */

        body {
            margin: 0;
            padding-top: 8vh;
            background-color: #f0f0f0;
            font-family: Arial, sans-serif;
        }

        /* HEADER */
        .header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            width: 100%;
            height: 8vh;
            padding: 1vh 2vw;
            background: #fff;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            position: fixed;
            top: 0;
            left: 0;
            z-index: 1000;
        }
        .logo img {
            max-width: 10vw;
            height: auto;
        }
        .header-right {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }
        .nav-links a {
            font-size: 1rem;
            color: #1f2b5b; /* dark blue */
            text-decoration: none;
            margin-right: 20px;
            transition: color 0.3s ease;
        }
        .nav-links a:hover {
            color: #004aad; /* bright blue on hover */
            text-decoration: underline;
        }
        .logout-btn {
            background: #5e17eb; /* violet */
            color: white;
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s ease;
        }
        .logout-btn:hover {
            background: #4b0dcf;
        }

        /* MAIN CONTAINER */
        .container {
            margin-top: 10vh;
            padding: 20px;
        }

        /* BOX GLOW */
        .box-glow {
            background-color: #fff;
            border-radius: 6px;
            box-shadow: 0 0 8px 0 #004aad; /* permanent blue glow */
            padding: 20px;
            margin-bottom: 20px;
        }

        /* TABLE STYLES */
        .table {
            width: 100%;
            margin-top: 20px;
        }
        .table thead th {
            background-color: #f2f2f2;
            color: #1f2b5b; /* dark blue headings */
        }

        /* HEADINGS */
        h1 {
            color: #1f2b5b;
            margin-bottom: 1rem;
        }
        h3 {
            color: #1f2b5b;
        }
        .insight-list {
            margin-top: 1rem;
        }
        .insight-list li {
            margin-bottom: 0.5rem;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- HEADER -->
        <div class="header">
            <div class="logo">
                <asp:Image ID="Image1" runat="server" ImageUrl="~/images/logo.png" />
            </div>
            <div class="header-right">
                <div class="nav-links">
                    <a href="Secretary.aspx">Dashboard</a>
                    <a href="ManageAppointments.aspx">Manage Appointments</a>
                    <a href="Reports.aspx">Reports</a>
                </div>
                <asp:Button ID="logoutbtn" runat="server" Text="Log Out" CssClass="logout-btn" OnClick="logoutbtn_Click" />
            </div>
        </div>

        <!-- MAIN CONTENT -->
        <div class="container">
            <div class="box-glow">
                <h1>Reports & Analytics</h1>
                <asp:GridView ID="rptGridView" runat="server" AutoGenerateColumns="False" CssClass="table table-striped">
                    <Columns>
                        <asp:BoundField DataField="Month" HeaderText="Month" />
                        <asp:BoundField DataField="TotalAppointments" HeaderText="Total Appointments" />
                        <asp:BoundField DataField="CompletedAppointments" HeaderText="Completed Appointments" />
                        <asp:BoundField DataField="CancelledAppointments" HeaderText="Cancelled Appointments" />
                    </Columns>
                </asp:GridView>
            </div>

            <!-- KEY INSIGHTS BOX (DYNAMIC) -->
            <div class="box-glow">
                <h3>Key Insights</h3>
                <ul class="insight-list">
                    <li>
                        Month with highest total appointments: 
                        <strong><asp:Label ID="lblMaxApptsMonth" runat="server" Text="N/A" /></strong>
                    </li>
                    <li>
                        Month with most cancellations: 
                        <strong><asp:Label ID="lblMaxCancelledMonth" runat="server" Text="N/A" /></strong>
                    </li>
                    <li>
                        Percentage of appointments completed vs. scheduled: 
                        <strong><asp:Label ID="lblCompletionPercent" runat="server" Text="0%" /></strong>
                    </li>
                </ul>
                <p>
                    These insights help you track trends and manage appointments effectively.
                </p>
            </div>
        </div>
    </form>
</body>
</html>
