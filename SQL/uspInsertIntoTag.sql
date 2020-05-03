--Lage stored procedure med parametre
create procedure uspInserIntoTag
@tagname char(15), @measInterval int, @tagunit char(15), @itemId char(50), @itemURL char(100), @tagDescription char(100)
as

begin
Insert into TAG (TagName, MeasurementInterval, TagUnit, ItemId, ItemUrl, TagDescription)
Values (@tagname, @measInterval, @tagunit, @itemId, @itemURL, @tagDescription)
end;

exec uspInserIntoTag @tagname = 'TC-01', @measInterval = 1, @tagunit = 'Celsius', @itemId = NULL, @itemURL = NULL, @tagDescription = 'Temperature sensor on air heater'
exec uspInserIntoTag @tagname = 'PID.U', @measInterval = 1, @tagunit = 'Voltage', @itemId = NULL, @itemURL = NULL, @tagDescription = 'Control signal for the air heater'

select * from TAG
