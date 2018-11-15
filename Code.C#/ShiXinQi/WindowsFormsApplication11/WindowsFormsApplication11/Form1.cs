using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Windows.Forms.DataVisualization.Charting;

namespace WindowsFormsApplication11
{
    public partial class Form1 : Form
    {

        public double[,] MovRight(int row, int colum,double pMovRig,double pMovWro, double[,] pMrx)
        {
            double[,] rPMrx = new double[row,colum];
            for (int i = 0; i < row; i++)
            {
                for (int j = 0; j < colum; j++)
                {
                    if (j == 0)
                    {
                        rPMrx[i, j] = pMovRig * pMrx[i, colum - 1] + pMovWro * pMrx[i, j];
                    }
                    else
                    {
                        rPMrx[i, j] = pMovRig * pMrx[i, j - 1] + pMovWro * pMrx[i, j];
                    }
                }
            }
            return rPMrx;
        }

        public double[,] MovLeft(int row, int colum, double pMovRig, double pMovWro, double[,] pMrx)
        {
            double[,] rPMrx = new double[row, colum];
            for (int i = 0; i < row; i++)
            {
                for (int j = 0; j < colum; j++)
                {
                    if (j == 4)
                    {
                        rPMrx[i, j] = pMovRig * pMrx[i, 0] + pMovWro * pMrx[i, j];
                    }
                    else
                    {
                        rPMrx[i, j] = pMovRig * pMrx[i, j + 1] + pMovWro * pMrx[i, j];
                    }
                }
            }
            return rPMrx;
        }

        public double[,] MovUp(int row, int colum, double pMovRig, double pMovWro, double[,] pMrx)
        {
            double[,] rPMrx = new double[row, colum];
            for (int j = 0; j < colum; j++)
            {
                for (int i = 0; i < row; i++)
                {
                    if (i == 3)
                    {
                        rPMrx[i, j] = pMovRig * pMrx[0, j] + pMovWro * pMrx[i, j];
                    }
                    else
                    {
                        rPMrx[i, j] = pMovRig * pMrx[i + 1, j] + pMovWro * pMrx[i, j];
                    }
                }
            }
            return rPMrx;
        }

        public double[,] MovDown(int row, int colum, double pMovRig, double pMovWro, double[,] pMrx)
        {
            double[,] rPMrx = new double[row, colum];
            for (int j = 0; j < colum; j++)
            {
                for (int i = 0; i < row; i++)
                {
                    if (i == 0)
                    {
                        rPMrx[i, j] = pMovRig * pMrx[row - 1, j] + pMovWro * pMrx[i, j];
                    }
                    else
                    {
                        rPMrx[i, j] = pMovRig * pMrx[i - 1, j] + pMovWro * pMrx[i, j];
                    }
                }
            }
            return rPMrx;
        }

        public double[,] MovStop(int row, int colum,double[,] pMovStop)
        {
            double[,] rMovStop = new double[row,colum];

            for (int i = 0; i < row; i++)
            {
                for (int j = 0; j < colum; j++)
                {
                    rMovStop[i, j] = pMovStop[i, j];
                }
            }



            return rMovStop;
        }

        public double[,] Sense(int row, int colum, string rSense, string[,] map, double pSenseRig, double pSenseWro, double[,] pMrx)
        {
            double sum = 0.0;
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
            return pMrx;
        }

        public double informationH(int row, int colum, double[,] pMrx)
        {
            double H = 0.0;
            for (int i = 0; i < row; i++)
            {
                for (int j = 0; j < colum; j++)
                {
                    H += (pMrx[i, j] * Math.Log(pMrx[i, j], 2));
                }
            }
            return -H;
        }

        string[,] map = {{"红","绿","绿","红","绿"},
                             {"红","红","绿","红","绿"},
                             {"红","红","绿","绿","绿"},
                             {"红","红","红","红","绿"}};

        int row = 4;
        int colum = 5;

        double pMovRig = 0.8;
        double pMovWro;
        double pSenseRig = 0.7;
        double pSenseWro ;
        double sta = 0;
        double staAnti;

        double pPMrx;
        double[,] pMrx = new double[4, 5];
        double[,] rPMrx = new double[4, 5];

        string[] action = { "上", "下", "左", "右", "停" };
        string[] rAction = { "停", "右", "下", "下", "右" };
        string[] rSense = { "绿", "绿", "绿", "绿", "绿" };
        double[,] informationHofMS;


        public Form1()
        {
            InitializeComponent();

            pMovWro = 1 - pMovRig;
            pSenseWro = 1 - pSenseRig;
            staAnti = 1 - sta;
            pPMrx = staAnti / map.Length;
            informationHofMS = new double[2, rAction.Length];


            if (rAction.Length != rSense.Length)
                MessageBox.Show("The length of the rAction should be the same as the one of the rSense");

            for (int i = 0; i < row; i++)
            {
                for (int j = 0; j < colum; j++)
                {
                    pMrx[i, j] = pPMrx;
                }
            }
        }


        private void button1_Click(object sender, EventArgs e)
        {
            textBox1.Clear();
            string[] str = textBox2.Text.Trim().Split('，');
            rAction = new string[str.Length];
            for (int i = 0; i < str.Length; i++)
            {
                rAction[i] = str[i];
            }

            str = textBox3.Text.Trim().Split('，');
            rSense = new string[str.Length];
            for (int i = 0; i < str.Length; i++)
            {
                rSense[i] = str[i];
            }

            //显示原始概率矩阵
            for (int i = 0; i < row; i++)
            {
                for (int j = 0; j < colum; j++)
                {
                    textBox1.Text += (pMrx[i, j].ToString() + "    ");
                }
                textBox1.Text += ("\r" + "\n");
            }


            for (int k = 0; k < rAction.Length; k++)
            {
                if (rAction[k] == action[0])
                    pMrx = MovUp(row, colum, pMovRig, pMovWro, pMrx);
                if (rAction[k] == action[1])
                    pMrx = MovDown(row, colum, pMovRig, pMovWro, pMrx);
                if (rAction[k] == action[2])
                    pMrx = MovLeft(row, colum, pMovRig, pMovWro, pMrx);
                if (rAction[k] == action[3])
                    pMrx = MovRight(row, colum, pMovRig, pMovWro, pMrx);
                if (rAction[k] == action[4])
                    pMrx = MovStop(row, colum, pMrx);
                informationHofMS[0, k] = informationH(row, colum, pMrx);

                pMrx = Sense(row, colum, rSense[k], map, pSenseRig, pSenseWro, pMrx);
                informationHofMS[1, k] = informationH(row, colum, pMrx);

            }

            for (int i = 0; i < row; i++)
            {
                for (int j = 0; j < colum; j++)
                {
                    textBox1.Text += (pMrx[i, j].ToString() + "    ");
                }
                textBox1.Text += ("\r" + "\n");
            }



            chart1.Series.Clear();
            Series cur1 = new Series("move");
            cur1.Color = Color.Blue;
            cur1.ChartType = SeriesChartType.Line;


            Series cur2 = new Series("sense");
            cur2.Color = Color.Red;
            cur2.ChartType = SeriesChartType.Line;


            for (int i = 0; i < rAction.Length; i++)
            {
                cur1.Points.AddXY(i, informationHofMS[0, i]);
                cur2.Points.AddXY(i, informationHofMS[1, i]);
            }
            chart1.Series.Add(cur1);
            chart1.Series.Add(cur2);

            chart1.ChartAreas[0].AxisX.MajorGrid.Enabled = false;
            chart1.ChartAreas[0].AxisY.MajorGrid.Enabled = false;
        }
    }
}
