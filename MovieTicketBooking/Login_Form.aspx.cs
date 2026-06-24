using System;
using System.Configuration;
using System.Data.SqlClient;

namespace MovieTicketBooking
{
    public partial class Login_Form : System.Web.UI.Page
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
                    string query = "SELECT username FROM dbo.user2 WHERE email = @email AND password = @password AND role = 'User'";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@email", TxtEmailid.Text.Trim());
                        cmd.Parameters.AddWithValue("@password", TxtPass.Text.Trim());

                        con.Open();
                        object userObj = cmd.ExecuteScalar();

                        if (userObj != null)
                        {
                            Session["UserEmail"] = TxtEmailid.Text.Trim();
                            Session["UserRole"] = "User";
                            Response.Redirect("MovieGallery.aspx");
                        }
                        else
                        {
                            Response.Write("Incorrect User Email or Password.");
                        }
                    }
                }
                catch (SqlException se)
                {
                    Response.Write(se.Message);
                }
            }
        }

        protected void newRegister_Click(object sender, EventArgs e)
        {
            Response.Redirect("SignUpForm.aspx");
        }
    }
}