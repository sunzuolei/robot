using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApplication2
{
    public partial class Form1 : Form
    {
        string[] strOber;
        double hit = 0.8;
        double mis = 0.2;
        
        string[] strArr = new string[5] { "绿", "红", "红", "绿", "绿" };
        double[] psb = new double[5] { 0.2, 0.2, 0.2, 0.2, 0.2 };


        public void Circulation(string[] strArr, string str,double[] psb)
        {
            double sum = 0;
            for (int i = 0; i < 5; i++)
            {
                if (str == strArr[i])
                {
                    psb[i] = psb[i] * hit;
                }
                else
                {
                    psb[i] = psb[i] * mis;
                }
            }

            for (int i = 0; i < 5; i++)
            {
                sum += psb[i];
            }

            for (int i = 0; i < 5; i++)
            {
                psb[i] = psb[i] / sum;
            }
            for (int i = 0; i < 5; i++)
            {
                textBox1.Text += (psb[i].ToString() + "\r" + "\n");
            }
        }


        public Form1()
        {
            InitializeComponent();
         }



        private void button1_Click(object sender, EventArgs e)
        {
            textBox1.Clear();
            string[] strTemp = textBox3.Text.Trim().Split('，');
            strOber = new string[strTemp.Length];
            for (int i = 0; i < strTemp.Length; i++)
            {
                strOber[i] = strTemp[i];
            }


            for (int i = 0; i < psb.Length; i++)
            {
                psb[i] = Convert.ToDouble(textBox2.Text.Trim());
            }


            for (int i = 0; i < strOber.Length; i++)
            {
                Circulation(strArr,strOber[i], psb);
                if (i != (strOber.Length - 1))
                    textBox1.Clear();
            }
        }
    }
}
