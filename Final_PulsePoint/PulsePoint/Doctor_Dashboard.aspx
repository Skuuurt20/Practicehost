<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Doctor_Dashboard.aspx.cs" Inherits="Pulsepoint.Doctor_Dashboard" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Doctor Dashboard</title>
    <style>
        /* Doctor color scheme:
           - Container glow: #1f2b5b (dark blue)
           - Headings/links: #004aad (bright blue)
           - Logout button: #5e17eb (violet)
        */

        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }

        /* HEADER */
        .header {
            background: #ffffff;
            border-bottom: 1px solid #ccc;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .logo {
            max-height: 60px;
        }
        .img-fluid {
            max-height: 60px;
            width: auto;
        }

        /* NAV + LOGOUT on the right */
        .header-right {
            display: flex;
            align-items: center;
            gap: 1.5rem; /* space between nav links & logout button */
        }
        .nav-links {
            display: flex;
            gap: 2rem;
        }
        .nav-links a {
            text-decoration: none;
            color: #004aad; /* bright blue links */
            font-size: 1rem;
            transition: color 0.3s ease;
        }
        .nav-links a:hover {
            color: #5e17eb; /* violet hover */
        }

        /* LOGOUT BUTTON - VIOLET */
        .logoutbtn {
            background-color: #5e17eb;
            color: #fff;
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

        /* MAIN CONTENT LAYOUT */
        .content {
            display: flex; 
            padding: 2vh 3vw;
            background-color: #f0f0f0; 
            border-radius: 5px;
        }
        .left-content {
            flex: 0 0 60%; 
            padding-right: 2%;
        }
        .right-content {
            flex: 0 0 40%; 
        }

        /* SECTIONS with permanent glow (#1f2b5b) */
        .section {
            background-color: #ffffff;
            border-radius: 5px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 0 8px 0 #1f2b5b; /* dark-blue glow */
        }
        .section h2 {
            margin-top: 0;
            color: #004aad; /* bright-blue headings */
            margin-bottom: 0.5rem;
        }

        /* APPOINTMENTS TABLE */
        .appointments-table {
            width: 100%;
            border-collapse: collapse;
        }
        .appointments-table th,
        .appointments-table td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: left;
            font-size: 0.95rem;
        }
        .appointments-table th {
            background: #f2f2f2;
            color: #004aad; /* bright-blue headings */
        }

        /* DOCTOR INSIGHTS (interactive placeholder) */
        .doctor-insights {
            margin-bottom: 20px;
        }
        .insight-cards {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            margin-top: 1rem;
        }
        .insight-card {
            flex: 1 1 45%;
            background: #fff;
            border-radius: 4px;
            box-shadow: 0 0 4px rgba(0,0,0,0.15);
            padding: 1rem;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .insight-card:hover {
            transform: scale(1.03);
            box-shadow: 0 0 8px rgba(31,43,91,0.5); /* dark-blue glow */
        }
        .insight-card h4 {
            margin-top: 0;
            color: #004aad;
            margin-bottom: 0.5rem;
        }
        .insight-card p {
            margin: 0;
            line-height: 1.4;
        }

        /* RESPONSIVE */
        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                align-items: flex-start;
            }
            .header-right {
                flex-wrap: wrap;
                gap: 1rem;
            }
            .nav-links {
                gap: 1rem;
            }
            .content {
                flex-direction: column;
            }
            .left-content, .right-content {
                max-width: 100%;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- HEADER NAV -->
        <div class="header">
            <asp:Image ID="Image1" runat="server" ImageUrl="~/images/logo.png" CssClass="img-fluid" />
            <div class="header-right">
                <div class="nav-links">
                    <a href="Doctor_Dashboard.aspx">Dashboard</a>
                    <a href="Doctor_Appointment.aspx">Appointments</a>
                </div>
                <asp:Button ID="logoutbtn" runat="server" Text="Log Out" CssClass="logoutbtn" OnClick="logoutbtn_Click" />
            </div>
        </div>

        <!-- CONTENT -->
        <div class="content">
            <div class="left-content">
                <div class="section greetings">
                    <h2>Welcome, Dr. Fabio Posas!</h2>
                    <p>This is your dashboard. Here you can see your appointment statistics, patient feedback, and recent updates.</p>
                </div>
                
                <div class="section appointment-summary">
                    <h2>Today's Appointment Summary</h2>
                    <p>You have <asp:Label ID="lblAppointmentCount" runat="server" Text="0"></asp:Label> appointments scheduled for today.</p>
                </div>

                <!-- Interactive placeholder: Doctor Insights/News -->
                <div class="section doctor-insights">
                    <h2>Doctor Insights</h2>
                    <p>Latest news, alerts, or best practices for the clinic or your specialty:</p>
                    <div class="insight-cards">
                        <div class="insight-card">
                            <h4>Medication Alerts</h4>
                            <p>Stay aware of any new medication warnings or recalls.</p>
                        </div>
                        <div class="insight-card">
                            <h4>New Clinical Guidelines</h4>
                            <p>Check the updated protocols for patient follow-ups and check-ups.</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="right-content">
                <div class="section upcoming-appointments">
                    <h2>Upcoming Appointments</h2>
                    <asp:GridView ID="UpcomingAppointmentsGridView" runat="server" AutoGenerateColumns="False" CssClass="appointments-table">
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
                            <asp:BoundField DataField="PatientName" HeaderText="Patient" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
