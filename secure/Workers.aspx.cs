
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
    
        public partial class Workers : System.Web.UI.Page
        {
            Connection conn = new Connection();
            SqlCommand objCommand = new SqlCommand();
            int i;
            protected void Page_Load(object sender, EventArgs e)
            {

            if (!IsPostBack && (Session["Authorized"] == null || Session["Authorized"].ToString() != "Admin"))
            {

                Response.Redirect("500-Error.aspx");
            }
            if (!IsPostBack)
            {

                Rptviewjob();
                lblmsg2.Text = "";

      

            }

        }

            protected void Rptviewjob()
            {

        
            objCommand.Parameters.Clear();
                objCommand.CommandType = CommandType.StoredProcedure;
                objCommand.CommandText = "GetAdminsAndWorkers";
                rptWokers.DataSource = conn.GetDataSetUsingCmdObj(objCommand);
                rptWokers.DataBind();


                //gvWorkers.DataSource = conn.GetDataSetUsingCmdObj(objCommand);
                //gvWorkers.DataBind();

            }


            protected void btnSubmit_Click(object sender, EventArgs e)
            {
                //bool validornot = userInputValidation();
                //if (validornot == true)
                //{
                    try
                    {
                        SqlCommand objCommand = new SqlCommand();
                        objCommand.CommandType = CommandType.StoredProcedure;
                        objCommand.CommandText = "CreateWorker";
                        objCommand.Parameters.AddWithValue("@TUID", txtTUid.Text);
                        objCommand.Parameters.AddWithValue("@name", txtFirstName.Text + " " + txtLastName.Text);
                        objCommand.Parameters.AddWithValue("@IsAdmin",Convert.ToInt16(ddlAdminOrWorker.SelectedValue.ToString()));
                        i = conn.DoUpdateUsingCmdObj(objCommand);
                        if (i == -1)
                        {
                        lblmsg2.Text = "<div class='alert alert-danger'><strong>Worker Exists!</strong></div>";
                        }
                        else
                        {

                        lblmsg2.Text = "<div class='alert alert-success'><strong>Worker Added!</strong></div>";
                        Rptviewjob();
                        //Gridviewjob();
                    }
                    }
                    catch (Exception ex)
                    {
               
                  lblmsg2.Text = "<div class='alert alert-danger'><strong> " + ex.ToString() + "</strong></div>";
                }
                //}



            }



        protected void rptWokers_ItemCommand1(object source, RepeaterCommandEventArgs e)
        {
            Label myLabel;
            string TUID;
            int rowIndex = e.Item.ItemIndex;
            if (e.CommandName== "Delete")
            {
                try
                {

                     myLabel = (Label)rptWokers.Items[rowIndex].FindControl("lblTUID");
                     TUID = myLabel.Text;
                    SqlCommand objCommand = new SqlCommand();
                    objCommand.CommandType = CommandType.StoredProcedure;
                    objCommand.CommandText = "DeleteWorker";
                    objCommand.Parameters.AddWithValue("@TUID", TUID);
                    conn.DoUpdateUsingCmdObj(objCommand);
                    lblmsg2.Text = "<div class='alert alert-danger'><strong>Worker Deleted!</strong></div>";
                    Rptviewjob();


                }
                catch (Exception ex)
                {
                    lblmsg2.Text = "<div class='alert alert-danger'><strong> " + ex.ToString() + "</strong></div>";
                }

            }
            
            else if (e.CommandName == "Save")
            {
                try
                {
                    CheckBox chk = (CheckBox)rptWokers.Items[rowIndex].FindControl("CheckBox1");
                    if (chk.Checked) {

                        myLabel = (Label)rptWokers.Items[rowIndex].FindControl("lblTUID");
                        TUID = myLabel.Text;
                        SqlCommand objCommand = new SqlCommand();
                        objCommand.CommandType = CommandType.StoredProcedure;
                        objCommand.CommandText = "PromoteOrDemote";
                        objCommand.Parameters.AddWithValue("@TUID", TUID);
                        objCommand.Parameters.AddWithValue("@IsAdmin", 1);
                        conn.DoUpdateUsingCmdObj(objCommand);
                        lblmsg2.Text = "<div class='alert alert-success'><strong>Worker Info Saved!</strong></div>";
                        Rptviewjob();
                        
                    }
                    else
                    {

                        myLabel = (Label)rptWokers.Items[rowIndex].FindControl("lblTUID");
                        TUID = myLabel.Text;
                        SqlCommand objCommand = new SqlCommand();
                        objCommand.CommandType = CommandType.StoredProcedure;
                        objCommand.CommandText = "PromoteOrDemote";
                        objCommand.Parameters.AddWithValue("@TUID", TUID);
                        objCommand.Parameters.AddWithValue("@IsAdmin", 0);
                        conn.DoUpdateUsingCmdObj(objCommand);
                        lblmsg2.Text = "<div class='alert alert-success'><strong>Worker Info Saved!</strong></div>";
                        Rptviewjob();
                    }

                }
                catch (Exception ex)
                {
                    lblmsg2.Text = "";
                    lblmsg2.Text = "<div class='alert alert-danger'><strong> " + ex.ToString() + "</strong></div>";
                }

            }

        }

        protected void btnClearSearch_Click(object sender, EventArgs e)
        {
            txtFirstName.Text = string.Empty;
            txtLastName.Text = string.Empty;
            txtTUid.Text = string.Empty;
        }

        protected void btnFindWorker_Click1(object sender, EventArgs e)
        {
            if (txtTUid.Text.Length == 9)
            {
                OwlCard.Classes.WebService.LDAPuser Temple_Information = new WebService.LDAPuser();
                Temple_Information=OwlCard.Classes.WebService.Webservice.getLDAPEntryByTUID(txtTUid.Text);
                 txtFirstName.Text = Temple_Information.givenName;
                txtLastName.Text = Temple_Information.sn;
            }
        }
    }
    }

