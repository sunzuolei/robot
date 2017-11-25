using System;
using System.Windows.Forms;

namespace P23
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            Detect();
            Compute();
        }
        double[] Xwa;
        double[] Xad;
        double[] Xaf;
        double[] Xwd;
        double[] Xwf;
        string[] strXwa;
        string[] strXad;
        string[] strXaf;

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
            // Xwa
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
                            throw new Exception(("“Xwa”文本框的输入格式不正确，请重新输入！"));
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
                tBXwa.Text = "5.00" + " " + "3.00" + " " + "50.00";
            }
            // Xad
            if (!string.IsNullOrEmpty(tBXad.Text))
            {
                try
                {
                    if (strXad.Length != 2)
                    {
                        throw new Exception("请在“Xad”文本框中完整输入2个参数，以“,”或“ ”为分割。");
                    }
                    for (int i = 0; i < 2; i++)
                    {
                        if (!double.TryParse(strXad[i], out Xad[i]))
                        {
                            throw new Exception(("“Xad”文本框中的输入格式不正确，请重新输入！"));
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
                Xad = new[] { 5.0, 2.0 };
                tBXad.Text = "5.00" + " " + "2.00" ;
            }

            // Xaf
            if (!string.IsNullOrEmpty(tBXaf.Text))
            {
                try
                {
                    if (strXaf.Length != 2)
                    {
                        throw new Exception("请在“Xaf”文本框中完整输入2个参数，以“,”或“ ”为分割。");
                    }
                    for (int i = 0; i < 2; i++)
                    {
                        if (!double.TryParse(strXwa[i], out Xwa[i]))
                        {
                            throw new Exception(("“Xaf”文本框中的输入格式不正确，请重新输入！"));
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
                Xaf = new[] { 3.0, 2.5 };
                tBXaf.Text = "3.00" + " " + "2.50" ;
            }
        }
        void Compute()
        {
            Xwd  = compound(Xwa, Xad);
            Xwf  = compound(Xwa, Xaf);
            // 显示
            tBXwd.Text = "";
            for (int i = 0; i < 2; i++)
            {
                tBXwd.Text += Xwd[i].ToString("F4") + " ";
            }
            tBXwd.Text = tBXwd.Text.TrimEnd(' ');

            tBXwf.Text = "";
            for (int i = 0; i < 2; i++)
            {
                tBXwf.Text += Xwf[i].ToString("F4") + " ";
            }
            tBXwf.Text = tBXwf.Text.TrimEnd(' ');
        }
        private double degtorad(double degree)
        {
            return (degree * Math.PI / 180);
        }
        double[] compound(double[] Xwa, double[] Xab)
        {
            // For details, please refer to Section 3.2.1 of R. Smith, M. Self,
            // "Estimating uncertain spatial relationships in robotics," 
            // Autonomous Robot Vehicles, pp. 167-193, 1990. 
            //   Xwa - should be of size 3*1 or 1*3
            //   Xab - can be 3*n or 2*n matrix
            // Seeded by Tim Bailey
            // Modified by Samuel on 7 May 2013

            double[] Xwb = new double[2];

            double[] rot = { Math.Cos(Xwa[2]), -Math.Sin(Xwa[2]), Math.Sin(Xwa[2]), Math.Cos(Xwa[2]) };
            Xwb[0] = rot[0] * Xab[0] + rot[1] * Xab[1] + Xwa[0];
            Xwb[1] = rot[2] * Xab[0] + rot[3] * Xab[1] + Xwa[1];

            return Xwb;
        }
        private double radtodeg(double rad)
        {
            return (180 * rad / Math.PI);
        }

        double piTopi(double angle)
        {
            // Input: array of angles.
            // Output: normalised angles.
            // Tim Bailey 2000, modified 2005.

            // Note: either rem or mod will work correctly
            // angle = mod(angle, 2*pi); % mod() is very slow for some versions of MatLab (not a builtin function)
            // angle = rem(angle, 2*pi); % rem() is typically builtin

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

        private void tBXwa_TextChanged(object sender, EventArgs e)
        {
            string temp = string.Empty;
            temp = tBXwa.Text.Replace(Environment.NewLine, " ");
            temp = temp.Replace(' ', ',');

            strXwa = temp.Split(new char[] { ',' }, 3, StringSplitOptions.RemoveEmptyEntries);
        }

        private void tBXad_TextChanged(object sender, EventArgs e)
        {
            string temp = string.Empty;
            temp = tBXad.Text.Replace(Environment.NewLine, " ");
            temp = temp.Replace(' ', ',');

            strXad = temp.Split(new char[] { ',' }, 2, StringSplitOptions.RemoveEmptyEntries);
        }

        private void tBXaf_TextChanged(object sender, EventArgs e)
        {
            string temp = string.Empty;
            temp = tBXwa.Text.Replace(Environment.NewLine, " ");
            temp = temp.Replace(' ', ',');

            strXaf = temp.Split(new char[] { ',' }, 2, StringSplitOptions.RemoveEmptyEntries);
        }

    }
}
