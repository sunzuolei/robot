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


namespace WindowsFormsApplication8
{
    public partial class Form1 : Form
    {

        public double informationH(double[] pEvent)
        {
            double result = 0;
            for (int i = 0; i < pEvent.Length; i++)
            {
                result += (pEvent[i] * Math.Log(pEvent[i], 2));
            }
            result = -result;
            return result;
        }


        //p = sense(p, measurements(i), world, pHit, pMiss); 
      public double[] Sense(double[] psb,string strSee,string[] strMap,double hit,double mis)
        {
            double sum = 0;

            for (int i = 0; i < strMap.Length; i++)
            {
                if (strSee == strMap[i])
                {
                    psb[i] = psb[i] * hit;
                }
                else
                {
                    psb[i] = psb[i] * mis;
                }
            }
            for (int i = 0; i < 5; i++)
            {
                sum += psb[i];
            }

            for (int i = 0; i < 5; i++)
            {
                psb[i] = psb[i] / sum;
            }
            return psb;
        }


      //p = move(p, motions(i), pExact, pOvershoot, pUndershoot);

        double[] Move(double[] pEvent,int step,double[] pUnderOver)
        {
            int j = 0;
              
            double[] pRut = new double[pEvent.Length];

            int over = 0;
            int exact = 0;
            int under = 0;

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

            return pRut;
        }

        double[] pEvent = { 0.2, 0.2, 0.2, 0.2, 0.2 };
        string[] map = { "green", "red", "red", "green", "green" };
        string[] see = { "red", "green" };
        int[] step = { 1, 1 };
        double hit = 0.6;
        double mis = 0.2;

        double[] pUnderOver = { 0.1, 0.8, 0.1 };
        double[,] resultH ;

        Series cur1 = new Series("sense");
        Series cur2 = new Series("move");


        public Form1()
        {
            InitializeComponent();
            resultH = new double[2, see.Length];

            for (int i = 0; i < see.Length; i++)
            {
                pEvent = Sense(pEvent, see[i], map, hit, mis);
                resultH[0, i] = informationH(pEvent);
                pEvent = Move(pEvent, step[i], pUnderOver);
                resultH[1, i] = informationH(pEvent);
            }



            chart1.Series.Clear();
           
            cur1.Color = Color.Blue;
            cur1.ChartType = SeriesChartType.Line;
            cur1.IsValueShownAsLabel = false;


            
            cur2.Color = Color.Red;
            cur2.ChartType = SeriesChartType.Line;
            //cur2.IsValueShownAsLabel = true;


            for (int i = 0; i < see.Length; i++)
            {
                cur1.Points.AddXY(i, resultH[0, i]);
                cur2.Points.AddXY(i, resultH[1, i]);
            }
            chart1.Series.Add(cur1);
            chart1.Series.Add(cur2);

            chart1.ChartAreas[0].AxisX.MajorGrid.Enabled = false;
            chart1.ChartAreas[0].AxisY.MajorGrid.Enabled = false;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (button1.Text == "转换为点")
            {
                button1.Text = "转换为线";

                cur1.ChartType = SeriesChartType.Point;
                cur2.ChartType = SeriesChartType.Point;
            }
            else
            {
                button1.Text = "转换为点";
              
                cur1.ChartType = SeriesChartType.Line;
                cur2.ChartType = SeriesChartType.Line;
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (button2.Text == "显示信息熵")
            {
                button2.Text = "隐藏信息熵";

                cur1.IsValueShownAsLabel = true;
                cur2.IsValueShownAsLabel = true;
            }
            else
            {
                button2.Text = "显示信息熵";

                cur1.IsValueShownAsLabel = false;
                cur2.IsValueShownAsLabel = false;
            }
        }



       
    }
}
