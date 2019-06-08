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

namespace OwlCard.secure
{
    public partial class Default : System.Web.UI.Page
    {
        Connection conn = new Connection();
        // declaring variables for Shibboleth-authed information
        //string employeeNumber = string.Empty;
        //string eduPersonPrincipalName = string.Empty;
        //string mail = string.Empty;
        //string affiliation = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            

            /* Check if the application is running demo mode */
           // if (ConfigurationManager.AppSettings["demo_mode"].ToLower().Equals("false"))
            {
                /* Check if the application is running locally for development
                 * Retrieve request header information
                 */
            //    if (HttpContext.Current.Request.IsLocal.Equals(true))
                {
                    /*The SSO Sign-on page will not appear while running locally. This is only used for development.*/
             //       employeeNumber = "915295896";
             //       GetUserInformation(employeeNumber);
                }
            //    else
                {
                    /*Application is running on server and the user has active Shibboleth session.*/
             //       employeeNumber = GetShibbolethHeaderAttributes();
            //        GetUserInformation(employeeNumber);
                }

                /*Use employee number to get user information from web services and then redirect*/
                //GetUserInformation(employeeNumber);
            } // end if statement
           // Session["Authorized"] = "Admin";

            Server.Transfer("Request.aspx");

        } // end page load

        /// Retrieve user information from Shibboleth headers
        ///     returns User's TUid
        //protected string GetShibbolethHeaderAttributes()
        //{
        //   string employeeNumber = Request.Headers["employeeNumber"]; //Use this to retrieve the user's information via the web services  
        //    Session["SSO_Attribute_mail"] = Request.Headers["mail"];
        //    Session["SSO_Attribute_affiliation"] = Request.Headers["affiliation"];
        //   Session["SSO_Attribute_eduPersonPrincipalName"] = Request.Headers["eduPersonPrincipalName"];
        //   Session["SSO_Attribute_Unscoped_Affiliation"] = Request.Headers["unscopedaffiliation"];
        //    Session["SSO_Attribute_employeeNumber"] = employeeNumber;

        //   return employeeNumber;
        // }


        //protected void GetUserInformation(string employeeNumber)
        // {
        //if (!string.IsNullOrWhiteSpace(employeeNumber))
        //    {
        //   int authLevel = IsAuthorized(employeeNumber);

        // if student not authorized ????? ---- CURRENTLY REDIRECTING TO A 500 ERROR PAGE
        //   if (authLevel == 2)
        //       {
        //        Session.Abandon();

        //        Server.Transfer("request.aspx");
        //       }

        // student worker, NO access to History.aspx or Admin.aspx
        //    else if (authLevel == 0)
        //    {
        //       Session["Authorized"] = "Student";

        //     }

        // admin - access to every page
        //     else
        //     {
            //    }

                /*Successful Login - Allowed to be redirected to Request.aspx*/
              //  Session["ID"] = employeeNumber;
            //    Response.Redirect("Request.aspx");
                
                
          //  }
            //else
          //  {
                //Error: Couldn't retrieve employeeNumber from request header
                // Clear Session Objects
          //      Session.Abandon();
          //      Server.Transfer("request.aspx");

           // }
        //}

        // takes an employee number (obtained from Shibboleth) as input
        //      checks against our worker table to see if logged in user is authorized to use our application
        //          returns true if authorized
        //protected int IsAuthorized(string employeeNumber)
        //{
            // making db call
          //  SqlCommand objCommand = new SqlCommand();
          //  objCommand.CommandType = CommandType.StoredProcedure;
         //  objCommand.CommandText = "IsAdmin";
         //   objCommand.Parameters.AddWithValue("@theTUID", employeeNumber);

        //    DataSet ds = conn.GetDataSetUsingCmdObj(objCommand);
        //    int active = Convert.ToInt32(ds.Tables[0].Rows[0]["IsActive"]);
        //    if (ds.Tables[0].Rows.Count == 0 || active == 0)
        //    {
                // worker does not exist in our db
       //         return 2;
        //    }
       //     int authLevel = Convert.ToInt32(ds.Tables[0].Rows[0]["IsAdmin"]);
          
       //     return authLevel;
        //}

        /// <summary>
        /// Spoof user to look like my information.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        //protected void btnEmployeeTestAcct_Click(object sender, EventArgs e)
        //{
         //   try
        //    {
         //       GetUserInformation("888000088");
        //    }
        //    catch (Exception)
        //    {
        //        Server.Transfer("request.aspx");
            //}
        //}

        /// <summary>
        /// Spoof test account
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
       // protected void btnStudentTestAcct_Click(object sender, EventArgs e)
       //{
         //   try
        //    {
         //       GetUserInformation("888000089");
        //    }
        //    catch (Exception)
       //     {
         //       Server.Transfer("request.aspx");
       //     }
       // }
        
        /// <summary>
         /// Use shibboleth if application is running demo_mode, but also not running locally.
         /// </summary>
         /// <param name="sender"></param>
         /// <param name="e"></param>
        //protected void btnShibb_Click(object sender, EventArgs e)
        //{
          //  try
         //   {
          //      if (Request.Headers["employeeNumber"] != null)
         //       {
         //           GetUserInformation(Request.Headers["employeeNumber"]);
         //       }
         //       else
         //       {
         //           divError.Visible = true;
         //           lblError.Text = (HttpContext.Current.Request.IsLocal.Equals(true)) ? "<strong>Error:</strong> Shibboleth cannot be used if application is running locally." : "<strong>Error:</strong> Profile could not be loaded!";
          //      }
          //  }
         //   catch (Exception)
          //  {
          //      Server.Transfer("request.aspx");
          //  }
       // }


    }
}