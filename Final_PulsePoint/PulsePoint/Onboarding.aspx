<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Onboarding.aspx.cs" Inherits="Pulsepoint.Onboarding" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PulsePoint</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            color: #1F2B5B;
            background-color: #f0f0f0;
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
        #authContainer {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        .btn-signup {
            padding: 8px 16px;
            border: 2px solid #1E1E2D;
            border-radius: 20px;
            background: none;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
        }
        .btn-signup:hover {
            background-color: #1E1E2D;
            color: white;
        }
        /* MAIN BODY WRAPPER */
        #bodyContainer {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-top: 4vh;
            padding-bottom: 4vh;
        }
        /* Ad container styles */
        .ad-container {
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 20px;
            padding: 2vh 2vw;
            margin-top: 4vh;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            max-width: 1000px;
            width: 90%;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .ad-container:hover {
            transform: scale(1.02);
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }
        .ad-img {
            border-radius: 20px;
            height: 40vh;
            width: auto;
            object-fit: cover;
            transition: transform 0.3s;
        }
        .ad-img:hover {
            transform: scale(1.05);
        }
        .ad-text {
            display: flex;
            flex-direction: column;
            justify-content: center;
            margin-left: 3vw;
            transition: opacity 0.3s;
        }
        .ad-text:hover {
            opacity: 0.9;
        }
        .adHeadingText {
            font-size: 40px;
            margin: 0 0 1vh 0;
        }
        .adContentText {
            font-size: 20px;
            line-height: 1.5;
        }
        /* GET STARTED SECTION */
        #getStartedContainer {
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 20px;
            padding: 2vh 2vw;
            margin-top: 4vh;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            max-width: 1000px;
            width: 90%;
            text-align: center;
        }
        #getStartedContainer:hover {
            transform: scale(1.02);
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }
        #getStartedContainer h1 {
            font-size: 24px;
            margin-bottom: 2vh;
        }
        /* FOOTER */
        #footerContainer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 40px;
            background-color: white;
            border-top: 1px solid #ccc;
            transition: background-color 0.3s;
        }
        #footerContainer:hover {
            background-color: #e8e8ff;
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
            transition: color 0.3s;
        }
        .footerLinks:hover {
            color: #6A0DAD;
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
        /* MODAL */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            transition: opacity 0.3s;
        }
        .modal-content {
            background-color: white;
            margin: 10% auto;
            padding: 40px;
            border-radius: 20px;
            width: 40%;
            text-align: center;
            position: relative;
            transition: transform 0.3s;
        }
        .modal-content:hover {
            transform: scale(1.02);
        }
        .close {
            position: absolute;
            top: 20px;
            right: 20px;
            font-size: 28px;
            cursor: pointer;
        }
        .btn-group {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 20px;
            margin-top: 20px;
        }
        .btn-role {
            padding: 12px 24px;
            font-size: 18px;
            width: 20%;
            border: 2px solid #1E1E2D;
            border-radius: 50px;
            background: none;
            font-weight: bold;
            color: #1E1E2D;
            cursor: pointer;
            transition: background 0.3s, color 0.3s;
        }
        .btn-role:hover {
            background-color: #1E1E2D;
            color: white;
        }
        .auto-style1 {
            margin-right: 0px;
            margin-bottom: 0px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- NAVBAR -->
        <div id="navBar">
            <div id="navContainer">
                <asp:Image ID="logo" runat="server" ImageUrl="~/Images/PulsePointLogo.png" />
                <a class="navLinks" href="AboutOurDoctors.aspx">About our Doctors</a>
                <a class="navLinks" href="AboutUs.aspx">About</a>
                <a class="navLinks" href="ContactUs.aspx">Contact</a>
            </div>
            <div id="authContainer">
                <!-- NEW: Login button that goes to Login.aspx -->
                <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn-signup" OnClick="BtnLogin_Click" />

                <!-- Existing Sign up button -->
                <asp:Button ID="btnSignUp" runat="server" Text="Sign up" CssClass="btn-signup" OnClick="btnSignUp_Click" />
            </div>
        </div>

        <!-- MAIN CONTENT -->
        <div id="bodyContainer">
            <!-- FIRST AD CONTAINER -->
            <div class="ad-container">
                <asp:Image ID="ad1Img" runat="server" ImageUrl="~/Images/ad1Banner.png" CssClass="ad-img" />
                <div class="ad-text">
                    <h1 class="adHeadingText">Book your appointments<br />with ease.</h1>
                    <p class="adContentText">
                        Manage your schedule effortlessly with an<br />
                        intuitive booking system that ensures a<br />
                        smooth experience for doctors and patients.
                    </p>
                </div>
            </div>

            <!-- SECOND AD CONTAINER (Reverse Layout) -->
            <div class="ad-container reverse-layout">
                <asp:Image ID="ad2Img" runat="server" ImageUrl="~/Images/ad2Banner.png" CssClass="ad-img" />
                <div class="ad-text">
                    <h1 class="adHeadingText">Experience seamless<br />booking.</h1>
                    <p class="adContentText">
                        Schedule appointments effortlessly with<br />
                        our seamless booking system—quick,<br />
                        convenient, and hassle-free.
                    </p>
                    <asp:Button ID="btnGetStarted" runat="server" Text="Get Started" CssClass="btn-signup" OnClick="btnGetStarted_Click" />
                </div>
            </div>

            <!-- THIRD AD CONTAINER -->
            <div class="ad-container">
                <asp:Image ID="ad3Img" runat="server" ImageUrl="~/Images/PulsePointLogo.png" CssClass="ad-img" />
                <div class="ad-text">
                    <h1 class="adHeadingText">Queue display next<br />in line</h1>
                    <p class="adContentText">
                        A quicker and easier way to line up<br />
                        just by booking online!
                    </p>
                </div>
            </div>

            <!-- GET STARTED CONTAINER -->
            <div id="getStartedContainer">
                <h1>FIRST COME FIRST SERVE, BOOK 1 DAY ADVANCE!</h1>
                <asp:Button ID="btnGetStarted2" runat="server" Text="Get Started" CssClass="btn-signup" OnClick="btnGetStarted_Click" />
            </div>
        </div>

        <!-- FOOTER -->
        <div id="footerContainer">
            <div id="logoContainer">
                <asp:Image ID="footerLogo" runat="server" ImageUrl="~/Images/PulsePointLogo2.png" CssClass="auto-style1" Width="208px" />
            </div>
            <div id="footerLinksContainer">
                <a class="footerLinks" href="AboutUs.aspx">About us</a>
                <a class="footerLinks" href="ContactUs.aspx">Contact us</a>
                <a class="footerLinks" href="PrivacyPolicy.aspx">Privacy &amp; Policy</a>
                <a class="footerLinks" href="TermsServices.aspx">Terms &amp; Services</a>
            </div>
            <div id="footerRightContainer">
                <div id="socialIcons">
                    <asp:Image ID="fbLogo" runat="server" ImageUrl="~/Images/fbLogo.png" CssClass="socialIcon" />
                    <asp:Image ID="igLogo" runat="server" ImageUrl="~/Images/igLogo.png" CssClass="socialIcon" />
                </div>
                <p id="copyrightText">
                    Copyright by PulsePoint &copy; 2025.<br />
                    All Rights Reserved.
                </p>
            </div>
        </div>

        <!-- SIGNUP MODAL -->
        <div id="signupModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeModal()">&times;</span>
                <h2>Welcome to PulsePoint!</h2>
                <p>To continue, please select your account type:</p>
                <div class="btn-group">
                    <asp:Button ID="btnDoctor" runat="server" Text="Doctor" CssClass="btn-role" OnClick="btnDoctor_Click" />
                    <asp:Button ID="btnPatient" runat="server" Text="Patient" CssClass="btn-role" OnClick="btnPatient_Click" />
                    <asp:Button ID="btnSecretary" runat="server" Text="Secretary" CssClass="btn-role" OnClick="btnSecretary_Click" />
                </div>
                <p>Already have an account? <a href="LoginRegister.aspx">Login</a></p>
            </div>
        </div>
    </form>
    <script>
        function openModal() {
            document.getElementById("signupModal").style.display = "block";
        }
        function closeModal() {
            document.getElementById("signupModal").style.display = "none";
        }
        window.onclick = function (event) {
            var modal = document.getElementById("signupModal");
            if (event.target === modal) {
                closeModal();
            }
        }
    </script>
</body>
</html>
