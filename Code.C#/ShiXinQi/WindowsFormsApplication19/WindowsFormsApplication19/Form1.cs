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

namespace WindowsFormsApplication19
{
    public partial class Form1 : Form
    {
        public double[] Convolution(double[] X, double[] Y)
        {
            int indexX = 0, indexY = 0;
            double sum = 0;
            double[] A, B;

            if (X.Length >= Y.Length)
            {
                A = X;
                B = Y;
            }
            else
            {
                B = X;
                A = Y;
            }

            int XLength = A.Length, YLength = B.Length;
            int AllLength = XLength + YLength;

            double[] Result = new double[AllLength - 1];

            for (int index = 0; index < AllLength - 1; index++)
            {
                indexX = index;
                indexY = 0;
                int tmpIndex = 0;

                while (tmpIndex < YLength)
                {
                    if (indexX >= 0 && indexX < XLength)
                    {
                        sum += A[indexX] * B[indexY];
                    }
                    else
                    {
                        if (indexX < 0)
                        {
                            break;
                        }
                    }
                    indexX--;
                    indexY++;
                    tmpIndex++;
                }
                Result[index] = sum;
                sum = 0;
            }
            return Result;
        }


        public double[] Multiplay(double[] X, double[] Y)
        {
            int max = 0;
            int min = 0;
            if (X.Length >= Y.Length)
            {
                max = X.Length;
                min = Y.Length;
            }
            else
            {
                max = Y.Length;
                min = X.Length;
            }
            double[] result = new double[min];

            for (int i = 0; i < min; i++)
            {
                result[i] = (X[i] * Y[i]);
            }
            return result;

        }


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


        double[] x = new double[200];
        double[] x1 = new double[400];


        public Form1()
        {
            InitializeComponent();

            x[0] = -10;
            for (int i = 1; i < x.Length; i++)
            {
                x[i] = (x[i - 1] + 0.1);
            }
            x1[0] = -20;
            for (int i = 1; i < x1.Length; i++)
            {
                x1[i] = x1[i - 1] + 0.1;
            }

        }

        private void button1_Click(object sender, EventArgs e)
        {
            double mean1 = 0, mean2 = 0, mean3 = 0;
            double segima1 = 1, segima2 = 1, segima3 = 1;

            double[] y1 = new double[x.Length];
            double[] y2 = new double[x.Length];
            double[] y3 = new double[x.Length];
            double[] y3a;

            double[] r1 = new double[x1.Length-1];
            double[] r2 = new double[x1.Length];

            mean1 = Convert.ToDouble(textBox1.Text.Trim()); segima1 = Convert.ToDouble(textBox2.Text.Trim());
            mean2 = Convert.ToDouble(textBox3.Text.Trim()); segima2 = Convert.ToDouble(textBox4.Text.Trim());
            mean3 = Convert.ToDouble(textBox5.Text.Trim()); segima3 = Convert.ToDouble(textBox6.Text.Trim());

            for (int i = 0; i < x.Length; i++)
            {
                y1[i] = Normal(x[i], mean1, segima1);
                y2[i] = Normal(x[i], mean2, segima2);
                y3[i] = Normal(x[i], mean3, segima3);
            }
            chart1.ChartAreas[0].AxisX.MajorGrid.Enabled = false;
            chart1.ChartAreas[0].AxisY.MajorGrid.Enabled = false;
            chart1.Series.Clear();

            Series cur1 = new Series("y1");
            Series cur2 = new Series("y2");
            Series cur3 = new Series("y3");

            cur1.Color = Color.Red;
            cur2.Color = Color.Green;
            cur3.Color = Color.Blue;

            cur1.ChartType = SeriesChartType.Line;
            cur2.ChartType = SeriesChartType.Line;
            cur3.ChartType = SeriesChartType.Line;

            for (int i = 0; i < x.Length; i++)
            {
                cur1.Points.AddXY(x[i], y1[i]);
                cur2.Points.AddXY(x[i], y2[i]);
                cur3.Points.AddXY(x[i], y3[i]);
            }
            chart1.Series.Add(cur1);
            chart1.Series.Add(cur2);
            chart1.Series.Add(cur3);

            chart2.ChartAreas[0].AxisX.MajorGrid.Enabled = false;
            chart2.ChartAreas[0].AxisY.MajorGrid.Enabled = false;
            chart2.Series.Clear();

            r2 = Convolution(y1, y2);
           

            Series cur4 = new Series("卷积");
            cur4.Color = Color.Red;
            cur4.ChartType = SeriesChartType.Line;
            for (int i = 0; i < x1.Length-1; i++)
            {
                cur4.Points.AddXY(x1[i], r2[i]);
            }
            chart2.Series.Add(cur4);

            Series cur5 = new Series("乘积");
            cur5.Color = Color.Blue;
            cur5.ChartType = SeriesChartType.Line;
            y3a = new double[r2.Length];
            for (int i = 0; i < r2.Length; i++)
            {
                y3a[i] = Normal(x1[i], mean3, segima3);
            }
            r1 = Multiplay(y3a, r2);
            for (int i = 0; i < r1.Length; i++)
            {
                cur5.Points.AddXY(x1[i], r1[i]);
            }
            chart2.Series.Add(cur5);
       }
   }
}
