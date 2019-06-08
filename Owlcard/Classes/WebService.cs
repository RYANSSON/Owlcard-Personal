using OwlCard.LDAP_Search;
using OwlCard.WS_Student;
using System;
using System.Configuration;
using OwlCard.Classes;
using OwlCard;

namespace OwlCard.Classes
{
    public class WebService
    {
        /// <summary>
        /// Class to create an LDAP User.  Also, due to the lack of Faculty Web service calls, this will be the primary object for
        /// Faculty Login
        /// </summary>
        public class LDAPuser
        {
            public string templeEduID;
            public string uID;
            public string cn;
            public string givenName;
            public string sn;
            public string eduPersonAffiliation;
            public string eduPersonPrimaryAffiliation;
            public string mail;
            public string title;
        }

        /// <summary>
        /// Class for identifying Term
        /// </summary>
        public class Term
        {
            public string termCode;
            public string termName;
            public string startDate;
            public string endDate;
            public string registrationStartDate;
            public string registrationEndDate;
        }

        /// <summary>
        /// Student Object 
        /// </summary>
        public class StudentObj
        {
            public string firstName { get; set; }
            public string middleInit { get; set; }
            public string lastName { get; set; }
            public string tuid { get; set; }
            public string email { get; set; }
            public string school { get; set; }
            public string major1 { get; set; }
            public string major2 { get; set; }

            public StudentObj() { }

            //Big ol' constructor
            public StudentObj(string firstName, string middleInit, string lastName, string tuid, string email, string school, string major1, string major2)
            {
                this.firstName = firstName;
                this.middleInit = middleInit;
                this.lastName = lastName;
                this.tuid = tuid;
                this.email = email;
                this.school = school;
                this.major1 = major1;
                this.major2 = major2;
            }
        }

        /// <summary>
        /// Class to hold College Info
        /// </summary>
        public class College
        {
            public string collegeName;
            public string collegeCode;
        }

        /// <summary>
        /// This is a helper class for Web Service requests
        /// </summary>

        public static class Webservice
        {
            //private static readonly string webServiceUsername = ConfigurationManager.AppSettings["Connection_WS_Username"];
            //private static readonly string webServicePassword = ConfigurationManager.AppSettings["Connection_WS_Password"];

            /// <summary>
            /// Creates a LDAPuser (Person Object) when passing a TUID
            /// </summary>
            /// <param name="tuID">TUID</param>
            /// <returns>LDAPuser</returns>
           /* public static LDAPuser getLDAPEntryByTUID(string tuID)
            {
                // Create the WebService proxy, send the search request and receive the TempleLDAPEntry object
                LDAP_Search.LDAP_Search ldapProxy = new LDAP_Search.LDAP_Search();

                TempleLDAPEntry[] results = new TempleLDAPEntry[1];
                results = ldapProxy.Search(webServiceUsername, webServicePassword, "templeEduTUID", tuID);
                TempleLDAPEntry resultEntry = results[0];

                // Check if request was successful
                if (resultEntry.error == null) // Success
                {
                    // Create our TempleLDAPEntry object to be returned
                    LDAPuser personLDAPEntry = new LDAPuser();
                    personLDAPEntry.templeEduID = resultEntry.templeEduTUID;
                    personLDAPEntry.uID = resultEntry.uid;
                    personLDAPEntry.cn = resultEntry.cn;
                    personLDAPEntry.givenName = resultEntry.givenName;
                    personLDAPEntry.sn = resultEntry.sn;
                    personLDAPEntry.eduPersonAffiliation = resultEntry.eduPersonAffiliation;
                    personLDAPEntry.eduPersonPrimaryAffiliation = resultEntry.eduPersonPrimaryAffiliation;
                    personLDAPEntry.mail = resultEntry.mail;
                    personLDAPEntry.title = resultEntry.title;
                    return personLDAPEntry;
                }
                else // Something went wrong..
                {
                    LDAPuser personLDAPEntry = new LDAPuser();
                    personLDAPEntry.givenName = "error";
                    personLDAPEntry.sn = "error";
                    //return null;
                    return personLDAPEntry;
                }
            }
            */

           
            /// <summary>
            /// Checks if string is null or empty and if so returns empty string.
            /// </summary>
            /// <param name="str"></param>
            /// <returns>String</returns>
            private static string IsNull(string str)
            {
                if (string.IsNullOrEmpty(str))
                {
                    return "";
                }
                else
                    return str;
            }

          
        }
    }
}