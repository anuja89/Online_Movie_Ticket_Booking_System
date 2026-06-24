<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login_Form.aspx.cs" Inherits="MovieTicketBooking.Login_Form" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Sign In - CineBook</title>
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
            background-image: radial-gradient(ellipse at 30% 20%, rgba(245,197,24,0.07) 0%, transparent 60%),
                              radial-gradient(ellipse at 70% 80%, rgba(229,9,20,0.07) 0%, transparent 60%);
            color: var(--text);
        }

        .panel {
            width: 100%;
            max-width: 420px;
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 12px;
            padding: 44px 40px;
            box-shadow: 0 24px 64px rgba(0,0,0,0.6);
        }

        .brand {
            display: block;
            font-family: 'Bebas Neue', sans-serif;
            font-size: 32px;
            letter-spacing: 3px;
            color: var(--gold);
            text-align: center;
            margin-bottom: 6px;
        }
        .brand-sub {
            text-align: center;
            font-size: 12px;
            color: var(--muted);
            letter-spacing: 2px;
            text-transform: uppercase;
            margin-bottom: 36px;
        }

        h2 {
            font-size: 22px;
            font-weight: 600;
            margin-bottom: 28px;
            color: #fff;
        }

        .field { margin-bottom: 20px; }
        label.field-label {
            display: block;
            font-size: 12px;
            font-weight: 600;
            letter-spacing: 0.8px;
            text-transform: uppercase;
            color: var(--muted);
            margin-bottom: 8px;
        }
        .field-label { color: var(--muted); }

        input[type="text"].input-box,
        input[type="password"].input-box,
        .input-box {
            display: block;
            width: 100%;
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

        .btn-row { display: flex; gap: 12px; margin-top: 28px; }

        .btn {
            flex: 1;
            padding: 13px;
            border: none;
            border-radius: 6px;
            font-family: 'Inter', sans-serif;
            font-size: 14px;
            font-weight: 600;
            letter-spacing: 0.5px;
            cursor: pointer;
            transition: opacity 0.2s, transform 0.15s;
        }
        .btn:hover { opacity: 0.9; transform: translateY(-1px); }

        .btn-login { background: var(--gold); color: #0A0A0A; }
        .btn-signup { background: transparent; color: var(--text); border: 1px solid var(--border); }
        .btn-signup:hover { background: rgba(255,255,255,0.07); }

        .divider {
            text-align: center;
            font-size: 12px;
            color: var(--muted);
            margin-top: 24px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="panel">
            <span class="brand">CineBook</span>
            <p class="brand-sub">Online Ticket Booking</p>

            <h2>Welcome back</h2>

            <div class="field">
                <label class="field-label">Email address</label>
                <asp:TextBox ID="TxtEmailid" runat="server" CssClass="input-box"></asp:TextBox>
                <asp:RequiredFieldValidator        ID="rfvEmail"  runat="server" ControlToValidate="TxtEmailid" ErrorMessage="Email is required."            CssClass="validator" Display="Dynamic" />
                <asp:RegularExpressionValidator    ID="revEmail"  runat="server" ControlToValidate="TxtEmailid" ErrorMessage="Enter a valid email address."  CssClass="validator" ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" Display="Dynamic" />
            </div>

            <div class="field">
                <label class="field-label">Password</label>
                <asp:TextBox ID="TxtPass" runat="server" CssClass="input-box" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPass" runat="server" ControlToValidate="TxtPass" ErrorMessage="Password is required." CssClass="validator" Display="Dynamic" />
            </div>

            <div class="btn-row">
                <asp:Button ID="login"       runat="server" Text="Sign In"       CssClass="btn btn-login"  OnClick="login_Click" />
                <asp:Button ID="newRegister" runat="server" Text="Register"       CssClass="btn btn-signup" OnClick="newRegister_Click" CausesValidation="False" />
            </div>

            <p class="divider">New here? Click Register to create your account.</p>
        </div>
    </form>
</body>
</html>
