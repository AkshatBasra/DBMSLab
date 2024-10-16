create database if not exists BankDB;
use BankDB;

create table if not exists Branch(
BranchName varchar(30) primary key,
BranchCity varchar(20),
Assets int);

create table if not exists BankAccount(
AccNo int primary key,
BranchName varchar(30),
Balance int,
foreign key(BranchName) references Branch(BranchName));

create table if not exists BankCustomer(
CustomerName varchar(20) primary key,
CustomerStreet varchar(30),
CustomerCity varchar(20));

create table if not exists Depositer(
CustomerName varchar(20),
AccNo int,
foreign key(CustomerName) references BankCustomer(CustomerName),
foreign key(AccNo) references BankAccount(AccNo));

create table if not exists Loan(
LoanNumber int primary key,
BranchName varchar(30),
Amount int,
foreign key(BranchName) references Branch(BranchName));

insert into Branch values
("SBI_Chamrajpet", "Bangalore", 50000),
("SBI_ResidencyRoad", "Bangalore", 10000),
("SBI_ShivajiRoad", "Bombay", 20000),
("SBI_ParliamentRoad", "Delhi", 10000),
("SBI_Jantarmantar", "Delhi", 20000);

insert into BankAccount values
(1, "SBI_Chamrajpet", 2000),
(2, "SBI_ResidencyRoad", 5000),
(3, "SBI_ShivajiRoad", 6000),
(4, "SBI_ParliamentRoad", 9000),
(5, "SBI_Jantarmantar", 8000),
(6, "SBI_ShivajiRoad", 4000),
(8, "SBI_ResidencyRoad", 4000),
(9, "SBI_ParliamentRoad", 3000),
(10, "SBI_ResidencyRoad", 5000),
(11, "SBI_Jantarmantar", 2000);

insert into BankCustomer values
("Avinash", "Bull_Temple_Road", "Bangalore"),
("Dinesh", "Bannergatta_Road", "Bangalore"),
("Mohan", "NationalCollege_Road", "Bangalore"),
("Nikil", "Akbar_Road", "Delhi"),
("Ravi", "PrithviRaj", "Delhi");

insert into Depositer values
("Avinash", 1),
("Dinesh", 2),
("Nikil", 4),
("Ravi", 5),
("Avinash", 8),
("Nikil", 9),
("Dinesh", 10),
("Nikil", 11);

insert into Loan values
(1, "SBI_Chamrajpet", 1000),
(2, "SBI_ResidencyRoad", 2000),
(3, "SBI_ShivajiRoad", 3000),
(4, "SBI_ParliamentRoad", 4000),
(5, "SBI_Jantarmantar", 5000);

select BranchName, Assets / 100000 as "Assets in Lakhs" from Branch;

select CustomerName from Depositer where AccNo in 
(select AccNo from BankAccount where BranchName = "SBI_ResidencyRoad")
group by CustomerName having count(AccNo) > 1;

create view NetLoan as 
select BranchName, sum(Amount) as "Net Loan Amount" from Loan group by BranchName;
select * from NetLoan;
