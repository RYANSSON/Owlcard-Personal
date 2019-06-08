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
using System.Drawing;


namespace OwlCard
{
    public partial class Request : System.Web.UI.Page
    {
        
        Connection conn = new Connection();
        Boolean isTodays = false;

        //initial page load
        protected void Page_Load(object sender, EventArgs e)
        {
            // prevents unauthorized access
            //      if Authorized session is empty, redirect
            //session checks
            if (!IsPostBack && Session["Authorized"] == null)
            {
                Response.Redirect("500-Error.aspx");
            }
            //first GV load
            if (!IsPostBack)
            {
                getPendingTransactions();
            }
            initialTableLoad();
            myModal.Style.Add("display", "none");
        }
        //gets all pending transactions for workers
        protected void getPendingTransactions()
        {
            // making db call
           /*SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "getPendingTransactions";
            DataSet ds = conn.GetDataSetUsingCmdObj(objCommand);
            gvDisplay.DataSource = ds;
            gvDisplay.DataBind();
            gvupdater();*/  
        }
        //modified gridview on every table load
        protected void initialTableLoad()
        {
            foreach (GridViewRow gr in gvDisplay.Rows)
            {
                String original = (gvDisplay.DataKeys[gr.RowIndex].Values[1].ToString());
                //clears col 1 if its not a purchase row
                if ((gvDisplay.Rows[gr.RowIndex].Cells[6].Text).ToString().Trim() != "Purchase")
                {
                    gvDisplay.Rows[gr.RowIndex].Cells[0].Text = "";
                }
                //adds the clickable modal feature to columns that have no other function
                for (int i = 1; i < 6; i++)
                {
                    gvDisplay.Rows[gr.RowIndex].Cells[i].CssClass = "clickable";
                    gvDisplay.Rows[gr.RowIndex].CssClass = "mainTableRow";
                }
                //replaces drop downs for purchase and deposit with their text value
                if ((gvDisplay.DataKeys[gr.RowIndex].Values[1].ToString().Trim()) != "New" && (gvDisplay.DataKeys[gr.RowIndex].Values[1].ToString().Trim()) != "Replace")
                {
                    gvDisplay.Rows[gr.RowIndex].Cells[6].Text = original;
                }
                //alternates row colors
                if (gr.RowIndex % 2 == 1)
                {
                    gvDisplay.Rows[gr.RowIndex].BackColor = System.Drawing.Color.FromName("#f5f5f5");
                }
            }
        }
        //on postback table adjustments
        protected void gvupdater()
        {
            foreach (GridViewRow gr in gvDisplay.Rows)
            {
                //updates row colors
                if (gr.RowIndex % 2 == 1)
                {
                    gvDisplay.Rows[gr.RowIndex].BackColor = System.Drawing.Color.FromName("#f5f5f5");
                }
                String original = (gvDisplay.DataKeys[gr.RowIndex].Values[1].ToString().Trim());
                String photo = gvDisplay.DataKeys[gr.RowIndex].Values[3].ToString().Trim();
                if ((gvDisplay.DataKeys[gr.RowIndex].Values[1].ToString().Trim()) != "New" && (gvDisplay.DataKeys[gr.RowIndex].Values[1].ToString().Trim()) != "Replace")
                {
                    gvDisplay.Rows[gr.RowIndex].Cells[6].Text = original;
                }
                else
                {
                    DropDownList ddl = (DropDownList)gr.FindControl("ddTransactionType");
                    if (original == "New")
                    {
                        ddl.SelectedIndex = 1;
                    }
                    //adjusts the selected index of the dd based on photo choice(free or not)
                    else if (gr.Cells[4].Text.ToString().Trim() == "$20.00")
                    {
                        if (photo.Equals("True"))
                        {
                            ddl.SelectedIndex = 2;
                        }
                        else
                        {
                            ddl.SelectedIndex = 3;
                        }
                    }
                    else
                    {
                        if (photo.Equals("True"))
                        {
                            ddl.SelectedIndex = 4;
                        }
                        else
                        {
                            ddl.SelectedIndex = 5;
                        }
                    }
                }
            }
        }
        //runs when a row is approved
        protected void approveClick(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow gr = (GridViewRow)btn.NamingContainer;
            DropDownList ddl = (DropDownList)gr.FindControl("ddacceptance");
            DropDownList ddltransaction = (DropDownList)gr.FindControl("ddTransactionType");
            TextBox idtype = (TextBox)gr.FindControl("txtValidID");
            int photoChoice;
            String TransactionType;
            //called when on the pending tab
            if (btn.Text.Equals("Submit"))
            {
                //entry validation
                if (ddl.SelectedValue == "null" || idtype.Text.Equals(""))
                {
                    myModal2.Style.Add("display", "block");
                    lblWarning.Text = "Please make sure the ID and APPROVAL fields are correct";
                }
                //if everything is valid get the info to submit the transaction update
                else
                {
                    SqlCommand objCommand = new SqlCommand();
                    objCommand.CommandType = CommandType.StoredProcedure;
                    objCommand.CommandText = "ApproveTransaction";
                    objCommand.Parameters.AddWithValue("@id", Convert.ToInt32(gvDisplay.DataKeys[gr.RowIndex].Values[0]));
                    //boolean value for acceptance criteria
                    if (ddl.SelectedValue == "Accept")
                    {
                        objCommand.Parameters.AddWithValue("@Approved", 1);
                    }
                    else
                    {
                        objCommand.Parameters.AddWithValue("@Approved", 0);
                    }
                    String original = (gvDisplay.DataKeys[gr.RowIndex].Values[1].ToString().Trim());
                    String photo = gvDisplay.DataKeys[gr.RowIndex].Values[3].ToString().Trim();
                    //evaluate photo options selected 
                    if ((gvDisplay.DataKeys[gr.RowIndex].Values[1].ToString().Trim()) != "New" && (gvDisplay.DataKeys[gr.RowIndex].Values[1].ToString().Trim()) != "Replace")
                    {
                        objCommand.Parameters.AddWithValue("@transactionType", original);
                        objCommand.Parameters.AddWithValue("@photoChoice", 1);
                    }
                    else
                    {
                        int si = ddltransaction.SelectedIndex;
                        switch (si)
                        {
                            case 0: photoChoice = 1; TransactionType = "New"; break;
                            case 1: photoChoice = 1; TransactionType = "Replace"; break;
                            case 2: photoChoice = 0; TransactionType = "Replace"; break;
                            case 3: photoChoice = 1; TransactionType = "Replace"; break;
                            case 4: photoChoice = 1; TransactionType = "Replace"; break;
                            default: photoChoice = 0; TransactionType = original; break; ;
                        }
                        objCommand.Parameters.AddWithValue("@transactionType", TransactionType);
                        objCommand.Parameters.AddWithValue("@photoChoice", photoChoice);
                    }
                    objCommand.Parameters.AddWithValue("@cost", (gvDisplay.Rows[gr.RowIndex].Cells[4].Text.ToString().Trim()));
                    objCommand.Parameters.AddWithValue("@paymentMethod", gvDisplay.Rows[gr.RowIndex].Cells[5].Text.ToString().Trim());
                    objCommand.Parameters.AddWithValue("@Witness", Convert.ToInt32(Session["ID"].ToString()));
                    TextBox txtid = (TextBox)gr.FindControl("txtValidID");
                    String ValidID = txtid.Text.ToString();
                    objCommand.Parameters.AddWithValue("@IdType", ValidID);
                    //transaction time updated to current time
                    objCommand.Parameters.AddWithValue("@date", DateTime.Now);
                    conn.DoUpdateUsingCmdObj(objCommand);
                    getPendingTransactions();
                    initialTableLoad();
                }
            }
            //runs on today's tab setting values to null
            else
            {
                SqlCommand objCommand = new SqlCommand();
                objCommand.CommandType = CommandType.StoredProcedure;
                objCommand.CommandText = "ApproveTransaction";
                objCommand.Parameters.AddWithValue("@id", Convert.ToInt32(gvDisplay.DataKeys[gr.RowIndex].Values[0]));
                objCommand.Parameters.AddWithValue("@Approved", DBNull.Value);
                objCommand.Parameters.AddWithValue("@Witness", DBNull.Value);
                objCommand.Parameters.AddWithValue("@IdType", DBNull.Value);
                objCommand.Parameters.AddWithValue("@cost", gvDisplay.Rows[gr.RowIndex].Cells[4].Text.ToString().Trim());
                objCommand.Parameters.AddWithValue("@paymentMethod", (gvDisplay.Rows[gr.RowIndex].Cells[5].Text.ToString().Trim()));
                objCommand.Parameters.AddWithValue("@transactionType", (gvDisplay.DataKeys[gr.RowIndex].Values[1]));
                objCommand.Parameters.AddWithValue("@photoChoice", gvDisplay.DataKeys[gr.RowIndex].Values[3]);
                objCommand.Parameters.AddWithValue("@date", DateTime.Now);
                conn.DoUpdateUsingCmdObj(objCommand);
                todaysTable();
                initialTableLoad();
            }        
        }
        //called when a row is clicked to open a modal view
        protected void modal_Click(object sender, EventArgs e)
        {
            myModal.Style.Add("display", "block");
            GridViewRow gvr = gvDisplay.Rows[Int32.Parse(ValueHiddenField.Value)];
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
            
                foreach(GridViewRow gr in gvPurchases.Rows) {
                    TextBox tb=(TextBox)gr.FindControl("txtValidID");
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

        protected void closeModal2(object sender, EventArgs e)
        {
            myModal2.Style.Add("display", "none");

        }

        private DataTable GetData(int id)
        {
            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "getTransactionItems";
            objCommand.Parameters.AddWithValue("@param1", id);
            DataSet ds = conn.GetDataSetUsingCmdObj(objCommand);
         
            DataTable dt = ds.Tables[0];
            return dt;
        }
        protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int TransactionId = Int32.Parse(gvDisplay.DataKeys[e.Row.RowIndex].Value.ToString());
                GridView gvItems = e.Row.FindControl("gvItems") as GridView;
                gvItems.DataSource = GetData(TransactionId);
                gvItems.DataBind(); 
            }
           
             
            
        }
       

        protected void ddTransactionType_SelectedIndexChanged(object sender, EventArgs e)
        {
           
            DropDownList ddl = (DropDownList)sender;
            GridViewRow gr = (GridViewRow)ddl.NamingContainer;
            
            if (ddl.SelectedIndex == 1) {
                gvDisplay.Rows[gr.RowIndex].Cells[5].Text = "Free";
                gvDisplay.Rows[gr.RowIndex].Cells[4].Text = "0.00";
                //gvDisplay.DataKeys[gr.RowIndex].Values[1] = "New";
                //gvDisplay.DataKeys[gr.RowIndex].Values[3] = "True";
            }
            else if (ddl.SelectedIndex == 2)
            {
                gvDisplay.Rows[gr.RowIndex].Cells[5].Text = "Cash";
                gvDisplay.Rows[gr.RowIndex].Cells[4].Text = "$20.00";
                //gvDisplay.DataKeys[gr.RowIndex].Values[1] = "Replace";
                //gvDisplay.DataKeys[gr.RowIndex].Values[3] = "True";
            }
            else if (ddl.SelectedIndex == 3)
            {
                gvDisplay.Rows[gr.RowIndex].Cells[5].Text = "Cash";
                gvDisplay.Rows[gr.RowIndex].Cells[4].Text = "$20.00";
                //gvDisplay.DataKeys[gr.RowIndex].Values[1] = "Replace";
                //gvDisplay.DataKeys[gr.RowIndex].Values[3] = "False";
            }
            else if (ddl.SelectedIndex == 4)
            {
                gvDisplay.Rows[gr.RowIndex].Cells[5].Text = "Cash";
                gvDisplay.Rows[gr.RowIndex].Cells[4].Text = "$0.00";
                //gvDisplay.DataKeys[gr.RowIndex].Values[1] = "Replace";
                //gvDisplay.DataKeys[gr.RowIndex].Values[3] = "True";
            }
            else
            {
                gvDisplay.Rows[gr.RowIndex].Cells[5].Text = "Cash";
                gvDisplay.Rows[gr.RowIndex].Cells[4].Text = "$0.00";
                //gvDisplay.DataKeys[gr.RowIndex].Values[1] = "Replace";
                //gvDisplay.DataKeys[gr.RowIndex].Values[3] = "False";
            }

        }
        protected void CurrentQue(object sender, EventArgs e)
        {
            isTodays = false;
            getPendingTransactions();
            gvupdater();
            initialTableLoad();
            lblTableTitle.Text = "Unapproved Transactions";
            btnTodaysHistory.CssClass = "tab";
            btnCurrentItems.CssClass = "tab active";
            gvDisplay.HeaderRow.Cells[8].Text = "Approve/Deny";

        }
        protected void TodaysHistory(object sender, EventArgs e)
        {
            isTodays = true;
            todaysTable();
          
        }
        protected void todaysTable()
        {
            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "getWorkersDailyTransactions";
            objCommand.Parameters.AddWithValue("@workerID", Session["ID"].ToString());
            objCommand.Parameters.AddWithValue("@date", DateTime.Today);
            DataSet ds = conn.GetDataSetUsingCmdObj(objCommand);
            
            gvDisplay.DataSource = ds;
            gvDisplay.DataBind();
            gvupdater();
            initialTableLoad();
            lblTableTitle.Text = "Todays Transactions";
            btnCurrentItems.CssClass = "tab";
            btnTodaysHistory.CssClass = "tab active";
            foreach (GridViewRow gr in gvDisplay.Rows)
            {
                Button button = (Button)gr.FindControl("btnRowSubmit");
                button.Text = "Undo";
                if((gvDisplay.DataKeys[gr.RowIndex].Values[1].ToString().Trim()) == "New" || (gvDisplay.DataKeys[gr.RowIndex].Values[1].ToString().Trim()) == "Replace") {
                    if (gvDisplay.DataKeys[gr.RowIndex].Values[3].ToString().Trim() == "True")
                        gvDisplay.Rows[gr.RowIndex].Cells[6].Text = gvDisplay.DataKeys[gr.RowIndex].Values[1].ToString().Trim() + " with new photo";
                    else
                        gvDisplay.Rows[gr.RowIndex].Cells[6].Text = gvDisplay.DataKeys[gr.RowIndex].Values[1].ToString().Trim() + " without new photo";
                }
                else
                    gvDisplay.Rows[gr.RowIndex].Cells[6].Text = gvDisplay.DataKeys[gr.RowIndex].Values[1].ToString().Trim();
                gvDisplay.Rows[gr.RowIndex].Cells[8].Text = gvDisplay.DataKeys[gr.RowIndex].Values[2].ToString().Trim();
                gvDisplay.Rows[gr.RowIndex].Cells[7].Text = gvDisplay.DataKeys[gr.RowIndex].Values[5].ToString().Trim();

                if (gvDisplay.Rows[gr.RowIndex].Cells[8].Text == "True")
                    gvDisplay.Rows[gr.RowIndex].Cells[8].Text = "Approved";
                else
                    gvDisplay.Rows[gr.RowIndex].Cells[8].Text = "Denied";

            }
            gvDisplay.HeaderRow.Cells[8].Text = "Approved";
        }

        protected void FilterTransactions_Click(object sender, EventArgs e)
        {
            DataSet ds;
            if (lblTableTitle.Text.Equals("Todays Transactions"))
            {
                
                SqlCommand objCommand = new SqlCommand();
                objCommand.CommandType = CommandType.StoredProcedure;
                objCommand.CommandText = "filterTodaysTransactions";
                objCommand.Parameters.AddWithValue("@workerID", Session["ID"].ToString());
                objCommand.Parameters.AddWithValue("@date", DateTime.Today);
                objCommand.Parameters.AddWithValue("@name", txtSearch.Text);
                ds = conn.GetDataSetUsingCmdObj(objCommand);
            }
            else
            {
                SqlCommand objCommand = new SqlCommand();
                objCommand.CommandType = CommandType.StoredProcedure;
                objCommand.CommandText = "filterPendingTransactions";
                objCommand.Parameters.AddWithValue("@name", txtSearch.Text);

                ds = conn.GetDataSetUsingCmdObj(objCommand);
            }
            gvDisplay.DataSource = ds;
            gvDisplay.DataBind();
            gvupdater();
            initialTableLoad();
        }
        protected void ResetTransactions_Click(object sender, EventArgs e)
        {
            if (lblTableTitle.Text.Equals("Todays Transactions"))
            {
                todaysTable();
            }
            else
            {
                getPendingTransactions();
                gvupdater();
                initialTableLoad();
            }
        }
    }
}