using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AirHeaterProcess
{
    class LowPassFilter
    {
        public double timestep { get; set; }
        public double filterTimeConst { get; set; }
        private double a { get; set; }
        public double filteredVal;
        



        public LowPassFilter(double timestep, double filterTimeConst, double init)
        {
            this.timestep = timestep;
            this.filterTimeConst = filterTimeConst;
            a = timestep / (filterTimeConst + timestep);
            filteredVal = init;
        }
        /*
        public void SimulateLowPass(int length, double init, double filterTimeConst)
        {
            int noOfIt = Convert.ToInt32(length / timestep);
            val = new double[noOfIt];
            time = new double[noOfIt];
            val[0] = init;
            for (int i = 1; i < noOfIt; i++)
            {
                val[i] = Math.Cos(Convert.ToDouble(i) / 2);
                time[i] = Convert.ToDouble(i) * Convert.ToDouble(timestep);
            }


            filteredVal = new double[noOfIt];
            double a = timestep / (filterTimeConst + timestep);

            filteredVal[0] = init;
            for (int i = 1; i < noOfIt; i++)
            {
                filteredVal[i] = (1 - a) * filteredVal[i - 1] + a * val[i];
            }
        }*/
        public void Filtering(double rawVal)
        {
            a = timestep / (filterTimeConst + timestep);
            filteredVal = (1 - a) * filteredVal + a * rawVal;
        }

    }
}
