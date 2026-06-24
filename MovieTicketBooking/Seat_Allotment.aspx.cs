using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Drawing;

namespace MovieTicketBooking
{
    public partial class Seat_Allotment : System.Web.UI.Page
    {
        Item[] item = null;
        string cs = ConfigurationManager.ConnectionStrings["MovieDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            foreach (Button btn in this.Page.Form.Controls.OfType<Button>())
            {
                if (btn.ID != "btn_save" && btn.ID != "Button1" && btn.ID != "Button2" && btn.ID != "Button3")
                {
                    btn.Click += myClickMethod;
                }
            }
            if (!IsPostBack)
            {
                item = new Item[61];
                foreach (Button btn in this.Page.Form.Controls.OfType<Button>())
                {
                    if (btn.ID != "btn_save" && btn.ID != "Button1" && btn.ID != "Button2" && btn.ID != "Button3" && btn.ID != "btnLogout")
                    {
                        int index = Convert.ToInt32(btn.Text);
                        item[index] = new Item(btn, index, Color.Lime, false);
                    }
                }
                SqlConnection con = new SqlConnection(cs);
                try
                {
                    string currentdate = System.DateTime.Today.ToString("yyyy-MM-dd");

                    string query = "select seatno from SeatAllotement where Mid = @mid and bookingdate =@bdate and slot=@slot";
                    SqlCommand cmd = new SqlCommand(query, con);
                    con.Open();
                    int Mid = Convert.ToInt32(Session["id"]);
                    cmd.Parameters.AddWithValue("@mid", Mid);
                    cmd.Parameters.AddWithValue("@bdate", currentdate);
                    cmd.Parameters.AddWithValue("@slot", Session["slot"].ToString());
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        int i = reader.GetInt32(0);
                        if (item[i] != null)
                        {
                            item[i].setBooked();
                            item[i].setColor(Color.Red);
                        }
                    }
                }
                catch (SqlException se)
                {
                    Response.Write(se.Message);
                }
                finally
                {
                    con.Close();
                }
                for (int i = 1; i <= 60; i++)
                {
                    if (item[i] != null)
                    {
                        Button btn = item[i].getButton();
                        btn.BackColor = item[i].getColor();
                    }
                }
            }
        }

        protected void ddlSlot_SelectedIndexChanged(object sender, EventArgs e)
        {
            Page_Load(sender, e);
        }

        protected void myClickMethod(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            Color selectedColor = ColorTranslator.FromHtml("#F5C518");

            // Clear outstanding text warnings from prior clicks
            lblMessage.Text = "";

            // Intercept check: Stop users from selecting an already occupied layout node (Red)
            if (btn.BackColor == Color.Red)
            {
                lblMessage.Text = "Seat is already booked!";
                return;
            }

            if (ViewState["count"] == null)
            {
                ViewState["count"] = 0;
            }

            if (btn.BackColor == Color.Lime)
            {
                btn.BackColor = selectedColor;
                int count = Convert.ToInt32(ViewState["count"]);
                count++;
                ViewState["count"] = count;
            }
            else if (btn.BackColor == selectedColor)
            {
                btn.BackColor = Color.Lime;
                int count = Convert.ToInt32(ViewState["count"]);
                count--;
                ViewState["count"] = count;
            }
            int clickCount = Convert.ToInt32(ViewState["count"]);
            int totalBill = Convert.ToInt32(Session["price"]) * clickCount;
            Session["bill"] = totalBill;
            Response.Write("<span style='color:white; font-weight:bold; font-size:large;'>Total Bill :  Rs." + totalBill.ToString() + "</span>");
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            // Empty check validation block before modifying DB constraints
            int selectedCount = ViewState["count"] != null ? Convert.ToInt32(ViewState["count"]) : 0;
            if (selectedCount == 0)
            {
                lblMessage.Text = "Please select your seat for showing your ticket";
                return;
            }

            SqlConnection con = new SqlConnection(cs);
            int count = 0;
            int[] seat = new int[11];
            int i = 1;
            Color selectedColor = ColorTranslator.FromHtml("#F5C518");
            List<string> selectedSeats = new List<string>();

            foreach (Button btn in this.Page.Form.Controls.OfType<Button>())
            {
                if (btn.ID != "Button2" && btn.BackColor == selectedColor)
                {
                    count++;
                    string seatno = btn.Text;
                    selectedSeats.Add(seatno);

                    if (i < seat.Length)
                    {
                        seat[i] = Convert.ToInt32(seatno);
                        i++;
                    }

                    try
                    {
                        string query = "insert into SeatAllotement values(@mid,@bdate,@seat,@slot);";
                        string currentdate = System.DateTime.Today.ToString("yyyy-MM-dd");
                        SqlCommand cmd = new SqlCommand(query, con);

                        cmd.Parameters.AddWithValue("@mid", Convert.ToInt32(Session["id"]));
                        cmd.Parameters.AddWithValue("@bdate", currentdate);
                        cmd.Parameters.AddWithValue("@seat", seatno);
                        cmd.Parameters.AddWithValue("@slot", Session["slot"].ToString());

                        con.Open();
                        int rowAffected = cmd.ExecuteNonQuery();
                        if (rowAffected > 0)
                        {
                            Session["cdate"] = currentdate;
                        }
                    }
                    catch (SqlException se)
                    {
                        lblMessage.Text = "Database error encountered: " + se.Message;
                        return;
                    }
                    finally
                    {
                        con.Close();
                    }
                }
            }
            Session["selectedSeats"] = string.Join(",", selectedSeats.ToArray());
            Response.Redirect("Receipt_Form.aspx");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();

            if (Request.Cookies[".ASPXAUTH"] != null)
            {
                HttpCookie authCookie = new HttpCookie(".ASPXAUTH");
                authCookie.Expires = DateTime.Now.AddDays(-1d);
                Response.Cookies.Add(authCookie);
            }

            if (Request.Cookies["ASP.NET_SessionId"] != null)
            {
                HttpCookie sessionCookie = new HttpCookie("ASP.NET_SessionId", "");
                sessionCookie.Expires = DateTime.Now.AddDays(-1d);
                Response.Cookies.Add(sessionCookie);
            }

            Response.Redirect("~/HomePage.aspx");
        }
    }
}