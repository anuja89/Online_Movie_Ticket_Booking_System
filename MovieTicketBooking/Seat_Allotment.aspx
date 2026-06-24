<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Seat_Allotment.aspx.cs" Inherits="MovieTicketBooking.Seat_Allotment" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Select Seats - CineBook</title>
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet"/>
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        :root { --gold:#F5C518; --red:#E50914; --dark:#0A0A0A; --card:#141414; --border:rgba(255,255,255,0.08); --text:#EDEDED; --muted:#666; --avail:#22C55E; --booked:#EF4444; --selected:#F5C518; }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--dark);
            background-image: url('Images/MovieBackground2.jpg');
            background-size: cover; background-position: center; background-attachment: fixed;
            color: var(--text); min-height: 100vh;
        }
        body::before {
            content: ''; position: fixed; inset: 0;
            background: rgba(0,0,0,0.82);
            z-index: 0;
        }

        .page { position: relative; z-index: 1; padding: 0 0 60px; }

        /* topbar */
        .topbar {
            display: flex; align-items: center; justify-content: space-between;
            padding: 0 32px; height: 60px;
            background: rgba(10,10,10,0.9);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid var(--border);
            position: sticky; top: 0; z-index: 100;
        }
        .brand { font-family: 'Bebas Neue', sans-serif; font-size: 24px; letter-spacing: 3px; color: var(--gold); }
        .btn-logout {
            padding: 8px 20px; background: transparent;
            border: 1px solid rgba(229,9,20,0.5); border-radius: 20px;
            color: #ff6b6b; font-family: 'Inter', sans-serif; font-size: 12px; font-weight: 600;
            cursor: pointer; transition: background 0.2s;
        }
        .btn-logout:hover { background: rgba(229,9,20,0.15); }

        /* screen */
        .screen-wrap { text-align: center; padding: 40px 32px 24px; }
        .screen {
            display: inline-block;
            width: min(580px, 90%);
            padding: 12px 0;
            background: linear-gradient(180deg, rgba(245,197,24,0.25), rgba(245,197,24,0.05));
            border-top: 3px solid var(--gold);
            border-radius: 0 0 50% 50% / 0 0 20px 20px;
            font-family: 'Bebas Neue', sans-serif;
            font-size: 18px; letter-spacing: 8px; color: var(--gold);
        }
        .screen-label { font-size: 11px; color: var(--muted); letter-spacing: 3px; text-transform: uppercase; margin-top: 14px; }

        /* legend */
        .legend {
            display: flex; gap: 24px; justify-content: center; align-items: center;
            margin: 24px 0;
        }
        .legend-item { display: flex; align-items: center; gap: 8px; font-size: 13px; color: var(--muted); }
        .swatch { width: 28px; height: 28px; border-radius: 5px; }
        .swatch-avail    { background: var(--avail); }
        .swatch-booked   { background: var(--booked); }
        .swatch-selected { background: var(--selected); }

        /* instruction */
        .instruction { text-align: center; font-size: 13px; color: var(--muted); margin-bottom: 24px; }

        /* seat grid */
        .seat-arena {
            background: rgba(14,14,14,0.85);
            border: 1px solid var(--border);
            border-radius: 12px;
            padding: 28px;
            max-width: 780px;
            margin: 0 auto;
        }

        .seat-section {
            display: grid;
            grid-template-columns: repeat(10, 1fr);
            gap: 8px;
            margin-bottom: 20px;
        }
        .seat-section + .seat-section { border-top: 1px dashed rgba(255,255,255,0.06); padding-top: 20px; }

        /* each seat button */
        .btn1 {
            aspect-ratio: 1;
            border: none; border-radius: 6px;
            background: var(--avail);
            color: #0A0A0A;
            font-family: 'Inter', sans-serif; font-size: 11px; font-weight: 700;
            cursor: pointer;
            transition: transform 0.1s, opacity 0.15s;
        }
        .btn1:hover { transform: scale(1.12); }

        /* continue */
        .continue-wrap { text-align: center; margin-top: 20px; }
        .btn-continue {
            padding: 15px 60px;
            background: var(--gold); color: #0A0A0A;
            border: none; border-radius: 6px;
            font-family: 'Inter', sans-serif; font-size: 15px; font-weight: 700;
            cursor: pointer;
            transition: opacity 0.2s, transform 0.15s;
            box-shadow: 0 8px 24px rgba(245,197,24,0.3);
        }
        .btn-continue:hover { opacity: 0.9; transform: translateY(-2px); }

        /* status-button legend items (keep the hidden server controls) */
        .hidden-status { display: none; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="page">

            <header class="topbar">
                <span class="brand">CineBook</span>
                <asp:Button ID="btnLogout" runat="server" Text="Log Out" CssClass="btn-logout" OnClick="btnLogout_Click" CausesValidation="False" />
            </header>

            <%-- Hidden status controls (required by code-behind) --%>
            <div class="hidden-status">
                <asp:Button ID="Button1" runat="server" Text="Booked"    BackColor="Red"  Font-Bold="True" Height="40px" Width="90px" />
                <asp:Button ID="Button2" runat="server" Text="Selected"  BackColor="Gray" Font-Bold="True" Height="40px" Width="90px" />
                <asp:Button ID="Button3" runat="server" Text="Available" BackColor="Lime" Font-Bold="True" Height="40px" Width="90px" />
            </div>

            <div class="screen-wrap">
                <div class="screen">SCREEN</div>
                <p class="screen-label">all eyes this way</p>
            </div>

            <div class="legend">
                <div class="legend-item"><div class="swatch swatch-avail"></div> Available</div>
                <div class="legend-item"><div class="swatch swatch-selected"></div> Selected</div>
                <div class="legend-item"><div class="swatch swatch-booked"></div> Booked</div>
            </div>

            <p class="instruction">Click seats to select or deselect. Then press Continue.</p>

            <div class="seat-arena">
                <%-- Row A: seats 01-10 --%>
                <div class="seat-section">
                    <asp:Button ID="Button4"  runat="server" CssClass="btn1" Text="01" />
                    <asp:Button ID="Button5"  runat="server" CssClass="btn1" Text="02" />
                    <asp:Button ID="Button6"  runat="server" CssClass="btn1" Text="03" />
                    <asp:Button ID="Button7"  runat="server" CssClass="btn1" Text="04" />
                    <asp:Button ID="Button8"  runat="server" CssClass="btn1" Text="05" />
                    <asp:Button ID="Button9"  runat="server" CssClass="btn1" Text="06" />
                    <asp:Button ID="Button10" runat="server" CssClass="btn1" Text="07" />
                    <asp:Button ID="Button11" runat="server" CssClass="btn1" Text="08" />
                    <asp:Button ID="Button12" runat="server" CssClass="btn1" Text="09" />
                    <asp:Button ID="Button13" runat="server" CssClass="btn1" Text="10" />
                </div>
                <%-- Row B --%>
                <div class="seat-section">
                    <asp:Button ID="Button14" runat="server" CssClass="btn1" Text="11" />
                    <asp:Button ID="Button15" runat="server" CssClass="btn1" Text="12" />
                    <asp:Button ID="Button16" runat="server" CssClass="btn1" Text="13" />
                    <asp:Button ID="Button17" runat="server" CssClass="btn1" Text="14" />
                    <asp:Button ID="Button18" runat="server" CssClass="btn1" Text="15" />
                    <asp:Button ID="Button19" runat="server" CssClass="btn1" Text="16" />
                    <asp:Button ID="Button20" runat="server" CssClass="btn1" Text="17" />
                    <asp:Button ID="Button21" runat="server" CssClass="btn1" Text="18" />
                    <asp:Button ID="Button22" runat="server" CssClass="btn1" Text="19" />
                    <asp:Button ID="Button23" runat="server" CssClass="btn1" Text="20" />
                </div>
                <%-- Row C --%>
                <div class="seat-section">
                    <asp:Button ID="Button24" runat="server" CssClass="btn1" Text="21" />
                    <asp:Button ID="Button25" runat="server" CssClass="btn1" Text="22" />
                    <asp:Button ID="Button26" runat="server" CssClass="btn1" Text="23" />
                    <asp:Button ID="Button27" runat="server" CssClass="btn1" Text="24" />
                    <asp:Button ID="Button28" runat="server" CssClass="btn1" Text="25" />
                    <asp:Button ID="Button29" runat="server" CssClass="btn1" Text="26" />
                    <asp:Button ID="Button30" runat="server" CssClass="btn1" Text="27" />
                    <asp:Button ID="Button31" runat="server" CssClass="btn1" Text="28" />
                    <asp:Button ID="Button32" runat="server" CssClass="btn1" Text="29" />
                    <asp:Button ID="Button33" runat="server" CssClass="btn1" Text="30" />
                </div>
                <%-- Row D --%>
                <div class="seat-section">
                    <asp:Button ID="Button34" runat="server" CssClass="btn1" Text="31" />
                    <asp:Button ID="Button35" runat="server" CssClass="btn1" Text="32" />
                    <asp:Button ID="Button36" runat="server" CssClass="btn1" Text="33" />
                    <asp:Button ID="Button37" runat="server" CssClass="btn1" Text="34" />
                    <asp:Button ID="Button38" runat="server" CssClass="btn1" Text="35" />
                    <asp:Button ID="Button39" runat="server" CssClass="btn1" Text="36" />
                    <asp:Button ID="Button40" runat="server" CssClass="btn1" Text="37" />
                    <asp:Button ID="Button41" runat="server" CssClass="btn1" Text="38" />
                    <asp:Button ID="Button42" runat="server" CssClass="btn1" Text="39" />
                    <asp:Button ID="Button43" runat="server" CssClass="btn1" Text="40" />
                </div>
                <%-- Row E --%>
                <div class="seat-section">
                    <asp:Button ID="Button44" runat="server" CssClass="btn1" Text="41" />
                    <asp:Button ID="Button45" runat="server" CssClass="btn1" Text="42" />
                    <asp:Button ID="Button46" runat="server" CssClass="btn1" Text="43" />
                    <asp:Button ID="Button47" runat="server" CssClass="btn1" Text="44" />
                    <asp:Button ID="Button48" runat="server" CssClass="btn1" Text="45" />
                    <asp:Button ID="Button49" runat="server" CssClass="btn1" Text="46" />
                    <asp:Button ID="Button50" runat="server" CssClass="btn1" Text="47" />
                    <asp:Button ID="Button51" runat="server" CssClass="btn1" Text="48" />
                    <asp:Button ID="Button52" runat="server" CssClass="btn1" Text="49" />
                    <asp:Button ID="Button53" runat="server" CssClass="btn1" Text="50" />
                </div>
                <%-- Row F --%>
                <div class="seat-section">
                    <asp:Button ID="Button54" runat="server" CssClass="btn1" Text="51" />
                    <asp:Button ID="Button55" runat="server" CssClass="btn1" Text="52" />
                    <asp:Button ID="Button56" runat="server" CssClass="btn1" Text="53" />
                    <asp:Button ID="Button57" runat="server" CssClass="btn1" Text="54" />
                    <asp:Button ID="Button58" runat="server" CssClass="btn1" Text="55" />
                    <asp:Button ID="Button59" runat="server" CssClass="btn1" Text="56" />
                    <asp:Button ID="Button60" runat="server" CssClass="btn1" Text="57" />
                    <asp:Button ID="Button61" runat="server" CssClass="btn1" Text="58" />
                    <asp:Button ID="Button62" runat="server" CssClass="btn1" Text="59" />
                    <asp:Button ID="Button63" runat="server" CssClass="btn1" Text="60" />
                </div>
            </div>

            <%-- Target positioning container for client feedback notifications --%>
            <div style="text-align: center; margin-top: 25px;">
                <asp:Label ID="lblMessage" runat="server" ForeColor="#EF4444" Font-Bold="true" Font-Size="Medium"></asp:Label>
            </div>

            <div class="continue-wrap">
                <asp:Button ID="btn_save" runat="server" Text="Show Ticket" CssClass="btn-continue" OnClick="btn_save_Click" />
            </div>

        </div>
    </form>
</body>
</html>