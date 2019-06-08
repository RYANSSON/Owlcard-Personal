
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
    public partial class ReplacementCard : System.Web.UI.Page
    {
        Connection conn = new Connection();
        Validation val = new Validation();
        private decimal cost;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && (Session["Ipad"] == null))
            {
                Response.Redirect("500-Error.aspx");
            }
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));
            Response.Cache.SetNoStore();
            if (!IsPostBack)
            {
                SqlCommand objCommand = new SqlCommand();
                objCommand.CommandType = CommandType.StoredProcedure;
                objCommand.CommandText = "GetPrice";
                objCommand.Parameters.AddWithValue("@name", "Replacement");
                DataSet ds = conn.GetDataSetUsingCmdObj(objCommand);
                DataRow dr = ds.Tables[0].Rows[0];
                try
                {
                    lblPrice.Text = Convert.ToInt32(dr["Cost"]).ToString();
                    cost = Convert.ToDecimal(dr["Cost"]);
                }
                catch
                {

                }

            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
 
            try
            {
                SqlCommand objCommand = new SqlCommand();
                objCommand.CommandType = CommandType.StoredProcedure;
                objCommand.CommandText = "StoreTransaction";
                objCommand.Parameters.AddWithValue("@TUID", txtID.Text);
                objCommand.Parameters.AddWithValue("@Name", txtFirstName.Text + " " + txtLastName.Text);
                objCommand.Parameters.AddWithValue("@Signature", txtSignature.Text);
                objCommand.Parameters.AddWithValue("@DateTime", DateTime.Now);
                string payMethod = ddlPayMethod.SelectedItem.Text;
                if (payMethod == "Cash")
                {
                    objCommand.Parameters.AddWithValue("@PaymentMethod", "Cash");
                }
                else if (payMethod == "Diamond Dollars")
                {
                    objCommand.Parameters.AddWithValue("@PaymentMethod", "Diamond");
                }
                objCommand.Parameters.AddWithValue("@Cost", cost);
                string photoChoice = ddlPhotoOptions.SelectedItem.Text;
                if (photoChoice == "Keep Existing Photo")
                {
                    objCommand.Parameters.AddWithValue("@PhotoChoice", 0);
                }
                else if (photoChoice == "Take New Photo")
                {
                    objCommand.Parameters.AddWithValue("@PhotoChoice", 1);
                }
                objCommand.Parameters.AddWithValue("@TransactionType", "Replace");
                
                conn.GetDataSetUsingCmdObj(objCommand);
                Response.Redirect("UserMessage.aspx");
            }
            catch (Exception ex)
            {
                //lblmsg.Text = ex.ToString();
                //"<div class='alert alert-danger'><strong> Sever Error. Make sure the inputs are correct.</strong></div>";
            }
            
        }                             

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Welcome.aspx");
        }
    }
}