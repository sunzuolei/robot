using System;
using System.Windows.Forms;

namespace P6
{
    public partial class MainForm : Form
    {
        public MainForm()
        {
            InitializeComponent();
            timer1.Interval = 200;
            timer1.Start();
        }

        private static int n = 5;
        private static int u = 1;
        private static double pExact = 0.8;
        private static double pOvershoot = 0.1;
        private static double pUndershoot = 0.1;

        private static int step = 1;
        private static double[] p = { 1, 0, 0, 0, 0 };


        public void paint()
        {
            chart1.Series[0].Points.DataBindY(p);
            label1.Text = "step=" + step.ToString();

            p = move();

            switch (step)
            {
                case 9:
                    {
                        label2.Text = "step=" + step.ToString();                        
                        chart2.Series[0].Points.DataBindY(p);
                        break;
                    }
                case 11:
                    {
                        label3.Text = "step=" + step.ToString();                                                
                        chart3.Series[0].Points.DataBindY(p);
                        break;
                    }
                case 14:
                    {
                        label6.Text = "step=" + step.ToString();                                                
                        chart4.Series[0].Points.DataBindY(p);
                        break;
                    }
                case 23:
                    {
                        label5.Text = "step=" + step.ToString();                                                
                        chart5.Series[0].Points.DataBindY(p);
                        break;
                    }
                case 50:
                    {
                        label4.Text = "step=" + step.ToString();                                                
                        chart6.Series[0].Points.DataBindY(p);
                        break;
                    }
                default:
                    break;
            }
        }
        double[] move()
        {
            double[] q = new double[5];
            for (int i = 0; i < n; i++)
            {
                //a mod b = (a % b + b) % b
                q[i] = pExact * p[((i - u) % n + n) % n];
                q[i] = q[i] + pOvershoot * p[((i - 1 - u) % n + n) % n];
                q[i] = q[i] + pUndershoot * p[((i + 1 - u) % n + n) % n];
            }
            return q;
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            if(step <= 100)
            {
                paint();
                step++;
            }
            else
            {
                timer1.Stop();
            }
        }
    }
}
