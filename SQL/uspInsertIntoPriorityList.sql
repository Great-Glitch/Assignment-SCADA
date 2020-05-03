create or alter procedure uspInsertIntoPriorityList
@priorityLevel int, @priorityName char(20)
as

begin
Insert into PRIORITYLIST(PriorityLevel, PriorityName)
Values (@priorityLevel, @priorityName)
end;

exec uspInsertIntoPriorityList 1, 'High'
exec uspInsertIntoPriorityList 2, 'Medium'
exec uspInsertIntoPriorityList 3, 'Low'

select * from PRIORITYLIST