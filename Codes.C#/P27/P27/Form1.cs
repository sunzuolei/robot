using System;
using System.Windows.Forms;

namespace P27
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
        double[] Xwa;
        double[] Pab;
        double[] Xab;
        double[] Xwb;

        string[] strXwa;
        string[] strPab;

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
                    if (strXwa.Length != 3)
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
                tBXwa.Text = "5" + " " + "3" + " " + "50";
            }

            if (!string.IsNullOrEmpty(tBPab.Text))
            {
                try
                {
                    if (strPab.Length != 2)
                    {
                        throw new Exception("请在“Pab”文本框中完整输入2个参数，以“,”或“ ”为分割。");
                    }
                    for (int i = 0; i < 2; i++)
                    {
                        if (!double.TryParse(strPab[i], out Pab[i]))
                        {
                            throw new Exception(("“Pab”文本框中的输入格式不正确，请重新输入！"));
                        }
                    }
                }
                catch (Exception ex)
                {
                    throw (ex);
                }
            }
            else
            {
                Pab = new[] { 7.0, 40.0 };
                tBPab.Text = "7" + " " + "40" ;
            }

            Pab[1] = degtorad(Pab[1]);
            Xab = pol2cart(Pab);
        }
        void Compute()
        {
            Xwb = compound(Xwa, Xab);
            tBXwb.Text = "";
            for (int i = 0; i < 3; i++)
            {
                tBXwb.Text += Xwb[i].ToString("F2") + " ";
            }
            tBXwb.Text = tBXwb.Text.TrimEnd(' ');
        }

        private double[] pol2cart(double[] pol)
        {
            double[] cart = new double[3];
            cart[0] = pol[0] * Math.Cos(pol[1]);
            cart[1] = pol[0] * Math.Sin(pol[1]);
            cart[2] = pol[1];
            return cart;
        }
        double[] compound(double[] Xwa, double[] Xab)
        {
            double[] Xwb = new double[3];

            double[] rot = { Math.Cos(Xwa[2]), -Math.Sin(Xwa[2]), Math.Sin(Xwa[2]), Math.Cos(Xwa[2]) };
            Xwb[0] = rot[0] * Xab[0] + rot[1] * Xab[1] + Xwa[0];
            Xwb[1] = rot[2] * Xab[0] + rot[3] * Xab[1] + Xwa[1];
            Xwb[2] = Xab[2] + Xwa[2];

            Xwb[2] = piTopi(Xwb[2]);
            Xwb[2] = radtodeg(Xwb[2]);

            return Xwb;
        }

        double piTopi(double angle)
        {
            double twopi = 2 * Math.PI;
            angle = angle - twopi * (int)(angle / twopi); // this is a stripped-down version of rem(angle, 2*pi)

            while (angle >= Math.PI)
            {
                angle -= twopi;
            }
            while (angle <= -Math.PI)
            {
                angle += twopi;
            }

            return angle;
        }

        private double radtodeg(double rad)
        {
            return (180 * rad / Math.PI);
        }

        private double degtorad(double degree)
        {
            return (degree * Math.PI / 180);
        }

        private void tBXwa_TextChanged(object sender, EventArgs e)
        {
            string temp = string.Empty;
            temp = tBXwa.Text.Replace(Environment.NewLine, " ");
            temp = temp.Replace(' ', ',');

            strXwa = temp.Split(new char[] { ',' }, 3, StringSplitOptions.RemoveEmptyEntries);
        }

        private void tBPab_TextChanged(object sender, EventArgs e)
        {
            string temp = string.Empty;
            temp = tBPab.Text.Replace(Environment.NewLine, " ");
            temp = temp.Replace(' ', ',');

            strPab = temp.Split(new char[] { ',' }, 2, StringSplitOptions.RemoveEmptyEntries);
        }
    }
}
