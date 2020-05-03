using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataLogger
{
    class AirHeater
    {
        List<double> uOld = new List<double>(100);
        private double td = 2;
        private double tc = 22;
        private double kh = 3.5;
        public double tenv = 21.5;
        int k = 0;
        double[] temperature = new double[5];
        private double[] u;
        public double Y { get; set; }
        public double U { get; set; }
        private double ts;

        public AirHeater(double ts)
        {
            this.ts = ts;
            InitControlSignal();
            this.Y = tenv;
        }
        /*
        public void Process(double u, double ts)
        {
            
            double y =0;
            double uNext;
            //uNext = uOld[uOld.Count];
            //y = 1 /td*(-Tout + (kh * u + tenv));
            for (int k = 0; k < temperature.Length-1; k++)
            {
                temperature[k + 1] = temperature[k] + ts * (1 / tc) * ((tenv - temperature[k]) + kh * u);
                Y = temperature[k + 1];
            }

            
           
        }*/
        public void Process(double u, double oldY)
        {
            U = TimeDelay(u);
            Y = oldY + ts * (1 / tc) * ((tenv - oldY) + kh * U);
        }
        private double TimeDelay(double uIn)
        {
            double currentU;

            currentU = u.Last();
            for (int i = 0; i < u.Length-1; i++)
            {
                u[i + 1] = u[i];
            }
            u[0] = uIn;
            return currentU;
        }
        public int DelayArrayLength(double ts, double td)
        {
            int length;

            length = Convert.ToInt32(td / ts);

            return length;

        }
        public void InitControlSignal()
        {
            u = new double[DelayArrayLength(this.ts, this.td)];
            for (int i = 0; i < u.Length; i++)
            {
                u[i] = 0;
            }
        }
            
}
}
