using System;
using System.Windows.Forms;

namespace P19
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            print();
        }
        double[] prior = new double[2000];
        double[] motionModel = new double[2000];
        double[] sensorModel = new double[2000];
        double[] probAfterMove = new double[2000];
        double[] probAfterSense = new double[2000];
        double x = -9.99;
        double[] xx = new double[2000];
        
        void print()
        {
            try
            {
                //x  = -10:0.01:10;
                for (int i = 0; i < 2000; i++)
                {
                    prior[i] = gaussian1d(2, 1, x);    // a Gaussian Prior of mean 2 and SD 1
                    motionModel[i] = gaussian1d(1, 2, x);    // a Gaussian motion model of mean 1 and SD 2
                    sensorModel[i] = gaussian1d(5, 1, x);    // a Gaussian observation model of mean 5 and SD 1

                    chart1.Series[0].Points.AddXY(x, prior[i]);
                    chart1.Series[1].Points.AddXY(x, motionModel[i]);

                    chart2.Series[1].Points.AddXY(x, sensorModel[i]);

                    xx[i] = x;
                    x += 0.01;
                }
                probAfterMove = Convoltion(motionModel, prior,2000);        // prediction is convolution
               probAfterSense = product1d(sensorModel, probAfterMove);  // update is multiplication

                chart1.Series[2].Points.DataBindXY(xx, probAfterMove);
                //chart1.Series[2].Points.DataBindY(probAfterMove);
                chart2.Series[0].Points.DataBindXY(xx, probAfterMove);
                chart2.Series[2].Points.DataBindXY(xx, probAfterSense);
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

        }

        private double[] product1d(double[] X, double[] Y)
        {
            int Xl = X.Length;
            int Yl = Y.Length;
            double[] result = new double[Xl];
            double integration = 0.0;

            if (Xl != Yl)
            {
                throw new Exception("概率数组必须有相同长度！");
            }
            for(int i = 0;i < Xl;i++)
            {
                result[i] = X[i] * Y[i];
                integration += result[i] * 0.01;
            }

            for (int i = 0; i < Xl;i++ )
            {
                result[i] = result[i] / integration;      // normalization
            }
            return result;
        }

        double[] Convoltion(double[] X,double[] Y,int N)        // matlab：conv(X,Y,'same');
        {
            int L = X.Length + Y.Length - 1;
            int halfL = L / 2;
            int halfN = N / 2;
            double[] result = new double[L];
            double[] sameresult = new double[N];
            double P = new double();
            double integration = 0.0;       // 积分
            int k = 0;
            for (int i = halfL - halfN + 1; i <= halfL + halfN; i++)
            {
                for (int j = 0; j < X.Length; j++)
                {
                    if ((j <= i) & (i - j) < Y.Length)
                    {
                        P = X[j] * Y[i - j];
                        result[i] += P;
                    }
                }
                sameresult[k] = result[i];
                integration += sameresult[k] * 0.01;        // 积分
                k++;
            }

            for (int i = 0; i < N; i++)
            {
                sameresult[i] = sameresult[i] / integration;      // normalization
            }

            return sameresult;
        }

        double gaussian1d(int mu, double sigma, double x)
        {
            double p;

            p = 1 / (sigma * Math.Sqrt(2 * Math.PI)) * Math.Exp(-(x - mu) * (x - mu) / (2 * sigma * sigma));
            return p;
        }
    }
}
