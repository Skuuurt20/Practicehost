<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TermsServices.aspx.cs" Inherits="Pulsepoint.TermsServices" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Terms &amp; Services - PulsePoint</title>
    <style>
        /* Basic reset and typography */
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            color: #1F2B5B;
        }
        .container {
            max-width: 900px;
            margin: 50px auto;
            background: #fff;
            padding: 20px 40px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }
        .container:hover {
            transform: scale(1.02);
        }
        h1 {
            text-align: center;
            color: #004aad;  /* Bright blue for headings */
            margin-bottom: 20px;
        }
        p {
            line-height: 1.6;
            font-size: 16px;
            margin-bottom: 15px;
        }
        .interactive-button {
            display: inline-block;
            background-color: #5e17eb; /* Violet */
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 25px;
            text-decoration: none;
            font-size: 16px;
            transition: background-color 0.3s ease;
            margin-top: 20px;
        }
        .interactive-button:hover {
            background-color: #4b0dcf; /* Darker violet */
        }
        /* Responsive design */
        @media (max-width: 600px) {
            .container {
                padding: 20px;
            }
            h1 {
                font-size: 24px;
            }
            p {
                font-size: 14px;
            }
            .interactive-button {
                font-size: 14px;
                padding: 8px 16px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1>Terms &amp; Services</h1>
            <p>
                Welcome to PulsePoint! This page outlines our Terms &amp; Services. Please read the following terms carefully. By using our services, you agree to comply with these terms.
            </p>
            <p>
                [Placeholder for detailed terms and conditions. This section will be updated periodically with the latest policies and guidelines to ensure transparency and trust between PulsePoint and its users.]
            </p>
            <a href="LoginRegister.aspx" class="interactive-button">Proceed to Login/Register</a>
        </div>
    </form>
</body>
</html>
