using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieTicketBooking
{
    public partial class Reports : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnUser_Click(object sender, EventArgs e)
        {
            Response.Redirect("user2Report.aspx");
        }

        protected void btnMovies_Click(object sender, EventArgs e)
        {
            Response.Redirect("MovieReport.aspx");
        }

        protected void btnDate_Click(object sender, EventArgs e)
        {
            Response.Redirect("DateWiseReport.aspx");
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