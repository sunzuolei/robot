using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;

namespace P10
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            comboBox1.Items.Add("green");
            comboBox1.Items.Add("red");
            comboBox1.Text = "green";
            print();
        }
        void print()
        {
            tBPrior.Text = "";
            tBq.Text = "";
            string[,] world = {{"red", "green", "green", "red" ,   "red"},
                               {"red", "red",   "green", "red",    "red"},
                               {"red", "red",   "green", "green",  "red"},
                               {"red", "red",   "red",   "red",    "red"}}; // Map
            double[,] ones = { { 1, 1, 1, 1, 1 }, { 1, 1, 1, 1, 1 }, { 1, 1, 1, 1, 1 }, { 1, 1, 1, 1, 1 }, { 1, 1, 1, 1, 1 } };
            int nRow = world.GetLength(0);
            int nCol = world.GetLength(1);
            double[,] prior = new double[nRow, nCol];
            //double[,] q = new double[4, 5];
            List<List<double>> q = new List<List<double>>(nRow);
            
            double pSenseCorrect = 0.7;
            double pStart = 0.7;

            for (int i = 0; i < nRow; i++)
            {
                for (int j = 0; j < nCol; j++)
                {
                    prior[i, j] = (1 - pStart) / (nRow * nCol - 1) * ones[i, j];// Prior
                }
            }
            prior[2, 1] = pStart;
            string measurements = comboBox1.Text;
            // Measurment update
            q = sense(prior, measurements, world, nRow, nCol, pSenseCorrect);

            for (int i = 0; i < nRow; i++)
            {
                for (int j = 0; j < nCol; j++)
                {
                    tBPrior.Text += string.Format("{0:F4}\t", prior[i, j]);
                }
                tBPrior.Text += Environment.NewLine;
            }

            // disp('The probability after moving:');
            for (int i = 0; i < nRow; i++)
            {
                for (int j = 0; j < nCol; j++)
                {
                    tBq.Text += string.Format("{0:F4}\t", q[i][j]);
                }
                tBq.Text += Environment.NewLine;
            }
            int[] maxindex = new int[2];
            maxindex = FindMax(q);
            label1.Text = string.Format("The largest probability {0:F4} occurs at cell({1},{2})", q[maxindex[0]][maxindex[1]], maxindex[0], maxindex[1]);
        }

        List<List<double>> sense(double[,] p, string z, string[,] world, int nRow,int nCol,double pSenseCorrect)
        {
            nRow = p.GetLength(0);
            nCol = p.GetLength(1);
            List<double> tList = new List<double>(nCol);                    
            //double[,] posterior= new double[nRow, nCol];
            List<List<double>> tposterior = new List<List<double>>();
            List<List<double>> posterior = new List<List<double>>();
            for(int r = 0;r < nRow;r++)
            {
                tList = new List<double>(nCol);                            
                for(int c = 0;c < nCol;c++)
                {
                    int hit = z.CompareTo(world[r,c]); // 相同为0，否则为1或-1
                    tList.Add((pSenseCorrect * (1 - hit * hit) + (1 - pSenseCorrect) * hit * hit) * p[r, c]);
                }
                tposterior.Add(tList);
                //tList.Clear();                      // List是引用类型，所以清空后，tposterior也清空了!!!!!!!!!!!!
            }

            double sum = tposterior[0].Sum() + tposterior[1].Sum() + tposterior[2].Sum() + tposterior[3].Sum();
            for (int i = 0; i < nRow; i++)
            {
                tList = new List<double>(nCol);                
                for (int j = 0; j < nCol;j++)
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

        private void comboBox1_SelectionChangeCommitted(object sender, EventArgs e)
        {
            print();
        }
    }
}
