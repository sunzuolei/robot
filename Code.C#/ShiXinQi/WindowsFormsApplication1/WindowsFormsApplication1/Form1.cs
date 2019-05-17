using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApplication1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        private void button1_Click(object sender, EventArgs e)
        {
            textBox2.Clear();
            int num = Convert.ToInt32(textBox1.Text.Trim());
            for (int i = 0; i < num; i++)
            {
                textBox2.Text += ("1/" + num.ToString() + "\r" + "\n");
            }          
        }

       
    }
}
