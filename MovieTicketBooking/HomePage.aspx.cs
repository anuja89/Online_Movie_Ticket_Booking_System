using System;

namespace MovieTicketBooking
{
    public partial class HomePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login_Form.aspx");
        }

        protected void btnSign_Click(object sender, EventArgs e)
        {
            Response.Redirect("SignUpForm.aspx");
        }

        protected void btnMovies_Click(object sender, EventArgs e)
        {
            Response.Redirect("MovieGallery.aspx");
        }

        protected void btnAdminLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminLogin.aspx");
        }
    }
}