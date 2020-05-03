namespace DataLogger
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
            this.btnLogg = new System.Windows.Forms.Button();
            this.tmrSample = new System.Windows.Forms.Timer(this.components);
            this.txtPI = new System.Windows.Forms.TextBox();
            this.txtMeasure = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.pnlLogger = new System.Windows.Forms.Panel();
            this.pnlLogger.SuspendLayout();
            this.SuspendLayout();
            // 
            // btnLogg
            // 
            this.btnLogg.Location = new System.Drawing.Point(3, 95);
            this.btnLogg.Name = "btnLogg";
            this.btnLogg.Size = new System.Drawing.Size(114, 40);
            this.btnLogg.TabIndex = 0;
            this.btnLogg.Text = "Start Data Logging";
            this.btnLogg.UseVisualStyleBackColor = true;
            this.btnLogg.Click += new System.EventHandler(this.btnLogg_Click);
            // 
            // tmrSample
            // 
            this.tmrSample.Interval = 5000;
            this.tmrSample.Tick += new System.EventHandler(this.tmrSample_Tick);
            // 
            // txtPI
            // 
            this.txtPI.BackColor = System.Drawing.SystemColors.ButtonHighlight;
            this.txtPI.Location = new System.Drawing.Point(137, 36);
            this.txtPI.Name = "txtPI";
            this.txtPI.ReadOnly = true;
            this.txtPI.Size = new System.Drawing.Size(100, 20);
            this.txtPI.TabIndex = 1;
            // 
            // txtMeasure
            // 
            this.txtMeasure.BackColor = System.Drawing.SystemColors.ButtonHighlight;
            this.txtMeasure.Location = new System.Drawing.Point(9, 36);
            this.txtMeasure.Name = "txtMeasure";
            this.txtMeasure.ReadOnly = true;
            this.txtMeasure.Size = new System.Drawing.Size(100, 20);
            this.txtMeasure.TabIndex = 2;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(137, 17);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(51, 13);
            this.label2.TabIndex = 4;
            this.label2.Text = "Pi Output";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(9, 17);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(71, 13);
            this.label1.TabIndex = 3;
            this.label1.Text = "Measurement";
            // 
            // pnlLogger
            // 
            this.pnlLogger.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.pnlLogger.Controls.Add(this.label2);
            this.pnlLogger.Controls.Add(this.label1);
            this.pnlLogger.Controls.Add(this.txtMeasure);
            this.pnlLogger.Controls.Add(this.txtPI);
            this.pnlLogger.Controls.Add(this.btnLogg);
            this.pnlLogger.Location = new System.Drawing.Point(12, 12);
            this.pnlLogger.Name = "pnlLogger";
            this.pnlLogger.Size = new System.Drawing.Size(253, 142);
            this.pnlLogger.TabIndex = 5;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(278, 167);
            this.Controls.Add(this.pnlLogger);
            this.Name = "Form1";
            this.Text = "Data Logger";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.pnlLogger.ResumeLayout(false);
            this.pnlLogger.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button btnLogg;
        private System.Windows.Forms.Timer tmrSample;
        private System.Windows.Forms.TextBox txtPI;
        private System.Windows.Forms.TextBox txtMeasure;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Panel pnlLogger;
    }
}

