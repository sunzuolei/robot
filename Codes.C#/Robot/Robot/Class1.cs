using System.Collections.Generic;
using System.Linq;

namespace Robot
{
    static public class ClassRobot
    {
        static public List<double> Move(List<double> prior, int u, double pExact, double pOvershoot, double pUndershoot)
        {
            int n = prior.Count;
            List<double> q = new List<double>();
            for (int i = 0; i < n; i++)
            {
                //a mod b = (a % b + b) % b
                q.Add(pExact * prior[((i - u) % n + n) % n]);
                q[i] = q[i] + pOvershoot * prior[((i - 1 - u) % n + n) % n];
                q[i] = q[i] + pUndershoot * prior[((i + 1 - u) % n + n) % n];
            }
            return q;
        }

        static public List<double> Sense(List<double> prior, string observation, string[] world, double pHit, double pMiss, out List<double> likelihood)
        {
            List<double> tPosterior = new List<double>();
            List<double> q = new List<double>();
            List<double> posterior = new List<double>();

            for (int i = 0; i < prior.Count; i++)
            {
                int hit = observation.CompareTo(world[i]); // 相同为0，否则为1或-1
                q.Add(pHit * (1 - hit * hit) + pMiss * hit * hit);
                tPosterior.Add(prior[i] * q[i]);
            }
            for (int i = 0; i < prior.Count; i++)
            {
                posterior.Add(tPosterior[i] / tPosterior.Sum());
            }
            likelihood = q;
            return posterior;
        }
    }
}
