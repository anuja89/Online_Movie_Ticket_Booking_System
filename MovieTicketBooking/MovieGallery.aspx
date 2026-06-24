<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MovieGallery.aspx.cs" Inherits="MovieTicketBooking.MovieGallery" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Now Showing - CineBook</title>
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet"/>
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        :root { --gold:#F5C518; --red:#E50914; --dark:#0A0A0A; --card:#141414; --border:rgba(255,255,255,0.08); --text:#EDEDED; --muted:#777; }

        body { font-family: 'Inter', sans-serif; background: var(--dark); color: var(--text); min-height: 100vh; }

        /* ── Top bar ── */
        .topbar {
            position: sticky; top: 0; z-index: 100;
            display: flex; align-items: center; justify-content: space-between;
            padding: 0 32px;
            height: 60px;
            background: rgba(10,10,10,0.95);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid var(--border);
        }
        .brand { font-family: 'Bebas Neue', sans-serif; font-size: 24px; letter-spacing: 3px; color: var(--gold); }

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

        /* ── Page header ── */
        .page-header {
            padding: 52px 32px 36px;
            border-bottom: 1px solid var(--border);
        }
        .page-header h1 {
            font-family: 'Bebas Neue', sans-serif;
            font-size: 48px; letter-spacing: 2px; color: #fff;
        }
        .page-header p { font-size: 14px; color: var(--muted); margin-top: 6px; }

        /* ── Gallery grid ── */
        .gallery {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 28px;
            padding: 40px 32px 60px;
        }

        /* ── Movie card ── */
        .movie-card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 10px;
            overflow: hidden;
            transition: transform 0.25s ease, box-shadow 0.25s ease;
            display: flex; flex-direction: column;
        }
        .movie-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 20px 50px rgba(0,0,0,0.6);
            border-color: rgba(245,197,24,0.2);
        }

        .poster-wrap {
            position: relative;
            width: 100%; padding-top: 140%;
            background: #111;
            overflow: hidden;
        }
        .poster-wrap img {
            position: absolute; inset: 0;
            width: 100%; height: 100%;
            object-fit: cover;
            transition: transform 0.4s ease;
        }
        .movie-card:hover .poster-wrap img { transform: scale(1.04); }

        .mid-badge {
            position: absolute; top: 10px; left: 10px;
            background: rgba(0,0,0,0.75);
            border: 1px solid var(--border);
            border-radius: 4px;
            padding: 3px 8px;
            font-size: 11px; color: var(--muted); letter-spacing: 0.5px;
        }

        .card-body { padding: 18px 18px 20px; flex: 1; display: flex; flex-direction: column; }

        .movie-title {
            font-size: 18px; font-weight: 700;
            color: #fff; margin-bottom: 6px;
            line-height: 1.2;
        }
        .movie-desc {
            font-size: 13px; color: var(--muted); line-height: 1.5;
            flex: 1; margin-bottom: 14px;
        }
        .price-row {
            display: flex; align-items: center; justify-content: space-between;
            margin-bottom: 16px;
        }
        .price-label { font-size: 11px; text-transform: uppercase; letter-spacing: 0.8px; color: var(--muted); }
        .price-value { font-size: 20px; font-weight: 700; color: var(--gold); }

        /* Slot select */
        .slot-row { margin-bottom: 16px; }
        .slot-row label { font-size: 11px; text-transform: uppercase; letter-spacing: 0.8px; color: var(--muted); display: block; margin-bottom: 7px; }
        .slot-select {
            width: 100%;
            padding: 10px 12px;
            background: rgba(255,255,255,0.05);
            border: 1px solid var(--border);
            border-radius: 6px;
            color: var(--text);
            font-family: 'Inter', sans-serif; font-size: 13px;
            cursor: pointer; outline: none;
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='8' viewBox='0 0 12 8'%3E%3Cpath d='M1 1l5 5 5-5' stroke='%23888' stroke-width='1.5' fill='none' stroke-linecap='round'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 12px center;
        }
        .slot-select option { background: #1a1a1a; }

        .btn-book {
            display: block; width: 100%;
            padding: 12px;
            background: var(--gold);
            color: #0A0A0A;
            border: none; border-radius: 6px;
            font-family: 'Inter', sans-serif; font-size: 14px; font-weight: 700;
            cursor: pointer;
            transition: opacity 0.2s, transform 0.15s;
        }
        .btn-book:hover { opacity: 0.9; transform: translateY(-1px); }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <header class="topbar">
            <span class="brand">CineBook</span>
            <asp:Button ID="btnLogout" runat="server" Text="Log Out" CssClass="btn-logout" OnClick="btnLogout_Click" CausesValidation="False" />
        </header>

        <div class="page-header">
            <h1>Now Showing</h1>
            <p>Select a movie, pick your slot, and book your seats.</p>
        </div>

        <div class="gallery">
            <asp:Repeater ID="reptMovie" runat="server" OnItemCommand="reptMovie_ItemCommand" OnItemDataBound="reptMovie_ItemDataBound">
                <ItemTemplate>
                    <div class="movie-card">
                        <div class="poster-wrap">
                            <asp:Image ID="movieImage" runat="server" ImageUrl='<%#Eval("poster")%>' />
                            <span class="mid-badge">#<asp:Label ID="Label1" runat="server" Text='<%#Eval("Mid")%>'></asp:Label></span>
                        </div>
                        <div class="card-body">
                            <div class="movie-title">
                                <asp:Label ID="lblName" runat="server" Text='<%#Eval("Mname")%>'></asp:Label>
                            </div>
                            <div class="movie-desc">
                                <asp:Label ID="Label3" runat="server" Text='<%#Eval("description")%>'></asp:Label>
                            </div>
                            <div class="price-row">
                                <span class="price-label">Ticket price</span>
                                <span class="price-value">&#8377;<asp:Label ID="Label2" runat="server" Text='<%#Eval("price")%>'></asp:Label></span>
                            </div>
                            <div class="slot-row">
                                <label>Choose slot</label>
                                <asp:DropDownList ID="ddlSlot" runat="server" CssClass="slot-select" AutoPostBack="True" Font-Bold="True">
                                    <asp:ListItem Text="09:00 AM - 12:00 PM" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="12:00 PM - 03:00 PM" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="03:00 PM - 06:00 PM" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="06:00 PM - 09:00 PM" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="09:00 PM - 12:00 AM" Value="5"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <asp:Button ID="Button1" runat="server" Text="Book Now" CssClass="btn-book" CommandName="BookNow" CommandArgument='<%#Eval("Mid")%>' OnClick="Button1_Click"/>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

    </form>
</body>
</html>
