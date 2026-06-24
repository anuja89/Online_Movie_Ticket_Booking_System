<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Manage_Movie.aspx.cs" Inherits="MovieTicketBooking.Manage_Movie" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Manage Movies - CineBook Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet"/>
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        :root { --gold:#F5C518; --red:#E50914; --dark:#0A0A0A; --card:#141414; --border:rgba(255,255,255,0.08); --text:#EDEDED; --muted:#666; }

        body { font-family: 'Inter', sans-serif; background: var(--dark); color: var(--text); min-height: 100vh; }

        /* topbar */
        .topbar {
            display: flex; align-items: center; justify-content: space-between;
            padding: 0 32px; height: 60px;
            background: rgba(14,14,14,0.98);
            border-bottom: 1px solid var(--border);
            position: sticky; top: 0; z-index: 100;
        }
        .brand { font-family: 'Bebas Neue', sans-serif; font-size: 24px; letter-spacing: 3px; color: var(--gold); }
        .admin-badge { font-size: 11px; color: var(--red); border: 1px solid rgba(229,9,20,0.4); border-radius: 10px; padding: 3px 10px; letter-spacing: 1px; text-transform: uppercase; }
        .btn-logout { padding: 8px 20px; background: transparent; border: 1px solid rgba(229,9,20,0.4); border-radius: 20px; color: #ff6b6b; font-family: 'Inter', sans-serif; font-size: 12px; font-weight: 600; cursor: pointer; transition: background 0.2s; }
        .btn-logout:hover { background: rgba(229,9,20,0.15); }

        /* CHANGED: Set up a single centered panel layout since grid table is removed */
        .layout { max-width: 500px; margin: 0 auto; padding: 40px 16px; }

        /* form panel */
        .form-panel {
            background: var(--card); border: 1px solid var(--border); border-radius: 12px; padding: 32px;
        }
        .form-panel h2 { font-size: 18px; font-weight: 700; margin-bottom: 24px; color: #fff; }

        .field { margin-bottom: 18px; }
        .field-label { display: block; font-size: 11px; font-weight: 600; letter-spacing: 0.8px; text-transform: uppercase; color: var(--muted); margin-bottom: 7px; }
        .input-box {
            display: block; width: 100%;
            padding: 11px 13px;
            background: rgba(255,255,255,0.05);
            border: 1px solid var(--border);
            border-radius: 6px;
            color: var(--text);
            font-family: 'Inter', sans-serif; font-size: 14px;
            transition: border-color 0.2s; outline: none;
        }
        .input-box:focus { border-color: var(--gold); background: rgba(245,197,24,0.04); }

        .btn-row { display: flex; gap: 10px; margin-top: 22px; flex-wrap: wrap; }
        .btn { padding: 11px 22px; border: none; border-radius: 6px; font-family: 'Inter', sans-serif; font-size: 13px; font-weight: 600; cursor: pointer; transition: opacity 0.2s, transform 0.15s; }
        .btn:hover { opacity: 0.88; transform: translateY(-1px); }
        .btn-add    { background: var(--gold); color: #0A0A0A; }
        .btn-update { background: #3B82F6;    color: #fff; }
        .btn-delete { background: var(--red); color: #fff; }
        .btn-clear  { background: rgba(255,255,255,0.08); color: var(--text); border: 1px solid var(--border); }

        .btn1 { padding: 6px 14px; border-radius: 4px; font-size: 12px; font-weight: 600; cursor: pointer; border: none; background: rgba(245,197,24,0.15); color: var(--gold); transition: background 0.2s; }
        .btn1:hover { background: rgba(245,197,24,0.28); }
    </style>
</head>
<body>
    <form id="form1" runat="server" enctype="multipart/form-data">

        <header class="topbar">
            <div style="display:flex;align-items:center;gap:14px;">
                <span class="brand">CineBook</span>
                <span class="admin-badge">Admin</span>
            </div>
            <asp:Button ID="btnLogout" runat="server" Text="Log Out" CssClass="btn-logout" OnClick="btnLogout_Click" CausesValidation="False" />
        </header>

        <div class="layout">
            <div class="form-panel">
                <h2>Add / Edit Movie</h2>

                <div class="field">
                    <label class="field-label">Movie ID</label>
                    <asp:TextBox ID="txtMid" runat="server" CssClass="input-box"></asp:TextBox>
                </div>
                <div class="field">
                    <label class="field-label">Movie Name</label>
                    <asp:TextBox ID="txtMname" runat="server" CssClass="input-box"></asp:TextBox>
                </div>
                <div class="field">
                    <label class="field-label">Language</label>
                    <asp:TextBox ID="txtLang" runat="server" CssClass="input-box"></asp:TextBox>
                </div>
                <div class="field">
                    <label class="field-label">Description</label>
                    <asp:TextBox ID="txtDes" runat="server" CssClass="input-box" TextMode="MultiLine" Rows="2"></asp:TextBox>
                </div>
                <div class="field">
                    <label class="field-label">Duration</label>
                    <asp:TextBox ID="txtDur" runat="server" CssClass="input-box"></asp:TextBox>
                </div>
                <div class="field">
                    <label class="field-label">Poster Image</label>
                    <asp:FileUpload ID="fposter" runat="server" CssClass="input-box" />
                </div>

                <div class="btn-row">
                    <asp:Button ID="btnInsert" runat="server" Text="Add" CssClass="btn btn-add" OnClick="btnInsert_Click" />
                    <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-update" OnClick="btnUpdate_Click" />
                    <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-delete" OnClick="btnDelete_Click" />
                    <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-clear" OnClick="btnClear_Click" CausesValidation="False" />
                </div>
                
                <div style="margin-top:15px;">
                    <asp:Button ID="Button1" runat="server" Text="View Shows" CssClass="btn1" OnClick="Button1_Click" Width="100%" />
                </div>
            </div>
        </div>

    </form>
</body>
</html>