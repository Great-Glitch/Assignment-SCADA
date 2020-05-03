create or alter view vActivatedAlarms as

select a.AlarmId, a.TagId, a.ActivationTime, a.AcknowledgeTime,  
al.AlarmName, al.AlarmType, al.AlarmDescription, 
t.TagName, t.TagUnit, t.TagDescription, 
ac.AlarmLimit, pl.PriorityName,
o.FirstName
from ALARM as a 
inner join ALARMLIST as al on a.AlarmId = al.AlarmId
inner join TAG as t on a.TagId = t.TagId
inner join ALARMCONFIGURATION as ac on ac.AlarmId = a.AlarmId and ac.TagId = t.TagId
left join OPERATOR as o on a.AcknowledgedBy = o.OperatorId
left join PRIORITYLIST as pl on ac.PriorityLevel = pl.PriorityLevel

select * from vActivatedAlarms