using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace MovieTicketBooking
{
    public partial class CancelTicket : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Calendar1.Visible = true;
            }
        }

        protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        {
            txtDate.Text = Calendar1.SelectedDate.ToString("yyyy-MM-dd");
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
                        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MovieDB"].ConnectionString);
                try
                {
                    // Delete seat booking
                    string queryd = "delete from SeatAllotement where Mid = @mid and bookingdate =@bdate and seatno=@Seat and slot=@slot";
                    SqlCommand cmd = new SqlCommand(queryd, con);
                    cmd.Parameters.AddWithValue("@mid",txtMid.Text);
                    cmd.Parameters.AddWithValue("@slot", txtSlot.Text);
                    cmd.Parameters.AddWithValue("@Seat", txtSeat.Text);
                    cmd.Parameters.AddWithValue("@bdate", Calendar1.SelectedDate.ToString("yyyy-MM-dd"));
                    con.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        
                        Response.Write("Ticket Cancelled");
                    }
                }
                catch (SqlException se)
                {
                    Response.Write(se.Message);
                }
                finally {
                    con.Close();
                }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("Receipt_Form.aspx");
        }
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // 1. Clear and invalidate state parameters
            Session.Clear();
            Session.Abandon();

            // 2. Clear authentication cookies explicitly if state persistence is active
            if (Request.Cookies[".ASPXAUTH"] != null)
            {
                HttpCookie authCookie = new HttpCookie(".ASPXAUTH");
                authCookie.Expires = DateTime.Now.AddDays(-1d);
                Response.Cookies.Add(authCookie);
            }

            // 3. Clear session cookie variables
            if (Request.Cookies["ASP.NET_SessionId"] != null)
            {
                HttpCookie sessionCookie = new HttpCookie("ASP.NET_SessionId", "");
                sessionCookie.Expires = DateTime.Now.AddDays(-1d);
                Response.Cookies.Add(sessionCookie);
            }

            // 4. Return safely back to the application landing page
            Response.Redirect("~/HomePage.aspx");
        }
    }
}