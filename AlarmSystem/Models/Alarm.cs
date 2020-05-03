using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace Alarmsystem.Models
{
    public class Alarm
    {
        public string AlarmName { get; set; }
        public string AlarmType { get; set; }
        public int AlarmId { get; set; }
        public string AlarmDescription { get; set; }
        public string TagName { get; set; }
        public double AlarmLimit { get; set; }
        public DateTime ActivationTime { get; set; }
        public DateTime AcknowledgeTime { get; set; }
        public string Priority { get; set; }
        public int TagId { get; set; }
        public string AcknowledgdedBy { get; set; }
        public string TagUnit { get; internal set; }
        public string TagDescription { get; internal set; }
    }
}
