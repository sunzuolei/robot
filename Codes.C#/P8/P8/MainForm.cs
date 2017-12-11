using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Robot;

namespace P8
{
    public partial class MainForm : Form
    {
        public MainForm()
        {
            InitializeComponent();
            print();
        }
        void print()
        {
            List<double> p = new List<double>{0.2, 0.2, 0.2, 0.2, 0.2};        // Prior
            string[] world = {"green", "red", "red", "green", "green"};  // Map    
            // First configuration of meas. & motion
            string[] measurements = {"red", "green"};      // Observation
            int[] motions = {1, 1};                     // Motions
            // Observation model
            double pHit = 0.6;                           
            double pMiss = 0.2;
            // Motion model / Process model
            double pExact = 0.8;
            double pOvershoot = 0.1;
            double pUndershoot = 0.1;
            // The recursive sensing and moving
            double[,] entropy = new double[2,motions.Length];// zeros(2, length(motions));

            List<double> likehood;

            for(int i = 0;i < measurements.Length;i++)
            {
                // Update by sensing
                p = Robot.ClassRobot.Sense(p, measurements[i], world, pHit, pMiss,out likehood);
                for(int j = 0;j < 5;j++)
                {
                    entropy[0,i] += -p[i] * Math.Log(p[i],2);
                }
                // Predict by moving
                p = Robot.ClassRobot.Move(p, motions[i], pExact, pOvershoot, pUndershoot);
                for(int j = 0;j < 5;j++)
                {
                    entropy[1,i] += -p[i] * Math.Log(p[i],2);
                }
            }
            chart1.Series[0]["PointWidth"] = "0.975";
            chart1.Series[0].Points.DataBindY(p);

            
            chart2.Series[0].Points.AddXY(1.0,entropy[0,0]);
            chart2.Series[0].Points[0].Color = Color.Blue;

            chart2.Series[0].Points.AddXY(1.0, entropy[0, 1]);
            chart2.Series[0].Points[1].Color = Color.Red;

            chart2.Series[0].Points.AddXY(2.0, entropy[1, 0]);
            chart2.Series[0].Points[2].Color = Color.Blue;

            chart2.Series[0].Points.AddXY(2.0, entropy[1, 1]);
            chart2.Series[0].Points[3].Color = Color.Red;

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
