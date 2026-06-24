<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Receipt_Form.aspx.cs" Inherits="MovieTicketBooking.Receipt_Form" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-8" />
    <title>Booking Confirmation - CineBook</title>
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet"/>
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        :root { --gold:#F5C518; --red:#E50914; --dark:#0A0A0A; --card:#141414; --border:rgba(255,255,255,0.08); --text:#EDEDED; --muted:#666; }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--dark);
            background-image: radial-gradient(ellipse at 50% 0%, rgba(245,197,24,0.08) 0%, transparent 50%);
            color: var(--text);
            min-height: 100vh;
            display: flex; flex-direction: column;
            align-items: center; justify-content: center;
            padding: 32px 16px;
        }

        .ticket {
            width: 100%; max-width: 480px;
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 14px;
            overflow: hidden;
            box-shadow: 0 32px 80px rgba(0,0,0,0.7);
        }

        /* header strip */
        .ticket-head {
            background: var(--gold);
            padding: 26px 32px;
            display: flex; align-items: center; justify-content: space-between;
        }
        .ticket-head .brand { font-family: 'Bebas Neue', sans-serif; font-size: 26px; letter-spacing: 3px; color: #0A0A0A; }
        .ticket-head .confirmed { font-size: 13px; font-weight: 700; color: #0A0A0A; letter-spacing: 0.5px; }

        /* perforated divider */
        .perf {
            height: 22px; position: relative;
            background: var(--dark);
            display: flex; align-items: center;
        }
        .perf::before, .perf::after {
            content: '';
            position: absolute; top: 50%; transform: translateY(-50%);
            width: 22px; height: 22px; border-radius: 50%;
            background: var(--dark);
        }
        .perf::before { left: -11px; }
        .perf::after  { right: -11px; }
        .perf-dots {
            flex: 1; margin: 0 12px;
            border-top: 2px dashed rgba(255,255,255,0.1);
        }

        /* body */
        .ticket-body { padding: 28px 32px 32px; }

        .success-icon {
            text-align: center; font-size: 44px; margin-bottom: 10px;
        }
        .success-msg {
            text-align: center; color: #22C55E; font-size: 13px; font-weight: 600;
            letter-spacing: 1px; text-transform: uppercase; margin-bottom: 28px;
        }

        /* detail rows */
        .detail-row {
            display: flex; justify-content: space-between; align-items: baseline;
            padding: 12px 0;
            border-bottom: 1px solid rgba(255,255,255,0.06);
        }
        .detail-row:last-of-type { border-bottom: none; }
        .detail-key   { font-size: 12px; color: var(--muted); text-transform: uppercase; letter-spacing: 0.8px; }
        .detail-value { font-size: 15px; font-weight: 600; color: var(--text); text-align: right; max-width: 60%; }

        .total-row {
            display: flex; justify-content: space-between; align-items: center;
            margin-top: 20px; padding-top: 20px;
            border-top: 1px solid rgba(245,197,24,0.25);
        }
        .total-key   { font-size: 13px; font-weight: 600; color: var(--muted); text-transform: uppercase; letter-spacing: 1px; }
        .total-value { font-size: 28px; font-weight: 700; color: var(--gold); }

        /* actions */
        .actions {
            display: flex; gap: 12px; margin-top: 28px;
        }
        .btn-cancel {
            flex: 1; padding: 13px;
            background: rgba(229,9,20,0.12); color: #ff6b6b;
            border: 1px solid rgba(229,9,20,0.3); border-radius: 6px;
            font-family: 'Inter', sans-serif; font-size: 13px; font-weight: 600;
            cursor: pointer; transition: background 0.2s;
        }
        .btn-cancel:hover { background: rgba(229,9,20,0.2); }

        .btn-logout {
            flex: 1; padding: 13px;
            background: transparent; color: var(--muted);
            border: 1px solid var(--border); border-radius: 6px;
            font-family: 'Inter', sans-serif; font-size: 13px; font-weight: 600;
            cursor: pointer; transition: background 0.2s;
        }
        .btn-logout:hover { background: rgba(255,255,255,0.05); }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="ticket">
            <div class="ticket-head">
                <span class="brand">CineBook</span>
                <span class="confirmed">- Booking Confirmed</span>
            </div>

            <div class="perf"><div class="perf-dots"></div></div>

            <div class="ticket-body">
                <div class="success-icon">🎬</div>
                <p class="success-msg">Enjoy your movie!</p>

                <div class="detail-row">
                    <span class="detail-key">Movie ID</span>
                    <asp:Label ID="lblMid" runat="server" CssClass="detail-value"></asp:Label>
                </div>
                <div class="detail-row">
                    <span class="detail-key">Movie</span>
                    <asp:Label ID="lblMovie" runat="server" CssClass="detail-value"></asp:Label>
                </div>
                <div class="detail-row">
                    <span class="detail-key">Show Slot</span>
                    <asp:Label ID="lblSlot" runat="server" CssClass="detail-value"></asp:Label>
                </div>
                <div class="detail-row">
                    <span class="detail-key">Your Seats</span>
                    <asp:Label ID="lblSeats" runat="server" CssClass="detail-value"></asp:Label>
                </div>
                <div class="detail-row">
                    <span class="detail-key">Date</span>
                    <asp:Label ID="lblDate" runat="server" CssClass="detail-value"></asp:Label>
                </div>

                <div class="total-row">
                    <span class="total-key">Total</span>
                    <asp:Label ID="lblTotalPrice" runat="server" CssClass="total-value"></asp:Label>
                </div>

                <div class="actions">
                    <asp:Button ID="Button1"   runat="server" Text="Cancel Ticket" CssClass="btn-cancel"  OnClick="Button1_Click" />
                    <asp:Button ID="btnLogout" runat="server" Text="Log Out"        CssClass="btn-logout"  OnClick="btnLogout_Click" CausesValidation="False" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
