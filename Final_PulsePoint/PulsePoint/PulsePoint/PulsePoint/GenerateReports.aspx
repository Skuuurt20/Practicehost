<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GenerateReports.aspx.cs" Inherits="PulsePoint.GenerateReports" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Generate Reports - PulsePoint</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f8f9fa; margin: 0; padding: 0; }
        .container { width: 700px; margin: 40px auto; background: #fff; padding: 20px; border-radius: 5px; box-shadow: 0 0 10px #ccc; }
        h2 { text-align: center; color: #333; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; }
        select, input { width: 100%; padding: 8px; box-sizing: border-box; }
        .btn { background: #17a2b8; color: #fff; padding: 10px 15px; border: none; border-radius: 3px; cursor: pointer; }
        .btn:hover { background: #138496; }
        .report-output { margin-top: 20px; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Generate Report</h2>
        <asp:Panel ID="pnlReport" runat="server">
            <div class="form-group">
                <label for="ddlReportType">Report Type:</label>
                <asp:DropDownList ID="ddlReportType" runat="server">
                    <asp:ListItem Text="Daily" Value="Daily"></asp:ListItem>
                    <asp:ListItem Text="Weekly" Value="Weekly"></asp:ListItem>
                    <asp:ListItem Text="Monthly" Value="Monthly"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="form-group">
                <label for="txtReportDate">Select Date:</label>
                <asp:TextBox ID="txtReportDate" runat="server" TextMode="Date"></asp:TextBox>
            </div>
            <asp:Button ID="btnGenerateReport" runat="server" Text="Generate Report" CssClass="btn" OnClick="btnGenerateReport_Click" />
            <div class="report-output">
                <asp:Literal ID="litReportOutput" runat="server"></asp:Literal>
            </div>
        </asp:Panel>
    </div>
</body>
</html>