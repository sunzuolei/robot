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

namespace WindowsFormsApplication7
{
    public partial class Form1 : Form
    {
        int j = 0;
        double[] pEvent = { 0, 0.5, 0, 0.5, 0 };
        double[] pUnderOver = { 0.1, 0.8, 0.1 };
        double[] pRut = new double[5];

        int step = 1;
        int over = 0;
        int exact = 0;
        int under = 0;
        int num = 24;
        double[] chartY;

        public Form1()
        {
            InitializeComponent();

             chartY = new double[num];

            for (int k = 0; k < num; k++)
            {
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
                    pEvent[i] = pRut[i];
                }

                chartY[k] = 0.0;

                for (int i = 0; i < pEvent.Length; i++)
                {
                    
                    chartY[k] += pEvent[i] * Math.Log(pEvent[i], 2);
                }
                chartY[k] = -chartY[k];
            }
            chart1.Series.Clear();
            Series cur = new Series("信息熵值变化");
            cur.ChartType = SeriesChartType.Line;
            for (int i = 0; i < chartY.Length; i++)
            {
                cur.Points.AddXY(i, chartY[i]);
            }
            chart1.Series.Add(cur);
            chart1.ChartAreas[0].AxisX.MajorGrid.Enabled = false;
            chart1.ChartAreas[0].AxisY.MajorGrid.Enabled = false;
           
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (button1.Text == "转换为点")
            {
                button1.Text = "转换为线";
                chart1.Series.Clear();
                Series cur = new Series("信息熵值变化");
                cur.ChartType = SeriesChartType.Point;
                for (int i = 0; i < chartY.Length; i++)
                {
                    cur.Points.AddXY(i, chartY[i]);
                }
                chart1.Series.Add(cur);
                chart1.ChartAreas[0].AxisX.MajorGrid.Enabled = false;
                chart1.ChartAreas[0].AxisY.MajorGrid.Enabled = false;
            }
            else
            {
                button1.Text = "转换为点";
                chart1.Series.Clear();
                Series cur = new Series("信息熵值变化");
                cur.ChartType = SeriesChartType.Line;
                for (int i = 0; i < chartY.Length; i++)
                {
                    cur.Points.AddXY(i, chartY[i]);
                }
                chart1.Series.Add(cur);
                chart1.ChartAreas[0].AxisX.MajorGrid.Enabled = false;
                chart1.ChartAreas[0].AxisY.MajorGrid.Enabled = false;
            }
        }
    }
}
