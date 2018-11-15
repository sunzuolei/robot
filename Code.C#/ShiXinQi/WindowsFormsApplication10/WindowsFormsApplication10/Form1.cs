using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApplication10
{
    public partial class Form1 : Form
    {
        string[,] map = {{"red","green","green","red","red"},
                             {"red","red","green","red","red"},
                             {"red","red","green","green","red"},
                             {"red","red","red","red","red"}};
        string rSense = "green";

        int row = 4;
        int colum = 5;
        double pSenseRig = 0.7;
        double pSenseWro;
        double sta = 0.7;
        double staAnti;
        int staRow =2;
        int staColum =3;
        double sum = 0.0;
        double pPMrx;
        double[,] pMrx = new double[4, 5];


        public Form1()
        {
            InitializeComponent();
        }


        private void button1_Click(object sender, EventArgs e)
        {
            string[] staArr = textBox4.Text.Trim().Split(',');
            staRow = Convert.ToInt32(staArr[0]);
            staColum = Convert.ToInt32(staArr[1]);

            pSenseRig = Convert.ToDouble(textBox2.Text.Trim());
            pSenseWro = 1 - pSenseRig;

            sta = Convert.ToDouble(textBox3.Text.Trim());
            staAnti = 1 - sta;
            pPMrx = staAnti / (map.Length - 1);
            for (int i = 0; i < row; i++)
            {
                for (int j = 0; j < colum; j++)
                {
                    pMrx[i, j] = pPMrx;
                }
            }
            pMrx[staRow - 1, staColum - 1] = sta;
            rSense = map[row - 1, colum - 1];

            //显示原始概率矩阵
            for (int i = 0; i < row; i++)
            {
                for (int j = 0; j < colum; j++)
                {
                    textBox1.Text += (pMrx[i, j].ToString() + "    ");
                }
                textBox1.Text += ("\r" + "\n");
            }


            textBox1.Text += "\r" + "\n";
            textBox1.Text += "\r" + "\n";
            textBox1.Text += "\r" + "\n";


            for (int i = 0; i < row; i++)
            {
                for (int j = 0; j < colum; j++)
                {
                    if (rSense == map[i, j])
                        pMrx[i, j] = pMrx[i, j] * pSenseRig;
                    else
                        pMrx[i, j] = pMrx[i, j] * pSenseWro;
                    sum += pMrx[i, j];
                }
            }


            for (int i = 0; i < row; i++)
            {
                for (int j = 0; j < colum; j++)
                {
                    pMrx[i, j] = (pMrx[i, j] / sum);
                }
            }


            for (int i = 0; i < row; i++)
            {
                for (int j = 0; j < colum; j++)
                {
                    textBox1.Text += (pMrx[i, j].ToString() + "    ");
                }
                textBox1.Text += ("\r" + "\n");
            }


        }
    }
}
