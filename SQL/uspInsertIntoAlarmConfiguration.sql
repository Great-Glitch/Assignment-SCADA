create procedure uspInsertIntoAlarmConfiguration
@tagname char(20), @alarmname char(50), @alarmLimit float, @priority char(20)
as
declare @TagId int,
@AlarmId int

select @TagId = (select TagId from TAG where TagName = @tagname)
select @AlarmId = (select AlarmId from ALARMLIST where AlarmName = @alarmname)

begin
Insert into ALARMCONFIGURATION(TagId, AlarmId, AlarmLimit, PriorityLevel)
Values (@TagId,@AlarmId, @alarmLimit, @priority)
end;

exec uspInsertIntoAlarmConfiguration 'TC-01', 'High High', 35, 1
exec uspInsertIntoAlarmConfiguration 'TC-01', 'High', 30, 2
exec uspInsertIntoAlarmConfiguration 'TC-01', 'Low', 24, 3
exec uspInsertIntoAlarmConfiguration 'TC-01', 'Low Low', 20, 1

select * from ALARMCONFIGURATION

