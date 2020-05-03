--Lage stored procedure med parametre
create procedure uspInserIntoUnit
@unit char(15)
as

begin
Insert into UNIT (TagUnit)
Values (@unit)
end;

exec uspInserIntoUnit @unit='Voltage'
exec uspInserIntoUnit @unit='Celsius'
SELECT * FROM UNIT