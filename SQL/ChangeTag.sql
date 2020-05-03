create procedure uspChangeTag 
@tagname char(15), @interval int, @tagunit char(15)
as
begin
update TAG

set 
 MeasurementInterval = @interval,
 TagUnit = @tagunit
where TagId = (select TagId from tag where TagName = @tagname)
end;
select * from TAG
exec uspChangeTag 'TC-01', 2, '°F'