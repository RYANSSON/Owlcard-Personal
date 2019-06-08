using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OwlCard
{
    public partial class DepositRecord : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // prevents unauthorized access
            //if (!IsPostBack && (Session["Authorized"] == null))
            //{
            //    Response.Redirect("500-Error.aspx");
            //}
        }
    }
}