create procedure uspAcknowledgeAlarmtest
@activationTime datetime
as
begin
update ALARM

set 
 AcknowledgeTime = CURRENT_TIMESTAMP

where ActivationTime = @activationTime
end;
select * from ALARM
exec '2020-04-28 16:22:07.603'