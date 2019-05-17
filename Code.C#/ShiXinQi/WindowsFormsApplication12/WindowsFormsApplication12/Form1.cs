using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApplication12
{
    public partial class Form1 : Form
    {
        double[] pCanOrNon = new double[2];
        double[] pPosCanPosNon = new double[2];
        double[] resultPos = new double[2];


        public Form1()
        {
            InitializeComponent();
            comboBox1.Items.Add("正确");
            comboBox1.Items.Add("错误");
        }

        private void button1_Click(object sender, EventArgs e)
        {
            double sum = 0;

            pCanOrNon[0] = Convert.ToDouble(textBox2.Text.Trim());
            pCanOrNon[1] = 1 - pCanOrNon[0];

            pPosCanPosNon[0] = 0.8;
            pPosCanPosNon[1] = 0.1;

            if (comboBox1.Text == "正确")
            {
                resultPos[0] = pCanOrNon[0] * pPosCanPosNon[0];
                resultPos[1] = pCanOrNon[1] * pPosCanPosNon[1];
            }
            else
            {
                resultPos[0] = pCanOrNon[0] * pPosCanPosNon[1];
                resultPos[1] = pCanOrNon[1] * pPosCanPosNon[0];
            }
            
            for (int i = 0; i < resultPos.Length; i++)
            {
                sum += resultPos[i];
            }
            for (int i = 0; i < resultPos.Length; i++)
            {
                resultPos[i] = (resultPos[i] / sum);
            }
            textBox1.Text = "确证得癌症概率：" + resultPos[0].ToString() + "\r"+"\n" + "确诊无癌症概率：" + resultPos[1].ToString();
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            textBox1.Clear();
        }
    }
}
