<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageAppointments.aspx.cs" Inherits="Pulsepoint.ManageAppointments" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PulsePoint - Manage Appointments</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        /* Secretary color scheme:
           - Glow color: #004aad (blue)
           - Headings/links: #1f2b5b (dark blue)
           - Logout button: #5e17eb (violet)
        */

        body {
            margin: 0;
            padding-top: 8vh; /* Prevent content from being hidden under the fixed header */
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
            text-decoration: none;
            color: #1f2b5b;
            margin-right: 20px;
            transition: color 0.3s ease-in-out;
        }
        .nav-links a:hover {
            color: #004aad;
            text-decoration: underline;
        }
        #currentTime {
            font-size: 1.2rem;
            font-weight: bold;
            color: #1f2b5b;
        }

        /* LOGOUT BUTTON - VIOLET */
        .logout-btn {
            font-size: 1rem;
            font-weight: bold;
            background: #5e17eb;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s ease-in-out;
        }
        .logout-btn:hover {
            background: #4b0dcf;
        }

        /* FLEX ROW FOR APPOINTMENT TABLES */
        .appointments-row {
            display: flex;
            flex-wrap: wrap;
            gap: 2rem;
            margin: 20px auto;
            width: 90%;
            max-width: 1200px;
        }

        /* TABLE CONTAINER BOXES */
        .table-container {
            flex: 1;
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 8px 0 #004aad;
            margin-bottom: 20px;
        }
        .table-container h3 {
            margin-top: 0;
            margin-bottom: 15px;
            color: #1f2b5b;
            text-align: center;
        }

        /* TABLE & BUTTONS */
        .table th, .table td {
            text-align: center;
            vertical-align: middle;
        }
        .btn-confirm {
            background: #28a745; /* green */
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn-cancel {
            background: #dc3545; /* red */
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 5px;
        }
        .btn-confirm:hover { background: #218838; }
        .btn-cancel:hover { background: #c82333; }

        /* SCROLLABLE SECTION FOR CONFIRMED APPOINTMENTS */
        .scroll-container {
            max-height: 300px;
            overflow-y: auto;
            margin-top: 1rem;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        /* MANUAL BOOKING SECTION */
        .manual-booking {
            margin: 20px auto;
            width: 90%;
            max-width: 1200px;
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 8px 0 #004aad;
            margin-bottom: 20px;
        }
        .manual-booking h3 {
            margin-top: 0;
            color: #1f2b5b;
        }
        .manual-booking label {
            font-weight: 600;
            color: #1f2b5b;
            display: block;
            margin-bottom: 0.3rem;
        }
        .manual-booking input, .manual-booking select {
            width: 100%;
            margin-bottom: 1rem;
            padding: 0.5rem;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .manual-booking button {
            background: #5e17eb;
            color: #fff;
            border: none;
            padding: 8px 16px;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s ease;
            margin-top: 1rem;
        }
        .manual-booking button:hover {
            background: #4b0dcf;
        }

        .calendar-row {
            margin-bottom: 1rem;
        }

        /* CALENDAR STYLES */
        .myCalendar {
            border: 1px solid #ccc;
            transition: box-shadow 0.3s ease;
            min-width: 250px; /* ensure enough width for month name */
        }
        .myCalendar:hover {
            box-shadow: 0 0 8px #004aad;
        }
        .calendar-past {
            background-color: #eee !important;
            color: #999 !important;
            cursor: not-allowed;
        }
        .calendar-fully-booked {
            background-color: #ffcccc !important;
            color: #cc0000 !important;
            cursor: not-allowed;
        }
        .booking-count {
            display: block;
            font-size: 0.8rem;
            margin-top: 2px;
            color: #555;
        }

        /* SEARCH BAR FOR CONFIRMED APPTS */
        .search-bar {
            display: flex;
            justify-content: center;
            margin-bottom: 1rem;
            gap: 1rem;
        }
        .search-bar input {
            width: 200px;
            padding: 0.5rem;
        }
        .search-bar button {
            background: #5e17eb;
            color: #fff;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            cursor: pointer;
        }
        .search-bar button:hover {
            background: #4b0dcf;
        }

        /* Validation summary styling */
        .validation-summary {
            color: red;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- HEADER -->
        <div class="header">
            <div class="logo">
                <asp:Image ID="Image1" runat="server" ImageUrl="~/images/logo.png" CssClass="img-fluid" />
            </div>
            <div class="header-right">
                <span id="currentTime"></span>
                <div class="nav-links">
                    <a href="Secretary.aspx">Dashboard</a>
                    <a href="ManageAppointments.aspx">Manage Appointments</a>
                    <a href="Reports.aspx">Reports</a>
                </div>
                <asp:Button ID="logoutbtn" runat="server" Text="Log Out" CssClass="logout-btn" OnClick="LogoutBtn_Click" />
            </div>
        </div>
        <script>
            function updateTime() {
                const now = new Date();
                document.getElementById("currentTime").innerText = now.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
            }
            setInterval(updateTime, 1000);
            updateTime();
        </script>

        <!-- APPOINTMENTS ROW -->
        <div class="appointments-row">
            <!-- PENDING APPOINTMENTS -->
            <div class="table-container">
                <h3>Pending Appointments</h3>
                <asp:GridView ID="gvPendingAppointments" runat="server" AutoGenerateColumns="False" CssClass="table table-striped"
                              OnRowCommand="GvPendingAppointments_RowCommand">
                    <Columns>
                        <asp:TemplateField HeaderText="Date">
                            <ItemTemplate>
                                <%# Eval("AppointmentDateTime", "{0:MMMM dd, yyyy}") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Time">
                            <ItemTemplate>
                                <%# Eval("AppointmentDateTime", "{0:h:mm tt}") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="PatientName" HeaderText="Name" />
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:Button ID="btnConfirm" runat="server" Text="Confirm"
                                    CommandName="Confirm" CommandArgument='<%# Eval("AppointmentId") %>'
                                    CssClass="btn-confirm" />
                                <br />
                                <asp:Button ID="btnCancel" runat="server" Text="Cancel"
                                    CommandName="CancelAppointment" CommandArgument='<%# Eval("AppointmentId") %>'
                                    CssClass="btn-cancel" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>

            <!-- CONFIRMED APPOINTMENTS -->
            <div class="table-container">
                <h3>Confirmed Appointments</h3>

                <!-- Simple Search Bar for Name -->
                <div class="search-bar">
                    <asp:TextBox ID="txtSearchName" runat="server" placeholder="Search name..." />
                    <asp:Button ID="btnSearchName" runat="server" Text="Search" OnClick="BtnSearchName_Click" />
                </div>

                <!-- Scrollable container for the table -->
                <div class="scroll-container">
                    <asp:GridView ID="gvConfirmedAppointments" runat="server" AutoGenerateColumns="False" CssClass="table table-striped"
                                  OnRowCommand="GvConfirmedAppointments_RowCommand">
                        <Columns>
                            <asp:TemplateField HeaderText="Date">
                                <ItemTemplate>
                                    <%# Eval("AppointmentDateTime", "{0:MMMM dd, yyyy}") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Time">
                                <ItemTemplate>
                                    <%# Eval("AppointmentDateTime", "{0:h:mm tt}") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="PatientName" HeaderText="Name" />
                            <asp:BoundField DataField="Status" HeaderText="Status" />
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <!-- Cancel button for last-minute cancellation -->
                                    <asp:Button ID="btnCancelConfirmed" runat="server" Text="Cancel"
                                        CommandName="CancelConfirmed"
                                        CommandArgument='<%# Eval("AppointmentId") %>'
                                        CssClass="btn-cancel" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>

        <!-- MANUAL BOOKING (Calendar with day render, etc.) -->
        <div class="manual-booking">
            <h3>Manual Booking for Walk-In</h3>
            <p>Fill in the details to create an account (if needed) and book an appointment.</p>

            <!-- Validation summary for manual booking -->
            <asp:ValidationSummary
                ID="valSummaryManual"
                runat="server"
                CssClass="validation-summary"
                ValidationGroup="ManualBookingGroup"
                HeaderText="Please correct the following errors:"
                DisplayMode="BulletList" />

            <div class="row">
                <!-- Left Column -->
                <div class="col-md-6">
                    <label for="txtFirstName">First Name <span style="color:red">*</span></label>
                    <asp:TextBox ID="txtFirstName" runat="server" />
                    <asp:RequiredFieldValidator
                        ID="reqFirstName"
                        runat="server"
                        ControlToValidate="txtFirstName"
                        ErrorMessage="First Name is required."
                        ForeColor="Red"
                        ValidationGroup="ManualBookingGroup"
                        Display="Dynamic" />
                    <br />

                    <label for="txtLastName">Last Name <span style="color:red">*</span></label>
                    <asp:TextBox ID="txtLastName" runat="server" />
                    <asp:RequiredFieldValidator
                        ID="reqLastName"
                        runat="server"
                        ControlToValidate="txtLastName"
                        ErrorMessage="Last Name is required."
                        ForeColor="Red"
                        ValidationGroup="ManualBookingGroup"
                        Display="Dynamic" />
                    <br />

                    <label for="txtEmail">Email (optional)</label>
                    <asp:TextBox ID="txtEmail" runat="server" />
                    <!-- If you want an optional email with a format check only if not empty, 
                         you'd add a custom or a RegularExpressionValidator with EnableClientScript. 
                         But for now we skip, since it's optional with no required or format check. -->
                    <br />

                    <label for="txtContactNumber">Contact Number (11 digits) <span style="color:red">*</span></label>
                    <asp:TextBox ID="txtContactNumber" runat="server" />
                    <asp:RequiredFieldValidator
                        ID="reqContactNumber"
                        runat="server"
                        ControlToValidate="txtContactNumber"
                        ErrorMessage="Contact Number is required."
                        ForeColor="Red"
                        ValidationGroup="ManualBookingGroup"
                        Display="Dynamic" />
                    <asp:RegularExpressionValidator
                        ID="regexContactNumber"
                        runat="server"
                        ControlToValidate="txtContactNumber"
                        ValidationExpression="^\d{11}$"
                        ErrorMessage="Contact number must be exactly 11 digits."
                        ForeColor="Red"
                        ValidationGroup="ManualBookingGroup"
                        Display="Dynamic" />
                    <br />

                    <label for="txtPassword">Password <span style="color:red">*</span></label>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" />
                    <asp:RequiredFieldValidator
                        ID="reqPassword"
                        runat="server"
                        ControlToValidate="txtPassword"
                        ErrorMessage="Password is required."
                        ForeColor="Red"
                        ValidationGroup="ManualBookingGroup"
                        Display="Dynamic" />
                    <br />
                </div>

                <!-- Right Column -->
                <div class="col-md-6">
                    <label for="CalendarWalkIn">Select Date <span style="color:red">*</span></label>
                    <div class="calendar-row">
                        <asp:Calendar 
                            ID="CalendarWalkIn" 
                            runat="server" 
                            CssClass="myCalendar"
                            OnDayRender="CalendarWalkIn_DayRender"
                            OnSelectionChanged="CalendarWalkIn_SelectionChanged" />
                    </div>

                    <label for="ddlTimeSlot">Select Time <span style="color:red">*</span></label>
                    <asp:DropDownList ID="ddlTimeSlot" runat="server" />
                    <asp:RequiredFieldValidator
                        ID="reqTimeSlot"
                        runat="server"
                        ControlToValidate="ddlTimeSlot"
                        InitialValue=""
                        ErrorMessage="Please select a time slot."
                        ForeColor="Red"
                        ValidationGroup="ManualBookingGroup"
                        Display="Dynamic" />
                    <br />

                    <label for="ddlReason">Medical Reason</label>
                    <asp:DropDownList ID="ddlReason" runat="server">
                        <asp:ListItem Text="Consultation" Value="Consultation" />
                        <asp:ListItem Text="Clearance" Value="Clearance" />
                        <asp:ListItem Text="Follow Up" Value="Follow Up" />
                        <asp:ListItem Text="Check Up" Value="Check Up" />
                    </asp:DropDownList><br />

                    <asp:Button 
                        ID="btnManualBook" 
                        runat="server" 
                        Text="Book Appointment" 
                        CssClass="mt-2"
                        OnClick="BtnManualBook_Click"
                        ValidationGroup="ManualBookingGroup" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
