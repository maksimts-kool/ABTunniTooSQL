--1. Käivita iga lause SQL Serveris
--2. Kommenteeri neid antud failis
--3. Tee uus branch iga SQL lausete teemade kohta
--3a. Tee Git commit iga SQL lause kohta.
--4. pane tabelite screen'id ja/või SQL tulemused readme faili
--5. Moodlesse lisa oma repo public link

-- db loomine
create database Tarpv24

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
-- vaatame tabeli andmeid
select * from Person
select * from Gender

-- esmalt kuvab kõik isikud, siis kustutab isiku ID-ga 8 ja lõpuks kuvab uuesti kõik isikud, et näha muudatust.
select * from Person
go
delete from Person where Id = 8
go
select * from Person

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

select * from Department
select * from Employees

-- Näitab ainult unikaalseid nime ja osakonna ID kombinatsioone
select distinct Name, DepartmentId from Employees

-- Arvutab kõigi töötajate kogupalga
select sum(cast(Salary as int)) from Employees
-- Leiab väikseima palga
select min(cast(Salary as int)) from Employees

--- igast reast võtab esimeses veerus täidetud lahtri ja kuvab ainult seda
select Id, coalesce(FirstName, MiddleName, LastName) as Name
from Employees