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

--- lisab välisvõtme piirangu nimega tblPerson_GenderId_FK tabelile Person
alter table Person add constraint tblPerson_GenderId_FK
foreign key (GenderId) references Gender(Id)

--- eemaldab välisvõtme piirangu
alter table Person
drop constraint tblPerson_GenderId_FK

-- lisame võõrvõtme uuesti
alter table Person
add constraint DF_Person_GenderId
default 3 for GenderId

--  lisab uue veeru nimega Age tabelisse Person
alter table Person
add Age nvarchar(10)

-- lisab Person tabelile vanusele, mis tagab, et vanus on vahemikus 1 kuni 149
alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 150)

--- lisame veeru juurde
alter table Person
add City nvarchar(25)

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