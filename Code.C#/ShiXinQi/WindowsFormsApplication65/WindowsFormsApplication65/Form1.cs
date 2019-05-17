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


namespace WindowsFormsApplication65
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            double p;
            double pAnti;
            double[] xLabel = new double[100];
            double[] yLabel = new double[100];
            double xMax = 0.0;
            double yMax = 0.0;
            for (int i = 1; i < 100; i++)
            {
                p = (double) i/100;
                pAnti = 1 - p;
                xLabel[i] = p;
                yLabel[i] = (p * Math.Log(p,2) + pAnti*Math.Log(pAnti,2));
                yLabel[i] = -yLabel[i]; 
            }


            for (int i = 0; i < 100; i++)
            {
                if (yLabel[i] >= yMax)
                {
                    yMax = yLabel[i];
                    xMax = xLabel[i];
                }
            }



            chart1.Series.Clear();
            chart1.ChartAreas[0].AxisX.MajorGrid.Enabled = false;
            chart1.ChartAreas[0].AxisY.MajorGrid.Enabled = false;
            Series curve = new Series("cur");
            
            curve.ChartType = SeriesChartType.Line;
            
            for (int i = 0; i < 100; i++)
            {
                curve.Points.AddXY(xLabel[i], yLabel[i]);
            }
            chart1.Series.Add(curve);
            textBox1.Text = xMax.ToString() +","+ (1 - xMax).ToString();
            textBox2.Text = yMax.ToString();
        }
    }
}
