using OwlCard.Classes;
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
using System.Globalization;

namespace OwlCard
{
    public partial class History : System.Web.UI.Page
    {
        Connection conn = new Connection();
        Validation val = new Validation();
        public DataSet ds;

        String name = null;
        String id = null;
        String type = null;
        String method = null;
        String start = null;
        String end = null;
        String approved = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            // prevents unauthorized access
            /*if (!IsPostBack && (Session["Authorized"] == null || Session["Authorized"].ToString() != "Admin"))
            {
                Response.Redirect("500-Error.aspx");
            }
            Connection conn = new Connection();

            //remove search results if no criteria found per search query
            if(!(lblmsg.Text == ""))
            {
                divDisplay.InnerHtml = "";
            }


            if (!IsPostBack)
            {
                lblmsg.Text = "";
                ds = getTransactionsByDateAndTypeCashOnInitialPageLoad();
                if (ds.Tables[0].Rows.Count == 0)
                {
                    lblmsg.Text = "<div class='alert alert-danger'><strong>No records found based on your search query. You need to correct search criteria.</strong></div>";
                   
                    divDisplay.InnerHtml = "";
                    return;
                }
                else
                {
                    lblmsg.Text = "";
                    //display search results
                    GenerateSearchResultTable();
                }
            }
            */
        }



        //get DS from DB
        protected void getTransactions()
        {
            /*

            // making db call
            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "getTransactions";
            objCommand.Parameters.AddWithValue("@name", name);
            objCommand.Parameters.AddWithValue("@tuid", id);
            objCommand.Parameters.AddWithValue("@start", start);
            objCommand.Parameters.AddWithValue("@end", end);
            objCommand.Parameters.AddWithValue("@type", type);
            objCommand.Parameters.AddWithValue("@method", method);
         
                objCommand.Parameters.AddWithValue("@approved", approved);
            
            return conn.GetDataSetUsingCmdObj(objCommand);
            */

        }

        //Per Business Requirement, by default on initial page load we need to show cash transactions for the last two weeks.
        protected void getTransactionsByDateAndTypeCashOnInitialPageLoad()
        {
            /*
            // making db call
            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "getTransactions";

            objCommand.Parameters.AddWithValue("@name", name);
            objCommand.Parameters.AddWithValue("@tuid", id);
            
            objCommand.Parameters.AddWithValue("@type", type);
            objCommand.Parameters.AddWithValue("@method", method);

            DateTime e = DateTime.Today.AddDays(1);// hard coded values
            DateTime s = e.AddDays(-14);//hard coded values

            objCommand.Parameters.AddWithValue("@start", s.Date.ToString());
            objCommand.Parameters.AddWithValue("@end", e.Date.ToString());
            objCommand.Parameters.AddWithValue("@approved", approved);



            return conn.GetDataSetUsingCmdObj(objCommand);
            */

        }


        protected void btnSearch_Click(object sender, EventArgs e)
        {
           // clearSearchCriteria();
           /*
            if (!isUserInputValid())
            {
                divDisplay.InnerHtml = "";
                return;
            }

            ds = null;

            try
            {
                
                ds = getTransactions();

                if (ds.Tables[0].Rows.Count == 0)
                {
                    lblmsg.Text = "<div class='alert alert-danger'><strong>No records found based on your search query. You need to correct search criteria.</strong></div>";
                    divDisplay.InnerHtml = "";
                    return;
                }
                else
                {
                    lblmsg.Text = "";
                    //display search results
                    GenerateSearchResultTable();
                }
            }
            catch (Exception ex)
            {
                lblmsg.Text = "<div class='alert alert-danger'><strong>There is an issue with establishing connection to the database</strong>" + ex.ToString() + "</div>";

            }
            */          
        }
        protected void clearSearchCriteria()
        {
            lblmsg.Text = "";
            txtFirst.Text = "";
            txtTUID.Text = "";
            startDate.Value = "";
            endDate.Value = "";
            ddlStatus.SelectedValue = "";
            ddlType.SelectedValue = "";
            divDisplay.InnerHtml = "";
        }
        protected bool isUserInputValid()
        {
            lblmsg.Text = "";
            //server side validation
            if (val.IsBlank(txtFirst.Text)
                && val.IsBlank(txtTUID.Text)
                && val.IsBlank(startDate.Value)
                && val.IsBlank(endDate.Value)
                && val.IsBlank(ddlType.SelectedValue)
                && val.IsBlank(ddlStatus.SelectedValue)
                )
            {
                lblmsg.Text = "<div class='alert alert-danger'><strong> You have not provided any search criteria</strong></div>";
                return false;
            }
            //dropdown by defualt
            if (!val.IsBlank(ddlType.SelectedValue))
            {
                if (ddlType.SelectedValue == "Cash" || ddlType.SelectedValue == "Diamond")
                {
                    method = ddlType.SelectedValue;
                }
                else
                {
                    type = ddlType.SelectedValue;
                }


            }
            //dropdown by defualt
            if (!val.IsBlank(ddlStatus.SelectedValue))
            {
                if (ddlStatus.SelectedValue == "Approved")
                {
                    approved = "1";
                }
                else if (ddlStatus.SelectedValue == "Denied")
                {
                    approved = "0";
                }
                else
                {
                   
                }


            }

            //if not blank
            if (!val.IsBlank(txtFirst.Text))
            {

                //if contain only letters
                if (
                    !val.ValidateLettersOnly(txtFirst.Text)
                    )
                {
                    lblmsg.Text = "<div class='alert alert-danger'><strong> Student's first name must contain only letters</strong></div>";
                    return false;
                }
                else
                {
                    name = txtFirst.Text;
                }
            }

            //if not blank
            if (!val.IsBlank(txtTUID.Text))
            {
                //if its valid TUID format 9 digits and is integer
                if (!val.ValidateTUID(txtTUID.Text)
                    )
                {
                    lblmsg.Text = "<div class='alert alert-danger'><strong>TUID must be 9 digits</strong></div>";
                    return false;
                }
                else
                {
                    id = txtTUID.Text;
                }
            }
            //if start is not blank
            if (!val.IsBlank(startDate.Value))
            {
                if (
                     !val.ValidateDate(startDate.Value)
                    )
                {
                    lblmsg.Text = "<div class='alert alert-danger'><strong> Incorrect Date format. You need to provide start date in the date format</strong></div>";
                    return false;
                }
                else
                {
                    
                    start = startDate.Value;

                }
            }
            //if not blank
            if (!val.IsBlank(endDate.Value))
            {
                if (
                     !val.ValidateDate(endDate.Value)
                    )
                {
                    lblmsg.Text = "<div class='alert alert-danger'><strong> Incorrect Date format. You need to provide end date in the date format</strong></div>";
                    return false;
                }
                else
                {
                    end = DateTime.Parse(endDate.Value).AddDays(1).ToString();


                }
            }

            //if not blank
            if (!val.IsBlank(startDate.Value) && !val.IsBlank(endDate.Value))
            {
                // start date can't be greater than end date
                if (DateTime.Parse(startDate.Value).Date > DateTime.Parse(endDate.Value).Date)
                {
                    lblmsg.Text = "<div class='alert alert-danger'><strong> Start date should be before end date.</strong></div>";
                    return false;
                }
                else
                {
                    
                    start = startDate.Value;
                    end = DateTime.Parse(endDate.Value).AddDays(1).ToString();

                }


            }
            //if not blank
            if (!val.IsBlank(startDate.Value))
            {
                // start date can't be greater than today
                if (DateTime.Parse(startDate.Value).Date > DateTime.Now.Date)
                {
                    lblmsg.Text = "<div class='alert alert-danger'><strong> Start date can't be a date in the future.</strong></div>";
                    return false;
                }
                else
                {
                    //start = DateTime.Parse(startDate.Value).Date;
                    start = startDate.Value;
                }

            }
            //if not blank
            if (!val.IsBlank(endDate.Value))
            {
                // end date can't be greater than today
                if (DateTime.Parse(endDate.Value).Date > DateTime.Now.Date)
                {
                    lblmsg.Text = "<div class='alert alert-danger'><strong> End date can't be a date in the future.</strong></div>";
                    return false;
                }
                else
                {
                    end = DateTime.Parse(endDate.Value).AddDays(1).ToString();
                }

            }



            //else data is valid
            return true;
        }
        protected void btnClearSearch_Click(object sender, EventArgs e)
        {
            clearSearchCriteria();
        }




        // This procedure builds an HTML table that displays information about each record

        // contained in the DataSet dsProductList

        private void GenerateSearchResultTable()
        {
            DataTable d;       // used to reference a table in the dataset
            DataRow record;    // used to reference a singe row (record) from the dataset

            String strHTML = "";
            d = ds.Tables[0];// assigning data returned from DB to loacal variable
            //https://jsfiddle.net/Mottie/z8Lacguz/
            if (d.Rows.Count != 0)
            {
                strHTML = strHTML +
                    "<h1>Transactions History</h1><table class='tablesorter'>" +
                          "<thead >" +
                              "<tr>" +
                                  "<th class='top'> TUID </th>" +
                                  "<th  class='top'> Name </th>" +
                                  "<th class='top'> Employee ID </th>" +
                                  "<th class='top'> Validation ID </th>" +
                                  "<th class='top'> Transaction Date </th>" +
                                  "<th class='top'> Transaction Cost </th>" +
                                  "<th class='top'> Transaction Type </th>" +
                                  "<th class='top'> Payment Method </th>" +
                                   "<th> Status </th>" +
                              "</tr>" +
                          "</thead>" +
                          "<tfoot>" +
                              "<tr class='tablesorter - ignoreRow'>" +
                              "<th colspan = '9' class='ts-pager form-horizontal'>" +
                                    "<button type = 'button' class='btn first'><i class='icon-step-backward glyphicon glyphicon-step-backward'></i> </button> " +
                                    "<button type = 'button' class='btn prev'><i class='icon-arrow-left glyphicon glyphicon-backward'></i></button><span class='pagedisplay'></span> " +
                                    "<button type = 'button' class='btn next'><i class='icon-arrow-right glyphicon glyphicon-forward'></i></button>" +
                                    "<button type = 'button' class='btn last'><i class='icon-step-forward glyphicon glyphicon-step-forward'></i></button>" +
                                    "&nbsp; Page Size: <select class='pagesize input-mini' title='Select page size'>" +
                                        "<option selected='selected' value='10'> 10 </option>" +
                                        "<option value='20'> 20 </option >" +
                                        "<option value='30'> 30 </option>" +
                                        "<option value='40'> 40 </option >" +
                                    "</select>" +
                                    "&nbsp; Page Number: <select class='pagenum input-mini' title='Select page number'></select>" +
                                "</th>" +
                              "</tr>" +
                          "</tfoot>" +
                          "<tbody>";

                //building rows
                for (int row = 0; row < d.Rows.Count; row++)
                {
                    record = d.Rows[row];
                    String approval;
                    if(record["Approved"].ToString() == "True")
                    {
                        approval = "Approved";
                    }
                    else if (record["Approved"].ToString() == "False")
                    {
                        approval = "Denied";
                    }
                    else
                    {
                        approval = "";
                    }
                    strHTML = strHTML + "<tr class='mainTableRow' id='" + row+ "'>" +
                                            "<td class='clickable'" + " id='tdID"+ row+"'>" + record["TUID"] + "</td>" +
                                            "<td class='clickable'>" + record["Name"] + "</td>" +
                                            "<td class='clickable'>" + record["WitnessID"] + "</td>" +
                                            "<td class='clickable'>" + record["IdType"] + "</td>" +
                                            "<td class='clickable'"+ " id = 'tdDate"+ row+"' > " + record["DateTime"] + "</td>" +
                                            "<td class='clickable'>" + String.Format("{0:c}", record["Cost"]) + "</td>" +
                                            "<td class='clickable'>" + record["TransactionType"] + "</td>" +
                                            "<td class='clickable'>" + record["PaymentMethod"] + "</td>" +
                                             "<td class='clickable'>" +approval + "</td>" +
                                        "</tr>";

                }

                // End the HTML table
                strHTML += "</tbody></table>";

            }

            // Write the HTML string for the table to a DIV in the HTML markup of the ASPX page
            divDisplay.InnerHtml = strHTML;

        }

        //called when a row is clicked to open a modal view
        protected void modal_Click(object sender, EventArgs e)
        {
            String field = ValueHiddenField.Value;
            String[] identifiers = field.Split('.');
            String iString = identifiers[2];
          

            myModal.Style.Add("display", "block");
            SqlCommand objCommand2 = new SqlCommand();
            objCommand2.CommandType = CommandType.StoredProcedure;
            objCommand2.CommandText = "getselectedTransaction";
            objCommand2.Parameters.AddWithValue("@id", identifiers[1]);
            objCommand2.Parameters.AddWithValue("@date",DateTime.Parse(iString));

            ds = conn.GetDataSetUsingCmdObj(objCommand2);
            gvDisplay.DataSource = ds;
            gvDisplay.DataBind();
            
            GridViewRow gvr = gvDisplay.Rows[0];
            string[] cost = (gvr.Cells[4].Text).ToString().Trim().Split('$');
            //following if else edjusts the rows shown depending on what type of transaction is selected and fills in their unique values
            if ((gvDisplay.DataKeys[gvr.RowIndex].Values[1].ToString().Trim()) == "New")
            {
                lblFormTitle.Text = "New OwlCard";
                RowDeposit.Style.Add("display", "none");
                RowOwlcardOptions.Style.Add("display", "none");
                RowPurchases.Style.Add("Display", "none");
            }
            else if (gvDisplay.DataKeys[gvr.RowIndex].Values[1].ToString().Trim() == "Replace")
            {
                lblFormTitle.Text = "Replacement OWLCard - $";
                RowDeposit.Style.Add("display", "none");
                RowOwlcardOptions.Style.Add("display", "block");
                RowPurchases.Style.Add("Display", "none");
                if ((gvr.Cells[5].Text).ToString().Trim() == "Cash")
                {
                    ddlOwlcardPaymentMethod.SelectedIndex = 0;
                }
                else if ((gvr.Cells[5].Text).ToString().Trim() == "Check")
                {
                    ddlOwlcardPaymentMethod.SelectedIndex = 1;
                }
                if (gvDisplay.DataKeys[gvr.RowIndex].Values[3].ToString().Trim() == "New")
                {
                    ddlPhotoOptions.SelectedIndex = 1;
                }
                else
                {
                    ddlPhotoOptions.SelectedIndex = 0;
                }

            }
            else if ((gvDisplay.DataKeys[gvr.RowIndex].Values[1].ToString().Trim()) == "Deposit")
            {

                lblFormTitle.Text = "Deposit Form";
                RowDeposit.Style.Add("display", "block");
                RowOwlcardOptions.Style.Add("display", "none");
                RowPurchases.Style.Add("Display", "none");
                if ((gvr.Cells[5].Text).ToString().Trim() == "Cash")
                {
                    ddlDepositPaymentMethod.SelectedIndex = 0;
                }
                else if ((gvr.Cells[5].Text).ToString().Trim() == "Check")
                {
                    ddlDepositPaymentMethod.SelectedIndex = 1;
                }
                if ((gvr.Cells[4].Text).ToString().Trim() == "$25.00")
                {
                    txtDepositAmount.Text = "";
                    ddlDepositPaymentAmount.SelectedIndex = 0;
                }
                else if ((gvr.Cells[4].Text).ToString().Trim() == "$50.00")
                {
                    txtDepositAmount.Text = "";
                    ddlDepositPaymentAmount.SelectedIndex = 1;
                }
                else if ((gvr.Cells[4].Text).ToString().Trim() == "$75.00")
                {
                    txtDepositAmount.Text = "";
                    ddlDepositPaymentAmount.SelectedIndex = 2;
                }
                else if ((gvr.Cells[4].Text).ToString().Trim() == "$100.00")
                {
                    txtDepositAmount.Text = "";
                    ddlDepositPaymentAmount.SelectedIndex = 3;
                }
                else
                {
                    ddlDepositPaymentAmount.SelectedIndex = 4;
                    txtDepositAmount.Text = cost[1];
                }
            }
            else
            {
                lblFormTitle.Text = "Purchase Form";
                RowDeposit.Style.Add("display", "none");
                RowOwlcardOptions.Style.Add("display", "none");
                RowPurchases.Style.Add("Display", "true");
                SqlCommand objCommand = new SqlCommand();
                objCommand.CommandType = CommandType.StoredProcedure;
                objCommand.CommandText = "getModalTransactionItems";
                objCommand.Parameters.AddWithValue("@param1", gvDisplay.DataKeys[gvr.RowIndex].Values[0].ToString().Trim());
                DataSet ds = conn.GetDataSetUsingCmdObj(objCommand);
                gvPurchases.DataSource = ds;
                gvPurchases.DataBind();

                foreach (GridViewRow gr in gvPurchases.Rows)
                {
                    TextBox tb = (TextBox)gr.FindControl("txtValidID");
                    tb.Text = gvPurchases.DataKeys[gr.RowIndex].Values[0].ToString().Trim();
                }


            }
            String[] name = (gvr.Cells[2].Text).ToString().Split(' ');
            txtFirstName.Text = name[0];
            txtLastName.Text = name[1];
            txtSignature.Text = gvDisplay.DataKeys[gvr.RowIndex].Values[4].ToString().Trim();
            txtID.Text = (gvr.Cells[1].Text).ToString();

        }
        protected void closeModal(object sender, EventArgs e)
        {
            myModal.Style.Add("display", "none");

        }

      
        }
    }
