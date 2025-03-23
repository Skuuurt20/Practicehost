<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Patient_Appointment.aspx.cs" Inherits="Pulsepoint.Patient_Appointment" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Patient Appointment</title>
    <!-- Optionally using Bootstrap for basic resets and container classes -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        /* COLOR PALETTE:
           #004aad (blue), #5e17eb (violet), #1f2b5b (dark blue)
        */

        /* BODY RESET / BACKGROUND */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            /* Subtle gradient background */
            background: linear-gradient(to bottom, #f0f0f0, #e6e6e6);
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
            height: 60px; 
            padding-right: 1rem;
        }
        .nav-container {
            display: flex;
            align-items: center;
            gap: 2vw;
        }
        .nav-container ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            display: flex;
            gap: 2vw;
        }
        .nav-container li {
            display: inline;
        }
        .nav-container a {
            text-decoration: none;
            color: #1f2b5b; /* dark blue */
            font-size: 1rem;
            transition: color 0.3s ease;
        }
        .nav-container a:hover {
            color: #5e17eb; /* violet */
        }

        /* LOGOUT BUTTON */
        .logoutbtn {
            background-color: #5e17eb; /* violet */
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            font-size: 1rem;
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }
        .logoutbtn:hover {
            background-color: #4b0dcf; /* darker violet */
        }

        /* MAIN CONTENT LAYOUT */
        .content {
            display: flex;
            padding: 2vh 3vw;
            margin-top: 1vh;
            gap: 2vw;
        }
        .view-appointment,
        .book-appointment {
            background-color: #ffffff;
            border-radius: 6px;
            padding: 2vh;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .view-appointment:hover,
        .book-appointment:hover {
            transform: scale(1.02);
            box-shadow: 0 4px 10px rgba(94, 23, 235, 0.3);
        }
        .view-appointment {
            flex: 1;
            max-width: 40%;
            margin-right: 2vw;
        }
        .book-appointment {
            flex: 0 0 60%;
        }
        h3, h2 {
            color: #1f2b5b; /* dark blue headings */
            margin-bottom: 1rem;
        }

        /* LABELS & INPUTS */
        .appointment-label {
            font-size: 1rem;
            margin-bottom: 0.5rem;
            display: block;
            color: #1f2b5b;
            font-weight: 600;
        }
        #Calendar1,
        #timeslotddl,
        #ddlMedicalReason {
            width: 100%;
            padding: 0.5rem;
            margin: 0.5rem 0;
            font-size: 1rem;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        /* BOOK BUTTON */
        #bookbtn {
            background-color: #5e17eb; /* violet */
            color: #fff;
            font-size: 1rem;
            padding: 0.5rem 1.5rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-top: 1rem;
            width: 100%;
        }
        #bookbtn:hover {
            background-color: #4b0dcf;
        }

        /* GRIDVIEW TABLE */
        .appointments-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }
        .appointments-table th,
        .appointments-table td {
            border: 1px solid #ccc;
            padding: 0.75rem;
            text-align: left;
            font-size: 0.95rem;
        }
        .appointments-table th {
            background-color: #f2f2f2;
            color: #1f2b5b;
        }
        .appointments-table tr:hover {
            background-color: #fafafa;
        }

        /* CANCEL BUTTON inside GridView */
        #CancelButton {
            background-color: #dc3545; /* red */
            color: #fff;
            border: none;
            padding: 0.4rem 0.75rem;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        #CancelButton:hover {
            background-color: #c82333;
        }

        /* CALENDAR STYLES */
        .myCalendar {
            border: 1px solid #ccc;
            transition: box-shadow 0.3s ease;
            min-width: 250px; /* ensure enough width for month name */
        }
        .myCalendar:hover {
            box-shadow: 0 0 8px #5e17eb; /* glowing violet effect */
        }
        /* Past or same-day dates (unselectable) */
        .calendar-past {
            background-color: #eee !important;
            color: #999 !important;
            cursor: not-allowed;
        }
        /* Fully booked dates */
        .calendar-fully-booked {
            background-color: #ffcccc !important; /* Light red */
            color: #cc0000 !important;
            cursor: not-allowed;
        }
        /* A small label or text to show “X/14” in the cell */
        .booking-count {
            display: block;
            font-size: 0.8rem;
            margin-top: 2px;
            color: #555;
        }

        /* RESPONSIVE */
        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                align-items: flex-start;
            }
            .nav-container {
                margin-top: 0.5rem;
            }
            .content {
                flex-direction: column;
            }
            .view-appointment {
                max-width: 100%;
                margin-right: 0;
                margin-bottom: 2rem;
            }
            .book-appointment {
                max-width: 100%;
            }
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <!-- HEADER -->
        <nav class="header">
            <asp:Image ID="logo" runat="server" ImageUrl="~/images/logo.png" CssClass="logo" />
            <div class="nav-container">
                <ul>
                    <li><a href="Patient_Dashboard.aspx">Dashboard</a></li>
                    <li><a href="Patient_Appointment.aspx">Appointment</a></li>
                </ul>
                <asp:Button ID="logoutbtn" runat="server" Text="Log Out" CssClass="logoutbtn" OnClick="logoutbtn_Click" />
            </div>
        </nav>

        <!-- CONTENT -->
        <div class="content">
            <!-- VIEW APPOINTMENTS -->
            <div class="view-appointment">
                <h3>View Appointments</h3>
                <asp:GridView ID="AppointmentsGridView" runat="server" AutoGenerateColumns="False" CssClass="appointments-table">
                    <Columns>
                        <asp:TemplateField HeaderText="Date &amp; Time">
                            <ItemTemplate>
                                <%# Eval("AppointmentDateTime", "{0:MMMM dd, yyyy h:mm tt}") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <%# Eval("Status") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:Button ID="CancelButton" runat="server" Text="Cancel"
                                    CommandName="Cancel" CommandArgument='<%# Eval("AppointmentId") %>'
                                    Visible='<%# Eval("Status").ToString() == "Pending" %>'
                                    OnCommand="CancelButton_Command" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>

            <!-- BOOK APPOINTMENT -->
            <div class="book-appointment">
                <h2>Book Appointment</h2>
                <asp:Label ID="datelabel" runat="server" CssClass="appointment-label" Text="Select a Date:"></asp:Label>
                <asp:Calendar
                    ID="Calendar1"
                    runat="server"
                    CssClass="myCalendar"
                    AutoPostBack="true"
                    OnSelectionChanged="Calendar1_SelectionChanged"
                    OnDayRender="Calendar1_DayRender">
                    <TitleStyle Font-Size="14px" Font-Bold="true" ForeColor="#1f2b5b" />
                    <NextPrevStyle Font-Size="12px" ForeColor="#5e17eb" />
                    <DayHeaderStyle Font-Bold="true" />
                </asp:Calendar>

                <asp:Label ID="timelabel" runat="server" CssClass="appointment-label" Text="Select Time Slot:"></asp:Label>
                <asp:DropDownList ID="timeslotddl" runat="server">
                   
                </asp:DropDownList>

                <asp:Label ID="reasonLabel" runat="server" CssClass="appointment-label" Text="Select Medical Reason:"></asp:Label>
                <asp:DropDownList ID="ddlMedicalReason" runat="server">
                    <asp:ListItem Text="Consultation" Value="Consultation" />
                    <asp:ListItem Text="Clearance" Value="Clearance" />
                    <asp:ListItem Text="Follow Up" Value="Follow Up" />
                    <asp:ListItem Text="Check Up" Value="Check Up" />
                </asp:DropDownList>

                <asp:Button ID="bookbtn" runat="server" Text="Book Appointment" CssClass="book-now-button" OnClick="bookbtn_Click" />
            </div>
        </div>
    </form>
</body>
</html>
