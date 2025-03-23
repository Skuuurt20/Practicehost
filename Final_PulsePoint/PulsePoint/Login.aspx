<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Pulsepoint.Login" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login - PulsePoint</title>
    <style>
        /* Overall reset/body */
        html, body {
            margin: 0;
            padding: 0;
            height: 100%;
            font-family: Arial, sans-serif;
            color: #1F2B5B;
            background-color: #f0f0f0;
        }

        /* Page wrapper to handle header+content+footer in a column layout */
        #pageWrapper {
            min-height: 100vh;    /* Full viewport height */
            display: flex;
            flex-direction: column; /* Column flow: header -> content -> footer */
        }

        /* NAVBAR (header) */
        #navBar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: white;
            padding: 15px 40px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        #navBar a {
            text-decoration: none;
        }
        #logo {
            height: 10vh;
        }

        /* CONTENT WRAPPER: flex:1 so it grows and pushes footer down. */
        #contentWrapper {
            flex: 1;
            display: flex;
        }

        /* LEFT COLUMN (Violet Gradient + Glow) */
        #leftColumn {
            flex: 1; /* takes all needed height */
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #5e17eb 0%, #7f23e2 100%);
            box-shadow: inset 0 0 20px rgba(0, 0, 0, 0.2);
            color: #fff;
        }
        #leftColumnContent {
            text-align: center;
            max-width: 400px;
            margin: 2rem;
            background-color: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            padding: 2rem;
            box-shadow: 0 0 20px rgba(94, 23, 235, 0.6);
        }
        #leftColumnContent h1 {
            font-size: 2rem;
            margin-bottom: 1rem;
        }
        #leftColumnContent p {
            font-size: 1.1rem;
            line-height: 1.5;
        }

        /* RIGHT COLUMN (form container) */
        #rightColumn {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }
        .container {
            width: 400px;
            background: #fff;
            border-radius: 5px;
            padding: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        /* FORM FIELDS */
        .form-field {
            margin-bottom: 15px;
        }
        .form-field label {
            display: block;
            margin-bottom: 5px;
        }
        .form-field input, .form-field select {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }

        /* VALIDATION SUMMARY */
        .validation-summary {
            color: red;
            margin-bottom: 10px;
        }

        /* TOGGLE LINK */
        .toggle-link {
            display: block;
            text-align: center;
            margin-top: 15px;
            cursor: pointer;
            color: #5e17eb;
            text-decoration: underline;
        }

        /* BUTTONS */
        .btnContainer {
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .btn {
            padding: 8px 16px;
            border: 2px solid #1E1E2D;
            border-radius: 20px;
            background: none;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
        }
        .btn:hover {
            background-color: #1E1E2D;
            color: white;
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
    </style>
    <script type="text/javascript">
        // Toggle between the Login and Register panels
        function toggleForms() {
            var loginPanel = document.getElementById("<%= loginPanel.ClientID %>");
            var registerPanel = document.getElementById("<%= registerPanel.ClientID %>");

            if (loginPanel.style.display === "none") {
                loginPanel.style.display = "block";
                registerPanel.style.display = "none";
            } else {
                loginPanel.style.display = "none";
                registerPanel.style.display = "block";
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" />

        <!-- Page Wrapper -->
        <div id="pageWrapper">

            <!-- NAVBAR -->
            <div id="navBar">
                <!-- Logo clickable => Onboarding.aspx -->
                <a href="Onboarding.aspx">
                    <asp:Image ID="logo" runat="server" ImageUrl="~/Images/PulsePointLogo.png" />
                </a>
            </div>

            <!-- CONTENT WRAPPER -->
            <div id="contentWrapper">
                <!-- LEFT COLUMN (Violet area) -->
                <div id="leftColumn">
                    <div id="leftColumnContent">
                        <h1>Welcome to PulsePoint</h1>
                        <p>Your one‑stop solution for effortless<br />appointment scheduling.</p>
                    </div>
                </div>

                <!-- RIGHT COLUMN (Forms) -->
                <div id="rightColumn">
                    <div class="container">

                        <!-- LOGIN PANEL (visible by default) -->
                        <asp:Panel ID="loginPanel" runat="server" Style="display: block;">
                            <h2>Login</h2>
                            <asp:ValidationSummary 
                                ID="ValidationSummaryLogin" 
                                runat="server" 
                                CssClass="validation-summary"
                                ValidationGroup="LoginGroup"
                                HeaderText="Please correct the following errors:"
                                DisplayMode="BulletList" />
                            <div class="form-field">
                                <label for="txtLoginEmail">Email</label>
                                <asp:TextBox ID="txtLoginEmail" runat="server" CssClass="form-control" ValidationGroup="LoginGroup" />
                                <asp:RequiredFieldValidator
                                    ID="rfvLoginEmail"
                                    runat="server"
                                    ControlToValidate="txtLoginEmail"
                                    ErrorMessage="Email is required."
                                    ForeColor="Red"
                                    ValidationGroup="LoginGroup"
                                    Display="Dynamic" />
                            </div>
                            <div class="form-field">
                                <label for="txtLoginPassword">Password</label>
                                <asp:TextBox ID="txtLoginPassword" runat="server" TextMode="Password" CssClass="form-control" ValidationGroup="LoginGroup" />
                                <asp:RequiredFieldValidator
                                    ID="rfvLoginPassword"
                                    runat="server"
                                    ControlToValidate="txtLoginPassword"
                                    ErrorMessage="Password is required."
                                    ForeColor="Red"
                                    ValidationGroup="LoginGroup"
                                    Display="Dynamic" />
                            </div>
                            <div class="form-field">
                                <label for="ddlUserType">User Type</label>
                                <asp:DropDownList ID="ddlUserType" runat="server" CssClass="form-control" ValidationGroup="LoginGroup">
                                    <asp:ListItem Text="Patient" Value="Patient" />
                                    <asp:ListItem Text="Doctor" Value="Doctor" />
                                    <asp:ListItem Text="Secretary" Value="Secretary" />
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator
                                    ID="rfvUserType"
                                    runat="server"
                                    ControlToValidate="ddlUserType"
                                    InitialValue=""
                                    ErrorMessage="Please select a user type."
                                    ForeColor="Red"
                                    ValidationGroup="LoginGroup"
                                    Display="Dynamic" />
                            </div>
                            <div class="btnContainer">
                                <asp:Button 
                                    ID="btnLogin" 
                                    runat="server" 
                                    Text="Login" 
                                    CssClass="btn" 
                                    ValidationGroup="LoginGroup"
                                    OnClick="BtnLogin_Click" />
                            </div>
                            <span class="toggle-link" onclick="toggleForms()">New patient? Register here</span>
                        </asp:Panel>

                        <!-- REGISTER PANEL (hidden by default) -->
                        <asp:Panel ID="registerPanel" runat="server" Style="display: none;">
                            <h2>Register</h2>
                            <asp:ValidationSummary 
                                ID="ValidationSummaryRegister" 
                                runat="server" 
                                CssClass="validation-summary"
                                ValidationGroup="RegisterGroup"
                                HeaderText="Please correct the following errors:"
                                DisplayMode="BulletList" />
                            <div class="form-field">
                                <label for="txtFirstName">First Name</label>
                                <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" ValidationGroup="RegisterGroup" />
                                <asp:RequiredFieldValidator 
                                    ID="rfvFirstName" 
                                    runat="server" 
                                    ControlToValidate="txtFirstName" 
                                    ErrorMessage="First Name is required." 
                                    ForeColor="Red"
                                    ValidationGroup="RegisterGroup" 
                                    Display="Dynamic" />
                            </div>
                            <div class="form-field">
                                <label for="txtLastName">Last Name</label>
                                <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" ValidationGroup="RegisterGroup" />
                                <asp:RequiredFieldValidator 
                                    ID="rfvLastName" 
                                    runat="server" 
                                    ControlToValidate="txtLastName" 
                                    ErrorMessage="Last Name is required." 
                                    ForeColor="Red"
                                    ValidationGroup="RegisterGroup" 
                                    Display="Dynamic" />
                            </div>
                            <div class="form-field">
                                <label for="txtContactNumber">Contact Number (11 digits)</label>
                                <asp:TextBox ID="txtContactNumber" runat="server" CssClass="form-control" ValidationGroup="RegisterGroup" />
                                <asp:RequiredFieldValidator 
                                    ID="rfvContactNumber" 
                                    runat="server" 
                                    ControlToValidate="txtContactNumber" 
                                    ErrorMessage="Contact Number is required." 
                                    ForeColor="Red"
                                    ValidationGroup="RegisterGroup" 
                                    Display="Dynamic" />
                                <asp:RegularExpressionValidator 
                                    ID="revContactNumber" 
                                    runat="server"
                                    ControlToValidate="txtContactNumber"
                                    ErrorMessage="Contact number must be exactly 11 digits."
                                    ValidationExpression="^\d{11}$"
                                    ForeColor="Red"
                                    ValidationGroup="RegisterGroup"
                                    Display="Dynamic" />
                            </div>
                            <div class="form-field">
                                <label for="txtEmail">Email</label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" ValidationGroup="RegisterGroup" />
                                <asp:RequiredFieldValidator
                                    ID="rfvEmail"
                                    runat="server"
                                    ControlToValidate="txtEmail"
                                    ErrorMessage="Email is required."
                                    ForeColor="Red"
                                    ValidationGroup="RegisterGroup"
                                    Display="Dynamic" />
                                <asp:RegularExpressionValidator 
                                    ID="revEmail" 
                                    runat="server"
                                    ControlToValidate="txtEmail"
                                    ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                                    ErrorMessage="Please enter a valid email address."
                                    ForeColor="Red"
                                    ValidationGroup="RegisterGroup"
                                    Display="Dynamic" />
                            </div>
                            <div class="form-field">
                                <label for="txtRegisterPassword">Password</label>
                                <asp:TextBox ID="txtRegisterPassword" runat="server" TextMode="Password" CssClass="form-control" ValidationGroup="RegisterGroup" />
                                <asp:RequiredFieldValidator
                                    ID="rfvRegisterPassword"
                                    runat="server"
                                    ControlToValidate="txtRegisterPassword"
                                    ErrorMessage="Password is required."
                                    ForeColor="Red"
                                    ValidationGroup="RegisterGroup"
                                    Display="Dynamic" />
                            </div>
                            <div class="form-field">
                                <label for="txtConfirmPassword">Confirm Password</label>
                                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control" ValidationGroup="RegisterGroup" />
                                <asp:RequiredFieldValidator
                                    ID="rfvConfirmPassword"
                                    runat="server"
                                    ControlToValidate="txtConfirmPassword"
                                    ErrorMessage="Confirm Password is required."
                                    ForeColor="Red"
                                    ValidationGroup="RegisterGroup"
                                    Display="Dynamic" />
                                <asp:CompareValidator
                                    ID="cvPasswords"
                                    runat="server"
                                    ControlToCompare="txtRegisterPassword"
                                    ControlToValidate="txtConfirmPassword"
                                    ErrorMessage="Passwords do not match."
                                    ForeColor="Red"
                                    ValidationGroup="RegisterGroup"
                                    Display="Dynamic" />
                            </div>
                            <div class="btnContainer">
                                <asp:Button 
                                    ID="btnRegister" 
                                    runat="server" 
                                    Text="Register" 
                                    CssClass="btn" 
                                    ValidationGroup="RegisterGroup"
                                    OnClick="BtnRegister_Click" />
                            </div>
                            <span class="toggle-link" onclick="toggleForms()">Already have an account? Login here</span>
                        </asp:Panel>
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
        </div>
    </form>
</body>
</html>
