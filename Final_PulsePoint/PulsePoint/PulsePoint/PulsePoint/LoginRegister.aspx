<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginRegister.aspx.cs" Inherits="PulsePoint.LoginRegister" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login &amp; Registration - PulsePoint</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0; padding: 0; }
        .container { width: 600px; margin: 50px auto; background: #fff; padding: 20px; border-radius: 5px; box-shadow: 0 0 10px #ccc; }
        h2 { text-align: center; color: #333; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; color: #555; }
        input[type="text"],
        input[type="password"],
        input[type="email"],
        input[type="date"] { width: 100%; padding: 8px; box-sizing: border-box; }
        .btn { background: #28a745; color: #fff; padding: 10px 15px; border: none; border-radius: 3px; cursor: pointer; }
        .btn:hover { background: #218838; }
        .toggle-link { text-align: center; margin-top: 20px; cursor: pointer; color: #007bff; }
        .toggle-link:hover { text-decoration: underline; }
        .error { color: red; }
    </style>
    <script type="text/javascript">
        function toggleForms() {
            var regForm = document.getElementById('registrationForm');
            var loginForm = document.getElementById('loginForm');
            if (regForm.style.display === 'none') {
                regForm.style.display = 'block';
                loginForm.style.display = 'none';
            } else {
                regForm.style.display = 'none';
                loginForm.style.display = 'block';
            }
        }
        window.onload = function () {
            // Show login by default
            document.getElementById('registrationForm').style.display = 'none';
            document.getElementById('loginForm').style.display = 'block';
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>PulsePoint - User Access</h2>
            <!-- Login Form -->
            <div id="loginForm">
                <asp:Panel ID="pnlLogin" runat="server">
                    <h3>Login</h3>
                    <div class="form-group">
                        <label for="txtEmailLogin">Email:</label>
                        <asp:TextBox ID="txtEmailLogin" runat="server" TextMode="Email"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEmailLogin" runat="server" ControlToValidate="txtEmailLogin" ErrorMessage="Email is required" CssClass="error"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group">
                        <label for="txtPasswordLogin">Password:</label>
                        <asp:TextBox ID="txtPasswordLogin" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPasswordLogin" runat="server" ControlToValidate="txtPasswordLogin" ErrorMessage="Password is required" CssClass="error"></asp:RequiredFieldValidator>
                    </div>
                    <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn" OnClick="btnLogin_Click" />
                    <p class="toggle-link" onclick="toggleForms()">Don't have an account? Register here</p>
                </asp:Panel>
            </div>
            <!-- Registration Form -->
            <div id="registrationForm">
                <asp:Panel ID="pnlRegister" runat="server">
                    <h3>Patient Registration</h3>
                    <div class="form-group">
                        <label for="txtFullName">Full Name:</label>
                        <asp:TextBox ID="txtFullName" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvFullName" runat="server" ControlToValidate="txtFullName" ErrorMessage="Full Name is required" CssClass="error"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group">
                        <label for="txtEmailRegister">Email:</label>
                        <asp:TextBox ID="txtEmailRegister" runat="server" TextMode="Email"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEmailRegister" runat="server" ControlToValidate="txtEmailRegister" ErrorMessage="Email is required" CssClass="error"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmailRegister"
                            ErrorMessage="Invalid email format" CssClass="error" 
                            ValidationExpression="\w+([-+.'']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">
                        </asp:RegularExpressionValidator>
                    </div>
                    <div class="form-group">
                        <label for="txtContact">Contact Number:</label>
                        <asp:TextBox ID="txtContact" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvContact" runat="server" ControlToValidate="txtContact" ErrorMessage="Contact Number is required" CssClass="error"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group">
                        <label for="txtPasswordRegister">Password:</label>
                        <asp:TextBox ID="txtPasswordRegister" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPasswordRegister" runat="server" ControlToValidate="txtPasswordRegister" ErrorMessage="Password is required" CssClass="error"></asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="cvPasswordLength" runat="server" ControlToValidate="txtPasswordRegister" ErrorMessage="Password must be at least 8 characters" CssClass="error" OnServerValidate="cvPasswordLength_ServerValidate"></asp:CustomValidator>
                    </div>
                    <div class="form-group">
                        <label for="txtDOB">Date of Birth:</label>
                        <asp:TextBox ID="txtDOB" runat="server" TextMode="Date"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvDOB" runat="server" ControlToValidate="txtDOB" ErrorMessage="Date of Birth is required" CssClass="error"></asp:RequiredFieldValidator>
                    </div>
                    <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn" OnClick="btnRegister_Click" />
                    <p class="toggle-link" onclick="toggleForms()">Already have an account? Login here</p>
                </asp:Panel>
            </div>
        </div>
    </form>
</body>
</html>