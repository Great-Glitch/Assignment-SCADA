namespace AirHeaterProcess
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.Windows.Forms.DataVisualization.Charting.ChartArea chartArea1 = new System.Windows.Forms.DataVisualization.Charting.ChartArea();
            System.Windows.Forms.DataVisualization.Charting.Legend legend1 = new System.Windows.Forms.DataVisualization.Charting.Legend();
            System.Windows.Forms.DataVisualization.Charting.Series series1 = new System.Windows.Forms.DataVisualization.Charting.Series();
            System.Windows.Forms.DataVisualization.Charting.Series series2 = new System.Windows.Forms.DataVisualization.Charting.Series();
            System.Windows.Forms.DataVisualization.Charting.Series series3 = new System.Windows.Forms.DataVisualization.Charting.Series();
            System.Windows.Forms.DataVisualization.Charting.Series series4 = new System.Windows.Forms.DataVisualization.Charting.Series();
            this.chartProcess = new System.Windows.Forms.DataVisualization.Charting.Chart();
            this.btnAirHeater = new System.Windows.Forms.Button();
            this.btnSP = new System.Windows.Forms.Button();
            this.timerTimestep = new System.Windows.Forms.Timer(this.components);
            this.timerChart = new System.Windows.Forms.Timer(this.components);
            this.txtSP = new System.Windows.Forms.TextBox();
            this.lblSP = new System.Windows.Forms.Label();
            this.panel1 = new System.Windows.Forms.Panel();
            this.lblKp = new System.Windows.Forms.Label();
            this.txtKp = new System.Windows.Forms.TextBox();
            this.lblTi = new System.Windows.Forms.Label();
            this.btnUpdatePID = new System.Windows.Forms.Button();
            this.txtTi = new System.Windows.Forms.TextBox();
            ((System.ComponentModel.ISupportInitialize)(this.chartProcess)).BeginInit();
            this.panel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // chartProcess
            // 
            chartArea1.AxisX.Title = "Time";
            chartArea1.AxisY.Title = "[°C]";
            chartArea1.AxisY2.Title = "[V]";
            chartArea1.Name = "ChartArea1";
            this.chartProcess.ChartAreas.Add(chartArea1);
            this.chartProcess.Dock = System.Windows.Forms.DockStyle.Fill;
            legend1.Name = "Legend1";
            this.chartProcess.Legends.Add(legend1);
            this.chartProcess.Location = new System.Drawing.Point(141, 0);
            this.chartProcess.Name = "chartProcess";
            series1.ChartArea = "ChartArea1";
            series1.ChartType = System.Windows.Forms.DataVisualization.Charting.SeriesChartType.Line;
            series1.IsXValueIndexed = true;
            series1.Legend = "Legend1";
            series1.Name = "PID.U [V]";
            series1.XValueType = System.Windows.Forms.DataVisualization.Charting.ChartValueType.DateTime;
            series2.ChartArea = "ChartArea1";
            series2.ChartType = System.Windows.Forms.DataVisualization.Charting.SeriesChartType.Line;
            series2.IsXValueIndexed = true;
            series2.Legend = "Legend1";
            series2.Name = "TC-01 [°C] unfiltered";
            series2.XValueType = System.Windows.Forms.DataVisualization.Charting.ChartValueType.DateTime;
            series3.ChartArea = "ChartArea1";
            series3.ChartType = System.Windows.Forms.DataVisualization.Charting.SeriesChartType.Line;
            series3.IsXValueIndexed = true;
            series3.Legend = "Legend1";
            series3.Name = "TC-01 [°C] filtered";
            series3.XValueType = System.Windows.Forms.DataVisualization.Charting.ChartValueType.DateTime;
            series4.ChartArea = "ChartArea1";
            series4.ChartType = System.Windows.Forms.DataVisualization.Charting.SeriesChartType.Line;
            series4.IsXValueIndexed = true;
            series4.Legend = "Legend1";
            series4.Name = "Set point TC-01 [°C]";
            series4.XValueType = System.Windows.Forms.DataVisualization.Charting.ChartValueType.DateTime;
            this.chartProcess.Series.Add(series1);
            this.chartProcess.Series.Add(series2);
            this.chartProcess.Series.Add(series3);
            this.chartProcess.Series.Add(series4);
            this.chartProcess.Size = new System.Drawing.Size(756, 450);
            this.chartProcess.TabIndex = 0;
            this.chartProcess.Text = "Process";
            // 
            // btnAirHeater
            // 
            this.btnAirHeater.Location = new System.Drawing.Point(12, 12);
            this.btnAirHeater.Name = "btnAirHeater";
            this.btnAirHeater.Size = new System.Drawing.Size(116, 23);
            this.btnAirHeater.TabIndex = 1;
            this.btnAirHeater.Text = "Start Air Heater";
            this.btnAirHeater.UseVisualStyleBackColor = true;
            this.btnAirHeater.Click += new System.EventHandler(this.btnAirHeater_Click);
            // 
            // btnSP
            // 
            this.btnSP.Location = new System.Drawing.Point(12, 109);
            this.btnSP.Name = "btnSP";
            this.btnSP.Size = new System.Drawing.Size(116, 23);
            this.btnSP.TabIndex = 2;
            this.btnSP.Text = "Change SP";
            this.btnSP.UseVisualStyleBackColor = true;
            this.btnSP.Click += new System.EventHandler(this.btnPIDcontrol_Click);
            // 
            // timerTimestep
            // 
            this.timerTimestep.Tick += new System.EventHandler(this.timerTimestep_Tick);
            // 
            // timerChart
            // 
            this.timerChart.Interval = 1000;
            this.timerChart.Tick += new System.EventHandler(this.timerChart_Tick);
            // 
            // txtSP
            // 
            this.txtSP.Location = new System.Drawing.Point(12, 83);
            this.txtSP.Name = "txtSP";
            this.txtSP.Size = new System.Drawing.Size(100, 20);
            this.txtSP.TabIndex = 3;
            this.txtSP.Text = "26";
            // 
            // lblSP
            // 
            this.lblSP.AutoSize = true;
            this.lblSP.Location = new System.Drawing.Point(12, 67);
            this.lblSP.Name = "lblSP";
            this.lblSP.Size = new System.Drawing.Size(70, 13);
            this.lblSP.TabIndex = 4;
            this.lblSP.Text = "Set Point [°C]";
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.lblKp);
            this.panel1.Controls.Add(this.txtKp);
            this.panel1.Controls.Add(this.lblTi);
            this.panel1.Controls.Add(this.btnUpdatePID);
            this.panel1.Controls.Add(this.txtTi);
            this.panel1.Controls.Add(this.lblSP);
            this.panel1.Controls.Add(this.btnAirHeater);
            this.panel1.Controls.Add(this.btnSP);
            this.panel1.Controls.Add(this.txtSP);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Left;
            this.panel1.Location = new System.Drawing.Point(0, 0);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(141, 450);
            this.panel1.TabIndex = 5;
            // 
            // lblKp
            // 
            this.lblKp.AutoSize = true;
            this.lblKp.Location = new System.Drawing.Point(12, 155);
            this.lblKp.Name = "lblKp";
            this.lblKp.Size = new System.Drawing.Size(20, 13);
            this.lblKp.TabIndex = 9;
            this.lblKp.Text = "Kp";
            // 
            // txtKp
            // 
            this.txtKp.Location = new System.Drawing.Point(12, 171);
            this.txtKp.Name = "txtKp";
            this.txtKp.Size = new System.Drawing.Size(100, 20);
            this.txtKp.TabIndex = 8;
            // 
            // lblTi
            // 
            this.lblTi.AutoSize = true;
            this.lblTi.Location = new System.Drawing.Point(12, 193);
            this.lblTi.Name = "lblTi";
            this.lblTi.Size = new System.Drawing.Size(30, 13);
            this.lblTi.TabIndex = 7;
            this.lblTi.Text = "Ti [s]";
            // 
            // btnUpdatePID
            // 
            this.btnUpdatePID.Location = new System.Drawing.Point(12, 235);
            this.btnUpdatePID.Name = "btnUpdatePID";
            this.btnUpdatePID.Size = new System.Drawing.Size(116, 23);
            this.btnUpdatePID.TabIndex = 5;
            this.btnUpdatePID.Text = "Change SP";
            this.btnUpdatePID.UseVisualStyleBackColor = true;
            this.btnUpdatePID.Click += new System.EventHandler(this.btnUpdatePID_Click);
            // 
            // txtTi
            // 
            this.txtTi.Location = new System.Drawing.Point(12, 209);
            this.txtTi.Name = "txtTi";
            this.txtTi.Size = new System.Drawing.Size(100, 20);
            this.txtTi.TabIndex = 6;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(897, 450);
            this.Controls.Add(this.chartProcess);
            this.Controls.Add(this.panel1);
            this.Name = "Form1";
            this.Text = "Form1";
            ((System.ComponentModel.ISupportInitialize)(this.chartProcess)).EndInit();
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.DataVisualization.Charting.Chart chartProcess;
        private System.Windows.Forms.Button btnAirHeater;
        private System.Windows.Forms.Button btnSP;
        private System.Windows.Forms.Timer timerTimestep;
        private System.Windows.Forms.Timer timerChart;
        private System.Windows.Forms.TextBox txtSP;
        private System.Windows.Forms.Label lblSP;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Label lblKp;
        private System.Windows.Forms.TextBox txtKp;
        private System.Windows.Forms.Label lblTi;
        private System.Windows.Forms.Button btnUpdatePID;
        private System.Windows.Forms.TextBox txtTi;
    }
}

