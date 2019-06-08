using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OwlCard.secure
{
    public partial class logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Abandon();
            Session.Clear();
            //Replace with shiplift login address
            Response.Redirect("https://np-fim.temple.edu/idp/profile/SAML2/Redirect/SSO ");
        }
    }
}