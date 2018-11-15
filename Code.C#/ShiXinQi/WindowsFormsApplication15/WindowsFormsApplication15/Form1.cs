using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApplication15
{
    public partial class Form1 : Form
    {
        double[] arr;
        double[] parameter = new double[2];
        double semiga2 = 0;
        double mean = 0;
        double mean2 = 0;


        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string[] tArr = textBox2.Text.Trim().Split(',');
            double sum = 0;
            arr = new double[tArr.Length];
            for (int i = 0; i < tArr.Length; i++)
            {
                arr[i] = Convert.ToDouble(tArr[i]);
                sum += arr[i];
            }
            mean = sum / arr.Length;
            sum = 0;
            for (int i = 0; i < arr.Length; i++)
            {
                semiga2 += ((arr[i] - mean) * (arr[i] - mean));
            }
            semiga2 = semiga2 / arr.Length;

            textBox1.Text = "计算得原数组的平方差为：" + semiga2.ToString()+"\r"+"\n";

            semiga2 = 0;
            for (int i = 0; i < arr.Length; i++)
            {
                arr[i] = (arr[i] * arr[i]);
                sum += arr[i];
            }
            mean2 = sum / arr.Length;

            semiga2 = (mean2-(mean*mean));
            
            textBox1.Text += "按照方法原数组的平方差为：" + semiga2.ToString() + "\r" + "\n";
        }


    }
}
