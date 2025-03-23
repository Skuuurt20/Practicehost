<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AboutUs.aspx.cs" Inherits="Pulsepoint.AboutUs" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>About PulsePoint</title>
    <style>
        /* Overall body reset & font */
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            color: #1F2B5B;
        }

        /* NAVBAR */
        #navBar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: white;
            padding: 15px 40px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        #navContainer {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        #logo {
            height: 10vh;
            padding-right: 4vw;
        }
        .navLinks {
            text-decoration: none;
            color: #1E1E2D;
            font-size: 20px;
            font-weight: 500;
            transition: 0.3s;
            padding-right: 3vw;
        }
        .navLinks:hover {
            color: #6A0DAD;
        }

        /* HERO SECTION */
        .hero-section {
            position: relative;
            background: linear-gradient(135deg, #5e17eb 0%, #7f23e2 100%);
            color: #fff;
            text-align: center;
            padding: 80px 20px;
            box-shadow: inset 0 0 20px rgba(0, 0, 0, 0.2);
        }
        .hero-section h1 {
            font-size: 3rem;
            margin-bottom: 1rem;
        }
        .hero-section p {
            font-size: 1.2rem;
            max-width: 700px;
            margin: 0 auto;
            line-height: 1.5;
        }

        /* MAIN CONTENT WRAPPER */
        #contentWrapper {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }

        /* SECTION HEADINGS */
        .section-heading {
            font-size: 2rem;
            margin-bottom: 1rem;
            text-align: center;
            color: #5e17eb; /* violet accent */
        }

        /* SECTIONS: Mission, Vision, Team, etc. */
        .info-section {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
            padding: 2rem;
            transition: transform 0.3s ease;
        }
        .info-section:hover {
            transform: translateY(-4px); /* subtle hover lift */
        }

        /* Example for mission/vision text containers */
        .info-content {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }
        .info-content h2 {
            margin: 0;
            font-size: 1.6rem;
            color: #1F2B5B;
        }
        .info-content p {
            font-size: 1rem;
            line-height: 1.6;
        }

        /* TEAM SECTION: 8-member grid */
        .team-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            margin-top: 1rem;
        }
        .team-member {
            background-color: #f7f7f7;
            border-radius: 10px;
            padding: 1rem;
            text-align: center;
            transition: box-shadow 0.3s ease;
        }
        .team-member:hover {
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .team-member img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            margin-bottom: 0.5rem;
        }
        .team-member h3 {
            margin: 0.5rem 0;
            font-size: 1.1rem;
            color: #5e17eb;
        }
        .team-member p {
            font-size: 0.9rem;
            color: #333;
        }

        /* FOOTER */
        #footerContainer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 40px;
            background-color: white;
            border-top: 1px solid #ccc;
        }
        #footerLogo {
            height: 10vh;
        }
        #footerLinksContainer {
            display: flex;
            gap: 1vw;
        }
        .footerLinks {
            text-decoration: none;
            color: #1E1E2D;
            font-size: 16px;
            font-weight: 500;
        }
        #footerRightContainer {
            text-align: right;
        }
        #socialIcons {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
            margin-bottom: 5px;
        }
        .socialIcon {
            width: 24px;
            height: 24px;
        }
        #copyrightText {
            font-size: 14px;
            color: #1E1E2D;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <!-- NAVBAR -->
        <div id="navBar">
            <div id="navContainer">
                <asp:Image ID="logo" runat="server" ImageUrl="~/Images/PulsePointLogo.png" />
                <a class="navLinks" href="Onboarding.aspx">Home</a>
                <a class="navLinks" href="AboutOurDoctors.aspx">About our Doctors</a>
                <a class="navLinks" href="ContactUs.aspx">Contact</a>
            </div>
        </div>

        <!-- HERO SECTION -->
        <div class="hero-section">
            <h1>About PulsePoint</h1>
            <p>Our journey, mission, and commitment to seamless appointment scheduling.</p>
        </div>

        <!-- MAIN CONTENT WRAPPER -->
        <div id="contentWrapper">
            <!-- MISSION & VISION -->
            <div class="info-section">
                <div class="info-content">
                    <h2>Our Mission</h2>
                    <p>
                        At PulsePoint, our mission is to revolutionize the healthcare 
                        scheduling process by providing an intuitive platform that 
                        benefits patients, doctors, and staff alike. We aim to reduce 
                        wait times, simplify bookings, and create a more efficient 
                        clinical environment.
                    </p>
                    <h2>Our Vision</h2>
                    <p>
                        We envision a future where healthcare is accessible and 
                        convenient for everyone, powered by technology that bridges 
                        the gap between patients and medical professionals. Through 
                        innovative solutions and constant improvements, PulsePoint 
                        aspires to be the global standard in healthcare appointments.
                    </p>
                </div>
            </div>

            <!-- TEAM SECTION with 8 members -->
            <div class="info-section">
                <div class="info-content">
                    <h2>Meet Our Team</h2>
                    <p>
                        PulsePoint is powered by a passionate group of professionals 
                        dedicated to transforming the patient experience. Our team 
                        combines expertise in healthcare, technology, and customer 
                        service to bring you the best possible platform.
                    </p>
                    <div class="team-grid">
                        <!-- Team Member 1 -->
                        <div class="team-member">
                            &nbsp;<h3>Jhan Maurice De Roxas</h3>
                            <p>CEO &amp; Founder</p>
                        </div>
                        <!-- Team Member 2 -->
                        <div class="team-member">
                            &nbsp;<h3>Franz Denrow</h3>
                            <p>Designer</p>
                        </div>
                        <!-- Team Member 3 -->
                        <div class="team-member">
                            &nbsp;<h3>Kurt Gabriel Pernia</h3>
                            <p>Designer</p>
                        </div>
                        <!-- Team Member 4 -->
                        <div class="team-member">
                            &nbsp;<h3>Jerinel Tidalgo</h3>
                            <p>Designer</p>
                        </div>
                        <div class="team-member">
                            <h3>Roweenie San Felipe</h3>
                            <p>QA Specialist</p>
                        </div>
                        <!-- Team Member 6 -->
                        <div class="team-member">
                            &nbsp;<h3>Darren Gozales</h3>
                            <p>Data Analyst</p>
                        </div>
                        <!-- Team Member 7 -->
                        <div class="team-member">
                            &nbsp;<h3>Yort Estremos</h3>
                            <p>Researcher</p>
                        </div>
                        <!-- Team Member 8 -->
                        <div class="team-member">
                            &nbsp;<h3>Clythe Torralba</h3>
                            <p>Customer Success</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ADDITIONAL INFO (Why Choose PulsePoint) -->
            <div class="info-section">
                <div class="info-content">
                    <h2>Why Choose PulsePoint?</h2>
                    <p>
                        We are committed to delivering an easy-to-use, reliable, and 
                        secure appointment scheduling platform that meets the 
                        evolving needs of the healthcare industry. Whether you’re 
                        a patient looking to skip the waiting room or a doctor seeking 
                        an organized schedule, PulsePoint is here to help.
                    </p>
                </div>
            </div>
        </div>

        <!-- FOOTER -->
        <div id="footerContainer">
            <div id="logoContainer">
                <asp:Image ID="footerLogo" ImageUrl="~/Images/PulsePointLogo2.png" runat="server" />
            </div>
            <div id="footerLinksContainer"> 
                <a class="footerLinks" href="AboutUs.aspx">About us</a>
                <a class="footerLinks" href="ContactUs.aspx">Contact us</a>
                <a class="footerLinks" href="PrivacyPolicy.aspx">Privacy &amp; Policy</a>
                <a class="footerLinks" href="TermsServices.aspx">Terms &amp; Services</a>
            </div>
            <div id="footerRightContainer">
                <div id="socialIcons">
                    <asp:Image ID="fbLogo" ImageUrl="~/Images/fbLogo.png" runat="server" CssClass="socialIcon" />
                    <asp:Image ID="igLogo" ImageUrl="~/Images/igLogo.png" runat="server" CssClass="socialIcon" />
                </div>
                <p id="copyrightText">
                    Copyright by PulsePoint &copy; 2025.<br/>
                    All Rights Reserved.
                </p>
            </div>
        </div>
    </form>
</body>
</html>
