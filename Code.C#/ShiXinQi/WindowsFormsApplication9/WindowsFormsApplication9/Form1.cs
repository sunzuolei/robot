using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApplication9
{
    public partial class Form1 : Form
    {
        string[,] map = {{"red","green","green","red","red"},
                             {"red","red","green","red","red"},
                             {"red","red","green","green","red"},
                             {"red","red","red","red","red"}};
        int row = 4;
        int colum = 5;
        int staRow;
        int staColum;
        double pMovRro = 0.8;
        double pMovWro;
        double sta = 0.7;
        double staAnti;
        double pPMrx;
        double[,] pMrx = new double[4, 5];
        double[,] rPMrx = new double[4, 5];


        public Form1()
        {
            InitializeComponent();           
        }


        private void button1_Click(object sender, EventArgs e)
        {
            textBox1.Clear();
            sta = Convert.ToDouble(textBox2.Text.Trim());

            string[] staLocation = textBox4.Text.Trim().Split(',');
            staRow = Convert.ToInt32(staLocation[0]);
            staColum = Convert.ToInt32(staLocation[1]);

            pMovWro = 1 - pMovRro;
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


            //向上移动
            for (int j = 0; j < colum; j++)
            {
                for (int i = 0; i < row; i++)
                {
                    if (i == 3)
                    {
                        rPMrx[i, j] = pMovRro * pMrx[0, j] + pMovWro * pMrx[i, j];
                    }
                    else
                    {
                        rPMrx[i, j] = pMovRro * pMrx[i + 1, j] + pMovWro * pMrx[i, j];
                    }
                }
            }

            //显示移动后的矩阵
            for (int i = 0; i < row; i++)
            {
                for (int j = 0; j < colum; j++)
                {
                    textBox1.Text += (rPMrx[i, j].ToString() + "    ");
                }
                textBox1.Text += ("\r" + "\n");
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            textBox1.Clear();
            sta = Convert.ToDouble(textBox2.Text.Trim());

            string[] staLocation = textBox4.Text.Trim().Split(',');
            staRow = Convert.ToInt32(staLocation[0]);
            staColum = Convert.ToInt32(staLocation[1]);

            pMovWro = 1 - pMovRro;
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

            //向下移动
            for (int j = 0; j < colum; j++)
            {
                for (int i = 0; i < row; i++)
                {
                    if (i == 0)
                    {
                        rPMrx[i, j] = pMovRro * pMrx[row - 1, j] + pMovWro * pMrx[i, j];
                    }
                    else
                    {
                        rPMrx[i, j] = pMovRro * pMrx[i - 1, j] + pMovWro * pMrx[i, j];
                    }
                }
            }

            //显示移动后的矩阵
            for (int i = 0; i < row; i++)
            {
                for (int j = 0; j < colum; j++)
                {
                    textBox1.Text += (rPMrx[i, j].ToString() + "    ");
                }
                textBox1.Text += ("\r" + "\n");
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            textBox1.Clear();
            sta = Convert.ToDouble(textBox2.Text.Trim());

            string[] staLocation = textBox4.Text.Trim().Split(',');
            staRow = Convert.ToInt32(staLocation[0]);
            staColum = Convert.ToInt32(staLocation[1]);

            pMovWro = 1 - pMovRro;
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

            //向左移动
            for (int i = 0; i < row; i++)
            {
                for (int j = 0; j < colum; j++)
                {
                    if (j == 4)
                    {
                        rPMrx[i, j] = pMovRro * pMrx[i, 0] + pMovWro * pMrx[i, j];
                    }
                    else
                    {
                        rPMrx[i, j] = pMovRro * pMrx[i, j + 1] + pMovWro * pMrx[i, j];
                    }
                }
            }

            //显示移动后的矩阵
            for (int i = 0; i < row; i++)
            {
                for (int j = 0; j < colum; j++)
                {
                    textBox1.Text += (rPMrx[i, j].ToString() + "    ");
                }
                textBox1.Text += ("\r" + "\n");
            }
        }

        private void button4_Click(object sender, EventArgs e)
        {
            textBox1.Clear();
            sta = Convert.ToDouble(textBox2.Text.Trim());

            string[] staLocation = textBox4.Text.Trim().Split(',');
            staRow = Convert.ToInt32(staLocation[0]);
            staColum = Convert.ToInt32(staLocation[1]);

            pMovWro = 1 - pMovRro;
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

            //向右移动
            for (int i = 0; i < row; i++)
            {
                for (int j = 0; j < colum; j++)
                {
                    if (j == 0)
                    {
                        rPMrx[i, j] = pMovRro * pMrx[i, colum - 1] + pMovWro * pMrx[i, j];
                    }
                    else
                    {
                        rPMrx[i, j] = pMovRro * pMrx[i, j - 1] + pMovWro * pMrx[i, j];
                    }
                }
            }

            //显示移动后的矩阵
            for (int i = 0; i < row; i++)
            {
                for (int j = 0; j < colum; j++)
                {
                    textBox1.Text += (rPMrx[i, j].ToString() + "    ");
                }
                textBox1.Text += ("\r" + "\n");
            }
        }
    }
}
