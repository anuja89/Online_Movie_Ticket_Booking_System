<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUpForm.aspx.cs" Inherits="MovieTicketBooking.SignUpForm" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Create Account - CineBook</title>
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet"/>
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        :root { --gold:#F5C518; --red:#E50914; --dark:#0A0A0A; --card:#141414; --border:rgba(255,255,255,0.1); --text:#EDEDED; --muted:#888; }

        body {
            font-family: 'Inter', sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: var(--dark);
            background-image: radial-gradient(ellipse at 70% 20%, rgba(229,9,20,0.07) 0%, transparent 60%),
                              radial-gradient(ellipse at 30% 80%, rgba(245,197,24,0.07) 0%, transparent 60%);
            color: var(--text);
            padding: 32px 16px;
        }

        .panel {
            width: 100%;
            max-width: 440px;
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 12px;
            padding: 44px 40px;
            box-shadow: 0 24px 64px rgba(0,0,0,0.6);
        }

        .brand { display: block; font-family: 'Bebas Neue', sans-serif; font-size: 28px; letter-spacing: 3px; color: var(--gold); text-align: center; margin-bottom: 4px; }
        .brand-sub { text-align: center; font-size: 11px; color: var(--muted); letter-spacing: 2px; text-transform: uppercase; margin-bottom: 32px; }
        h2 { font-size: 22px; font-weight: 600; margin-bottom: 28px; color: #fff; }

        .field { margin-bottom: 18px; }
        label.field-label { display: block; font-size: 11px; font-weight: 600; letter-spacing: 0.8px; text-transform: uppercase; color: var(--muted); margin-bottom: 7px; }

        .input-box {
            display: block; width: 100%;
            padding: 12px 14px;
            background: rgba(255,255,255,0.05);
            border: 1px solid var(--border);
            border-radius: 6px;
            color: var(--text);
            font-size: 15px;
            font-family: 'Inter', sans-serif;
            transition: border-color 0.2s;
            outline: none;
        }
        .input-box:focus { border-color: var(--gold); background: rgba(245,197,24,0.04); }

        .validator { display: block; font-size: 12px; color: #ff6b6b; margin-top: 5px; }

        .btn-submit {
            display: block; width: 100%;
            margin-top: 28px;
            padding: 14px;
            background: var(--gold);
            color: #0A0A0A;
            border: none;
            border-radius: 6px;
            font-family: 'Inter', sans-serif;
            font-size: 15px;
            font-weight: 700;
            letter-spacing: 0.5px;
            cursor: pointer;
            transition: opacity 0.2s, transform 0.15s;
        }
        .btn-submit:hover { opacity: 0.9; transform: translateY(-1px); }

        .signin-link { text-align: center; font-size: 13px; color: var(--muted); margin-top: 20px; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="panel">
            <span class="brand">CineBook</span>
            <p class="brand-sub">Online Ticket Booking</p>

            <h2>Create your account</h2>

            <div class="field">
                <label class="field-label">Full Name</label>
                <asp:TextBox ID="TxtName" runat="server" CssClass="input-box"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvUname" runat="server" ControlToValidate="TxtName" ErrorMessage="Name is required." CssClass="validator" Display="Dynamic" />
            </div>

            <div class="field">
                <label class="field-label">Email Address</label>
                <asp:TextBox ID="TxtEmailid" runat="server" CssClass="input-box"></asp:TextBox>
                <asp:RequiredFieldValidator     ID="RequiredFieldValidator1"  runat="server" ControlToValidate="TxtEmailid" ErrorMessage="Email is required."           CssClass="validator" Display="Dynamic" />
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TxtEmailid" ErrorMessage="Enter a valid email address." CssClass="validator" ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" Display="Dynamic" />
            </div>

            <div class="field">
                <label class="field-label">Mobile Number</label>
                <asp:TextBox ID="TxtMob" runat="server" CssClass="input-box"></asp:TextBox>
                <asp:RequiredFieldValidator     ID="rfvMobile"  runat="server" ControlToValidate="TxtMob" ErrorMessage="Mobile number is required."                               CssClass="validator" Display="Dynamic" />
                <asp:RegularExpressionValidator ID="revMobile"  runat="server" ControlToValidate="TxtMob" ErrorMessage="Enter a valid 10-digit number starting with 6–9." CssClass="validator" ValidationExpression="^[6-9]\d{9}$" Display="Dynamic" />
            </div>

            <div class="field">
                <label class="field-label">Password</label>
                <asp:TextBox ID="TxtPass" runat="server" CssClass="input-box" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPass" runat="server" ControlToValidate="TxtPass" ErrorMessage="Password is required." CssClass="validator" Display="Dynamic" />
            </div>

            <asp:Button ID="Button1" runat="server" Text="Create Account" CssClass="btn-submit" OnClick="Button1_Click" />
            <p class="signin-link">Already have an account? Go back to <a href="Login_Form.aspx">Sign In</p>
        </div>
    </form>
</body>
</html>
