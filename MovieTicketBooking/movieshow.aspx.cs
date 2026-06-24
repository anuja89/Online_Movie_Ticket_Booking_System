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
    public partial class movieshow : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Calendar1.Visible = true;
                Calendar2.Visible = true;
            }
        }

        // ADDED: Handler to update the text box when the start date changes
        protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        {
            txtFrom.Text = Calendar1.SelectedDate.ToShortDateString();
        }

        // ADDED: Handler to update the text box when the end date changes
        protected void Calendar2_SelectionChanged(object sender, EventArgs e)
        {
            txtTo.Text = Calendar2.SelectedDate.ToShortDateString();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Calendar1.SelectedDate == DateTime.MinValue || Calendar2.SelectedDate == DateTime.MinValue)
            {
                Response.Write("<span style='color:#F5C518; font-weight:bold;'>Please select both From and To dates on the calendar before adding a show.</span>");
                return;
            }

                        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MovieDB"].ConnectionString);
            try
            {
                string query = "insert into dbo.MovieShow values(@mid,@fromdate,@todate,@price)";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@mid", txtMid.Text);
                cmd.Parameters.AddWithValue("@fromdate", Calendar1.SelectedDate);
                cmd.Parameters.AddWithValue("@todate", Calendar2.SelectedDate);
                cmd.Parameters.AddWithValue("@price", txtPrice.Text);

                con.Open();
                int rowAffected = cmd.ExecuteNonQuery();
                if (rowAffected > 0)
                {
                    Response.Write("<span style='color:#F5C518; font-weight:bold;'>Show added successfully!</span>");
                }
                else
                {
                    Response.Write("<span style='color:#ff6b6b; font-weight:bold;'>Error: Movie not displayed.</span>");
                }
            }
            catch (SqlException se)
            {
                Response.Write("<span style='color:#ff6b6b;'>" + se.Message + "</span>");
            }
            finally
            {
                con.Close();
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            if (Calendar1.SelectedDate == DateTime.MinValue || Calendar2.SelectedDate == DateTime.MinValue)
            {
                Response.Write("<span style='color:#F5C518; font-weight:bold;'>Please select both From and To dates on the calendar before updating.</span>");
                return;
            }

                        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MovieDB"].ConnectionString);
            try
            {
                string query = "UPDATE dbo.MovieShow SET FromDate=@fromdate,ToDate=@todate,price=@price WHERE Mid=@mid";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@mid", txtMid.Text);
                cmd.Parameters.AddWithValue("@fromdate", Calendar1.SelectedDate);
                cmd.Parameters.AddWithValue("@todate", Calendar2.SelectedDate);
                cmd.Parameters.AddWithValue("@price", txtPrice.Text);

                con.Open();
                int rowAffected = cmd.ExecuteNonQuery();
                if (rowAffected > 0)
                {
                    Response.Write("<span style='color:#F5C518; font-weight:bold;'>Show updated successfully!</span>");
                }
                else
                {
                    Response.Write("<span style='color:#ff6b6b; font-weight:bold;'>Error updating show.</span>");
                }
            }
            catch (SqlException se)
            {
                Response.Write("<span style='color:#ff6b6b;'>" + se.Message + "</span>");
            }
            finally
            {
                con.Close();
            }
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            Response.Redirect("HomePage.aspx");
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            Response.Redirect("Reports.aspx");
        }

        protected void Button5_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtMid.Text))
            {
                Response.Write("<span style='color:#F5C518; font-weight:bold;'>Please enter a Movie ID to delete the show.</span>");
                return;
            }

                        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MovieDB"].ConnectionString);
            try
            {
                string query = "DELETE FROM dbo.MovieShow WHERE Mid=@mid";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@mid", txtMid.Text);

                con.Open();
                int rowAffected = cmd.ExecuteNonQuery();
                if (rowAffected > 0)
                {
                    Response.Write("<span style='color:#F5C518; font-weight:bold;'>Show deleted successfully!</span>");
                }
                else
                {
                    Response.Write("<span style='color:#ff6b6b; font-weight:bold;'>No show found with that Movie ID.</span>");
                }
            }
            catch (SqlException se)
            {
                Response.Write("<span style='color:#ff6b6b;'>" + se.Message + "</span>");
            }
            finally
            {
                con.Close();
            }
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