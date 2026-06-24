<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="movieshow.aspx.cs" Inherits="MovieTicketBooking.movieshow" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Manage Shows — CineBook Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet"/>
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        :root { --gold:#F5C518; --red:#E50914; --dark:#0A0A0A; --card:#141414; --border:rgba(255,255,255,0.08); --text:#EDEDED; --muted:#666; }

        body { font-family: 'Inter', sans-serif; background: var(--dark); color: var(--text); min-height: 100vh; }

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

        .topbar-actions { display: flex; gap: 10px; align-items: center; }
        .btn-nav {
            padding: 8px 18px; background: transparent;
            border: 1px solid var(--border); border-radius: 20px;
            color: var(--muted); font-family: 'Inter', sans-serif;
            font-size: 12px; font-weight: 600; cursor: pointer;
            transition: background 0.2s, color 0.2s;
        }
        .btn-nav:hover { background: rgba(255,255,255,0.06); color: var(--text); }
        .btn-logout {
            padding: 8px 18px; background: transparent;
            border: 1px solid rgba(229,9,20,0.4); border-radius: 20px;
            color: #ff6b6b; font-family: 'Inter', sans-serif;
            font-size: 12px; font-weight: 600; cursor: pointer;
            transition: background 0.2s;
        }
        .btn-logout:hover { background: rgba(229,9,20,0.15); }

        /* ── Layout ── */
        .page { max-width: 900px; margin: 0 auto; padding: 44px 32px 60px; }

        .page-title {
            font-family: 'Bebas Neue', sans-serif;
            font-size: 40px; letter-spacing: 2px; color: #fff;
            margin-bottom: 8px;
        }
        .page-sub { font-size: 13px; color: var(--muted); margin-bottom: 36px; }

        /* ── Card ── */
        .card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 12px; padding: 32px;
            margin-bottom: 28px;
        }
        .card-title { font-size: 13px; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; color: var(--gold); margin-bottom: 20px; }

        /* ── Fields ── */
        .field-row { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 20px; }
        .field { margin-bottom: 0; }
        .field-label { display: block; font-size: 11px; font-weight: 600; letter-spacing: 0.8px; text-transform: uppercase; color: var(--muted); margin-bottom: 7px; }

        .input-box {
            display: block; width: 100%;
            padding: 11px 13px;
            background: rgba(255,255,255,0.05);
            border: 1px solid var(--border);
            border-radius: 6px; color: var(--text);
            font-family: 'Inter', sans-serif; font-size: 14px;
            transition: border-color 0.2s; outline: none;
        }
        .input-box:focus { border-color: var(--gold); background: rgba(245,197,24,0.04); }
        .input-box[readonly] { color: var(--muted); cursor: default; }

        /* ── Dropdown ── */
        .select-box {
            display: block; width: 100%;
            padding: 11px 13px;
            background: rgba(255,255,255,0.05);
            border: 1px solid var(--border);
            border-radius: 6px; color: var(--text);
            font-family: 'Inter', sans-serif; font-size: 14px;
            outline: none; cursor: pointer; appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='8' viewBox='0 0 12 8'%3E%3Cpath d='M1 1l5 5 5-5' stroke='%23888' stroke-width='1.5' fill='none' stroke-linecap='round'/%3E%3C/svg%3E");
            background-repeat: no-repeat; background-position: right 14px center;
        }
        .select-box option { background: #1a1a1a; }

        /* ── Calendars ── */
        .cal-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 24px; margin-bottom: 24px; }
        .cal-wrap { border: 1px solid var(--border); border-radius: 8px; overflow: hidden; margin-top: 8px; }

        /* ── Buttons ── */
        .btn-row { display: flex; gap: 12px; flex-wrap: wrap; }
        .btn { padding: 12px 28px; border: none; border-radius: 6px; font-family: 'Inter', sans-serif; font-size: 14px; font-weight: 600; cursor: pointer; transition: opacity 0.2s, transform 0.15s; }
        .btn:hover { opacity: 0.88; transform: translateY(-1px); }
        .btn-add    { background: var(--gold); color: #0A0A0A; }
        .btn-update { background: #3B82F6; color: #fff; }
        .btn-reports { background: rgba(255,255,255,0.08); color: var(--text); border: 1px solid var(--border); }

        .btn-delete { background: var(--red); color: #fff; }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <header class="topbar">
            <div style="display:flex;align-items:center;gap:14px;">
                <span class="brand">CineBook</span>
                <span class="admin-badge">Admin</span>
            </div>
            <div class="topbar-actions">
                <asp:Button ID="Button4"   runat="server" Text="View Reports" CssClass="btn-nav"    OnClick="Button4_Click"   CausesValidation="False" />
                <asp:Button ID="Button3"   runat="server" Text="Home"         CssClass="btn-nav"    OnClick="Button3_Click"   CausesValidation="False" />
                <asp:Button ID="btnLogout" runat="server" Text="Log Out"      CssClass="btn-logout" OnClick="btnLogout_Click" CausesValidation="False" />
            </div>
        </header>

        <div class="page">
            <h1 class="page-title">Manage Shows</h1>
            <p class="page-sub">Schedule new shows or update existing screening dates and prices.</p>

            <%-- Movie + Price --%>
            <div class="card">
                <p class="card-title">Show Details</p>
                <div class="field-row">
                    <div class="field">
                        <label class="field-label">Movie ID</label>
                        <asp:TextBox ID="txtMid" runat="server" CssClass="input-box"></asp:TextBox>
                    </div>
                    <div class="field">
                        <label class="field-label">Select Movie</label>
                        <asp:DropDownList ID="DropDownList1" runat="server"
                            DataSourceID="SqlDataSource1"
                            DataTextField="Mname" DataValueField="Mid"
                            CssClass="select-box">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                            ConnectionString="<%$ ConnectionStrings:MovieDB %>"
                            SelectCommand="SELECT [Mid], [Mname] FROM [Movie_Details]">
                        </asp:SqlDataSource>
                    </div>
                </div>
                <div class="field-row">
                    <div class="field">
                        <label class="field-label">Ticket Price (₹)</label>
                        <asp:TextBox ID="txtPrice" runat="server" CssClass="input-box"></asp:TextBox>
                    </div>
                </div>
            </div>

            <%-- Date pickers --%>
            <div class="card">
                <p class="card-title">Screening Dates</p>
                <div class="cal-grid">
                    <div>
                        <label class="field-label">From Date</label>
                        <asp:TextBox ID="txtFrom" runat="server" CssClass="input-box" ReadOnly="True"></asp:TextBox>
                        <div class="cal-wrap">
                            <asp:Calendar ID="Calendar1" runat="server"
                                OnSelectionChanged="Calendar1_SelectionChanged"
                                Width="100%"
                                BackColor="#1a1a1a" BorderWidth="0px"
                                DayNameFormat="Shortest"
                                Font-Names="Inter, Arial" Font-Size="13px"
                                ForeColor="#EDEDED" ShowGridLines="False">
                                <DayHeaderStyle BackColor="#111" ForeColor="#666" Font-Bold="True" />
                                <NextPrevStyle ForeColor="#F5C518" Font-Bold="True" />
                                <OtherMonthDayStyle ForeColor="#444" />
                                <SelectedDayStyle BackColor="#F5C518" ForeColor="#0A0A0A" Font-Bold="True" />
                                <TitleStyle BackColor="#0F0F0F" ForeColor="#F5C518" Font-Bold="True" Font-Size="14px" />
                                <TodayDayStyle BackColor="#2a2a2a" ForeColor="#F5C518" />
                            </asp:Calendar>
                        </div>
                    </div>
                    <div>
                        <label class="field-label">To Date</label>
                        <asp:TextBox ID="txtTo" runat="server" CssClass="input-box" ReadOnly="True"></asp:TextBox>
                        <div class="cal-wrap">
                            <asp:Calendar ID="Calendar2" runat="server"
                                OnSelectionChanged="Calendar2_SelectionChanged"
                                Width="100%"
                                BackColor="#1a1a1a" BorderWidth="0px"
                                DayNameFormat="Shortest"
                                Font-Names="Inter, Arial" Font-Size="13px"
                                ForeColor="#EDEDED" ShowGridLines="False">
                                <DayHeaderStyle BackColor="#111" ForeColor="#666" Font-Bold="True" />
                                <NextPrevStyle ForeColor="#F5C518" Font-Bold="True" />
                                <OtherMonthDayStyle ForeColor="#444" />
                                <SelectedDayStyle BackColor="#F5C518" ForeColor="#0A0A0A" Font-Bold="True" />
                                <TitleStyle BackColor="#0F0F0F" ForeColor="#F5C518" Font-Bold="True" Font-Size="14px" />
                                <TodayDayStyle BackColor="#2a2a2a" ForeColor="#F5C518" />
                            </asp:Calendar>
                        </div>
                    </div>
                </div>
            </div>

            <%-- Actions --%>
            <div class="btn-row">
                <asp:Button ID="Button1" runat="server" Text="Add Show"    CssClass="btn btn-add"    OnClick="Button1_Click" />
                <asp:Button ID="Button2" runat="server" Text="Update Show" CssClass="btn btn-update" OnClick="Button2_Click" />
                <asp:Button ID="Button5" runat="server" Text="Delete Show" CssClass="btn btn-delete" OnClick="Button5_Click" />
            </div>
        </div>

    </form>
</body>
</html>