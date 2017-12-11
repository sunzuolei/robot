using System;
using System.Windows.Forms;

namespace P20
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            print();
        }
        static int arrayL = 2000;
        double[] prior = new double[arrayL];
        double[] motionModel = new double[arrayL];
        double[] sensorModel = new double[arrayL];
        double[] probAfterMove = new double[arrayL];
        double[] probAfterSense = new double[arrayL];
        double[] probAfterMoveParam = new double[arrayL];
        double[] probAfterSenseParam = new double[arrayL];
        double[] probAfterSenseParamSeq = new double[arrayL];

        double[] paraAfterMove = new double[2];
        double[] paraAfterSense = new double[2];

        double x = -9.9;
        double[] xx = new double[arrayL];

        void print()
        {
            //x  = -10:0.01:10;

            paraAfterMove = convolute1dParam(2, 1, 1, 2);
            paraAfterSense = product1dParam(paraAfterMove[0], paraAfterMove[1], 5, 1);

            for (int i = 0; i < arrayL; i++)
            {
                prior[i] = gaussian1d(2, 1, x);    // a Gaussian Prior of mean 2 and SD 1
                motionModel[i] = gaussian1d(1, 2, x);    // a Gaussian motion model of mean 1 and SD 2
                sensorModel[i] = gaussian1d(5, 1, x);    // a Gaussian observation model of mean 5 and SD 1

                probAfterMoveParam[i] = gaussian1d(paraAfterMove[0], paraAfterMove[1], x);
                probAfterSenseParam[i] = gaussian1d(paraAfterSense[0], paraAfterSense[1], x);


                xx[i] = x;
                x += 0.01;
            }

            probAfterMove = Convoltion1d(motionModel, prior, arrayL);        // prediction is convolution
            probAfterSense = product1d(sensorModel, probAfterMove);  // update is multiplication

            probAfterSenseParamSeq = product1d(sensorModel, probAfterMoveParam);

            chart1.ChartAreas[0].AxisX.Minimum = -5;
            chart2.ChartAreas[0].AxisX.Minimum = -5;
            chart1.ChartAreas[0].AxisX.Maximum = 10;
            chart2.ChartAreas[0].AxisX.Maximum = 10;

            //chart1.Series[0]["PointWidth"] = "20";
            chart1.Series[0].BorderWidth  = 5;
            chart1.Series[0].Points.DataBindXY(xx, probAfterMove);
            chart1.Series[1].Points.DataBindXY(xx, probAfterMoveParam);

            chart2.Series[0].BorderWidth = 5;
            chart2.Series[0].Points.DataBindXY(xx, probAfterSense);
            chart2.Series[1].Points.DataBindXY(xx, probAfterSenseParam);
            chart2.Series[2].Points.DataBindXY(xx, probAfterSenseParamSeq);            
        }

        private double[] product1dParam(double muAfterMove, double sdAfterMove, double muSensor, double sdSensor)
        {
            double[] para = new double[2];
            para[0] = (muAfterMove * Math.Pow(sdSensor, 2) + muSensor * Math.Pow(sdAfterMove, 2)) / (Math.Pow(sdAfterMove, 2) + Math.Pow(sdSensor, 2));
            para[1] = (Math.Pow(sdSensor, 2) * Math.Pow(sdAfterMove, 2)) / (Math.Pow(sdAfterMove, 2) + Math.Pow(sdSensor, 2));
            return para;
        }

        private double[] convolute1dParam(int muPrior, int sdPrior, int muMotion, int sdMotion)
        {
            double[] para = new double[2];
            para[0] = muPrior + muMotion;
            para[1] = Math.Sqrt(Math.Pow(sdPrior,2) + Math.Pow(sdMotion, 2));
            return para;
        }

        private double[] product1d(double[] X, double[] Y)
        {
            int Xl = X.Length;
            int Yl = Y.Length;
            double[] result = new double[Xl];
            double integration = 0.0;

            if (Xl != Yl)
            {
                MessageBox.Show("概率数组必须有相同长度！");
            }
            for (int i = 0; i < Xl; i++)
            {
                result[i] = X[i] * Y[i];
                integration += result[i] * 0.01;
            }

            for (int i = 0; i < Xl; i++)
            {
                result[i] = result[i] / integration;      // normalization
            }
            return result;
        }

        double[] Convoltion1d(double[] X, double[] Y, int N)        // matlab：conv(X,Y,'same');
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

        double gaussian1d(double mu, double sigma, double x)
        {
            double p;

            p = 1 / (sigma * Math.Sqrt(2 * Math.PI)) * Math.Exp(-(x - mu) * (x - mu) / (2 * sigma * sigma));
            return p;
        }
    }
}
