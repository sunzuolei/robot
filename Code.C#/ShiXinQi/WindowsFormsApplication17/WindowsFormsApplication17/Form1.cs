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

namespace WindowsFormsApplication17
{
    public partial class Form1 : Form
    {
        double mean = 0;
        double segima = 0;


        public double Normal(double x, double mean, double segima)
        {
            double result = 0;
            double temp1 = 0;
            double temp2 = 0;
            temp1 = 1 / (Math.Sqrt(2 * Math.PI) * segima);
            temp2 = Math.Exp(-(x - mean) * (x - mean) / (2 * segima * segima));
            result = temp1 * temp2;
            return result;
        }


        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            double[] x = new double[200];
            double[] y = new double[200];
            mean = Convert.ToDouble(textBox1.Text.Trim());
            segima = Convert.ToDouble(textBox2.Text.Trim());
            x[0] = -10;
            for (int i = 1; i < x.Length; i++)
            {
                x[i] = (x[i - 1] + 0.1);
            }
            for (int i = 0; i < x.Length; i++)
            {
                y[i] = Normal(x[i], mean, segima);
            }
            chart1.Series.Clear();
            Series cur1 = new Series("高斯分布线");
            cur1.Color = Color.Red;
            cur1.ChartType = SeriesChartType.Line;

            for (int i = 0; i < x.Length; i++)
            {
                cur1.Points.AddXY(x[i], y[i]);
            }

            chart1.Series.Add(cur1);
            chart1.ChartAreas[0].AxisX.MajorGrid.Enabled = false;
            chart1.ChartAreas[0].AxisY.MajorGrid.Enabled = false;

        }
    }
}
