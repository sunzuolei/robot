using System;

namespace P31
{
    class Program
    {
        static void Main(string[] args)
        {
            double[] Xab    = {96, 35, degtorad(62)};

            double[] Xba  = Inverse(Xab);
            double[] Xab_ = Inverse(Xba);

            Xab_[2] = radtodeg(Xab_[2]);

            //disp(Xab);
            Console.WriteLine("Xab:");
            for(int i = 0;i < 2;i++)
            {
                Console.WriteLine(Xab[i].ToString("F4"));
            }
            Console.WriteLine(radtodeg(Xab[2]).ToString("F4"));
            Console.WriteLine();

            //disp(Xab_);
            Console.WriteLine("Inverse(Inverse(Xab)):");
            for (int i = 0; i < 3; i++)
            {
                Console.WriteLine(Xab_[i].ToString("F4"));
            }
            Console.ReadKey();
        }
        private static double[] Inverse(double[] Xab)
        {
            if (Xab.Length != 3)
            {
                Console.WriteLine("Xab should be of the size 3*1!");
            }
            double[] Xba = new double[3];

            Xba[0] = -Xab[0] * Math.Cos(Xab[2]) - Xab[1] * Math.Sin(Xab[2]);
            Xba[1] = Xab[0] * Math.Sin(Xab[2]) - Xab[1] * Math.Cos(Xab[2]);
            Xba[2] = -Xab[2];
            Xba[2] = piTopi(Xba[2]);

            return Xba;
        }

        static private double piTopi(double angle)
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

        static private double degtorad(double degree)
        {
            return (degree * Math.PI / 180);
        }

        static private double radtodeg(double rad)
        {
            return (180 * rad / Math.PI);
        }
    }
}
