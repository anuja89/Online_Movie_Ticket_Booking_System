<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="MovieTicketBooking.HomePage" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>CineBook - Online Movie Ticket Booking</title>
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet"/>
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        :root {
            --gold:   #F5C518;
            --red:    #E50914;
            --dark:   #0A0A0A;
            --card:   rgba(18,18,18,0.92);
            --text:   #EDEDED;
            --muted:  #888;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--dark);
            color: var(--text);
            min-height: 100vh;
            overflow-x: hidden;
        }

        /* ── Hero ── */
        .hero {
            position: relative;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            background-image: url('Images/Background1.jpg');
            background-size: cover;
            background-position: center;
        }
        .hero::before {
            content: '';
            position: absolute; inset: 0;
            background: linear-gradient(160deg, rgba(0,0,0,0.85) 0%, rgba(10,10,10,0.70) 100%);
        }

        /* film-strip top bar */
        .filmstrip {
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 22px;
            background: repeating-linear-gradient(
                90deg,
                #1a1a1a 0px, #1a1a1a 18px,
                var(--gold) 18px, var(--gold) 22px,
                #1a1a1a 22px, #1a1a1a 40px,
                var(--gold) 40px, var(--gold) 44px
            );
            opacity: 0.6;
        }

        .hero-content {
            position: relative;
            z-index: 1;
            padding: 0 24px;
        }

        .eyebrow {
            display: inline-block;
            font-size: 11px;
            font-weight: 600;
            letter-spacing: 4px;
            text-transform: uppercase;
            color: var(--gold);
            margin-bottom: 18px;
        }

        h1 {
            font-family: 'Bebas Neue', sans-serif;
            font-size: clamp(52px, 9vw, 110px);
            line-height: 0.9;
            letter-spacing: 2px;
            color: #fff;
            text-shadow: 0 4px 24px rgba(0,0,0,0.6);
        }

        h1 span { color: var(--gold); }

        .tagline {
            margin: 20px auto 48px;
            max-width: 480px;
            font-size: 16px;
            font-weight: 300;
            color: rgba(237,237,237,0.7);
            line-height: 1.6;
        }

        /* ── Nav Buttons ── */
        .nav-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 14px;
            justify-content: center;
        }

        .nav-btn {
            position: relative;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 14px 28px;
            font-family: 'Inter', sans-serif;
            font-size: 14px;
            font-weight: 600;
            letter-spacing: 0.5px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .nav-btn:hover { transform: translateY(-3px); }

        .btn-primary {
            background: var(--gold);
            color: #0A0A0A;
            box-shadow: 0 6px 20px rgba(245,197,24,0.35);
        }
        .btn-primary:hover { box-shadow: 0 10px 30px rgba(245,197,24,0.5); }

        .btn-outline {
            background: transparent;
            color: #fff;
            border: 2px solid rgba(255,255,255,0.35);
        }
        .btn-outline:hover {
            background: rgba(255,255,255,0.08);
            border-color: rgba(255,255,255,0.6);
        }

        .btn-danger {
            background: var(--red);
            color: #fff;
            box-shadow: 0 6px 20px rgba(229,9,20,0.35);
        }
        .btn-danger:hover { box-shadow: 0 10px 30px rgba(229,9,20,0.5); }

        /* icon prefix */
        .nav-btn::before {
            font-size: 18px;
            line-height: 1;
        }

        /* ── Footer badge ── */
        .footer-bar {
            position: absolute;
            bottom: 28px;
            left: 50%;
            transform: translateX(-50%);
            z-index: 1;
            font-size: 12px;
            color: var(--muted);
            letter-spacing: 1px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="hero">
            <div class="filmstrip"></div>

            <div class="hero-content">
                <span class="eyebrow">Your Premier Cinema Platform</span>
                <h1>CINE<span>BOOK</span></h1>
                <p class="tagline">Reserve your perfect seat for the latest blockbusters - fast, simple, and secure.</p>

                <div class="nav-grid">
    <asp:Button ID="btnLogin"      runat="server" Text="Sign In"        CssClass="nav-btn btn-primary"  OnClick="btnLogin_Click" />
    <asp:Button ID="btnSign"       runat="server" Text="Create Account" CssClass="nav-btn btn-primary"  OnClick="btnSign_Click"  CausesValidation="False" />
    <asp:Button ID="btnMovies"     runat="server" Text="Browse Movies"  CssClass="nav-btn btn-primary"  OnClick="btnMovies_Click" CausesValidation="False" />
    <asp:Button ID="btnAdminLogin" runat="server" Text="Admin Portal"   CssClass="nav-btn btn-danger"   OnClick="btnAdminLogin_Click" CausesValidation="False" />
</div>
            </div>

            <div class="footer-bar">&copy; 2025 CineBook &nbsp;&nbsp; All rights reserved</div>
        </div>
    </form>
</body>
</html>
