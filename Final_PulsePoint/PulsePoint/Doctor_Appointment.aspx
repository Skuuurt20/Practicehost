<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Doctor_Appointment.aspx.cs" Inherits="Pulsepoint.Doctor_Appointment" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Doctor Appointments</title>
    <style>
        /* Doctor color scheme:
           - Container glow: #1f2b5b (dark blue)
           - Headings/links: #004aad (bright blue)
           - Logout button: #5e17eb (violet)
        */

        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f0f0;
        }

        /* HEADER */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 2rem;
            border-bottom: 1px solid #ccc;
            background-color: #ffffff;
        }
        .logo {
            max-height: 60px;
        }
        .img-fluid {
            max-height: 60px;
            width: auto;
        }
        .nav-container {
            display: flex;
            align-items: center;
            gap: 2rem;
        }
        .nav-container ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            display: flex;
            gap: 2rem;
        }
        .nav-container li {
            display: inline;
        }
        .nav-container a {
            text-decoration: none;
            color: #004aad; /* bright blue links */
            font-size: 1rem;
            transition: color 0.3s ease;
        }
        .nav-container a:hover {
            color: #5e17eb; /* violet hover */
        }

        /* LOGOUT BUTTON - VIOLET */
        .logoutbtn {
            background-color: #5e17eb;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            font-size: 1rem;
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }
        .logoutbtn:hover {
            background-color: #4b0dcf;
        }

        /* CONTENT WRAPPER */
        .content {
            padding: 2vh 3vw;
        }

        /* HEADINGS */
        h2, h3, h4 {
            color: #004aad; /* bright blue headings */
            margin-top: 0;
        }

        /* APPOINTMENTS TABLE STYLES */
        .appointments-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1vh;
        }
        .appointments-table th,
        .appointments-table td {
            border: 1px solid #ccc;
            padding: 1vh;
            text-align: left;
            font-size: 0.95rem;
        }
        .appointments-table th {
            background-color: #f2f2f2;
            color: #004aad;
        }

        /* COMPLETE BUTTON (Green) */
        .complete-button {
            background-color: #28a745;
            color: #fff;
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
        }
        .complete-button:hover {
            background-color: #218838;
        }

        /* MAIN BOXES (toggle view + search section) */
        .appointments-box,
        .search-section {
            background-color: #fff;
            padding: 2vh;
            border-radius: 6px;
            box-shadow: 0 0 8px 0 #1f2b5b; /* dark-blue glow */
            margin-bottom: 2vh;
        }

        /* FLEX LAYOUT: TWO COLUMNS ON WIDE SCREENS */
        .flex-row {
            display: flex;
            flex-wrap: wrap; /* so they stack if screen is narrow */
            gap: 2rem;
        }
        .flex-column {
            flex: 1;
            min-width: 300px; /* so they don’t get too narrow on small screens */
        }

        /* SEARCH SECTION STYLES */
        .search-section h3 {
            margin-top: 0;
        }
        .search-fields {
            margin-bottom: 1em;
        }
        .search-fields label {
            display: block;
            margin-bottom: 0.5em;
            color: #004aad;
            font-weight: 600;
        }
        .search-fields input {
            width: 200px;
            padding: 5px;
            margin-bottom: 0.5em;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .search-fields button {
            background-color: #5e17eb; /* violet */
            color: #fff;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .search-fields button:hover {
            background-color: #4b0dcf;
        }

        /* CALENDAR STYLES (for CalendarSearch) */
        .myCalendar {
            border: 1px solid #ccc;
            transition: box-shadow 0.3s ease;
            min-width: 250px; /* ensure enough width for month name */
        }
        .myCalendar:hover {
            box-shadow: 0 0 8px #1f2b5b; /* dark-blue glow on hover */
        }
        .calendar-past {
            background-color: #eee !important;
            color: #999 !important;
        }
        .calendar-fully-booked {
            background-color: #ffcccc !important; /* Light red */
            color: #cc0000 !important;
        }
        .booking-count {
            display: block;
            font-size: 0.8rem;
            margin-top: 2px;
            color: #555;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- HEADER -->
        <nav class="header">
            <asp:Image ID="Image1" runat="server" ImageUrl="~/images/logo.png" CssClass="img-fluid" />
            <div class="nav-container">
                <ul>
                    <li><a href="Doctor_Dashboard.aspx">Dashboard</a></li>
                    <li><a href="Doctor_Appointment.aspx">Appointments</a></li>
                </ul>
                <asp:Button ID="logoutbtn" runat="server" Text="Log Out" CssClass="logoutbtn" OnClick="logoutbtn_Click" />
            </div>
        </nav>

        <div class="content">
            <div class="flex-row">
                <!-- LEFT COLUMN: Toggleable View -->
                <div class="appointments-box flex-column">
                    <h2>Toggleable Appointment View</h2>
                    <!-- NOTE: The method is "ddlViewOption_SelectedIndexChanged" in code-behind -->
                    <asp:DropDownList ID="ddlViewOption" runat="server" AutoPostBack="true"
                                      OnSelectedIndexChanged="ddlViewOption_SelectedIndexChanged">
                        <asp:ListItem Text="Today's Confirmed" Value="TodayConfirmed" />
                        <asp:ListItem Text="Today's Completed" Value="TodayCompleted" />
                        <asp:ListItem Text="Tomorrow's Confirmed" Value="TomorrowConfirmed" />
                    </asp:DropDownList>

                    <asp:GridView ID="gvToggleAppointments" runat="server" AutoGenerateColumns="False" CssClass="appointments-table">
                        <Columns>
                            <asp:TemplateField HeaderText="Date &amp; Time">
                                <ItemTemplate>
                                    <%# Eval("AppointmentDateTime", "{0:MMMM dd, yyyy h:mm tt}") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="PatientName" HeaderText="Patient" />
                            <asp:BoundField DataField="MedicalReason" HeaderText="Reason" />
                            <asp:BoundField DataField="Status" HeaderText="Status" />
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <!-- Show Complete button if status == Confirmed -->
                                    <asp:Button ID="CompleteButton" runat="server" Text="Complete"
                                        CommandName="Complete"
                                        CommandArgument='<%# Eval("AppointmentId") %>'
                                        CssClass="complete-button"
                                        Visible='<%# (Eval("Status").ToString() == "Confirmed") %>'
                                        OnCommand="CompleteButton_Command" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>

                <!-- RIGHT COLUMN: Search Section -->
                <div class="search-section flex-column">
                    <h3>Search Appointments by Date &amp; Patient Name</h3>
                    <div class="search-fields">
                        <label for="txtPatientName">Patient Name (optional):</label>
                        <asp:TextBox ID="txtPatientName" runat="server" />
                        <br />
                        <label for="CalendarSearch">Select a Date:</label>
                        <asp:Calendar
                            ID="CalendarSearch"
                            runat="server"
                            CssClass="myCalendar"
                            OnDayRender="CalendarSearch_DayRender" />
                        <br />
                        <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                    </div>

                    <h4>Appointments on Selected Date</h4>
                    <asp:GridView ID="gvDateAppointments" runat="server" AutoGenerateColumns="False" CssClass="appointments-table">
                        <Columns>
                            <asp:TemplateField HeaderText="Date &amp; Time">
                                <ItemTemplate>
                                    <%# Eval("AppointmentDateTime", "{0:MMMM dd, yyyy h:mm tt}") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="PatientName" HeaderText="Patient" />
                            <asp:BoundField DataField="MedicalReason" HeaderText="Reason" />
                            <asp:BoundField DataField="Status" HeaderText="Status" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
