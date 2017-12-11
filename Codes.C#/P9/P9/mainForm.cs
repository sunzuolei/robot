using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;

namespace P9
{
    public partial class mainForm : Form
    {
        List<double> tList;
        
        public mainForm()
        {
            InitializeComponent();
            comboBox1.Items.Add("stop");
            comboBox1.Items.Add("right");
            comboBox1.Items.Add("left");
            comboBox1.Items.Add("down");
            comboBox1.Items.Add("up");

            comboBox1.Text = "right";

            print();
        }
        public void print()
        {
            textBoxPrior.Text = "";
            textBoxq.Text = "";
            string[,] world = {{"red", "green", "green", "red" ,   "red"},
                               {"red", "red",   "green", "red",    "red"},
                               {"red", "red",   "green", "green",  "red"},
                               {"red", "red",   "red",   "red",    "red"}}; // Map
            double[,] ones = {{1,1,1,1,1},{1,1,1,1,1},{1,1,1,1,1},{1,1,1,1,1},{1,1,1,1,1}};
            List<List<double>> prior = new List<List<double>>();
            List<List<double>> q;
            int nRow = world.GetLength(0);
            int nCol = world.GetLength(1);
            int[] stop  = {0, 0};
            int[] right = {0, 1};
            int[] left  = {0,-1};
            int[] down  = {1, 0};
            int[] up    = {-1,0};
            int[][] directions = { stop, right, left, down, up };
            string[] strDirections = { "stop", "right", "left", "down", "up" };
    
            double pMoveCorrect = 0.8;
            double pStart = 0.7;
            for(int i = 0;i < nRow;i++)
            {
                tList = new List<double>();                
                for(int j = 0;j < nCol;j++)
                {
                    tList.Add((1 - pStart) / (nRow * nCol - 1) * ones[i, j]);// Prior
                }
                prior.Add(tList);
            }
                
            // Fisrt configuration
            prior[2][1] = pStart;
            int[] motions = new int[]{};

            for(int i = 0;i < strDirections.Length;i++)
            {
                if(comboBox1.SelectedItem == strDirections[i])
                {
                    motions = directions[i];
                    break;
                }
            }

            q = move(prior, motions, pMoveCorrect,nRow,nCol);

            for(int i = 0;i < nRow;i++)
            {
                for(int j = 0;j < nCol;j++)
                {
                    textBoxPrior.Text +=  string.Format("{0:F4}\t",prior[i][j]);
                }
                textBoxPrior.Text += Environment.NewLine;
            }
             
            // disp('The probability after moving:');
            for(int i = 0;i < nRow;i++)
            {
                for(int j = 0;j < nCol;j++)
                {
                    textBoxq.Text += string.Format("{0:F4}\t",q[i][j]);
                }
                textBoxq.Text += Environment.NewLine;
            }
            int[] maxindex = new int[2];
            maxindex = FindMax(q);
            label1.Text = string.Format("The largest probability {0:F4} occurs at cell({1},{2})",q[maxindex[0]][maxindex[1]],maxindex[0],maxindex[1]);
        }

        List<List<double>> move(List<List<double>> prior, int[] u, double pMoveCorrect, int nRow, int nCol)
        {
            nRow = prior.Count();
            nCol = prior[0].Count();
            List<List<double>> q = new List<List<double>>();

            for (int r = 0; r < nRow; r++)
            {
                tList = new List<double>();
                
                for (int c = 0; c < nCol; c++)
                {
                    tList.Add(pMoveCorrect * prior[mod(r - u[0], nRow)][mod(c - u[1], nCol)] + (1 - pMoveCorrect) * prior[r][c]);
                }
                q.Add(tList);
            }

            return q;
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

        int mod(int a,int b)
        {
            return ((a % b + b) % b);
        }

        private void comboBox1_SelectionChangeCommitted(object sender, EventArgs e)
        {
            print();
        }
    }
}
