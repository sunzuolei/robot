using System;
using System.Windows.Forms;

namespace P65
{
    public partial class MainForm : Form
    {
        public MainForm()
        {
            InitializeComponent();
            timer1.Interval = 30;
            timer1.Start();
            chart1.ChartAreas[0].AxisY.Maximum = 1.0;
            chart1.ChartAreas[0].AxisY.Minimum = 0.0;
        }
        double pHead = 0.0;
        int n = 100;
        int i = 0;

        string[] xValues = { "pHead", "pTail" };
        double[] yValues = new double[2];
        double[] H = new double[101];//y2Values


        void print()
        {
            if(i == 0 || i == 100)
            {
                H[i] = 0;
            }
            else
            {
                H[i] = -((pHead * Math.Log((pHead), 2)) + (1 - pHead) * Math.Log((1 - pHead), 2));
            }
            
            if (i == 0 || i % 10 == 0)
            {
                yValues = new double[] { pHead, 1 - pHead };
                chart1.Series[0].Points.DataBindXY(xValues, yValues);
            }
            pHead += 0.01;

        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            if (i <= 100)
            {
                print();
                i++;
            }
            else
            {
                timer1.Stop();
                
                double[] x2Value = new double[n + 1];
                double[] y2Value = new double[n + 1];
                for (int j = 0; j <= n; j++)
                {
                    x2Value[j] = j / 100.0;
                }
                y2Value = H;
                chart2.ChartAreas[0].AxisY.Minimum = 0.0;
                chart2.Series[0].Points.DataBindXY(x2Value, y2Value);
            }
        }
    }
}