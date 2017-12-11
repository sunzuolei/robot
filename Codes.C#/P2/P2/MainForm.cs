using System;
using System.Collections.Generic;
using System.Windows.Forms;

namespace P2
{
    public partial class MainForm : Form
    {
        public MainForm()
        {
            InitializeComponent();
        }

        private void MainForm_Load(object sender, EventArgs e)
        {
            cBObservation.Items.Add("red");
            cBObservation.Items.Add("green");
            cBObservation.Text = "red";
            PaintHist();
        }

        private void cBObservation_SelectedIndexChanged(object sender, EventArgs e)
        {
            PaintHist();
        }

        private void PaintHist()
        {
            string[] world = { "green", "red", "red", "green", "green" };  // Map
            List<double> prior = new List<double>{ 0.2, 0.2, 0.2, 0.2, 0.2 };        // Prior
            string observation = cBObservation.Text;                            // Observation
            double pHit = 0.6;                           // Observation model
            double pMiss = 0.2;
            List<double> likelihood;
            List<double> posterior;
            posterior = Robot.ClassRobot.Sense(prior, observation, world, pHit, pMiss, out likelihood);  // Update
            //绘图
            chart1.Series[0].Points.DataBindY(prior);
            chart2.Series[0].Points.DataBindY(likelihood);
            chart3.Series[0].Points.DataBindY(posterior);
        }
    }
}
