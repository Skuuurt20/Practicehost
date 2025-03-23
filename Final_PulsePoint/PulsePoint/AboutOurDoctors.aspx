<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AboutOurDoctors.aspx.cs" Inherits="Pulsepoint.AboutOurDoctors" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>About Our Doctor - PulsePoint</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f0f0f0;
      margin: 0;
      padding: 0;
      color: #1f2b5b;
    }
    .header {
      background: #fff;
      padding: 20px;
      text-align: center;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }
    .header h1 {
      margin: 0;
      color: #004aad;
    }
    .doctor-card {
      background: #fff;
      max-width: 800px;
      margin: 40px auto;
      border-radius: 10px;
      overflow: hidden;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.15);
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    .doctor-card:hover {
      transform: scale(1.02);
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.25);
    }
    .doctor-img {
      width: 100%;
      height: auto;
    }
    .doctor-info {
      padding: 20px;
    }
    .doctor-info h2 {
      margin-top: 0;
      color: #004aad;
    }
    .doctor-info p {
      line-height: 1.6;
      color: #1f2b5b;
    }
    .btn-read-more {
      display: inline-block;
      margin-top: 15px;
      padding: 10px 20px;
      background-color: #5e17eb;
      color: white;
      border: none;
      border-radius: 5px;
      transition: background-color 0.3s ease;
      text-decoration: none;
    }
    .btn-read-more:hover {
      background-color: #4b0dcf;
    }
  </style>
</head>
<body>
  <form id="form1" runat="server">
    <div class="header">
      <h1>About Our Doctor</h1>
    </div>
    <div class="doctor-card">
      <!-- Replace '~/Images/doctor.jpg' with the actual image path for Dr. Fabio Enrique Posas -->
      &nbsp;<div class="doctor-info">
        <h2>Dr. Fabio Enrique Posas</h2>
        <p>
          Dr. Fabio Enrique Posas is a renowned Cardiologist with over 15 years of experience in diagnosing and treating heart conditions. Dedicated to providing personalized care, he utilizes the latest medical advancements to ensure the best possible outcomes for his patients.
        </p>
        <a href="#" class="btn-read-more">Read More</a>
      </div>
    </div>
  </form>
</body>
</html>
