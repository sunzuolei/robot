﻿using System;

namespace P33
{
    class Program
    {
        static void Main(string[] args)
        {
            double[] Xab = {5.0,3.0,degtorad(50)};
            
            double[] Xwb = {9.0,6.0,degtorad(70)};

            // First solution
            double[] Xba     = Inverse(Xab);
            double[] Xwa = compound(Xwb, Xba);

            Console.WriteLine("Fisrt solution:");
            for (int i = 0; i < 3;i++ )
            {
                Console.WriteLine(Xwa[i].ToString("F4"));
            }
            Console.WriteLine();

            // Second solution
            double[] Xwa2 = Inverse(compound(Xab, Inverse(Xwb)));

            Console.WriteLine("Second solution:");
            for (int i = 0; i < 3; i++)
            {
                Console.WriteLine(Xwa2[i].ToString("F4"));
            }
            Console.ReadLine();

        }

        private static double[] Inverse(double[] Xab)
        {
            if(Xab.Length != 3)
            {
                Console.WriteLine("Xab should be of the size 3*1!");
            }
            double[] Xba = new double[3];
            /*
            R   = [ -cos(Xab(3)), -sin(Xab(3)), 0;
                sin(Xab(3)),  -cos(Xab(3)), 0;
                    0,        0,            -1];
            Xba = R * Xab; */

            Xba[0] = -Xab[0] * Math.Cos(Xab[2]) - Xab[1] * Math.Sin(Xab[2]);
            Xba[1] = Xab[0] * Math.Sin(Xab[2]) - Xab[1] * Math.Cos(Xab[2]);
            Xba[2] = -Xab[2];
            Xba[2] = piTopi(Xba[2]);

            return Xba;
        }

        private static double[] compound(double[] Xwa, double[] Xab)
        {
            // For details, please refer to Section 3.2.1 of R. Smith, M. Self,
            // "Estimating uncertain spatial relationships in robotics," 
            // Autonomous Robot Vehicles, pp. 167-193, 1990. 
            //   Xwa - should be of size 3*1 or 1*3
            //   Xab - can be 3*n or 2*n matrix
            // Seeded by Tim Bailey
            // Modified by Samuel on 7 May 2013
            double[] Xwb = new double[3];
            
            double[] rot = {Math.Cos(Xwa[2]),-Math.Sin(Xwa[2]),Math.Sin(Xwa[2]),Math.Cos(Xwa[2])};
            Xwb[0] = rot[0] * Xab[0] + rot[1] * Xab[1] + Xwa[0];
            Xwb[1] = rot[2] * Xab[0] + rot[3] * Xab[1] + Xwa[1];
            Xwb[2] = Xab[2] + Xwa[2];

            Xwb[2] = piTopi(Xwb[2]);
            //Xwb[2] = radtodeg(Xwb[2]);

            return Xwb;
        }
        static private double piTopi(double angle)
        {
            // Input: array of angles.
            // Output: normalised angles.
            // Tim Bailey 2000, modified 2005.

            // Note: either rem or mod will work correctly
            // angle = mod(angle, 2*pi); % mod() is very slow for some versions of MatLab (not a builtin function)
            // angle = rem(angle, 2*pi); % rem() is typically builtin

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
