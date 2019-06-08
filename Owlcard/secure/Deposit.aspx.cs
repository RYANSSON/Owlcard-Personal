using OwlCard.Classes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OwlCard
{
    public partial class Deposit : System.Web.UI.Page
    {
        Connection conn = new Connection();
        Validation val = new Validation();

        protected void Page_Load(object sender, EventArgs e)
        {

            //prevents unauthorized access

            if (!IsPostBack && (Session["Ipad"] == null))
            {
                Response.Redirect("500-Error.aspx");
            }


        }

        protected void btnSubmitDepositFormPage_Click(object sender, EventArgs e)
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
                objCommand.Parameters.AddWithValue("@PaymentMethod", payMethod);
                if (ddlAmount.SelectedItem.Text == "$25")
                {
                    objCommand.Parameters.AddWithValue("@Cost", 25.00);
                }
                if (ddlAmount.SelectedItem.Text == "$50")
                {
                    objCommand.Parameters.AddWithValue("@Cost", 50.00);
                }
                if (ddlAmount.SelectedItem.Text == "$75")
                {
                    objCommand.Parameters.AddWithValue("@Cost", 75.00);
                }
                if (ddlAmount.SelectedItem.Text == "$100")
                {
                    objCommand.Parameters.AddWithValue("@Cost", 100.00);
                }
                if (ddlAmount.SelectedItem.Text == "Other")
                {
                    objCommand.Parameters.AddWithValue("@Cost", Convert.ToDecimal(txtAmount.Text));

                }
                objCommand.Parameters.AddWithValue("@PhotoChoice", 0);
                objCommand.Parameters.AddWithValue("@TransactionType", "Deposit");


                conn.GetDataSetUsingCmdObj(objCommand);
                Response.Redirect("UserMessage.aspx");
            }
            catch
            {

            }
        
        }

        protected void btnGoBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Welcome.aspx");
        }

        protected void ddlAmount_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedVal = ddlAmount.SelectedItem.Text;
            if (selectedVal == "Other")
            {
                txtAmount.Enabled = true;
                regAmount.Enabled = true;
                reqAmount.Enabled = true;
                txtAmount.Visible = true;
                lblAmount.Visible = true;
                txtAmount.Text = "";
            }
            else
            {
                txtAmount.Enabled = false;
                regAmount.Enabled = false;
                reqAmount.Enabled = false;
                txtAmount.Visible = false;
                lblAmount.Visible = false;
            }
        }
    }
}