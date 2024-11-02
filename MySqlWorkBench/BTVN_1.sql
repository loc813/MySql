create database CompanyDB;
use CompanyDB;

create table Employees (
	EmployeeID int primary key auto_increment,
    FirstName varchar(100) not null,
    LastName varchar(100) not null, 
    HireDate date not null,
    Salary int not null
); 

alter table Employees 
add Department varchar(100) not null;

alter table Employees 
modify column Salary decimal(10,2) not null;