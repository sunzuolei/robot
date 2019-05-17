using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApplication13
{
    public partial class Form1 : Form
    {
        double mean = 0;
        double standardDivision = 0;
        double semiga2 = 0;
        double[] arr;

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
                sum += Convert.ToDouble(tempArr[i]);
            }
            mean = (sum / tempArr.Length);

            for (int i = 0; i < tempArr.Length; i++)
            {
                semiga2 += ((arr[i] - mean) * (arr[i] - mean));
            }
            semiga2 = (semiga2 / arr.Length);
            standardDivision = Math.Sqrt(semiga2);
           
            textBox1.Text = "该数组的平均数为：" + mean.ToString() + "\r" + "\n" + "该数组的方差为：" + semiga2.ToString() + "\r" + "\n" + "该数组的标准差为：" + standardDivision.ToString();
            
        }




    }
}
