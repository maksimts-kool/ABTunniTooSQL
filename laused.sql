--1. Käivita iga lause SQL Serveris
--2. Kommenteeri neid antud failis
--3. Tee uus branch iga SQL lausete teemade kohta
--3a. Tee Git commit iga SQL lause kohta.
--4. pane tabelite screen'id ja/või SQL tulemused readme faili
--5. Moodlesse lisa oma repo public link

-- db loomine
create database Tarpv24

-- db kustutamine
DRop DataBASE Tarpv24

-- Tabeli Gender loomine
create table Gender
(
Id int NOT NULL primary key,
Gender nvarchar(10) not null
)

create table Person
(
Id int not null primary key,
Name nvarchar(25),
Email nvarchar(30),
GenderId int
)

--- andmete sisestamine tabelisse
insert into Gender (Id, Gender)
values (1, 'Female')
insert into Gender (Id, Gender)
values (2, 'Male')

--- lisab välisvõtme piirangu nimega tblPerson_GenderId_FK tabelile Person
alter table Person add constraint tblPerson_GenderId_FK
foreign key (GenderId) references Gender(Id)

-- sisestab 7 uut kirjet Person tabelisse
insert into Person (Id, Name, Email, GenderId)
values (1, 'Supermees', 's@s.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (2, 'Wonderwoman', 'w@w.com', 1)
insert into Person (Id, Name, Email, GenderId)
values (3, 'Batman', 'b@b.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (4, 'Aquaman', 'a@a.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (5, 'Catwoman', 'c@c.com', 1)
insert into Person (Id, Name, Email, GenderId)
values (6, 'Antman', 'ant"ant.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (7, 'Spiderman', 'spider@spiderman.com', 2)

-- vaatame tabeli andmeid
select * from Person

--- eemaldab välisvõtme piirangu
alter table Person
drop constraint tblPerson_GenderId_FK

-- lisab uue kirje tabelisse Gender
insert into Gender (Id, Gender)
values (3, 'Unknown')
-- lisame võõrvõtme uuesti
alter table Person
add constraint DF_Person_GenderId
default 3 for GenderId


select * from Person
select * from Gender

insert into Person (Id, Name, Email)
values (8, 'Test', 'Test')

--  lisab uue veeru nimega Age tabelisse Person
alter table Person
add Age nvarchar(10)

--uuendame andmeid
update Person
set Age = 149
where Id = 8

-- lisab Person tabelile vanusele, mis tagab, et vanus on vahemikus 1 kuni 149
alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 150)

insert into Person (Id, Name, Email, GenderId, Age)
values (9, 'Test', 'Test', 2, 160)

-- esmalt kuvab kõik isikud, siis kustutab isiku ID-ga 8 ja lõpuks kuvab uuesti kõik isikud, et näha muudatust.
select * from Person
go
delete from Person where Id = 8
go
select * from Person

--- lisame veeru juurde
alter table Person
add City nvarchar(25)

-- valib kõik kirjed Person tabelist, kus City väärtus on 'Gotham'.
select * from Person where City = 'Gotham'


-- kõik, kes ei ela Gothamis
select * from Person where City <> 'Gotham'
select * from Person where City != 'Gotham'

-- otsivad isikuid, kes on kas 20, 50 või 100 aastat vanad
select *from Person where Age = 100 or 
Age = 50 or Age = 20
select * from Person where Age in (100, 50, 20)


-- leiab kõik isikud, kelle linna nimi algab tähega "n"
-- kontrollib, kas isikul on e-posti aadressis '@' märk
select * from Person where City like 'n%'
select * from Person where Email like '%@%'

-- leiab need, kellel seda pole
select * from Person where Email not like '%@%'

--- näitab, kelle on emailis ees ja peale @-märki
-- ainult üks täht
select * from Person where Email like '_@_.com'

-- otsib isikuid, kelle nimi EI alga tähtedega W, A ega S, kasutades erilist sümbolit [^]
select * from Person where Name like '[^WAS]%'
--- filtreerib isikud, kes elavad kas Gothamis või New Yorgis JA on vähemalt 40-aastased
select * from Person where (City = 'Gotham' or City = 'New York')
and Age >= 40

---võtab kolm esimest rida
select top 3 * from Person

--- Näitab kõiki veerge ja ridu Person tabelis
-- Näitab ainult vanuse ja nime veerud, piirates tulemuse 3 kirjega
select * from Person
select top 3 Age, Name from Person

-- Näitab 50 top kirjetest Person tabelist
select top 50 percent * from Person
-- Teisendab vanuse arvuks enne sorteerimist
-- Sorteerib otse vanuse veeru järgi
select * from Person order by cast(Age as int)
select * from Person order by Age

-- Arvutab kõikide isikute vanuste summa
select sum(cast(Age as int)) from Person

-- Leiab kõige väiksema vanuse
select min(cast(Age as int)) from Person

-- Leiab kõige suurema vanuse
select max(cast(Age as int)) from Person

select City, sum(cast(Age as int)) as TotalAge from Person group by City


--- loome uued tabelid
create table Department
(
Id int primary key,
DepartmentName nvarchar(50),
Location nvarchar(50),
DepartmentHead nvarchar(50)
)

create table Employees
(
Id int primary key,
Name nvarchar(50),
Gender nvarchar(10),
Salary nvarchar(50),
DepartmentId int
)

-- Andmete sisestamine osakondadesse ja töötajatesse
insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (1, 'IT', 'London', 'Rick')
insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (2, 'Payroll', 'Delhi', 'Ron')
insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (3, 'HR', 'New York', 'Christie')
insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (4, 'Other Deparment', 'Sydney', 'Cindrella')

select * from Department

insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (1, 'Tom', 'Male', 4000, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (2, 'Pam', 'Female', 3000, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (3, 'John', 'Male', 3500, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (4, 'Sam', 'Male', 4500, 2)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (5, 'Todd', 'Male', 2800, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (6, 'Ben', 'Male', 7000, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (7, 'Sara', 'Female', 4800, 3)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (8, 'Valarie', 'Female', 5500, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (9, 'James', 'Male', 6500, NULL)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (10, 'Russell', 'Male', 8800, NULL)

select * from Employees

-- Näitab ainult unikaalseid nime ja osakonna ID kombinatsioone
select distinct Name, DepartmentId from Employees

-- Arvutab kõigi töötajate kogupalga
select sum(cast(Salary as int)) from Employees
-- Leiab väikseima palga
select min(cast(Salary as int)) from Employees


alter table Employees
add City nvarchar(25)


alter table Employees
add DepartmentId
int null


-- lisab uue veeru nimega MiddleName tabelisse Employees
alter table Employees
add MiddleName nvarchar(30)

alter table Employees
add LastName nvarchar(30)

update Employees set FirstName = 'Tom', MiddleName = 'Nick', LastName = 'Jones'
where Id = 1
update Employees set FirstName = 'Pam', MiddleName = NULL, LastName = 'Anderson'
where Id = 2
update Employees set FirstName = 'John', MiddleName = NULL, LastName = NULL
where Id = 3
update Employees set FirstName = 'Sam', MiddleName = NULL, LastName = 'Smith'
where Id = 4
update Employees set FirstName = NULL, MiddleName = 'Todd', LastName = 'Someone'
where Id = 5
update Employees set FirstName = 'Ben', MiddleName = 'Ten', LastName = 'Sven'
where Id = 6
update Employees set FirstName = 'Sara', MiddleName = NULL, LastName = 'Connor'
where Id = 7
update Employees set FirstName = 'Valarie', MiddleName = 'Balerine', LastName = NULL
where Id = 8
update Employees set FirstName = 'James', MiddleName = '007', LastName = 'Bond'
where Id = 9
update Employees set FirstName = NULL, MiddleName = NULL, LastName = 'Crowe'
where Id = 10


--- igast reast võtab esimeses veerus täidetud lahtri ja kuvab ainult seda
select Id, coalesce(FirstName, MiddleName, LastName) as Name
from Employees

select * from Employees
select * from Department