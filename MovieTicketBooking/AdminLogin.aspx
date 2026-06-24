<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="MovieTicketBooking.AdminLogin" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Admin Portal-CineBook</title>
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet"/>
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        :root { --gold:#F5C518; --red:#E50914; --dark:#0A0A0A; --card:#0F0F0F; --border:rgba(229,9,20,0.25); --text:#EDEDED; --muted:#666; }

        body {
            font-family: 'Inter', sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #050505;
            background-image: radial-gradient(ellipse at 50% 40%, rgba(229,9,20,0.1) 0%, transparent 65%);
            color: var(--text);
        }

        .panel {
            width: 100%; max-width: 400px;
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 12px;
            padding: 48px 40px;
            box-shadow: 0 24px 64px rgba(0,0,0,0.8), 0 0 0 1px rgba(229,9,20,0.05);
        }

        .shield {
            width: 52px; height: 52px;
            background: rgba(229,9,20,0.12);
            border: 1.5px solid rgba(229,9,20,0.4);
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            margin: 0 auto 20px;
            font-size: 22px;
        }

        .brand { display: block; font-family: 'Bebas Neue', sans-serif; font-size: 26px; letter-spacing: 3px; color: var(--gold); text-align: center; }
        .panel-title { text-align: center; font-size: 20px; font-weight: 600; margin: 20px 0 32px; color: #fff; }

        .field { margin-bottom: 18px; }
        label.field-label { display: block; font-size: 11px; font-weight: 600; letter-spacing: 0.8px; text-transform: uppercase; color: var(--muted); margin-bottom: 7px; }

        .input-box {
            display: block; width: 100%;
            padding: 12px 14px;
            background: rgba(255,255,255,0.04);
            border: 1px solid rgba(255,255,255,0.08);
            border-radius: 6px;
            color: var(--text);
            font-size: 15px; font-family: 'Inter', sans-serif;
            transition: border-color 0.2s; outline: none;
        }
        .input-box:focus { border-color: var(--red); background: rgba(229,9,20,0.04); }

        .validator { display: block; font-size: 12px; color: #ff6b6b; margin-top: 5px; }

        .btn-admin {
            display: block; width: 100%; margin-top: 28px;
            padding: 14px;
            background: var(--red);
            color: #fff;
            border: none; border-radius: 6px;
            font-family: 'Inter', sans-serif; font-size: 14px; font-weight: 700;
            letter-spacing: 1px; text-transform: uppercase;
            cursor: pointer;
            transition: background 0.2s, transform 0.15s;
            box-shadow: 0 6px 20px rgba(229,9,20,0.35);
        }
        .btn-admin:hover { background: #c1000e; transform: translateY(-1px); }

        .secure-note { text-align: center; font-size: 11px; color: var(--muted); margin-top: 16px; letter-spacing: 0.5px; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="panel">
            <div class="shield">🔐</div>
            <span class="brand">CineBook</span>
            <h2 class="panel-title">Admin Portal</h2>

            <div class="field">
                <label class="field-label">Admin Email</label>
                <asp:TextBox ID="TxtEmailid" runat="server" CssClass="input-box"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="TxtEmailid" ErrorMessage="Email is required." CssClass="validator" Display="Dynamic" />
            </div>

            <div class="field">
                <label class="field-label">Password</label>
                <asp:TextBox ID="TxtPass" runat="server" CssClass="input-box" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPass" runat="server" ControlToValidate="TxtPass" ErrorMessage="Password is required." CssClass="validator" Display="Dynamic" />
            </div>

            <asp:Button ID="login" runat="server" Text="Secure Login" CssClass="btn-admin" OnClick="login_Click" />
            <p class="secure-note">Restricted access · Authorised personnel only</p>
        </div>
    </form>
</body>
</html>
