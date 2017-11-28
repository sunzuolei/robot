namespace P13
{
    partial class Form1
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
            this.tBData = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.tBMean = new System.Windows.Forms.TextBox();
            this.tBVarience = new System.Windows.Forms.TextBox();
            this.tBStd = new System.Windows.Forms.TextBox();
            this.button1 = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // tBData
            // 
            this.tBData.Location = new System.Drawing.Point(92, 40);
            this.tBData.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.tBData.Name = "tBData";
            this.tBData.Size = new System.Drawing.Size(269, 25);
            this.tBData.TabIndex = 0;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(16, 44);
            this.label1.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(52, 15);
            this.label1.TabIndex = 1;
            this.label1.Text = "数据：";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(16, 100);
            this.label2.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(52, 15);
            this.label2.TabIndex = 2;
            this.label2.Text = "均值：";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(16, 158);
            this.label3.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(52, 15);
            this.label3.TabIndex = 3;
            this.label3.Text = "方差：";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(16, 216);
            this.label4.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(67, 15);
            this.label4.TabIndex = 4;
            this.label4.Text = "标准差：";
            // 
            // tBMean
            // 
            this.tBMean.Location = new System.Drawing.Point(92, 96);
            this.tBMean.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.tBMean.Name = "tBMean";
            this.tBMean.ReadOnly = true;
            this.tBMean.Size = new System.Drawing.Size(132, 25);
            this.tBMean.TabIndex = 0;
            // 
            // tBVarience
            // 
            this.tBVarience.Location = new System.Drawing.Point(92, 154);
            this.tBVarience.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.tBVarience.Name = "tBVarience";
            this.tBVarience.ReadOnly = true;
            this.tBVarience.Size = new System.Drawing.Size(132, 25);
            this.tBVarience.TabIndex = 0;
            // 
            // tBStd
            // 
            this.tBStd.Location = new System.Drawing.Point(95, 212);
            this.tBStd.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.tBStd.Name = "tBStd";
            this.tBStd.ReadOnly = true;
            this.tBStd.Size = new System.Drawing.Size(132, 25);
            this.tBStd.TabIndex = 0;
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(121, 275);
            this.button1.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(79, 28);
            this.button1.TabIndex = 5;
            this.button1.Text = "计算";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(379, 328);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.tBStd);
            this.Controls.Add(this.tBVarience);
            this.Controls.Add(this.tBMean);
            this.Controls.Add(this.tBData);
            this.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.Name = "Form1";
            this.Text = "Form1";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox tBData;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox tBMean;
        private System.Windows.Forms.TextBox tBVarience;
        private System.Windows.Forms.TextBox tBStd;
        private System.Windows.Forms.Button button1;
    }
}

