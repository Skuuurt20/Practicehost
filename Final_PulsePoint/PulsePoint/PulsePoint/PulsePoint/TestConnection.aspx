<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TestConnection.aspx.cs" Inherits="PulsePoint.TestConnection" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Test Database Connection</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .message { font-size: 18px; color: green; }
        .error { font-size: 18px; color: red; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="btnTestConnection" runat="server" Text="Test Connection" OnClick="btnTestConnection_Click" />
            <br /><br />
            <asp:Label ID="lblResult" runat="server"></asp:Label>
        </div>
    </form>
</body>
</html>