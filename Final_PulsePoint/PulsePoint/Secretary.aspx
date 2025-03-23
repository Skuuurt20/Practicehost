<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Secretary.aspx.cs" Inherits="Pulsepoint.Secretary" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PulsePoint - Secretary Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        /* COLOR PALETTE for Secretary:
           #004aad for box glow,
           #1f2b5b for headings/links,
           #5e17eb for the logout button (violet).
        */

        body {
            margin: 0;
            padding-top: 8vh; /* Space for the fixed header */
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
        .header .logo img {
            max-width: 10vw;
            height: auto;
        }
        .header-right {
            display: flex;
            align-items: center;
            gap: 1.5rem; /* space between nav links and logout */
        }
        .nav-links a {
            font-size: 1rem;
            color: #1f2b5b; /* dark blue text */
            text-decoration: none;
            margin-right: 20px;
            transition: color 0.3s ease;
        }
        .nav-links a:hover {
            color: #004aad; /* bright blue on hover */
            text-decoration: underline;
        }

        /* LOGOUT BUTTON (violet) */
        .logout-btn {
            background: #5e17eb;
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

        /* GREETING + STATS BOXES with GLOW */
        .dashboard-greeting,
        .stat-box,
        .patient-list-section,
        .search-bar {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            /* Glow with #004aad */
            box-shadow: 0 0 8px 0 #004aad;
            margin-bottom: 20px;
        }

        .dashboard-greeting h1 {
            margin-top: 0;
            color: #1f2b5b; /* dark blue heading */
        }
        .dashboard-greeting p {
            color: #333;
        }

        .stats-container {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }
        .stat-box {
            flex: 1;
            text-align: center;
        }
        .stat-box h2 {
            margin: 0;
            font-size: 2rem;
            color: #004aad; /* bright blue for the number */
        }
        .stat-box p {
            margin: 5px 0 0;
            color: #555;
        }

        /* SEARCH BAR */
        .search-bar label {
            font-weight: 600;
            color: #1f2b5b;
            margin-right: 10px;
        }
        .search-bar input {
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .search-bar button {
            background: #5e17eb; /* violet */
            color: #fff;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            margin-left: 10px;
            cursor: pointer;
            transition: background 0.3s ease;
        }
        .search-bar button:hover {
            background: #4b0dcf;
        }

        /* PATIENT LIST */
        .patient-list-section h3 {
            margin-top: 0;
            color: #1f2b5b;
        }
        .patient-list-section .table th {
            color: #1f2b5b;
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
            <!-- Greeting and quick stats -->
            <div class="dashboard-greeting">
                <h1>Hello, Alice Wonderland!</h1>
                <p>Welcome to your secretary dashboard. Here you can manage patient information, appointments, and view reports easily.</p>
            </div>

            <div class="stats-container">
                <div class="stat-box">
                    <h2><asp:Label ID="lblPendingCount" runat="server" Text="0"></asp:Label></h2>
                    <p>Pending Appointments</p>
                </div>
                <div class="stat-box">
                    <h2><asp:Label ID="lblConfirmedCount" runat="server" Text="0"></asp:Label></h2>
                    <p>Confirmed Appointments</p>
                </div>
                <div class="stat-box">
                    <h2><asp:Label ID="lblCompletedCount" runat="server" Text="0"></asp:Label></h2>
                    <p>Completed Appointments</p>
                </div>
            </div>

            <!-- Search Bar for Patient Name -->
            <div class="search-bar">
                <label for="txtSearchName">Search Patient Name:</label>
                <asp:TextBox ID="txtSearchName" runat="server" />
                <asp:Button ID="btnSearchName" runat="server" Text="Search" OnClick="btnSearchName_Click" />
            </div>

            <!-- Patient list with Edit & Delete in edit mode -->
            <div class="patient-list-section">
                <h3>Patient List</h3>
<asp:GridView ID="gvPatients" 
              runat="server" 
              AutoGenerateColumns="False" 
              CssClass="table table-striped"
              DataKeyNames="PatientId"
              OnRowEditing="gvPatients_RowEditing"
              OnRowCancelingEdit="gvPatients_RowCancelingEdit"
              OnRowUpdating="gvPatients_RowUpdating"
              OnRowDeleting="gvPatients_RowDeleting">
    <Columns>
        <asp:BoundField DataField="PatientId" HeaderText="ID" ReadOnly="True" />
        <asp:BoundField DataField="FirstName" HeaderText="First Name" ReadOnly="True" />
        <asp:BoundField DataField="LastName" HeaderText="Last Name" ReadOnly="True" />
        <asp:BoundField DataField="Email" HeaderText="Email" ReadOnly="True" />
        <asp:BoundField DataField="ContactNumber" HeaderText="Contact Number" />
        

        <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" ButtonType="Button" />
    </Columns>
</asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>
