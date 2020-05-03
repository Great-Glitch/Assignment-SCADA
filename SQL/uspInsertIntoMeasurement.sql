--Lage stored procedure med parametre
create or alter procedure uspInsertIntoMeasurement
@tagname char(15), @value float, @status char(18), @quality char(18)
as
declare @TagId int
select @TagId = (select TagId from TAG where TagName = @tagname)
begin
Insert into MEASUREMENT (TagId, Measurement, MeasurementTimestamp, OPCStatus, OPCQuality)
Values (@TagId, @VALUE, CURRENT_TIMESTAMP, @status, @quality)
end;

EXEC uspInsertIntoMeasurement @tagname = 'TC-01', @value = 24, @status='Connected' @quality='Good'

select * from MEASUREMENT

SELECT * FROM MEASUREMENTSTATISTIC