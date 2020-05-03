using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace Alarmsystem.Models
{
    public class AlarmSystem
    {
        public List<Alarm> alarmList = new List<Alarm>();
        private SqlDatabase database; 
        private string connectionString;
        public Alarm alarm = new Alarm();
        public AlarmSystem(string connectionString)
        {
            this.connectionString = connectionString;
        }

        public void GetAlarms()
        {
            string sqlQuery = "Select top 20 * from vActivatedAlarms order by AcknowledgeTime asc, activationTime desc";
            database = new SqlDatabase(connectionString);
            database.OpenConnection();
            object[,] values = database.View(sqlQuery);

            for (int i = 1; i < values.GetLength(0); i++)
            {
                

                Alarm alarmData = new Alarm();
                alarmData.AlarmId = Convert.ToInt32(values[0,i]);
                alarmData.TagId = Convert.ToInt32(values[1, i]);
                alarmData.ActivationTime = Convert.ToDateTime(values[2, i]);
                try
                {
                    alarmData.AcknowledgeTime = Convert.ToDateTime(values[3, i]);
                }
                catch (Exception ex)
                {

                }
                alarmData.AlarmName = Convert.ToString(values[4, i]);
                alarmData.AlarmType = Convert.ToString(values[5, i]);
                alarmData.AlarmDescription = Convert.ToString(values[6, i]);
                alarmData.TagName = Convert.ToString(values[7, i]);
                alarmData.TagUnit = Convert.ToString(values[8, i]);
                alarmData.TagDescription = Convert.ToString(values[9, i]);
                alarmData.AlarmLimit = Convert.ToDouble(values[10, i]);
                alarmData.Priority = Convert.ToString(values[11, i]);
                alarmData.AcknowledgdedBy = Convert.ToString(values[12, i]);

                alarmList.Add(alarmData);
                
            }

            database.CloseConnection();

        }
        public void AcknowledgeAlarm(int alarmId, int tagId, string activatedTime)
        {
            string sqlQuery = "uspAcknowledgeAlarm";
            database = new SqlDatabase(connectionString);
            database.OpenConnection();

            object[,] val = new object[2, 3];
            val[0, 0] = "@alarmId"; val[0, 1] = "@tagId"; val[0, 2] = "@activationTime";
            val[1, 0] = alarmId; val[1, 1] = tagId; val[1, 2] = activatedTime;

            database.RunProcedure(sqlQuery, val);

        }

    }
}
