using DataLogger;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Windows.Forms.DataVisualization.Charting;

namespace AirHeaterProcess
{
    public partial class Form1 : Form
    {
        public double timestep = 0.1;//seconds
        PidController pid;
        AirHeater airHeater;
        LowPassFilter lowPassFilter;
        List<double> uVal = new List<double>();
        List<double> tempValFilter = new List<double>();
        List<double> tempVal = new List<double>();
        List<double> setPoint = new List<double>();
        List<DateTime> time = new List<DateTime>();

        OPC opcTemp = new OPC(@"\\localhost\SCADA_OPC\TC-01");
        OPC opcU = new OPC(@"\\localhost\SCADA_OPC\PID-U");

        public Form1()
        {
            InitializeComponent();
            airHeater = new AirHeater(timestep);
            lowPassFilter = new LowPassFilter(timestep, 0.5, airHeater.tenv);
            pid = new PidController(0.4, 48, timestep, Convert.ToDouble(txtSP.Text));
            chartProcess.ChartAreas[0].AxisX.Interval = 15.0;
            chartProcess.ChartAreas[0].AxisX.IntervalType = DateTimeIntervalType.Seconds;
            chartProcess.ChartAreas[0].AxisX.LabelStyle.Format = "HH:mm:ss";

<<<<<<< HEAD
            chartProcess.Series["u [v]"].Points.DataBindXY(uVal, time);
            chartProcess.Series["°C unfiltered"].Points.DataBindXY(tempVal, time);
            chartProcess.Series["°C filtered"].Points.DataBindXY(tempValFilter, time);
            //opcTemp.ConnectWriter();
            //opcU.ConnectWriter();
=======
            chartProcess.Series["PID.U [V]"].Points.DataBindXY(uVal, time);
            chartProcess.Series["TC-01 [°C] unfiltered"].Points.DataBindXY(tempVal, time);
            chartProcess.Series["TC-01 [°C] filtered"].Points.DataBindXY(tempValFilter, time);
            opcTemp.ConnectWriter();
            opcU.ConnectWriter();

            txtKp.Text = pid.Kp.ToString();
            txtTi.Text = pid.Ti.ToString();
>>>>>>> 1fc931f5305694b2f58d8bfc72f85742e874953a
        }
        

        private void btnAirHeater_Click(object sender, EventArgs e)
        {
            timerTimestep.Start();
            timerChart.Start();
            
        }

        private void timerTimestep_Tick(object sender, EventArgs e)
        {
            tempVal.Add(airHeater.Y);
            lowPassFilter.Filtering(airHeater.Y);

            uVal.Add(pid.PiController(airHeater.Y));
            tempValFilter.Add(lowPassFilter.filteredVal);

            airHeater.Process(uVal.Last(), tempValFilter.Last());

            time.Add(DateTime.Now);
            setPoint.Add(pid.Sp);

        }

        private void btnPIDcontrol_Click(object sender, EventArgs e)
        {
            pid.Sp = Convert.ToDouble(txtSP.Text);
        }

        private void timerChart_Tick(object sender, EventArgs e)
        {
            chartProcess.Series["PID.U [V]"].Points.DataBindXY(time, uVal);
            chartProcess.Series["TC-01 [°C] unfiltered"].Points.DataBindXY(time, tempVal);
            chartProcess.Series["TC-01 [°C] filtered"].Points.DataBindXY(time, tempValFilter);
            chartProcess.Series["Set point TC-01 [°C]"].Points.DataBindXY(time, setPoint);
            chartProcess.Invalidate();
            //opcTemp.WriteValue(tempValFilter.Last());
            //opcU.WriteValue(uVal.Last());
        }

        private void btnUpdatePID_Click(object sender, EventArgs e)
        {
            pid.Kp = Convert.ToDouble(txtKp.Text);
            pid.Ti = Convert.ToDouble(txtTi.Text);
            
        }
    }
}
