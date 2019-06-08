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


namespace OwlCard.secure
{
    public partial class ItemsPage : System.Web.UI.Page
    {

        Connection conn = new Connection();
        int itemcount;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && (Session["Authorized"] == null || Session["Authorized"].ToString() != "Admin"))
            {
                Response.Redirect("500-Error.aspx");
            }
            if (!IsPostBack)
            {
                GenerateSearchResultTable(getItems());
            }
        }
        protected DataSet getItems()
        {
            // making db call
            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "GetItemsInfo";
            DataSet ds = conn.GetDataSetUsingCmdObj(objCommand);
            return ds;
            


        }
        private void GenerateSearchResultTable(DataSet ds)
        {
            DataTable d;       // used to reference a table in the dataset
            DataRow record;    // used to reference a singe row (record) from the dataset

            String strHTML = "";
            d = ds.Tables[0];// assigning data returned from DB to loacal variable
            itemcount = d.Rows.Count;
            //https://jsfiddle.net/Mottie/z8Lacguz/
            if (d.Rows.Count != 0)
            {
                strHTML = strHTML +
                    "<table class='tablesorter'>" +
                          "<thead>" +
                              "<tr>" +
                                  "<th> ID </th>" +
                                  "<th> Name </th>" +
                                  "<th> Description </th>" +
                                  "<th> Cost </th>" +
                                
                              "</tr>" +
                          "</thead>" +
                          "<tfoot>" +
                              "<tr class='tablesorter - ignoreRow'>" +
                              "<th colspan = '4' class='ts-pager form-horizontal'>" +
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
                    strHTML = strHTML + "<tr>" +
                                            "<td>" + record["Id"] + "</td>" +
                                            "<td>" + record["Name"] + "</td>" +
                                            "<td>" + record["Description"] + "</td>" +
                                            "<td>" + String.Format("{0:c}", record["Cost"]) + "</td>" +
                                           
                                        "</tr>";

                }

                // End the HTML table
                strHTML += "</tbody></table>";

            }

            // Write the HTML string for the table to a DIV in the HTML markup of the ASPX page
            divDisplay.InnerHtml = strHTML;

        }
        protected void Add_Click(object sender, EventArgs e)
        {
            if (!txtName.Text.Equals("") && (!txtCost.Equals("") && Double.Parse(txtCost.Text) > 0))
            {


                SqlCommand objCommand = new SqlCommand();
                objCommand.CommandType = CommandType.StoredProcedure;
                objCommand.CommandText = "AddSalesItem";
                objCommand.Parameters.AddWithValue("@Name", txtName.Text);
                objCommand.Parameters.AddWithValue("@Description", txtDescription.Text);
                objCommand.Parameters.AddWithValue("@Cost", Double.Parse(txtCost.Text));
                conn.DoUpdateUsingCmdObj(objCommand);
                GenerateSearchResultTable(getItems());
                lblAddWarning.Style.Add("display", "none");
            }
            else
            {
                lblAddWarning.Style.Add("display", "block");
            }
        }
        protected void Update_Click(object sender, EventArgs e)
        {
            if (!txtUpdateRow.Text.Equals("") && Int32.Parse(txtUpdateRow.Text) > 0)
            {
                gvItems.Style.Add("Display", "inline-block");
                SqlCommand objCommand = new SqlCommand();
                objCommand.CommandType = CommandType.StoredProcedure;
                objCommand.CommandText = "GetSingleSalesItem";
                objCommand.Parameters.AddWithValue("@id", Int32.Parse(txtUpdateRow.Text));
                DataSet ds = conn.GetDataSetUsingCmdObj(objCommand);
                gvItems.DataSource = ds;
                gvItems.DataBind();
                GridViewRow gr = gvItems.Rows[0];
                TextBox tbName = (TextBox)gr.FindControl("txtUpdateName");
                TextBox tbDescription = (TextBox)gr.FindControl("txtUpdateDescription");
                TextBox tbCost = (TextBox)gr.FindControl("txtUpdateCost");
                tbCost.Text = (gvItems.DataKeys[gr.RowIndex].Values[2].ToString());
                tbDescription.Text = (gvItems.DataKeys[gr.RowIndex].Values[1].ToString());
                tbName.Text = (gvItems.DataKeys[gr.RowIndex].Values[0].ToString());
                lblIdWarning.Style.Add("display", "none");
            }
            else
            {
                lblIdWarning.Style.Add("display", "block");
            }
        }
        protected void SubmitUpdate_Click(object sender, EventArgs e)
        {

            GridViewRow gr = gvItems.Rows[0];
            TextBox tbName = (TextBox)gr.FindControl("txtUpdateName");
            TextBox tbDescription = (TextBox)gr.FindControl("txtUpdateDescription");
            TextBox tbCost = (TextBox)gr.FindControl("txtUpdateCost");
            gvItems.Style.Add("Display", "none");
            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "UpdateItems";
            objCommand.Parameters.AddWithValue("@itemID", Int32.Parse(gr.Cells[0].Text));
            objCommand.Parameters.AddWithValue("@name", tbName.Text);
            objCommand.Parameters.AddWithValue("@Description", tbDescription.Text);
            objCommand.Parameters.AddWithValue("@cost", Double.Parse(tbCost.Text));
            conn.DoUpdateUsingCmdObj(objCommand);
            GenerateSearchResultTable(getItems());
        }
        protected void DeleteUpdate_Click(object sender, EventArgs e)
        {
            GridViewRow gr = gvItems.Rows[0];
            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "DeleteItems";
            objCommand.Parameters.AddWithValue("@itemID", Int32.Parse(gr.Cells[0].Text));
            conn.DoUpdateUsingCmdObj(objCommand);
            GenerateSearchResultTable(getItems());
        }
    }
}