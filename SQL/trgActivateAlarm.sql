create or alter trigger trgActivateAlarm on MEASUREMENT
after insert
as

declare @tagId int 
declare @measurement float

declare @alarmIdHH int
declare @alarmIdH int
declare @alarmIdL int
declare @alarmIdLL int

declare @alarmlimitHH float
declare @alarmlimitH float
declare @alarmlimitL float
declare @alarmlimitLL float

declare @alarmName char(50)

select @tagId = TagId from inserted;

select @alarmName = 'High High';
select @alarmIdHH = (select AlarmId from ALARMCONFIGURATION where TagId = @tagId and AlarmId = (select AlarmId from ALARMLIST where AlarmName = @alarmname));
select @measurement = Measurement from inserted;
select @alarmlimitHH = (select AlarmLimit from ALARMCONFIGURATION where TagId = @tagId and AlarmId = @alarmIdHH);

select @alarmName = 'High';
select @alarmIdH = (select AlarmId from ALARMCONFIGURATION where TagId = @tagId and AlarmId = (select AlarmId from ALARMLIST where AlarmName = @alarmname));
select @measurement = Measurement from inserted;
select @alarmlimitH = (select AlarmLimit from ALARMCONFIGURATION where TagId = @tagId and AlarmId = @alarmIdH);

select @alarmName = 'Low Low';
select @alarmIdLL = (select AlarmId from ALARMCONFIGURATION where TagId = @tagId and AlarmId = (select AlarmId from ALARMLIST where AlarmName = @alarmname));
select @measurement = Measurement from inserted;
select @alarmlimitLL = (select AlarmLimit from ALARMCONFIGURATION where TagId = @tagId and AlarmId = @alarmIdLL);

select @alarmName = 'Low';
select @alarmIdL = (select AlarmId from ALARMCONFIGURATION where TagId = @tagId and AlarmId = (select AlarmId from ALARMLIST where AlarmName = @alarmname));
select @measurement = Measurement from inserted;
select @alarmlimitL = (select AlarmLimit from ALARMCONFIGURATION where TagId = @tagId and AlarmId = @alarmIdL);

begin
if @measurement > @alarmlimitHH
begin
	if (select top 1 AcknowledgedBy from ALARM where @alarmIdHH = AlarmId and TagId = @tagId order by AcknowledgedBy asc) is not NULL
	insert into ALARM (TagId, AlarmId, ActivationTime)
	values(@tagId, @alarmIdHH, CURRENT_TIMESTAMP);
end;

else if @measurement > @alarmlimitH
begin
	if (select top 1 AcknowledgedBy from ALARM where @alarmIdH = AlarmId and TagId = @tagId order by AcknowledgedBy asc) is not NULL
	insert into ALARM (TagId, AlarmId, ActivationTime)
	values(@tagId, @alarmIdH, CURRENT_TIMESTAMP);
end;

else if @measurement < @alarmlimitLL
begin
	if (select top 1 AcknowledgedBy from ALARM where @alarmIdLL = AlarmId and TagId = @tagId order by AcknowledgedBy asc) is not NULL
	insert into ALARM (TagId, AlarmId, ActivationTime)
	values(@tagId, @alarmIdLL, CURRENT_TIMESTAMP);
end;

else if @measurement < @alarmlimitL
begin
	if (select top 1 AcknowledgedBy from ALARM where @alarmIdL = AlarmId and TagId = @tagId order by AcknowledgedBy asc) is not NULL
	insert into ALARM (TagId, AlarmId, ActivationTime)
	values(@tagId, @alarmIdL, CURRENT_TIMESTAMP);
end;
end;

select * from ALARMCONFIGURATION

insert into MEASUREMENT
values(1, CURRENT_TIMESTAMP, 36, null, null)

insert into MEASUREMENT
values(1, CURRENT_TIMESTAMP, 33, null, null)

insert into MEASUREMENT
values(1, CURRENT_TIMESTAMP, 22, null, null)

insert into MEASUREMENT
values(1, CURRENT_TIMESTAMP, 18, null, null)

select * from ALARM order by ActivationTime desc

select top 100 * from MEASUREMENT order by measurementTimestamp desc

select * from viewAlarmList

delete from alarm

select * from ALARM
where TagId = 1 
order by AcknowledgedBy desc
offset 0 rows
fetch first 1 row

selec
select * from tag
where tagId = 1
order by tagId asc

update alarm
set AcknowledgeTime = CURRENT_TIMESTAMP,
AcknowledgedBy = 1
where TagId = 1

if (select top 1 AcknowledgedBy from ALARM where 1 = AlarmId and TagId = 1 order by AcknowledgedBy asc) is NULL
select * from alarmlist
