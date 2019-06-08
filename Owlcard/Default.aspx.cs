using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OwlCard
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // This page is only used to redirect to the secure folder
            //      The program at this point has the session information from the Shibboleth auth
            Response.Redirect("secure");
        }
    }
}