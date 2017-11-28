using System.Collections.Generic;
using System.Windows.Forms;

namespace P3
{
    public partial class MainForm : Form
    {
        public MainForm()
        {
            InitializeComponent();
            PaintHist();
        }

        private void PaintHist()
        {
            string[] world = { "green", "red", "red", "green", "green" };  // Map
            List<double> prior = new List<double>{ 0.2, 0.2, 0.2, 0.2, 0.2 };        // Prior
            string[] observation = {"red","green"};                            // Observation
            double pHit = 0.6;                           // Observation model
            double pMiss = 0.2;
            List<double> likelihood;
            List<double> posterior;
            for (int i = 0; i < observation.Length; i++)
            {
                //绘图
                if (i == 0)
                {
                    posterior = Robot.ClassRobot.Sense(prior, observation[i], world, pHit, pMiss, out likelihood);  // Update
                    chart1.Series[0].Points.DataBindY(prior);
                    chart2.Series[0].Points.DataBindY(likelihood);
                    chart3.Series[0].Points.DataBindY(posterior);
                    prior = posterior;
                }
                else
                {
                    posterior = Robot.ClassRobot.Sense(prior, observation[i], world, pHit, pMiss, out likelihood);  // Update
                    chart4.Series[0].Points.DataBindY(prior);
                    chart5.Series[0].Points.DataBindY(likelihood);
                    chart6.Series[0].Points.DataBindY(posterior);
                }
            }
        }

        //private List<double> Sense(List<double> prior, string observation, string[] world, double pHit, double pMiss, out List<double> likelihood)
        //{
        //    List<double> tPosterior = new List<double>();
        //    List<double> q = new List<double>();
        //    List<double> posterior = new List<double>();

        //    for (int i = 0; i < prior.Count; i++)
        //    {
        //        int hit = observation.CompareTo(world[i]); // 相同为0，否则为1或-1
        //        q.Add(pHit * (1 - hit * hit) + pMiss * hit * hit);
        //        tPosterior.Add(prior[i] * q[i]);
        //    }
        //    for (int i = 0; i < prior.Count; i++)
        //    {
        //        posterior.Add(tPosterior[i] / tPosterior.Sum());
        //    }
        //    likelihood = q;
        //    return posterior;
        //}
    }
}
