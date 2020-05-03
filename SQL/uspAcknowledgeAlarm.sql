create procedure uspAcknowledgeAlarm
@alarmId int, @tagId int, @activationTime datetime
as
begin
update ALARM

set 
 AcknowledgeTime = CURRENT_TIMESTAMP,
 AcknowledgedBy = (select OPERATORid from OPERATOR where UserName = CURRENT_USER)

where AlarmId = @alarmId and TagId = @tagId and LEFT(CONVERT(VARCHAR, ActivationTime, 120), 19) = @activationTime
end;

select * from ALARM order by AcknowledgedBy asc
exec uspAcknowledgeAlarm 2,1, '2020-05-01 13:17:21'