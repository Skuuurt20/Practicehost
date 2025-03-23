<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageAppointments.aspx.cs" Inherits="PulsePoint.ManageAppointments" %>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageAppointments.aspx.cs" Inherits="PulsePoint.ManageAppointments" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Appointments - PulsePoint</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #fdfdfd; margin: 0; padding: 0; }
        .container { width: 900px; margin: 30px auto; background: #fff; padding: 20px; border-radius: 5px; box-shadow: 0 0 10px #bbb; }
        h2 { text-align: center; color: #333; }
        .form-group { margin-bottom: 10px; }
        label { display: block; margin-bottom: 5px; color: #444; }
        input, select { padding: 8px; width: 100%; box-sizing: border-box; }
        .btn { background: #dc3545; color: #fff; padding: 8px 12px; border: none; border-radius: 3px; cursor: pointer; }
        .btn:hover { background: #c82333; }
        .search-container { margin-bottom: 20px; }
        .gridview { margin-top: 20px; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Manage Appointments</h2>
        <div class="search-container">
            <asp:TextBox ID="txtSearch" runat="server" Placeholder="Search by patient name or date"></asp:TextBox>
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" OnClick="btnSearch_Click" />
        </div>
        <asp:GridView ID="gvAppointments" runat="server" AutoGenerateColumns="False" CssClass="gridview">
            <Columns>
                <asp:BoundField DataField="PatientName" HeaderText="Patient Name" />
                <asp:BoundField DataField="AppointmentDate" HeaderText="Date" DataFormatString="{0:d}" />
                <asp:BoundField DataField="AppointmentTime" HeaderText="Time" />
                <asp:BoundField DataField="ReasonForVisit" HeaderText="Reason" />
                <asp:BoundField DataField="Status" HeaderText="Status" />
                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandArgument='<%# Eval("AppointmentID") %>' OnClick="btnEdit_Click" />
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CommandArgument='<%# Eval("AppointmentID") %>' OnClick="btnCancel_Click" />
                        <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandArgument='<%# Eval("AppointmentID") %>' OnClick="btnDelete_Click" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</body>
</html>
