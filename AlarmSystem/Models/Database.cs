using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Data.SqlClient;


namespace Alarmsystem.Models
{
    public class Database
    {
        public SqlConnection con;
        public SqlCommand cmd;
        public SqlDataReader dr;
        public Database(string connectionString)
        {

            con = new SqlConnection(connectionString);

        }
    }
}
