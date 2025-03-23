<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PrivacyPolicy.aspx.cs" Inherits="Pulsepoint.PrivacyPolicy" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>Privacy Policy - PulsePoint</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f0f0f0;
      color: #1F2B5B;
      margin: 0;
      padding: 0;
    }
    .header {
      background-color: #ffffff;
      padding: 20px;
      text-align: center;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
      margin-bottom: 20px;
    }
    .header h1 {
      margin: 0;
      color: #004aad;
    }
    .content {
      max-width: 800px;
      margin: 0 auto;
      background-color: #fff;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }
    .content h2 {
      color: #1f2b5b;
      margin-top: 20px;
    }
    .content p {
      line-height: 1.6;
      font-size: 1rem;
      color: #333;
      margin-bottom: 1rem;
    }
    .content ul {
      margin-left: 20px;
      margin-bottom: 1rem;
    }
  </style>
</head>
<body>
  <form id="form1" runat="server">
    <div class="header">
      <h1>Privacy Policy</h1>
    </div>
    <div class="content">
      <h2>Our Commitment to Your Privacy</h2>
      <p>
        At PulsePoint, your privacy is our top priority. We are committed to protecting your personal information and ensuring that your data is secure. This Privacy Policy explains how we collect, use, and safeguard your data.
      </p>
      
      <h2>Information We Collect</h2>
      <p>
        We may collect various types of information, including:
      </p>
      <ul>
        <li>Personal data you provide during registration and appointment booking (e.g., name, email, contact number).</li>
        <li>Usage data when you interact with our website and services.</li>
      </ul>
      
      <h2>How We Use Your Information</h2>
      <p>
        Your information is used to enhance your experience, manage appointments, and provide customer support. We do not share your data with third parties without your consent.
      </p>
      
      <h2>Data Security</h2>
      <p>
        We implement industry-standard security measures to protect your data from unauthorized access, disclosure, alteration, or destruction. Your data is stored securely and is only accessible by authorized personnel.
      </p>
      
      <h2>Changes to This Privacy Policy</h2>
      <p>
        We may update this Privacy Policy periodically. Any changes will be posted on this page, and we encourage you to review it regularly.
      </p>
      
      <p>
        If you have any questions or concerns about our privacy practices, please contact us at <a href="mailto:support@pulsepoint.com">support@pulsepoint.com</a>.
      </p>
    </div>
  </form>
</body>
</html>
