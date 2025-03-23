<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookAppointment.aspx.cs" Inherits="PulsePoint.BookAppointment" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Book Appointment - PulsePoint</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #e9ecef; margin: 0; padding: 0; }
        .container { width: 800px; margin: 50px auto; background: #fff; padding: 20px; border-radius: 5px; box-shadow: 0 0 10px #aaa; }
        h2 { text-align: center; color: #333; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; color: #555; }
        input, select, textarea { width: 100%; padding: 8px; box-sizing: border-box; }
        .btn { background: #007bff; color: #fff; padding: 10px 15px; border: none; border-radius: 3px; cursor: pointer; }
        .btn:hover { background: #0069d9; }
        .gridview-container { margin-top: 30px; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Book Your Appointment</h2>
        <asp:Panel ID="pnlBookAppointment" runat="server">
            <div class="form-group">
                <label for="txtFullName">Full Name:</label>
                <asp:TextBox ID="txtFullName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvFullName" runat="server" ControlToValidate="txtFullName" ErrorMessage="Full Name is required" CssClass="error"></asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <label for="txtContact">Contact Number:</label>
                <asp:TextBox ID="txtContact" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvContact" runat="server" ControlToValidate="txtContact" ErrorMessage="Contact Number is required" CssClass="error"></asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <label for="txtEmail">Email:</label>
                <asp:TextBox ID="txtEmail" runat="server" TextMode="Email"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required" CssClass="error"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                    ErrorMessage="Invalid email format" CssClass="error"
                    ValidationExpression="\w+([-+.'']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">
                </asp:RegularExpressionValidator>
            </div>
            <div class="form-group">
                <label for="txtReason">Reason for Visit:</label>
                <asp:TextBox ID="txtReason" runat="server" TextMode="MultiLine" Rows="3"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvReason" runat="server" ControlToValidate="txtReason" ErrorMessage="Reason for visit is required" CssClass="error"></asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <label for="ddlTimeSlots">Preferred Time Slot:</label>
                <asp:DropDownList ID="ddlTimeSlots" runat="server">
                    <asp:ListItem Text="1:00 PM" Value="13:00"></asp:ListItem>
                    <asp:ListItem Text="1:30 PM" Value="13:30"></asp:ListItem>
                    <asp:ListItem Text="2:00 PM" Value="14:00"></asp:ListItem>
                    <asp:ListItem Text="2:30 PM" Value="14:30"></asp:ListItem>
                    <asp:ListItem Text="3:00 PM" Value="15:00"></asp:ListItem>
                    <asp:ListItem Text="3:30 PM" Value="15:30"></asp:ListItem>
                    <asp:ListItem Text="4:00 PM" Value="16:00"></asp:ListItem>
                    <asp:ListItem Text="4:30 PM" Value="16:30"></asp:ListItem>
                    <asp:ListItem Text="5:00 PM" Value="17:00"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="form-group">
                <label for="txtAppointmentDate">Appointment Date:</label>
                <asp:TextBox ID="txtAppointmentDate" runat="server" TextMode="Date"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvDate" runat="server" ControlToValidate="txtAppointmentDate" ErrorMessage="Appointment date is required" CssClass="error"></asp:RequiredFieldValidator>
            </div>
            <asp:Button ID="btnBook" runat="server" Text="Book Appointment" CssClass="btn" OnClick="btnBook_Click" />
        </asp:Panel>
        <div class="gridview-container">
            <asp:GridView ID="gvAppointments" runat="server" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField DataField="AppointmentTime" HeaderText="Time" />
                    <asp:BoundField DataField="Status" HeaderText="Status" />
                    <!-- Additional fields as needed -->
                </Columns>
            </asp:GridView>
        </div>
    </div>
</body>
</html>