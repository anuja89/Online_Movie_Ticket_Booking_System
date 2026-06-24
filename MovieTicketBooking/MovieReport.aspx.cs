using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;

namespace MovieTicketBooking
{
    public partial class MovieReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
                        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MovieDB"].ConnectionString);
            try
            {
                string query = "SELECT md.Mid, md.Mname, md.language,md.duration, ms.FromDate, ms.ToDate, ms.price,md.poster FROM Movie_Details md, MovieShow ms WHERE md.Mid = ms.Mid;";
                SqlCommand cmd = new SqlCommand(query, con);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();

                con.Open();
                sda.Fill(ds);
                ReportDocument crp = new ReportDocument();
                crp.Load(Server.MapPath("CrystalReportMovie_Details.rpt"));
                crp.SetDataSource(ds.Tables["table"]);

                CrystalReportViewer1.ReportSource = crp;
                crp.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "MovieReport");

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

        /*protected void Button1_Click(object sender, EventArgs e)
        {
            
        }*/
        
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