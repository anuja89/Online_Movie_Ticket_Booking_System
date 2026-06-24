
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="user2Report.aspx.cs" Inherits="MovieTicketBooking.user2Report" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Users Report</title>
    <style>
        /* Modern, high-end design for your logout button */
.btn-logout-beautiful {
    background: linear-gradient(135deg, #e53935, #b71c1c) !important;
    color: #ffffff !important;
    font-family: 'Segoe UI', Arial, sans-serif !important;
    font-size: 13px !important;
    font-weight: 600 !important;
    padding: 8px 22px !important;
    border: none !important;
    border-radius: 20px !important; /* Smooth capsule shape */
    cursor: pointer !important;
    box-shadow: 0 4px 10px rgba(183, 28, 28, 0.3) !important;
    transition: all 0.25s ease-in-out !important;
    text-transform: uppercase !important;
    letter-spacing: 0.8px !important;
    display: inline-block !important;
    outline: none !important;
}

/* Hover state styling */
.btn-logout-beautiful:hover {
    background: linear-gradient(135deg, #d32f2f, #c62828) !important;
    box-shadow: 0 6px 15px rgba(183, 28, 28, 0.5) !important;
    transform: translateY(-1px) !important; /* Clean interactive lift */
}

/* Pressed/Active state styling */
.btn-logout-beautiful:active {
    transform: translateY(1px) !important;
    box-shadow: 0 2px 5px rgba(183, 28, 28, 0.2) !important;
}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        
    <%--<div style="margin-top:50px; margin-left:60px;">
        <asp:Button ID="Button1" runat="server" Text="View Users" Font-Bold="True" Font-Size="Medium" OnClick="Button1_Click" />
    </div>--%>
        <div>
            <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true" />
        </div>
        <div class="logout-wrapper" style="text-align: right; padding: 10px 20px;">
    <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn-logout-beautiful" OnClick="btnLogout_Click" CausesValidation="False" />
</div>
    </form>
</body>
</html>
