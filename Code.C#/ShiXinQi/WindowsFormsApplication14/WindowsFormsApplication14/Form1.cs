using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApplication14
{
    public partial class Form1 : Form
    {
        double[] parameter = new double[2];
        double[] arr;
        double mean = 0;


        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            double sum = 0;
            string[] tempArr = textBox2.Text.Trim().Split(',');
            arr = new double[tempArr.Length];
            for (int i = 0; i < tempArr.Length; i++)
            {
                arr[i] = Convert.ToDouble(tempArr[i]);
            }

            tempArr = textBox3.Text.Trim().Split(',');
            for (int i = 0; i < tempArr.Length; i++)
            {
                parameter[i] = Convert.ToDouble(tempArr[i]);
            }

            for (int i = 0; i < arr.Length; i++)
            {
                sum += arr[i];
            }
            mean = sum / arr.Length;
            sum = 0;
            textBox1.Text = "原数组的平均数为：" + mean.ToString() + "\r" + "\n";

            for (int i = 0; i < arr.Length; i++)
            {
                arr[i] = (arr[i] * parameter[0] + parameter[1]);
                sum += arr[i];
            }
            mean = sum / arr.Length;
            textBox1.Text += ("数组"+parameter[0].ToString()+"X+"+parameter[1].ToString()+"的均值为：" + mean.ToString() + "\r" + "\n");

        }
    }
}
