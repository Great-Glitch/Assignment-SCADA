using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace DataLogger
{
    /// <summary>
    /// Class for establishing a connection to a SQL server
    /// </summary>
    class SqlDatabase
    {
        //private string connectionString = ConfigurationManager.ConnectionStrings["AssignmentDatabase"].ConnectionString;
        private string connectionString;
        private SqlConnection con;
        private SqlCommand cmd;
        private SqlDataReader dataReader;
        private bool connected = false;
        private int attempts = 0;

        /// <summary>
        /// Class for establishing a connection to a SQL server.
        /// sets the conection string to the specified database
        /// </summary>
        /// <param name="database">name of the database that should be connected to</param>
        public SqlDatabase(string database)
        {
            connectionString = ConfigurationManager.ConnectionStrings[database].ConnectionString;
        }

        /// <summary>
        /// opens a connection to the SQL database
        /// </summary>
        public void OpenConnection()
        {

            try
            {
                con = new SqlConnection(connectionString);
                con.Open();
                connected = true;
                attempts = 0;
            }
            catch (Exception e)
            {
                if (attempts >= 3)
                {
                    MessageBox.Show("An error occured when attempting to reach the SQL server, Please check your connection and try again.\r\n" + e.Message);

                }
                attempts++;
                OpenConnection();
            }

        }

        /// <summary>
        /// changes the assosiated connection to the specified database
        /// </summary>
        /// <param name="newDatabase"> The database that the object should connect to</param>
        public void changeDatabase(string newDatabase)
        {
            con.ChangeDatabase(newDatabase);
        }

        /// <summary>
        /// closes the established connection
        /// </summary>
        public void CloseConnection()
        {

            con.Close();
        }

        /// <summary>
        /// creates a view from the connection stored in the object
        /// </summary>
        /// <returns>
        /// A two dimensional array representing the values from the view, the first field in each collumn is the title of the collumn.
        /// </returns>
        public object[,] View(string view)
        {
            bool newConnection = false;
            if (!connected)
            {
                OpenConnection();
                newConnection = true;
            }
            int columnCount = 0;
            cmd = new SqlCommand(view, con);
            dataReader = cmd.ExecuteReader();
            List<List<object>> listOfList = new List<List<object>>();
            List<object> placeHolder;
            object[,] dataArray = new object[0, 0];
            for (int i = 0; i < dataReader.FieldCount; i++)
            {
                placeHolder = new List<object>();
                placeHolder.Add(dataReader.GetName(i).ToString());
                listOfList.Add(placeHolder);
                columnCount++;
            }
            while (dataReader.Read())
            {
                for (int i = 0; i < columnCount; i++)
                {
                    try
                    {
                        listOfList[i].Add(dataReader.GetValue(i));
                    }
                    catch (IndexOutOfRangeException)
                    {

                        listOfList[i].Add(null);
                    }

                }

            }
            dataArray = new object[columnCount, listOfList[0].Count];
            for (int i = 0; i < dataArray.GetLength(0); i++)
            {
                for (int j = 0; j < dataArray.GetLength(1); j++)
                {
                    try
                    {
                        dataArray[i, j] = listOfList[i][j];
                    }
                    catch (IndexOutOfRangeException)
                    {
                        dataArray[i, j] = null;

                    }

                }
            }
            if (newConnection)
            {
                CloseConnection();
            }
            return dataArray;
        }

        /// <summary>
        /// runs a stored procecedure with the parameters given.
        /// </summary>
        /// <param name="storedProcedure">
        /// the stored procedure that you whish to run
        /// </param>
        /// <param name="values">array of Parameter names and values.
        /// the parameter names must be stored in the first collumn with their repective value in the secound
        /// </param>
        public void RunProcedure(string storedProcedure, object[,] values)
        {
            bool newConnection = false;

            try
            {
                if (!connected)
                {
                    OpenConnection();
                    newConnection = true;
                }

                SqlCommand cmd = new SqlCommand(storedProcedure, con);
                cmd.CommandType = CommandType.StoredProcedure;
                for (int i = 0; i < values.GetLength(1); i++)
                {
                    cmd.Parameters.Add(new SqlParameter(values[0, i].ToString(), values[1, i]));
                }
                cmd.ExecuteNonQuery();

            }
            catch (Exception e)
            {

                MessageBox.Show("could not run the stored procedure: " + storedProcedure + ", because of the error:\r\n" + e.Message);

            }
            finally
            {
                if (newConnection)
                {
                    CloseConnection();
                }
            }


        }

        /// <summary>
        /// executes the stored procedure without any parameter
        /// </summary>
        /// <param name="storedProcedure">The stored procedure to be excecuted </param>
        public void RunProcedure(string storedProcedure)
        {
            bool newConnection = false;
            try
            {
                if (!connected)
                {
                    OpenConnection();
                    newConnection = true;
                }

                SqlCommand cmd = new SqlCommand(storedProcedure, con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.ExecuteNonQuery();
            }

            catch (Exception ex)
            {
                MessageBox.Show("could not run the stored procedure: " + storedProcedure + ", because of the error:\r\n" + ex.Message);
            }

            finally
            {
                if (newConnection)
                {
                    CloseConnection();
                }
            }
        }
    }
}
