--Lager view for Measurement og statestikk
create view vTag as

select MEASUREMENT.TagId, MEASUREMENT.MeasurementTimestamp, MEASUREMENT.Measurement, ms.MeanVal, ms.MinVal, ms.MaxVal
from Measurement Inner join MEASUREMENTSTATISTIC AS ms
on MEASUREMENT.MeasurementTimestamp = ms.MeasurementTimestamp
where MEASUREMENT.MeasurementTimestamp = ms.MeasurementTimestamp


select MeasurementTimestamp, Measurement, MeanVal, MinVal, MaxVal from vTag
where TagId = 1
order by Measurement desc

drop view vTag