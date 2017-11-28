namespace P23
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
            this.label2 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.tBXwa = new System.Windows.Forms.TextBox();
            this.tBXad = new System.Windows.Forms.TextBox();
            this.tBXaf = new System.Windows.Forms.TextBox();
            this.tBXwd = new System.Windows.Forms.TextBox();
            this.tBXwf = new System.Windows.Forms.TextBox();
            this.button1 = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(32, 42);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(39, 15);
            this.label1.TabIndex = 0;
            this.label1.Text = "Xwa:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(32, 96);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(39, 15);
            this.label2.TabIndex = 1;
            this.label2.Text = "Xad:";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(32, 150);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(39, 15);
            this.label4.TabIndex = 2;
            this.label4.Text = "Xaf:";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(32, 204);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(39, 15);
            this.label5.TabIndex = 1;
            this.label5.Text = "Xwd:";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(32, 258);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(39, 15);
            this.label6.TabIndex = 2;
            this.label6.Text = "Xwf:";
            // 
            // tBXwa
            // 
            this.tBXwa.Location = new System.Drawing.Point(97, 39);
            this.tBXwa.Name = "tBXwa";
            this.tBXwa.Size = new System.Drawing.Size(173, 25);
            this.tBXwa.TabIndex = 3;
            this.tBXwa.TextChanged += new System.EventHandler(this.tBXwa_TextChanged);
            // 
            // tBXad
            // 
            this.tBXad.Location = new System.Drawing.Point(97, 93);
            this.tBXad.Name = "tBXad";
            this.tBXad.Size = new System.Drawing.Size(173, 25);
            this.tBXad.TabIndex = 3;
            this.tBXad.TextChanged += new System.EventHandler(this.tBXad_TextChanged);
            // 
            // tBXaf
            // 
            this.tBXaf.Location = new System.Drawing.Point(97, 147);
            this.tBXaf.Name = "tBXaf";
            this.tBXaf.Size = new System.Drawing.Size(173, 25);
            this.tBXaf.TabIndex = 3;
            this.tBXaf.TextChanged += new System.EventHandler(this.tBXaf_TextChanged);
            // 
            // tBXwd
            // 
            this.tBXwd.Location = new System.Drawing.Point(97, 201);
            this.tBXwd.Name = "tBXwd";
            this.tBXwd.ReadOnly = true;
            this.tBXwd.Size = new System.Drawing.Size(173, 25);
            this.tBXwd.TabIndex = 3;
            // 
            // tBXwf
            // 
            this.tBXwf.Location = new System.Drawing.Point(97, 255);
            this.tBXwf.Name = "tBXwf";
            this.tBXwf.ReadOnly = true;
            this.tBXwf.Size = new System.Drawing.Size(173, 25);
            this.tBXwf.TabIndex = 3;
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(137, 303);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(75, 27);
            this.button1.TabIndex = 4;
            this.button1.Text = "计算";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(282, 340);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.tBXwf);
            this.Controls.Add(this.tBXwd);
            this.Controls.Add(this.tBXaf);
            this.Controls.Add(this.tBXad);
            this.Controls.Add(this.tBXwa);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Name = "Form1";
            this.Text = "Form1";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.TextBox tBXwa;
        private System.Windows.Forms.TextBox tBXad;
        private System.Windows.Forms.TextBox tBXaf;
        private System.Windows.Forms.TextBox tBXwd;
        private System.Windows.Forms.TextBox tBXwf;
        private System.Windows.Forms.Button button1;
    }
}

