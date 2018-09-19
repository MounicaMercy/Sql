create database DB
use DB
--created countries table
create table Countries(Id int primary key identity(1,1),Name varchar(50) not null)
--inserting values countries table
insert into Countries(Name) values ('USA')
insert into Countries(Name) values ('INDIA')
insert into Countries(Name) values ('SOUTH AFRICA')
--creating politicians table
CREATE TABLE Politicians(Id int not null,Name varchar(50))
--inserting values into politician table
insert into Politicians(Id,Name) values (1,'Gandhi')
--changed id as identity so no need to enter values of id 
insert into Politicians(Name) values ('Obama')
insert into Politicians(Name) values ('Mandela')
--adding a column to politicians and setting it as foriegn key
alter table Politicians add CountryId int

select * from Countries
select * from Politicians order by CountryId
select * from Politicians order by Id

--updating values of column country id in table politicians
update Politicians set CountryId=2 where Id=1
update Politicians set CountryId=1 where Id=2
update Politicians set CountryId=3 where Id=3
--using joins
select c.Id,c.Name,p.Name,p.CountryId from Politicians p join Countries c on c.Id=p.CountryId
insert into Politicians(Name,CountryId) values ('Modi',2)
insert into Politicians(Name) values ('Trump')
select p.Name,c.Name,p.CountryId from Politicians p Left join Countries c on c.Id=p.CountryId order by c.Id

update Politicians set CountryId=1 where Id=5
--Distinct keyword
select DISTINCT CountryId from Politicians
--where keyword
select CountryId,Name from Politicians where CountryId=2
select CountryId,Name from Politicians where CountryId=2 and Name='Modi'
select CountryId,Name from Politicians where CountryId=2 or CountryId=3
select CountryId,Name from Politicians where not CountryId=2

select * from Countries
select * from Politicians
select * from Portfolio
select * from IndexTable
insert into Portfolio(Name) values ('Railway Minister')
insert into Portfolio(Name) values ('External Affairs Minister')
insert into Portfolio(Name) values ('Human Resources Minister')
insert into Portfolio(Name) values ('Agriculture Minister')
insert into Portfolio(Name) values ('Food Security Minister')
alter table Portfolio drop column PoliticianId

select c.Id,c.Name,p.Id,p.NAME,po.Id,po.Name from
 Countries c join Politicians p on c.Id=p.CountryId
 join IndexTable I on p.Id=I.PoliticianId
 join Portfolio po on po.Id=I.PortfolioId