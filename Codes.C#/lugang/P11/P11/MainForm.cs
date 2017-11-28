using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;

namespace P11
{
    public partial class MainForm : Form
    {
        List<double> tList;
        public MainForm()
        {
            InitializeComponent();
            print();
        }
        void print()
        {
            tBPrior.Text = "";
            tBq.Text = "";
            label1.Text = "";
            string[,] world = {{"red", "green", "green", "red" ,   "red"},
                               {"red", "red",   "green", "red",    "red"},
                               {"red", "red",   "green", "green",  "red"},
                               {"red", "red",   "red",   "red",    "red"}}; // Map
            double[,] ones = { { 1, 1, 1, 1, 1 }, { 1, 1, 1, 1, 1 }, { 1, 1, 1, 1, 1 }, { 1, 1, 1, 1, 1 }, { 1, 1, 1, 1, 1 } };
            int nRow = world.GetLength(0);
            int nCol = world.GetLength(1);
            List<int> stop  = new List<int>{0, 0};
            List<int> right = new List<int>{0, 1};
            List<int> left  = new List<int>{0,-1};
            List<int> down  = new List<int>{1, 0};
            List<int> up    = new List<int>{-1,0};
            List<List<int>> directions = new List<List<int>> { stop, right, left, down, up };
            double pMoveCorrect = 0.8;
            double pSenseCorrect = 0.7;

            List<List<double>> prior = new List<List<double>>();

            for (int i = 0; i < nRow; i++)
            {
                tList = new List<double>();
                for (int j = 0; j < nCol; j++)
                {
                    tList.Add(1.0 / (nRow * nCol) * ones[i, j]);
                }
                prior.Add(tList);
            }

            List<List<int>> motions = new List<List<int>>();
            List<string> measurements = new List<string>();
            string[] strMotionEnum = {"stop","right","left","down","up"};
            string[] strMeasurementEnum = { "green", "red" };

            // First configuration
            if(string.IsNullOrEmpty(tBMotions.Text) && string.IsNullOrEmpty(tBMeasurements.Text))
            {
                motions = new List<List<int>> { stop, right, down, down, right };
                measurements = new List<string>{ "green", "green", "green", "green", "green" };
                tBMotions.Text = "stop " + "right " + "down " + "down " + "right ";
                tBMeasurements.Text = "green " + "green " + "green " + "green " + "green ";
            }
            else
            {
                string[] strMotions = tBMotions.Text.Split(new char[] { ' ' },StringSplitOptions.RemoveEmptyEntries);
                int count = 0;
                for (int i = 0; i < strMotions.Length; i++)
                {
                    foreach (var k in strMotionEnum)
                    {
                        if (k == strMotions[i])
                        {
                            motions.Add(directions[count]);
                        }
                        count++;
                    }
                    count = 0;
                }

                string[] strMeasurements = tBMeasurements.Text.Split(new char[] { ' ' },StringSplitOptions.RemoveEmptyEntries);
                for (int i = 0; i < strMeasurements.Length; i++)
                {
                    foreach (var k in strMeasurementEnum)
                    {
                        if (k == strMeasurements[i])
                        {
                            measurements.Add(strMeasurements[i]);
                        }
                    }
                }
            }
            // Check the size
            if(motions.Count != 0 && measurements.Count != 0)
            {
                if (motions.Count != measurements.Count)
                {
                    MessageBox.Show("The variable \"motions\" should be of the same size as \"measurements\"!");
                    return;
                }
                else
                {
                    double[,] entropy = new double[2, motions.Count];
                    List<List<double>> p0;

                    // The main loop
                    for (int i = 0; i < motions.Count; i++)
                    {
                        prior = Move(prior, motions[i], pMoveCorrect);
                        p0 = prior;
                        prior = Sense(prior, measurements[i], world, nRow, nCol, pSenseCorrect);
                        // Compute entropy
                        entropy[0, i] = ComputeEntropy(p0);
                        entropy[1, i] = ComputeEntropy(prior);
                    }

                    for (int i = 0; i < nRow; i++)
                    {
                        for (int j = 0; j < nCol; j++)
                        {
                            tBPrior.Text += string.Format("{0:F4}\t", prior[i][j]);
                        }
                        tBPrior.Text += Environment.NewLine;
                    }

                    // disp('The probability after sensing:');
                    for (int i = 0; i < nRow; i++)
                    {
                        for (int j = 0; j < nCol; j++)
                        {
                            tBq.Text += string.Format("{0:F4}\t", prior[i][j]);
                        }
                        tBq.Text += Environment.NewLine;
                    }

                    int[] maxindex = new int[2];
                    maxindex = FindMax(prior);
                    label1.Text = string.Format("The largest probability {0:F4} occurs at cell({1},{2})", prior[maxindex[0]][maxindex[1]], maxindex[0], maxindex[1]);
                }
            }
            else
            {
                MessageBox.Show("请输入有效数据");
            }

        }

        //public List<List<double>> Move(List<List<double>> prior, int[] u, double pMoveCorrect)
        //{
        //    int nRow = prior.Count();
        //    int nCol = prior[0].Count();
        //    List<List<double>> q = new List<List<double>>();

        //    for (int r = 0; r < nRow; r++)
        //    {
        //        tList = new List<double>();
        //        for (int c = 0; c < nCol; c++)
        //        {
        //            tList.Add(pMoveCorrect * prior[mod((r - u[0]), nRow)][mod(c - u[1], nCol)]
        //                     + (1 - pMoveCorrect) * prior[r][c]);
        //        }
        //        q.Add(tList);
        //    }
        //    return q;
        //}

        public List<List<double>> Move(List<List<double>> prior, List<int> u, double pMoveCorrect)
        {
            int nRow = prior.Count();
            int nCol = prior[0].Count();
            List<List<double>> q = new List<List<double>>();

            for (int r = 0; r < nRow; r++)
            {
                tList = new List<double>();
                for (int c = 0; c < nCol; c++)
                {
                    tList.Add(pMoveCorrect * prior[mod((r - u[0]), nRow)][mod(c - u[1], nCol)]
                             + (1 - pMoveCorrect) * prior[r][c]);
                }
                q.Add(tList);
            }
            return q;
        }

        //List<List<double>> Sense(double[,] p, string z, string[,] world, int nRow, int nCol, double pSenseCorrect)
        //{
        //    nRow = p.GetLength(0);
        //    nCol = p.GetLength(1);
        //    List<double> tList = new List<double>(nCol);
        //    //double[,] posterior= new double[nRow, nCol];
        //    List<List<double>> tposterior = new List<List<double>>();
        //    List<List<double>> posterior = new List<List<double>>();
        //    for (int r = 0; r < nRow; r++)
        //    {
        //        tList = new List<double>(nCol);
        //        for (int c = 0; c < nCol; c++)
        //        {
        //            int hit = z.CompareTo(world[r, c]); // 相同为0，否则为1或-1
        //            tList.Add((pSenseCorrect * (1 - hit * hit) + (1 - pSenseCorrect) * hit * hit) * p[r, c]);
        //        }
        //        tposterior.Add(tList);
        //        //tList.Clear();                      // List是引用类型，所以清空后，tposterior也清空了!!!!!!!!!!!!
        //    }

        //    double sum = tposterior[0].Sum() + tposterior[1].Sum() + tposterior[2].Sum() + tposterior[3].Sum();
        //    for (int i = 0; i < nRow; i++)
        //    {
        //        tList = new List<double>(nCol);
        //        for (int j = 0; j < nCol; j++)
        //        {
        //            tList.Add(tposterior[i][j] / sum);
        //        }
        //        posterior.Add(tList);
        //    }
        //    return posterior;
        //}

        List<List<double>> Sense(List<List<double>> p, string z, string[,] world, int nRow, int nCol, double pSenseCorrect)
        {
            nRow = p.Count();
            nCol = p[0].Count();
            List<List<double>> tposterior = new List<List<double>>();
            List<List<double>> posterior = new List<List<double>>();

            for (int r = 0; r < nRow; r++)
            {
                tList = new List<double>(nCol);
                for (int c = 0; c < nCol; c++)
                {
                    int hit = z.CompareTo(world[r, c]); // 相同为0，否则为1或-1
                    tList.Add((pSenseCorrect * (1 - hit * hit) + (1 - pSenseCorrect) * hit * hit) * p[r][c]);
                }
                tposterior.Add(tList);
                //tList.Clear();                      // List是引用类型，所以清空后，tposterior也清空了!!!!!!!!!!!!
            }

            double sum = tposterior[0].Sum() + tposterior[1].Sum() + tposterior[2].Sum() + tposterior[3].Sum();
            for (int i = 0; i < nRow; i++)
            {
                tList = new List<double>(nCol);
                for (int j = 0; j < nCol; j++)
                {
                    tList.Add(tposterior[i][j] / sum);
                }
                posterior.Add(tList);
            }
            return posterior;
        }

        int[] FindMax(List<List<double>> array)
        {
            int[] index = new int[2];
            double max = array[0][0];
            if (array == null || array.Count == 0)
            {
                index = new int[] { -1, -1 };
                return index;
            }
            index = new int[] { 0, 0 };
            for (int i = 0; i < array.Count; i++)
            {
                for (int j = 0; j < array[i].Count; j++)
                {
                    if (array[i][j] > max)
                    {
                        index[0] = i;
                        index[1] = j;
                        max = array[i][j];
                    }
                }
            }
            return index;
        }

        //double ComputeEntropy(double[,] p)
        //{
        //    double entropy = new double { };
        //    for (int i = 0; i < p.GetLength(0); i++)
        //    {
        //        for (int j = 0; j < p.GetLength(1);j++ )
        //        {
        //            entropy += -p[i,j] * Math.Log(p[i,j], 2);
        //        }
        //    }
        //    return entropy;
        //}

        double ComputeEntropy(List<List<double>> p)
        {
            double entropy = new double { };
            for (int i = 0; i < p.Count(); i++)
            {
                for (int j = 0; j < p[0].Count(); j++)
                {
                    entropy += -p[i][j] * Math.Log(p[i][j], 2);
                }
            }
            return entropy;
        }

        int mod(int a, int b)
        {
            return ((a % b + b) % b);
        }
       
        private void button1_Click(object sender, EventArgs e)
        {
            print();
        }
    }
}
