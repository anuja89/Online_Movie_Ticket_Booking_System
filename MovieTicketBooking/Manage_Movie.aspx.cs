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
    public partial class Manage_Movie : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                load_data();
            }
        }
        void load_data()
        {

        }
        protected void btnInsert_Click(object sender, EventArgs e)
        {
            // 1. Check if fields are empty
            if (string.IsNullOrEmpty(txtMid.Text.Trim()) ||
                string.IsNullOrEmpty(txtMname.Text.Trim()) ||
                string.IsNullOrEmpty(txtLang.Text.Trim()) ||
                string.IsNullOrEmpty(txtDes.Text.Trim()) ||
                string.IsNullOrEmpty(txtDur.Text.Trim()))
            {
                Response.Write("<span style='color:red; font-weight:bold; font-size:large;'>Please fill in all the movie details before adding!</span>");
                return;
            }

            // 2. Check if file is selected
            if (!fposter.HasFile)
            {
                Response.Write("<span style='color:red; font-weight:bold; font-size:large;'>Please select a poster image file!</span>");
                return;
            }

                        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MovieDB"].ConnectionString);
            try
            {
                string query = "insert into dbo.Movie_Details values(@id,@title,@language,@description,@duration,@poster)";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@id", txtMid.Text.Trim());
                cmd.Parameters.AddWithValue("@title", txtMname.Text.Trim());
                cmd.Parameters.AddWithValue("@language", txtLang.Text.Trim());
                cmd.Parameters.AddWithValue("@description", txtDes.Text.Trim());
                cmd.Parameters.AddWithValue("@duration", txtDur.Text.Trim());

                // Define the virtual DB path
                string dbPosterPath = "~/Images/" + fposter.FileName;
                cmd.Parameters.AddWithValue("@poster", dbPosterPath);

                // ADDED: Save the actual physical file to the server's Images folder
                string physicalFolder = Server.MapPath("~/Images/");
                fposter.SaveAs(physicalFolder + fposter.FileName);

                con.Open();
                int rowAffected = cmd.ExecuteNonQuery();
                if (rowAffected > 0)
                {
                    Response.Write("<span style='color:white; font-weight:bold; font-size:large;'>Movie inserted successfully..!</span>");
                }
                else
                {
                    Response.Write("<span style='color:red; font-weight:bold; font-size:large;'>Error at time insertion</span>");
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
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
                        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MovieDB"].ConnectionString);
            try
            {
                string query = "UPDATE dbo.Movie_Details SET Mname=@title, language=@language, description=@description, duration=@duration, poster=@poster WHERE Mid=@id";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@id", txtMid.Text);
                cmd.Parameters.AddWithValue("@title", txtMname.Text);
                cmd.Parameters.AddWithValue("@language", txtLang.Text);
                cmd.Parameters.AddWithValue("@description", txtDes.Text);
                cmd.Parameters.AddWithValue("@duration", txtDur.Text);

                string dbPosterPath = "~/Images/" + fposter.FileName;
                cmd.Parameters.AddWithValue("@poster", dbPosterPath);

                // ADDED: Save file during an update too
                if (fposter.HasFile)
                {
                    string physicalFolder = Server.MapPath("~/Images/");
                    fposter.SaveAs(physicalFolder + fposter.FileName);
                }

                con.Open();
                int rowAffected = cmd.ExecuteNonQuery();
                if (rowAffected > 0)
                {
                    Response.Write("<span style='color:white; font-weight:bold; font-size:large;'>Movie updated successfully..!</span>");
                }
                else
                {
                    Response.Write("<span style='color:red; font-weight:bold; font-size:large;'>Error updating movie</span>");
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
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
                        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MovieDB"].ConnectionString);
            try
            {
                string query = "DELETE from dbo.Movie_Details WHERE Mid=@id";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@id", txtMid.Text);

                con.Open();
                int rowAffected = cmd.ExecuteNonQuery();
                if (rowAffected > 0)
                {
                    Response.Write("<span style='color:white; font-weight:bold; font-size:large;'>Movie deleted successfully..!</span>");
                }
                else
                {
                    Response.Write("<span style='color:red; font-weight:bold; font-size:large;'>Movie not found or could not be deleted !</span>");
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
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtMid.Text = "";
            txtMname.Text = "";
            txtLang.Text = "";
            txtDes.Text = "";
            txtDur.Text = "";
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("movieshow.aspx");
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