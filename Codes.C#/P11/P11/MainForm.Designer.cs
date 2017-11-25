namespace P11
{
    partial class MainForm
    {
        /// <summary>
        /// 必需的设计器变量。
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// 清理所有正在使用的资源。
        /// </summary>
        /// <param name="disposing">如果应释放托管资源，为 true；否则为 false。</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows 窗体设计器生成的代码

        /// <summary>
        /// 设计器支持所需的方法 - 不要
        /// 使用代码编辑器修改此方法的内容。
        /// </summary>
        private void InitializeComponent()
        {
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.tBq = new System.Windows.Forms.TextBox();
            this.tBPrior = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.tBMotions = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this.tBMeasurements = new System.Windows.Forms.TextBox();
            this.button1 = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(6, 259);
            this.label3.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(185, 12);
            this.label3.TabIndex = 14;
            this.label3.Text = "The probability after sensing:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(6, 0);
            this.label2.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(65, 12);
            this.label2.TabIndex = 13;
            this.label2.Text = "The Prior:";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(6, 416);
            this.label1.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(41, 12);
            this.label1.TabIndex = 12;
            this.label1.Text = "label1";
            // 
            // tBq
            // 
            this.tBq.Location = new System.Drawing.Point(8, 274);
            this.tBq.Margin = new System.Windows.Forms.Padding(2);
            this.tBq.Multiline = true;
            this.tBq.Name = "tBq";
            this.tBq.ReadOnly = true;
            this.tBq.Size = new System.Drawing.Size(366, 122);
            this.tBq.TabIndex = 11;
            // 
            // tBPrior
            // 
            this.tBPrior.Location = new System.Drawing.Point(8, 14);
            this.tBPrior.Margin = new System.Windows.Forms.Padding(2);
            this.tBPrior.Multiline = true;
            this.tBPrior.Name = "tBPrior";
            this.tBPrior.ReadOnly = true;
            this.tBPrior.Size = new System.Drawing.Size(366, 122);
            this.tBPrior.TabIndex = 10;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(6, 148);
            this.label4.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(53, 12);
            this.label4.TabIndex = 15;
            this.label4.Text = "Motions:";
            // 
            // tBMotions
            // 
            this.tBMotions.Location = new System.Drawing.Point(70, 148);
            this.tBMotions.Multiline = true;
            this.tBMotions.Name = "tBMotions";
            this.tBMotions.Size = new System.Drawing.Size(184, 59);
            this.tBMotions.TabIndex = 17;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(279, 148);
            this.label5.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(83, 12);
            this.label5.TabIndex = 15;
            this.label5.Text = "measurements:";
            // 
            // tBMeasurements
            // 
            this.tBMeasurements.Location = new System.Drawing.Point(368, 145);
            this.tBMeasurements.Multiline = true;
            this.tBMeasurements.Name = "tBMeasurements";
            this.tBMeasurements.Size = new System.Drawing.Size(189, 59);
            this.tBMeasurements.TabIndex = 17;
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(271, 223);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(75, 23);
            this.button1.TabIndex = 18;
            this.button1.Text = "计算";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(614, 446);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.tBMeasurements);
            this.Controls.Add(this.tBMotions);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.tBq);
            this.Controls.Add(this.tBPrior);
            this.Margin = new System.Windows.Forms.Padding(2);
            this.Name = "MainForm";
            this.Text = "Form1";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox tBq;
        private System.Windows.Forms.TextBox tBPrior;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox tBMotions;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.TextBox tBMeasurements;
        private System.Windows.Forms.Button button1;
    }
}

