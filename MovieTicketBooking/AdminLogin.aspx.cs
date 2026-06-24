using System;
using System.Configuration;
using System.Data.SqlClient;

namespace MovieTicketBooking
{
    public partial class AdminLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void login_Click(object sender, EventArgs e)
        {
                        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MovieDB"].ConnectionString);
            {
                try
                {
                    string query = "SELECT username FROM dbo.user2 WHERE email = @email AND password = @password AND role = 'Admin'";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@email", TxtEmailid.Text.Trim());
                        cmd.Parameters.AddWithValue("@password", TxtPass.Text.Trim());

                        con.Open();
                        object adminUser = cmd.ExecuteScalar();

                        if (adminUser != null)
                        {
                            Session["UserEmail"] = TxtEmailid.Text.Trim();
                            Session["UserRole"] = "Admin";
                            Response.Redirect("Manage_Movie.aspx");
                        }
                        else
                        {
                            Response.Write("<script>alert('Access Denied: Invalid Administrative Credentials.');</script>");
                        }
                    }
                }
                catch (SqlException se)
                {
                    Response.Write(se.Message);
                }
            }
        }
    }
}