using System;
using System.Linq;
using System.Windows.Forms;

namespace P13
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            this.StartPosition = FormStartPosition.CenterScreen;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(tBData.Text))
                {
                    throw new Exception("输入为空！");
                }
                string[] strData = new string[] { };
                strData = tBData.Text.Split(new char[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
                if (strData.Contains(","))
                {
                    strData = tBData.Text.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                }
                if (strData.Length == 0)
                {
                    throw new Exception("输入为空！");
                }

                double[] dData = new double[strData.Length];
                for (int i = 0; i < strData.Length; i++)
                {
                    if (!double.TryParse(strData[i], out dData[i]))
                    {
                        throw new Exception("请输入有效数据！");
                    }
                }
                double mean = 0.0;
                double varience = 0.0;
                varience = Varience(dData, out mean);
                tBMean.Text = mean.ToString("F4");
                tBVarience.Text = varience.ToString("F4");
                tBStd.Text = Math.Sqrt(varience).ToString("F4");
            }
            
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private double Varience(double[] dData,out double mean)
        {
            double sum = 0;
            double varience = 0.0;
            int l = dData.Length;
            for(int i = 0;i < l;i++)
            {
                sum += dData[i];
            }
            mean = sum / l;
            for(int i = 0;i < l;i++)
            {
                varience += (dData[i] - mean) * (dData[i] - mean);
            }
            varience = varience / l;
            return varience;
        }
    }
}
