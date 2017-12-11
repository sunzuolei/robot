using System;
using System.Collections.Generic;
using System.Windows.Forms;

namespace P7
{
    public partial class MainForm : Form
    {
        public MainForm()
        {
            InitializeComponent();
            print();
        }
        public void print()
        {
            List<double> p = new List<double>{1, 0, 0, 0, 0};
            double[] q = new double[p.Count];
            int u = 1;
            int step = 100;
            double pExact = 0.8;
            double pOvershoot = 0.1;
            double pUndershoot = 0.1;
            double[] entropy = new double[step];
            double tLog = 0.0;
            for (int i = 0; i < step; i++)
            {
                p = Robot.ClassRobot.Move(p, u, pExact, pOvershoot, pUndershoot);
                for(int j = 0;j < 5;j++)
                {
                    if(IsEqual(p[j],0.0))
                    {
                        tLog = 0.0;
                    }
                    else
                    {
                        tLog = Math.Log(p[j], 2);
                    }
                    entropy[i] += -(p[j] * tLog);
                }
            }
            chart1.Series[0].Points.DataBindY(entropy);
        }
        bool IsEqual(double n1, double n2)
        {
            if (Math.Abs(n1 - n2) <= Math.Pow(10, -2))
                return true;
            else
                return false;
        }
    }
}
