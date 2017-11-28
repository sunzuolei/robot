using System;
using System.Windows.Forms;

namespace WindowsFormsApplication1
{
    public partial class MainForm : Form
    {
        public MainForm()
        {
            InitializeComponent();
            comboBox1.Items.Add("positive");
            comboBox1.Items.Add("negative");
            comboBox1.Text = "positive";
        }

        private void button1_Click(object sender, EventArgs e)
        {
            double pCan = 0.001;
            double pNon = 0.999;
            string z = comboBox1.Text;
            double pPosCan = 0.8;
            double pPosNon = 0.1;
            double[] p;
            textBox1.Text = "";

            if (z == "positive")
            {
                p = new[] { pPosCan * pCan, pPosNon * pNon };
            }
            else if(z == "negative")
            {
                p = new[] { (1 - pPosCan) * pCan, (1 - pPosNon) * pNon };
            }
            else
            {
                textBox1.Text = "\"Cancer Test\"的值不正确";
                return;
            }

            p = new[] { p[0] / (p[0] + p[1]), p[1] / (p[0] + p[1]) };
            textBox1.Text = string.Format("The probability of having cancer given the {0} test：{1}\r\n", z, p[0]);
            textBox1.Text += string.Format("The probability of cancer free given the {0} test：{1}\r\n", z, p[1]);
        }
    }
}
