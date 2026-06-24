<%@ Page Language="C#" AutoEventWireup="true" Codefile="New_Register_Form.aspx.cs" Inherits="MovieTicketBooking.New_Register_Form" %>
<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>New Register</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f4f4f4;
            margin: 0;
        }
        .container {
            background: white;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            width: 350px;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .form-group {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }
        label {
            width: 100px; 
            font-weight: bold;
        }
        .input-box {
            flex: 1;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .btn-container {
            text-align: center;
            margin-top: 15px;
        }
        .btn {
            padding: 10px;
            width: 100%;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            font-weight: bold;
            background-color: #3366FF;
            color: white;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>New Register</h2>

            <div class="form-group">
                <label for="TxtName">Username</label>
                <asp:TextBox ID="TxtName" runat="server" CssClass="input-box"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="TxtEmailid">Email ID</label>
                <asp:TextBox ID="TxtEmailid" runat="server" CssClass="input-box"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="TxtMob">Mobile Number</label>
                <asp:TextBox ID="TxtMob" runat="server" CssClass="input-box"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="TxtPass">Password</label>
                <asp:TextBox ID="TxtPass" runat="server" CssClass="input-box" TextMode="Password"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="ddlRole">Login As</label>
                <asp:DropDownList ID="ddlRole" runat="server" CssClass="input-box">
                <asp:ListItem Text="User" Value="user" Selected="True"></asp:ListItem>
                <asp:ListItem Text="Admin" Value="admin"></asp:ListItem>
                </asp:DropDownList>
           </div>

            <div class="btn-container">
                <asp:Button ID="Button1" runat="server"  Text="Sign Up" OnClick="Button1_Click" />
            </div>
        </div>
    </form>
</body>
</html>