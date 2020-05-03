--lag trigger after
CREATE trigger trgInsertStatistics on MEASUREMENT
after insert
as 

declare @Mean float
declare @Min float
declare @Max float
declare @TagId int
declare @timestamp datetime

select @TagId = TagId from INSERTED
select @timestamp = MeasurementTimestamp from INSERTED

select @Mean = (SELECT AVG(Measurement) from MEASUREMENT where TagId = @TagId)
Select @Min = (select MIN(Measurement) FROM MEASUREMENT)
select @Max = (select MAX(Measurement) FROM MEASUREMENT)
BEGIN
insert into MEASUREMENTSTATISTIC (TagId, MeasurementTimeStamp, MeanVal, MinVal, MaxVal)
values (@TagId, @timestamp, @Mean, @Min, @Max);
END;


select SUM(Measurement) 
OVER(Order by MeasurementTimestamp desc rows between 15 preceding and current row) as avg_value 
from MEASUREMENT where TagId = @TagId)
(select avg(Measurement) from MEASUREMENT
OVER(Order by MeasurementTimestamp desc rows between 15 preceding and current row) as avg_value 
from MEASUREMENT where TagId = 1)

select * from MEASUREMENT