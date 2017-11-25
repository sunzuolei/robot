using System;
using System.Windows.Forms;

namespace P17
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            print();
        }
        void print()
        {
            double x = -1.99;
            int mu = 5;
            double sigma = 0.5;
            double[] xx = new double[1400];
            double[] res = new double[1400];
            double max = 0.0;
            double integration = 0.0;
            for(int i = 0;i < 1400;i++)
            {
                //xx[i-1] = -2 + i / 100.0;
                xx[i] = x;
                res[i] = gaussian1d(mu, sigma, x);
                integration += 0.01 * res[i];
                x += 0.01;

                if(max < res[i])
                {
                    max = res[i];
                }
            }
            label2.Text = "The integration of p with respect to x is " + integration.ToString("F4");
            //chart1.ChartAreas[0].AxisY.Minimum = -2;
            chart1.Series[0].Points.DataBindXY(xx,res);
            chart1.Series[1]["PointWidth"] = "0.1";   //柱子宽度
            chart1.Series[1].Points.AddXY(5, max);
        }
            
        double gaussian1d(int mu, double sigma, double x)
        {
            double p;

            p = 1 / (sigma * Math.Sqrt(2 * Math.PI)) * Math.Exp(-(x - mu) * (x - mu) / (2 * sigma * sigma));
            return p;
        }
    }
}
