namespace P22
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
            this.label1 = new System.Windows.Forms.Label();
            this.tBXwb = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.tBXwa = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.tBXab = new System.Windows.Forms.TextBox();
            this.button1 = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(26, 159);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(39, 15);
            this.label1.TabIndex = 0;
            this.label1.Text = "Xwb:";
            // 
            // tBXwb
            // 
            this.tBXwb.Location = new System.Drawing.Point(97, 159);
            this.tBXwb.Multiline = true;
            this.tBXwb.Name = "tBXwb";
            this.tBXwb.Size = new System.Drawing.Size(100, 51);
            this.tBXwb.TabIndex = 1;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(26, 17);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(39, 15);
            this.label2.TabIndex = 2;
            this.label2.Text = "Xwa:";
            // 
            // tBXwa
            // 
            this.tBXwa.Location = new System.Drawing.Point(97, 17);
            this.tBXwa.Multiline = true;
            this.tBXwa.Name = "tBXwa";
            this.tBXwa.Size = new System.Drawing.Size(100, 51);
            this.tBXwa.TabIndex = 1;
            this.tBXwa.TextChanged += new System.EventHandler(this.tBXwa_TextChanged);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(26, 89);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(39, 15);
            this.label3.TabIndex = 2;
            this.label3.Text = "Xab:";
            // 
            // tBXab
            // 
            this.tBXab.Location = new System.Drawing.Point(97, 89);
            this.tBXab.Multiline = true;
            this.tBXab.Name = "tBXab";
            this.tBXab.Size = new System.Drawing.Size(100, 51);
            this.tBXab.TabIndex = 1;
            this.tBXab.TextChanged += new System.EventHandler(this.tBXab_TextChanged);
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(107, 223);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(75, 33);
            this.button1.TabIndex = 3;
            this.button1.Text = "计算";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(237, 268);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.tBXab);
            this.Controls.Add(this.tBXwa);
            this.Controls.Add(this.tBXwb);
            this.Controls.Add(this.label1);
            this.Name = "Form1";
            this.Text = "Form1";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox tBXwb;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox tBXwa;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox tBXab;
        private System.Windows.Forms.Button button1;
    }
}

