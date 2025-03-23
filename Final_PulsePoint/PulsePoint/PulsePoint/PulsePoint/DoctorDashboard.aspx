<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DoctorDashboard.aspx.cs" Inherits="PulsePoint.DoctorDashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Doctor Dashboard - PulsePoint</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #eef2f7; margin: 0; padding: 0; }
        .container { width: 800px; margin: 40px auto; background: #fff; padding: 20px; border-radius: 5px; box-shadow: 0 0 10px #aaa; }
        h2 { text-align: center; color: #333; }
        .gridview { margin-top: 20px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Today's Appointments</h2>
        <asp:GridView ID="gvTodayAppointments" runat="server" AutoGenerateColumns="False" CssClass="gridview">
            <Columns>
                <asp:BoundField DataField="PatientName" HeaderText="Patient Name" />
                <asp:BoundField DataField="AppointmentTime" HeaderText="Time" />
                <asp:BoundField DataField="ReasonForVisit" HeaderText="Reason" />
                <asp:BoundField DataField="Status" HeaderText="Status" />
            </Columns>
        </asp:GridView>
    </div>
</body>
</html>