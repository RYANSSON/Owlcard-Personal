﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OwlCard
{
    public partial class Welcome : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // prevents unauthorized access
            //if (!IsPostBack && ((Session["Ipad"] == null && Session["Authorized"] == null)))
            //{
            //    Response.Redirect("500-Error.aspx");
            //}
            /*else */
            //else
            //{
            //    Session["Authorized"] = "none";
            //    Session.Clear();
            //    Session["Ipad"] = "Ipad";
            //}

        }
    }
}