<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Patient_Dashboard.aspx.cs" Inherits="Pulsepoint.Patient_Dashboard" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Patient Dashboard</title>
    <style>
        /* COLOR PALETTE:
           #004aad (blue), #5e17eb (violet), #1f2b5b (dark blue)
        */

        /* GLOBAL RESET / BODY */
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
            background-color: #ffffff;
            border-bottom: 1px solid #ccc;
        }
        .logo {
            height: 60px;
            padding-right: 1rem;
        }
        .header-right {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }
        .nav-links {
            display: flex;
            gap: 1.5rem;
            list-style: none;
        }
        .nav-links li {
            display: inline;
        }
        .nav-links a {
            text-decoration: none;
            color: #1f2b5b; /* dark blue */
            font-size: 1rem;
            transition: color 0.3s ease;
        }
        .nav-links a:hover {
            color: #5e17eb; /* violet */
        }
        .logoutbtn {
            background-color: #5e17eb; /* violet */
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

        /* CONTENT WRAPPER */
        .content {
            display: flex;
            padding: 2vh 3vw;
            margin-top: 1vh;
            gap: 2vw;
        }
        .left-content {
            flex: 1;
        }
        .right-content {
            flex: 1;
            max-width: 400px;
        }

        /* SECTION BOXES */
        .section {
            background-color: #ffffff;
            border-radius: 6px;
            padding: 1rem 1.5rem;
            margin-bottom: 1rem;
            /* Permanent violet glow around each section */
            box-shadow: 0 0 8px 0 #5e17eb;
            color: #000;
            position: relative;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .section:hover {
            transform: scale(1.02);
            box-shadow: 0 4px 10px rgba(94, 23, 235, 0.3);
        }
        .section h2 {
            font-size: 1.2rem;
            margin-bottom: 0.5rem;
            color: #1f2b5b;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        /* GREETINGS & ACTIVE APPOINTMENT */
        .greetings {
            margin-bottom: 1rem;
        }
        .greetings p {
            margin: 0.75rem 0;
            line-height: 1.4;
        }

        /* Pulsing animation for active appointment */
        @keyframes pulse {
            0% {
                background-color: #004aad;
            }
            50% {
                background-color: #005be5;
            }
            100% {
                background-color: #004aad;
            }
        }
        .active-appointment {
            color: #fff;
            padding: 0.5rem 0.75rem;
            border-radius: 4px;
            display: inline-block;
            margin-top: 0.5rem;
            font-weight: bold;
            animation: pulse 2s infinite;
        }

        /* HEALTH TIPS SECTION */
        .health-tips ul {
            margin: 0;
            padding-left: 1.2rem;
        }
        .health-tips li {
            margin-bottom: 0.5rem;
            display: flex; /* so icon & text align nicely */
            align-items: center;
        }
        .tip-icon {
            width: 24px;
            height: 24px;
            margin-right: 8px;
            vertical-align: middle;
        }

        /* FAQ SECTION */
        .faqs ul {
            margin: 0;
            padding-left: 1.2rem;
        }
        .faqs li {
            margin-bottom: 0.5rem;
        }

        /* APPOINTMENT INFO (BOOK) */
        .appointment-info p {
            margin: 0.75rem 0;
            line-height: 1.4;
        }
        .book-now-button {
            background-color: #5e17eb; /* violet */
            color: #fff;
            border: none;
            padding: 0.5rem 1.5rem;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1rem;
            transition: background-color 0.3s ease;
            margin-top: 1rem;
        }
        .book-now-button:hover {
            background-color: #4b0dcf;
        }

        /* DOCTOR INFO */
        .doctor-info ul {
            margin: 0;
            padding-left: 1.2rem;
        }

        /* Example image sizing for the tips icons (adjust as needed) */
        .auto-style1 {
            height: 63px;
            width: 63px;
            margin-right: 8px;
        }
        .auto-style2 {
            height: 63px;
            width: 63px;
            margin-right: 8px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- HEADER -->
        <div class="header">
            <asp:Image ID="logo" runat="server" ImageUrl="~/images/logo.png" CssClass="logo" />
            <div class="header-right">
                <ul class="nav-links">
                    <li><a href="Patient_Dashboard.aspx">Dashboard</a></li>
                    <li><a href="Patient_Appointment.aspx">Appointment</a></li>
                </ul>
                <asp:Button ID="logoutbtn" runat="server" Text="Log Out" CssClass="logoutbtn" OnClick="logoutbtn_Click" />
            </div>
        </div>

        <!-- MAIN CONTENT -->
        <div class="content">
            <!-- LEFT CONTENT -->
            <div class="left-content">
                <!-- GREETINGS SECTION -->
                <div class="section greetings">
                    <h2>Greetings, <asp:Label ID="lblPatientName" runat="server" Text=""></asp:Label>!</h2>
                    <p>We are glad to see you at our clinic. Your health is our priority.</p>
                    <span class="active-appointment">
                        Active Appointment:
                        <asp:Label ID="lblActiveAppointment" runat="server" Text="No active appointment"></asp:Label>
                    </span>
                </div>

                <!-- HEALTH TIPS SECTION -->
                <div class="section health-tips">
                    <h2>Health Tips</h2>
                    <ul>
                        <li>
                            <img src="images/drink.png" class="auto-style1" alt="Drink Water Icon" />
                            Stay hydrated by drinking plenty of water.
                        </li>
                        <li>
                            <img src="images/exercise.jpg" class="auto-style1" alt="Exercise Icon" />
                            Regular exercise keeps you fit and healthy.
                        </li>
                        <li>
                            <img src="images/sleep.jpg" class="auto-style2" alt="Sleep Icon" />
                            Ensure you get enough sleep for better health.
                        </li>
                    </ul>
                </div>

                <!-- FAQ SECTION -->
                <div class="section faqs">
                    <h2>FAQs</h2>
                    <ul>
                        <li><strong>Q:</strong> How do I book an appointment?</li>
                        <li><strong>A:</strong> Click on the "Book Now" button to schedule your appointment.</li>
                        <li><strong>Q:</strong> Do I need to bring anything for my first appointment?</li>
                        <li><strong>A:</strong> Please bring your ID and health insurance information.</li>
                    </ul>
                </div>
            </div>

            <!-- RIGHT CONTENT -->
            <div class="right-content">
                <div class="section appointment-info">
                    <h2>Need a Medical Appointment?</h2>
                    <p>If you are experiencing health issues or simply looking for a routine check-up, scheduling a medical appointment is an important step toward maintaining your health and well-being. Our clinic is dedicated to providing comprehensive healthcare tailored to your needs.</p>
                    <asp:Button ID="btnBookNow" runat="server" Text="Book Now" CssClass="book-now-button" OnClick="btnBookNow_Click" />
                </div>

                <div class="section doctor-info">
                    <h2>Doctor Information</h2>
                    <p>Meet our highly qualified doctor who is here to help you.</p>
                    <ul>
                        <li>Dr. Posas - Cardiologist</li>
                    </ul>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
