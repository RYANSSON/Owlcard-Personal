
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using OwlCard.Classes;

namespace OwlCard
{
    public partial class NewCard : System.Web.UI.Page
    {
        Connection conn = new Connection();
        Validation val = new Validation();
        private decimal cost = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!IsPostBack && (Session["Ipad"] == null))
           //{
            //    Response.Redirect("500-Error.aspx");
            //}

            /*Application is running on server and the user has active Shibboleth session.*/

        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
           
            try
            {
                /*
                SqlCommand objCommand = new SqlCommand();
                objCommand.CommandType = CommandType.StoredProcedure;
                objCommand.CommandText = "StoreTransaction";
                objCommand.Parameters.AddWithValue("@TUID", txtID.Text);
                objCommand.Parameters.AddWithValue("@Name", txtFirstName.Text + " " + txtLastName.Text);
                objCommand.Parameters.AddWithValue("@Signature", txtSignature.Text);
                objCommand.Parameters.AddWithValue("@DateTime", DateTime.Now);                
                objCommand.Parameters.AddWithValue("@Cost", cost);
                objCommand.Parameters.AddWithValue("@PaymentMethod", "Free");
                objCommand.Parameters.AddWithValue("@PhotoChoice", 0);
                objCommand.Parameters.AddWithValue("@TransactionType", "New");
        
                conn.GetDataSetUsingCmdObj(objCommand);
                */               
                Response.Redirect("UserMessage.aspx");
            }
            catch (Exception ex)
            {
                //lblmsg.Text = ex.ToString();
                //"<div class='alert alert-danger'><strong> Sever Error. Make sure the inputs are correct.</strong></div>";
            }
        }


        protected void btngoBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Welcome.aspx");
        }


        protected void txtID_TextChanged(object sender, EventArgs e)
        {
            if((txtID.Text).Length == 9)
            {
                
            }
        }
    }

}

