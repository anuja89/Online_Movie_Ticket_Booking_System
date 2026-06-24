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
    public partial class New_Register: System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void signUp_Click(object sender, EventArgs e)
        {
                        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MovieDB"].ConnectionString);
            try
            {

                string query = "insert into dbo.user2 values(@name,@email,@mobileNo,@password,@role)";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@name", TxtName.Text);
                cmd.Parameters.AddWithValue("@email", TxtEmailid.Text);
                cmd.Parameters.AddWithValue("@mobileNo", TxtMob.Text);
                cmd.Parameters.AddWithValue("@password", TxtPass.Text);
                cmd.Parameters.AddWithValue("@role", ddlRole.SelectedItem.Text);
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
            catch (SqlException se)
            {
                Response.Write(se.Message);
            }
            finally
            {
                con.Close();
            }
        }
       
    }
}