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
    public partial class DateWiseReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
                        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MovieDB"].ConnectionString);
            try
            {
                string query = "select * from dbo.SeatAllotement";
                SqlCommand cmd = new SqlCommand(query, con);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();

                con.Open();
                sda.Fill(ds);
                ReportDocument crp = new ReportDocument();
                crp.Load(Server.MapPath("CrystalReportDateWise.rpt"));
                crp.SetDataSource(ds.Tables["table"]);

                CrystalReportViewer1.ReportSource = crp;
                crp.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "DateWiseReport");

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