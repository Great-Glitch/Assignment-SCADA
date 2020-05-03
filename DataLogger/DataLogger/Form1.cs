using System;
using System.Windows.Forms;

namespace DataLogger
{

    public partial class Form1 : Form
    {
        PidController piController;
        AirHeater airHeater = new AirHeater(0.5);
        SqlDatabase sqlDatabase = new SqlDatabase("SCADA");
        OPC opcTemp = new OPC(@"\\localhost\SCADA_OPC\TC-01");
        OPC opcU = new OPC(@"\\localhost\SCADA_OPC\PID-U");
        object[,] data;
        object[,] measurementTemp = new object[2, 4];
        object[,] measurementU = new object[2, 4];
        double temprature;
        double controllerSignal;


        public Form1(PidController controller)
        {
            InitializeComponent();
            piController = controller;
            measurementTemp[0, 0] = "Tagname"; measurementTemp[0, 1] = "value"; measurementTemp[0, 2] = "status"; measurementTemp[0, 3] = "quality";
            measurementU[0, 0] = "Tagname"; measurementU[0, 1] = "value"; measurementU[0, 2] = "status"; measurementU[0, 3] = "quality";
            //tagData[0, 0] = "TagId";[0, 1] =
        }

        private void btnLogg_Click(object sender, EventArgs e)
        {

            tmrSample.Start();

        }

        private void tmrSample_Tick(object sender, EventArgs e)
        {
            opcTemp.Connect();
            opcU.Connect();

            temprature = opcTemp.ReadValue();
            controllerSignal = opcU.ReadValue();
            txtMeasure.Text = temprature.ToString();
            txtPI.Text = controllerSignal.ToString();

            measurementTemp[1, 0] = "TC-01"; measurementTemp[1, 1] = temprature; measurementTemp[1, 2] = opcTemp.connectionStatus.ToString(); measurementTemp[1, 3] = opcTemp.Quality;
            measurementU[1, 0] = "PID.U"; measurementU[1, 1] = controllerSignal; measurementU[1, 2] = opcU.connectionStatus.ToString(); measurementU[1, 3] = opcU.Quality;

            sqlDatabase.OpenConnection();
            sqlDatabase.RunProcedure("uspInsertIntoMeasurement", measurementTemp);
            sqlDatabase.RunProcedure("uspInsertIntoMeasurement", measurementU);

            sqlDatabase.CloseConnection();

            opcTemp.Disconnect();
            opcU.Disconnect();

        }



        private void Form1_Load(object sender, EventArgs e)
        {

        }
        private void Form1_FormClosing(Object sender, FormClosingEventArgs e)
        {
            opcTemp.Disconnect();
            opcU.Disconnect();
        }
    }
}
