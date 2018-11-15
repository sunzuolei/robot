using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApplication5
{
    public partial class Form1 : Form
    {
        //mod函数计算方法
       /* public int Divided(int a, int b)
        {
            int c;
            if (a < 0)
            {
                c = a / b;
                c = (a - b * c);
                c += b;
            }
            else
            {
                c = a / b;
                c = (a - b * c);
            }
            return c;
        }*/



        int j = 0;
        double[] pEvent = {0,0.5,0,0.5,0};
        double[] pUnderOver = { 0.1, 0.8, 0.1 };
        double[] pRut = new double[5];
        int step = 2;
        int over = 0;
        int exact = 0;
        int under = 0;


        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            textBox1.Clear();
            string[] strP = textBox3.Text.Trim().Split(',');
            pEvent = new double[strP.Length];
            pRut = new double[strP.Length];

            for (int i = 0; i < strP.Length; i++)
            {
                pEvent[i] = Convert.ToDouble(strP[i]);
            }

            step = Convert.ToInt32(textBox2.Text.Trim());
           

            for (int i = 0; i < pRut.Length; i++)
            {
                under = j + step - 1;
                exact = j + step;
                over = j + step + 1;

                if (over >= pEvent.Length)
                    over -= pEvent.Length;
                if (exact >= pEvent.Length)
                    exact -= pEvent.Length;
                if (under >= pEvent.Length)
                    under -= pEvent.Length;

                pRut[i] = pUnderOver[0] * pEvent[under] + pUnderOver[1] * pEvent[exact] + pUnderOver[2] * pEvent[over];
                j++;
            }
            j = 0;
            for (int i = 0; i < pRut.Length; i++)
            {
                textBox1.Text += (pRut[i].ToString() + "\r" + "\n");
            }
        }
    }
}
