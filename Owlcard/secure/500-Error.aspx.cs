using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OwlCard.secure
{
    public partial class _500_Error : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Response.Cache.SetCacheability(HttpCacheability.NoCache);
           // Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));
            //Response.Cache.SetNoStore();
           // Session.Abandon();
           // Session.Clear();

        }
    }
}