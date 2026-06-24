using System;
using System.Configuration;
using System.Data.SqlClient;

namespace MovieTicketBooking
{
    public partial class SignUpForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
                        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MovieDB"].ConnectionString);
            {
                try
                {
                    string query = "INSERT INTO dbo.user2 (username, email, mobileNo, password, role) VALUES (@name, @email, @mobileNo, @password, 'User')";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@name", TxtName.Text.Trim());
                        cmd.Parameters.AddWithValue("@email", TxtEmailid.Text.Trim());
                        cmd.Parameters.AddWithValue("@mobileNo", TxtMob.Text.Trim());
                        cmd.Parameters.AddWithValue("@password", TxtPass.Text.Trim());

                        con.Open();
                        int rowAffected = cmd.ExecuteNonQuery();
                        if (rowAffected > 0)
                        {
                            Response.Redirect("Login_Form.aspx");
                        }
                        else
                        {
                            Response.Write("REGISTER UNSUCCESSFULLY");
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