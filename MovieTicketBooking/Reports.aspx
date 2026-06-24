<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="MovieTicketBooking.Reports" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Reports — CineBook Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet"/>
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        :root { --gold:#F5C518; --red:#E50914; --dark:#0A0A0A; --card:#141414; --border:rgba(255,255,255,0.08); --text:#EDEDED; --muted:#666; }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--dark);
            background-image: radial-gradient(ellipse at 50% 0%, rgba(245,197,24,0.06) 0%, transparent 55%);
            color: var(--text); min-height: 100vh;
        }

        /* ── Topbar ── */
        .topbar {
            display: flex; align-items: center; justify-content: space-between;
            padding: 0 32px; height: 60px;
            background: rgba(14,14,14,0.98);
            border-bottom: 1px solid var(--border);
            position: sticky; top: 0; z-index: 100;
        }
        .brand { font-family: 'Bebas Neue', sans-serif; font-size: 24px; letter-spacing: 3px; color: var(--gold); }
        .admin-badge { font-size: 11px; color: var(--red); border: 1px solid rgba(229,9,20,0.4); border-radius: 10px; padding: 3px 10px; letter-spacing: 1px; text-transform: uppercase; }
        .btn-logout {
            padding: 8px 20px; background: transparent;
            border: 1px solid rgba(229,9,20,0.4); border-radius: 20px;
            color: #ff6b6b; font-family: 'Inter', sans-serif;
            font-size: 12px; font-weight: 600; cursor: pointer;
            transition: background 0.2s;
        }
        .btn-logout:hover { background: rgba(229,9,20,0.15); }

        /* ── Hero ── */
        .hero {
            text-align: center;
            padding: 70px 32px 50px;
        }
        .hero-eyebrow {
            font-size: 11px; font-weight: 600; letter-spacing: 4px;
            text-transform: uppercase; color: var(--gold); margin-bottom: 14px;
        }
        .hero h1 {
            font-family: 'Bebas Neue', sans-serif;
            font-size: clamp(42px, 6vw, 72px);
            letter-spacing: 3px; color: #fff; margin-bottom: 10px;
        }
        .hero p { font-size: 14px; color: var(--muted); }

        /* ── Report cards grid ── */
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 20px;
            max-width: 960px;
            margin: 0 auto;
            padding: 0 32px 80px;
        }

        .report-card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 12px;
            padding: 32px 28px;
            display: flex; flex-direction: column;
            align-items: flex-start;
            transition: transform 0.22s ease, border-color 0.22s ease, box-shadow 0.22s ease;
        }
        .report-card:hover {
            transform: translateY(-5px);
            border-color: rgba(245,197,24,0.25);
            box-shadow: 0 16px 40px rgba(0,0,0,0.5);
        }

        .card-icon { font-size: 32px; margin-bottom: 18px; }
        .card-label {
            font-size: 11px; font-weight: 700;
            text-transform: uppercase; letter-spacing: 1.2px;
            color: var(--gold); margin-bottom: 8px;
        }
        .card-title { font-size: 19px; font-weight: 700; color: #fff; margin-bottom: 10px; line-height: 1.2; }
        .card-desc  { font-size: 13px; color: var(--muted); line-height: 1.6; flex: 1; margin-bottom: 24px; }

        .btn-report {
            display: inline-block;
            padding: 11px 24px;
            background: var(--gold); color: #0A0A0A;
            border: none; border-radius: 6px;
            font-family: 'Inter', sans-serif; font-size: 13px; font-weight: 700;
            cursor: pointer; letter-spacing: 0.3px;
            transition: opacity 0.18s, transform 0.15s;
        }
        .btn-report:hover { opacity: 0.88; transform: translateY(-1px); }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <header class="topbar">
            <div style="display:flex;align-items:center;gap:14px;">
                <span class="brand">CineBook</span>
                <span class="admin-badge">Admin</span>
            </div>
            <asp:Button ID="btnLogout" runat="server" Text="Log Out" CssClass="btn-logout" OnClick="btnLogout_Click" CausesValidation="False" />
        </header>

        <div class="hero">
            <p class="hero-eyebrow">Admin Dashboard</p>
            <h1>Reports</h1>
            <p>Generate and view detailed reports for users, movies, and seat bookings.</p>
        </div>

        <div class="grid">

            <div class="report-card">
                <div class="card-icon">👥</div>
                <p class="card-label">Users</p>
                <h2 class="card-title">Users Report</h2>
                <p class="card-desc">View all registered user accounts, contact details, and activity information.</p>
                <asp:Button ID="btnUser" runat="server" Text="Generate Report" CssClass="btn-report" OnClick="btnUser_Click" />
            </div>

            <div class="report-card">
                <div class="card-icon">🎬</div>
                <p class="card-label">Movies</p>
                <h2 class="card-title">Movie Details Report</h2>
                <p class="card-desc">Full breakdown of all movies in the system including descriptions, pricing, and poster info.</p>
                <asp:Button ID="btnMovies" runat="server" Text="Generate Report" CssClass="btn-report" OnClick="btnMovies_Click" />
            </div>

            <div class="report-card">
                <div class="card-icon">📅</div>
                <p class="card-label">Bookings</p>
                <h2 class="card-title">Date-wise Seat Report</h2>
                <p class="card-desc">Seat allotment data filtered by date — useful for tracking occupancy and cancellations.</p>
                <asp:Button ID="btnDate" runat="server" Text="Generate Report" CssClass="btn-report" OnClick="btnDate_Click" />
            </div>

        </div>

    </form>
</body>
</html>