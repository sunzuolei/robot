using System;
using System.Windows.Forms;

namespace P22
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            this.StartPosition = FormStartPosition.CenterScreen;
            Detect();
            Compute();
        }
        string[] strXwa;
        string[] strXab;
        double[] Xwa = new double[3];
        double[] Xab = new double[3];
        double[] Xwb = new double[3];

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                Detect();
                Compute();
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
        void Detect()
        {
            if (!string.IsNullOrEmpty(tBXwa.Text))
            {
               try
               {
                   if(strXwa.Length != 3)
                   {
                       throw new Exception("请在“Xwa”文本框中完整输入3个参数，以“,”或“ ”为分割。");
                   }
                   for (int i = 0; i < 3; i++)
                   {
                        if (!double.TryParse(strXwa[i], out Xwa[i]))
                        {
                            throw new Exception(("“Xwa”文本框中的输入格式不正确，请重新输入！"));
                        }
                   }
                   Xwa[2] = degtorad(Xwa[2]);
               }
               catch (Exception ex)
               {
                   throw (ex);
               }
            }
            else
            {
                Xwa = new[] { 5, 3, degtorad(50) };
                tBXwa.Text = "5" + Environment.NewLine + "3" + Environment.NewLine + "50";
            }

            if (!string.IsNullOrEmpty(tBXab.Text))
            {
                try
                {
                    if(strXab.Length != 3)
                    {
                        throw new Exception("请在“Xab”文本框中完整输入3个参数，以“,”或“ ”为分割。");
                    }
                    for (int i = 0; i < 3; i++)
                    {
                        if (!double.TryParse(strXab[i], out Xab[i]))
                        {
                            throw new Exception(("“Xab”文本框中的输入格式不正确，请重新输入！"));
                        }
                    }
                    Xab[2] = degtorad(Xab[2]);
                }
                catch(Exception ex)
                {
                    throw ex;
                }
            }
            else
            {
                Xab = new[] { 4, 2, degtorad(20) };
                tBXab.Text = "4" + Environment.NewLine + "2" + Environment.NewLine + "20";
            }
        }

        void Compute()
        {
            Xwb = compound(Xwa, Xab);
            tBXwb.Text = "";
            for (int i = 0; i < 3;i++ )
            {
                tBXwb.Text += Xwb[i].ToString("F2") + Environment.NewLine;
            }
        }

        
        double[] compound(double[] Xwa, double[] Xab)
        {
            double[] Xwb = new double[3];
            
            double[] rot = {Math.Cos(Xwa[2]),-Math.Sin(Xwa[2]),Math.Sin(Xwa[2]),Math.Cos(Xwa[2])};
            Xwb[0] = rot[0] * Xab[0] + rot[1] * Xab[1] + Xwa[0];
            Xwb[1] = rot[2] * Xab[0] + rot[3] * Xab[1] + Xwa[1];
            Xwb[2] = Xab[2] + Xwa[2];

            Xwb[2] = piTopi(Xwb[2]);
            Xwb[2] = radtodeg(Xwb[2]);

            return Xwb;
        }

        private double radtodeg(double rad)
        {
            return (180 * rad / Math.PI);
        }
        private double degtorad(double degree)
        {
            return (degree * Math.PI / 180);
        }

        double piTopi(double angle)
        {
            double twopi = 2 * Math.PI;
            angle = angle - twopi * (int)(angle/twopi); // this is a stripped-down version of rem(angle, 2*pi)

            while(angle >= Math.PI)
            {
                angle -= twopi;
            }
            while(angle <= -Math.PI)
            {
                angle += twopi;
            }

            return angle;
        }

        private void tBXwa_TextChanged(object sender, EventArgs e)
        {
            string temp = string.Empty;
            temp = tBXwa.Text.Replace(Environment.NewLine, " ");
            temp = temp.Replace(' ', ',');

            strXwa = temp.Split(new char[] { ',' }, 3, StringSplitOptions.RemoveEmptyEntries);
        }

        private void tBXab_TextChanged(object sender, EventArgs e)
        {
            string temp = string.Empty;
            temp = tBXab.Text.Replace(Environment.NewLine, " ");
            temp = temp.Replace(' ', ',');

            strXab = temp.Split(new char[] { ',' }, 3, StringSplitOptions.RemoveEmptyEntries);
        }
    }
}
