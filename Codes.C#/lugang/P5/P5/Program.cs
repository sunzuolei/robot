using System;
using System.Collections.Generic;

namespace P5
{
    class Program
    {
        static void Main(string[] args)
        {
            List<double> p = new List<double>{0, 0.5, 0, 0.5, 0}; 
            int u = 2;                               
            double pExact = 0.8;
            double pOvershoot = 0.1;
            double pUndershoot = 0.1;
            List<double> q = new List<double>();
            q = Robot.ClassRobot.Move(p, u, pExact, pOvershoot, pUndershoot);
            Console.Write("U=2:\t");
            for(int i = 0;i < p.Count;i++)
            {
                Console.Write(string.Format("{0}\t",q[i]));
            }
            Console.WriteLine();
            Console.ReadLine();
        }
    }
}
