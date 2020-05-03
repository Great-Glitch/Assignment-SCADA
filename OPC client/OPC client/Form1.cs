using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace OPC_client
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            tempSensor = new AnalogSensor(1, 0, 40);
            opc = new OPC(@"\\localhost\ProcessData\Temperature\Configured Aliases\Temperature");
            timer1.Start();
        }
        AnalogSensor tempSensor;
        OPC opc;
        private void btnGetVal_Click(object sender, EventArgs e)
        {
            opc.Connect();
            tempSensor.value = opc.ReadValue();
            opc.Disconnect();
            txtGetVal.Text = tempSensor.value.ToString();
            waveformGraph1.PlotYAppend(tempSensor.value);
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            opc.Connect();
            txtConnection.Text = opc.connectionStatus;
            
        }
        
    }

}
