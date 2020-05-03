create procedure uspInsertIntoAlarmList
@alarmName char(50), @alarmType char(50), @alarmDescription char(100)
as
begin
Insert into ALARMLIST(AlarmName, AlarmType, AlarmDescription)
Values (@alarmName,@alarmType, @alarmDescription)
end;

exec uspInsertIntoAlarmList 'High', 'H', 'Warning: Measurement above limit'
exec uspInsertIntoAlarmList 'High High', 'HH', 'Alarm: Measurement above limit'
exec uspInsertIntoAlarmList 'Low', 'L', 'Warning: Measurement below limit'
exec uspInsertIntoAlarmList 'Low Low', 'LL', 'Alarm: Measurement below limit'

select * from ALARMLIST

update ALARMLIST
set AlarmName = 'Low Low' where AlarmId = 4