using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OwlCard.Classes;

namespace OwlCard
{
    public partial class Purchases : System.Web.UI.Page
    {
        Validation valid = new Validation();
        Connection conn = new Connection();

        protected void Page_Load(object sender, EventArgs e)
        {
            //// prevents unauthorized access
            if (!IsPostBack && (Session["Ipad"] == null))
            {
                Response.Redirect("500-Error.aspx");
            }
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));
            Response.Cache.SetNoStore();
            if (!IsPostBack)
            {

                SqlCommand objCommand2 = new SqlCommand();
                objCommand2.CommandType = CommandType.StoredProcedure;
                objCommand2.CommandText = "GetPurchaseItems";
                DataSet ds2 = conn.GetDataSetUsingCmdObj(objCommand2);
                gvDisplay.DataSource = ds2;
                gvDisplay.DataBind();
            }




        }

        // resets all form controls on page load
        protected void ResetForm()
        {
            txtFirstName.Text = "";
            txtLastName.Text = "";
            foreach (GridViewRow gr in gvDisplay.Rows)
            {
                TextBox Quantity = (TextBox)gr.FindControl("txtQuantity");
                Quantity.Text = "";
            }
            txtSignature.Text = "";
        }

        protected void btnSubmit_Click1(object sender, EventArgs e)
        {

            //Don't allow quanity of 0 or - number
            int j = 0;

            try
            {
                int[] quantities = new int[gvDisplay.Rows.Count];
                int[] ids = new int[gvDisplay.Rows.Count];
                decimal[] costs = new decimal[gvDisplay.Rows.Count];
                int count = 0;
                GridView gv = gvDisplay;

                int total=0;
                for (int i = 0; i < gv.Rows.Count; i++)
                {

                    TextBox itemAmount = new TextBox();

                    itemAmount = (TextBox)gv.Rows[i].FindControl("txtValidID");
                    if (itemAmount.Text.ToString().Equals(""))
                    {
                        quantities[count] = 0;
                    }
                    else if (double.Parse(itemAmount.Text.ToString()) < 0)
                    {
                        quantities[count] = 0;
                    }
                    else
                    {
                        quantities[count] = Int32.Parse(itemAmount.Text);
                    }

                    total += quantities[count];


                    ids[count] = Int32.Parse(gvDisplay.DataKeys[i].Values[0].ToString());
                    costs[count] = Decimal.Parse(gvDisplay.DataKeys[i].Values[1].ToString());
                    count++;
                }
                if (total == 0)
                {
                    lblmsg.Text = "<div class='alert alert-danger'><strong>Please Enter Atleast 1 Positive Numbers!</strong></div>";
                }
                else
                {


                    Transaction thisTrans = new Transaction();

                    thisTrans.TuID = Int32.Parse(txtID.Text);
                    thisTrans.Name = txtFirstName.Text + " " + txtLastName.Text;
                    thisTrans.Signature = txtSignature.Text;
                    thisTrans.Timestamp = DateTime.Now;
                    thisTrans.TransactionType = "Purchase";

                    // creates Transaction record and returns id created upon insertion
                    int transID = Transaction.CreateTransaction(thisTrans);

                    Transaction.CreateTransactionItems(transID, quantities, ids, costs);

                    // calculate total cost
                    decimal totalCost = CalculateCost(quantities, costs);

                    // update Transaction record with total cost
                    Transaction.UpdateTransactionCost(transID, totalCost);
                    Response.Redirect("UserMessage.aspx");
                }
            }
            catch
            {
                lblmsg.Text = "<div class='alert alert-danger'><strong>Please Enter Atleast 1 Positive Numbers!</strong></div>";
            }


        }

        private decimal CalculateCost(int[] quantities, decimal[] costs)
        {
            decimal totalCost = 0;
            for (int i = 0; i < quantities.Length; i++)
            {
                totalCost = totalCost + (quantities[i] * costs[i]);
            }


            return totalCost;


        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Welcome.aspx");
        }
    }
}