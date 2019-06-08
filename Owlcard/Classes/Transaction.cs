using OwlCard.Classes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace OwlCard.Classes
{
    public class Transaction
    {
        

        private int tuID;
        private string name;
        private string signature;
        private int witnessID;
        private DateTime timestamp;
        private decimal cost;
        private string payType;
        private string photoType;
        private string transactionType;

        //default constructor
        public Transaction()
        {
        }

        // full parameterized constructor
        public Transaction(int tuID, string name, string signature, int witnessID, DateTime timestamp, decimal cost, string payType, string photoType, string transactionType)
        {
            this.tuID = tuID;
            this.name = name;
            this.signature = signature;
            this.witnessID = witnessID;
            this.timestamp = timestamp;
            this.cost = cost;
            this.payType = payType;
            this.photoType = photoType;
            this.transactionType = transactionType;
        }

        // getters/setters
        public int TuID { get => tuID; set => tuID = value; }
        public string Name { get => name; set => name = value; }
        public string Signature { get => signature; set => signature = value; }
        public int WitnessID { get => witnessID; set => witnessID = value; }
        public DateTime Timestamp { get => timestamp; set => timestamp = value; }
        public decimal Cost { get => cost; set => cost = value; }
        public string PayType { get => payType; set => payType = value; }
        public string PhotoType { get => photoType; set => photoType = value; }
        public string TransactionType { get => transactionType; set => transactionType = value; }

        // Create initial transaction method
        //      returns newly created TransactionID
        public static int CreateTransaction (Transaction thisTrans)
        {
            /*Connection conn = new Connection();
            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "CreateTransactionRecord";
            objCommand.Parameters.AddWithValue("@TUID", thisTrans.TuID);
            objCommand.Parameters.AddWithValue("@Name", thisTrans.Name);
            objCommand.Parameters.AddWithValue("@Signature", thisTrans.Signature);
            objCommand.Parameters.AddWithValue("@DateTime", thisTrans.Timestamp);
            objCommand.Parameters.AddWithValue("@TransactionType", thisTrans.TransactionType);
            SqlParameter result = new SqlParameter("@transID", DbType.Int32);
            result.Direction = ParameterDirection.Output;
            objCommand.Parameters.Add(result);
            conn.DoUpdateUsingCmdObj(objCommand);
            int transID = Convert.ToInt32(objCommand.Parameters["@transID"].Value);
            */
            int transID = 1;           
            return transID;
        }

        public static void CreateTransactionItems (int transID, int[] Quantities, int[] ids, decimal[] costs)
        {
            Connection conn = new Connection(); 
            for(int i = 0; i < Quantities.Length; i++)
            {
                if (Quantities[i]!=(0))
                {
                    SqlCommand objCommand = new SqlCommand();
                    objCommand.CommandType = CommandType.StoredProcedure;
                    objCommand.CommandText = "CreateTransactionItem";
                    objCommand.Parameters.AddWithValue("@transID", transID);
                    objCommand.Parameters.AddWithValue("@itemID", ids[i]);
                    objCommand.Parameters.AddWithValue("@quantity", Quantities[i]);
                    objCommand.Parameters.AddWithValue("@cost", Quantities[i] * costs[i]);
                    //conn.DoUpdateUsingCmdObj(objCommand);
                }
            }
           
        }
        
        public static void UpdateTransactionCost(int transID, decimal cost)
        {
            Connection conn = new Connection();
            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "UpdateTransactionCost";
            objCommand.Parameters.AddWithValue("@transID", transID);
            objCommand.Parameters.AddWithValue("@cost", cost);
           //conn.DoUpdateUsingCmdObj(objCommand);
        }
    }
}