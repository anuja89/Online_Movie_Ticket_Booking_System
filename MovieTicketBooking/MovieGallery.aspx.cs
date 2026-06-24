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
    public partial class MovieGallery : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
            
            if (!IsPostBack)
            {
                string cs = ConfigurationManager.ConnectionStrings["MovieDB"].ConnectionString;
                string query = string.Format("select ms.Mid,md.Mname,md.description,md.poster,ms.price from MovieShow ms,Movie_Details md where @currentdate >=FromDate and @currentdate <=ToDate and ms.Mid = md.Mid");
                SqlConnection con = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(query,con);
                string currentdate = System.DateTime.Today.ToString("yyyy-MM-dd");
                cmd.Parameters.AddWithValue("@currentdate", currentdate);

                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                reptMovie.DataSource = rdr;
                reptMovie.DataBind();
                con.Close();
            }
        }
        protected void reptMovie_ItemCommand(Object source, RepeaterCommandEventArgs e)
        {
            /*string id = Session["id"].ToString();
            Response.Write(id);
            Response.Write(Session["name"].ToString());
            Response.Write(Session["price"].ToString());*/
            //Response.Redirect("~/Seat_Allotment.aspx");
        }

        protected void reptMovie_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var lblid = (Label)e.Item.FindControl("Label1");
                var lblname = (Label)e.Item.FindControl("lblname");
                var lblprice = (Label)e.Item.FindControl("Label2");
                
                Session["id"] = lblid.Text;
                Session["name"] = lblname.Text;
                Session["price"] = lblprice.Text;

            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Session["UserEmail"] == null) {
                Response.Redirect("Login_Form.aspx");
            }

            Button btn = (Button)sender;
            RepeaterItem item = (RepeaterItem)btn.NamingContainer;

            var lblId = (Label)item.FindControl("Label1");
            var lblname = (Label)item.FindControl("lblname");
            var lblprice = (Label)item.FindControl("Label2");
            var slot = (DropDownList)item.FindControl("ddlSlot");
            //Session["id"]=lblId.Text;
            Session["id"] = lblId.Text;
            Session["name"] = lblname.Text;
            Session["price"] = lblprice.Text;
            Session["slot"] =slot.SelectedItem.Value;
            Session["PSlot"] = slot.SelectedItem.Text;
            
            Response.Redirect("Seat_Allotment.aspx");
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