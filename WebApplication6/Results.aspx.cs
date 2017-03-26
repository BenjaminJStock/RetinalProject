using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication6
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //string[] answers = new string[10] { "Y", "Y", "N", "Y", "N", "Y", "N", "Y", "N", "Y" };
            //rptResults1.DataSource = rptResults1;
            //rptResults1.DataBind();

            Label1.Text = (string)Session["ResultsName"];
            Label2.Text = (string)Session["ResultsScore"];
        }
    }
}