namespace OPC_client
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
            this.txtGetVal = new System.Windows.Forms.TextBox();
            this.btnGetVal = new System.Windows.Forms.Button();
            this.timer1 = new System.Windows.Forms.Timer(this.components);
            this.waveformGraph1 = new NationalInstruments.UI.WindowsForms.WaveformGraph();
            this.waveformPlot1 = new NationalInstruments.UI.WaveformPlot();
            this.xAxis1 = new NationalInstruments.UI.XAxis();
            this.yAxis1 = new NationalInstruments.UI.YAxis();
            this.txtConnection = new System.Windows.Forms.TextBox();
            ((System.ComponentModel.ISupportInitialize)(this.waveformGraph1)).BeginInit();
            this.SuspendLayout();
            // 
            // txtGetVal
            // 
            this.txtGetVal.Location = new System.Drawing.Point(99, 32);
            this.txtGetVal.Name = "txtGetVal";
            this.txtGetVal.Size = new System.Drawing.Size(100, 20);
            this.txtGetVal.TabIndex = 0;
            // 
            // btnGetVal
            // 
            this.btnGetVal.Location = new System.Drawing.Point(231, 30);
            this.btnGetVal.Name = "btnGetVal";
            this.btnGetVal.Size = new System.Drawing.Size(75, 23);
            this.btnGetVal.TabIndex = 1;
            this.btnGetVal.Text = "Get value";
            this.btnGetVal.UseVisualStyleBackColor = true;
            this.btnGetVal.Click += new System.EventHandler(this.btnGetVal_Click);
            // 
            // timer1
            // 
            this.timer1.Interval = 1000;
            this.timer1.Tick += new System.EventHandler(this.timer1_Tick);
            // 
            // waveformGraph1
            // 
            this.waveformGraph1.Location = new System.Drawing.Point(356, 55);
            this.waveformGraph1.Name = "waveformGraph1";
            this.waveformGraph1.Plots.AddRange(new NationalInstruments.UI.WaveformPlot[] {
            this.waveformPlot1});
            this.waveformGraph1.Size = new System.Drawing.Size(416, 270);
            this.waveformGraph1.TabIndex = 2;
            this.waveformGraph1.UseColorGenerator = true;
            this.waveformGraph1.XAxes.AddRange(new NationalInstruments.UI.XAxis[] {
            this.xAxis1});
            this.waveformGraph1.YAxes.AddRange(new NationalInstruments.UI.YAxis[] {
            this.yAxis1});
            // 
            // waveformPlot1
            // 
            this.waveformPlot1.XAxis = this.xAxis1;
            this.waveformPlot1.YAxis = this.yAxis1;
            // 
            // txtConnection
            // 
            this.txtConnection.Location = new System.Drawing.Point(99, 305);
            this.txtConnection.Name = "txtConnection";
            this.txtConnection.Size = new System.Drawing.Size(100, 20);
            this.txtConnection.TabIndex = 3;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.txtConnection);
            this.Controls.Add(this.waveformGraph1);
            this.Controls.Add(this.btnGetVal);
            this.Controls.Add(this.txtGetVal);
            this.Name = "Form1";
            this.Text = "Form1";
            ((System.ComponentModel.ISupportInitialize)(this.waveformGraph1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox txtGetVal;
        private System.Windows.Forms.Button btnGetVal;
        private System.Windows.Forms.Timer timer1;
        private NationalInstruments.UI.WindowsForms.WaveformGraph waveformGraph1;
        private NationalInstruments.UI.WaveformPlot waveformPlot1;
        private NationalInstruments.UI.XAxis xAxis1;
        private NationalInstruments.UI.YAxis yAxis1;
        private System.Windows.Forms.TextBox txtConnection;
    }
}

