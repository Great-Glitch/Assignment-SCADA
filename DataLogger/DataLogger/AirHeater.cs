using System.Collections.Generic;

namespace DataLogger
{
    class AirHeater
    {
        List<double> uOld = new List<double>(100);
        private double td = 2;
        private double tc = 22;
        private double kh = 3.5;
        private double tenv = 21.5;
        int k = 0;
        double[] temperature = new double[5];
        public double Y { get; set; }
        private double ts;

        public AirHeater(double ts)
        {
            this.ts = ts;
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
            Y = oldY + ts * (1 / tc) * ((tenv - oldY) + kh * u);
        }
    }
}
