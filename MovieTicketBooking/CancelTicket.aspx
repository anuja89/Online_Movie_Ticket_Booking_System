<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CancelTicket.aspx.cs" Inherits="MovieTicketBooking.CancelTicket" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Cancel Ticket-CineBook</title>
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet"/>
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        :root { --gold:#F5C518; --red:#E50914; --dark:#0A0A0A; --card:#141414; --border:rgba(255,255,255,0.08); --text:#EDEDED; --muted:#666; }

        body {
            font-family: 'Inter', sans-serif; min-height: 100vh;
            background: var(--dark);
            background-image: radial-gradient(ellipse at 50% 40%, rgba(229,9,20,0.08) 0%, transparent 60%);
            display: flex; align-items: center; justify-content: center; padding: 24px;
            color: var(--text);
        }

        .panel {
            width: 100%; max-width: 480px;
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 12px; padding: 44px 40px;
            box-shadow: 0 24px 64px rgba(0,0,0,0.6);
        }

        .icon-wrap { text-align: center; font-size: 40px; margin-bottom: 12px; }
        h2 { text-align: center; font-size: 22px; font-weight: 600; color: #fff; margin-bottom: 8px; }
        .subtitle { text-align: center; font-size: 13px; color: var(--muted); margin-bottom: 32px; line-height: 1.6; }

        .field { margin-bottom: 18px; }
        .field-label {
            display: block; font-size: 11px; font-weight: 600;
            letter-spacing: 0.8px; text-transform: uppercase;
            color: var(--muted); margin-bottom: 7px;
        }

        .input-box {
            display: block; width: 100%;
            padding: 12px 14px;
            background: rgba(255,255,255,0.05);
            border: 1px solid var(--border);
            border-radius: 6px; color: var(--text);
            font-family: 'Inter', sans-serif; font-size: 15px;
            transition: border-color 0.2s; outline: none;
        }
        .input-box:focus { border-color: var(--red); background: rgba(229,9,20,0.04); }

        /* slot select */
        .slot-select {
            display: block; width: 100%;
            padding: 12px 14px;
            background: rgba(255,255,255,0.05);
            border: 1px solid var(--border);
            border-radius: 6px; color: var(--text);
            font-family: 'Inter', sans-serif; font-size: 15px;
            outline: none; cursor: pointer; appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='8' viewBox='0 0 12 8'%3E%3Cpath d='M1 1l5 5 5-5' stroke='%23888' stroke-width='1.5' fill='none' stroke-linecap='round'/%3E%3C/svg%3E");
            background-repeat: no-repeat; background-position: right 14px center;
        }
        .slot-select option { background: #1a1a1a; }

        /* calendar wrapper — styled to match dark theme */
        .cal-wrap {
            margin-top: 6px;
            border-radius: 8px; overflow: hidden;
            border: 1px solid var(--border);
        }

        .btn-row { display: flex; gap: 12px; margin-top: 28px; }
        .btn {
            flex: 1; padding: 13px; border: none; border-radius: 6px;
            font-family: 'Inter', sans-serif; font-size: 14px; font-weight: 600;
            cursor: pointer; transition: opacity 0.2s, transform 0.15s;
        }
        .btn:hover { opacity: 0.9; transform: translateY(-1px); }
        .btn-cancel { background: var(--red); color: #fff; }
        .btn-back   { background: rgba(255,255,255,0.07); color: var(--muted); border: 1px solid var(--border); }

        /* hide the date text box — it's driven by calendar, no need to show */
        .hidden-input { display: none; }

        .btn-logout {
    padding: 8px 20px;
    background: transparent;
    border: 1px solid rgba(229,9,20,0.5);
    border-radius: 20px;
    color: #ff6b6b;
    font-family: 'Inter', sans-serif;
    font-size: 12px; font-weight: 600;
    letter-spacing: 0.5px;
    cursor: pointer;
    transition: background 0.2s, border-color 0.2s;
}
.btn-logout:hover { background: rgba(229,9,20,0.15); border-color: var(--red); }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="panel">
            <div class="icon-wrap">🎟️</div>
            <h2>Cancel Ticket</h2>
            <p class="subtitle">Select your booking date and enter the details below. This action cannot be undone.</p>

            <%-- Movie ID — matches txtMid in code-behind --%>
            <div class="field">
                <label class="field-label">Movie ID</label>
                <asp:TextBox ID="txtMid" runat="server" CssClass="input-box"></asp:TextBox>
            </div>

            <%-- Slot — matches txtSlot in code-behind --%>
            <div class="field">
                <label class="field-label">Show Slot</label>
                <asp:TextBox ID="txtSlot" runat="server" CssClass="input-box" placeholder="e.g. 1"></asp:TextBox>
            </div>

            <%-- Seat — matches txtSeat in code-behind --%>
            <div class="field">
                <label class="field-label">Seat Number</label>
                <asp:TextBox ID="txtSeat" runat="server" CssClass="input-box"></asp:TextBox>
            </div>

            <%-- Booking date — driven by Calendar1, txtDate holds formatted value --%>
            <div class="field">
                <label class="field-label">Booking Date</label>
                <asp:TextBox ID="txtDate" runat="server" CssClass="input-box" ReadOnly="True"></asp:TextBox>
                <div class="cal-wrap">
                    <asp:Calendar ID="Calendar1" runat="server"
                        OnSelectionChanged="Calendar1_SelectionChanged"
                        Width="100%"
                        BackColor="#1a1a1a"
                        BorderColor="#333"
                        BorderWidth="0px"
                        DayNameFormat="Shortest"
                        Font-Names="Inter, Arial"
                        Font-Size="13px"
                        ForeColor="#EDEDED"
                        ShowGridLines="False">
                        <DayHeaderStyle BackColor="#111" ForeColor="#666" Font-Bold="True" />
                        <NextPrevStyle ForeColor="#F5C518" Font-Bold="True" />
                        <OtherMonthDayStyle ForeColor="#444" />
                        <SelectedDayStyle BackColor="#E50914" ForeColor="#fff" Font-Bold="True" />
                        <SelectorStyle BackColor="#222" />
                        <TitleStyle BackColor="#0F0F0F" ForeColor="#F5C518" Font-Bold="True" Font-Size="14px" />
                        <TodayDayStyle BackColor="#2a2a2a" ForeColor="#F5C518" />
                    </asp:Calendar>
                </div>
            </div>

            <div class="btn-row">
    <asp:Button ID="btnCancel" runat="server" Text="Cancel Ticket" CssClass="btn btn-cancel" OnClick="btnCancel_Click" />
    <asp:Button ID="btnLogout" runat="server" Text="Log Out" CssClass="btn-logout" OnClick="btnLogout_Click" CausesValidation="False" />
</div>
        </div>
    </form>
</body>
</html>
