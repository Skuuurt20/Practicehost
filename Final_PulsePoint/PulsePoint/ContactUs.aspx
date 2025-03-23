<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ContactUs.aspx.cs" Inherits="Pulsepoint.ContactUs" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Contact Us - PulsePoint</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        /* Global Styles */
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            color: #1F2B5B;
            margin: 0;
            padding: 0;
        }
        /* Container for the contact form and map */
        .contact-container {
            max-width: 800px;
            margin: 50px auto;
            background-color: #fff;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .contact-container h1 {
            text-align: center;
            margin-bottom: 30px;
            color: #004aad;
        }
        /* Form styling */
        .contact-form label {
            font-weight: bold;
            color: #1F2B5B;
        }
        .contact-form input[type="text"],
        .contact-form input[type="email"],
        .contact-form textarea {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            transition: border-color 0.3s ease;
        }
        .contact-form input[type="text"]:focus,
        .contact-form input[type="email"]:focus,
        .contact-form textarea:focus {
            border-color: #5e17eb;
            outline: none;
        }
        .contact-form button {
            background-color: #5e17eb;
            color: #fff;
            border: none;
            padding: 12px 20px;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .contact-form button:hover {
            background-color: #4b0dcf;
        }
        /* Map container styling */
        .map-container {
            margin-top: 30px;
            text-align: center;
        }
        .map-container iframe {
            width: 100%;
            height: 300px;
            border: none;
            border-radius: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="contact-container">
            <h1>Contact Us</h1>
            <div class="contact-form">
                <div class="mb-3">
                    <label for="txtName">Name</label>
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" Placeholder="Enter your name"></asp:TextBox>
                </div>
                <div class="mb-3">
                    <label for="txtEmail">Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Placeholder="Enter your email"></asp:TextBox>
                </div>
                <div class="mb-3">
                    <label for="txtSubject">Subject</label>
                    <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control" Placeholder="Subject"></asp:TextBox>
                </div>
                <div class="mb-3">
                    <label for="txtMessage">Message</label>
                    <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" CssClass="form-control" Rows="5" Placeholder="Write your message here"></asp:TextBox>
                </div>
                <div class="text-center">
                    <asp:Button ID="btnSend" runat="server" Text="Send Message" CssClass="btn" OnClick="btnSend_Click" />
                </div>
            </div>
            <div class="map-container">
                <!-- Embed a sample Google Map. Replace the src with your desired location. -->
                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3153.414184216166!2d144.96305831590484!3d-37.81410797975126!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x6ad65d43f1d2f5b5%3A0x5045675218ce6e0!2sMelbourne%20CBD%2C%20Melbourne%20VIC%2C%20Australia!5e0!3m2!1sen!2sus!4v1600000000000" allowfullscreen="" aria-hidden="false" tabindex="0"></iframe>
            </div>
        </div>
    </form>
</body>
</html>
