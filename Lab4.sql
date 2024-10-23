use BankDB;

select c.CustomerName from 
BankCustomer c join Depositer b on c.CustomerName = b.CustomerName 
join BankAccount a on b.AccNo = a.AccNo 
join Branch r on a.BranchName = r.BranchName
where BranchCity = "Delhi" 
group by c.CustomerName 
having count(distinct a.BranchName) = (
select count(*) from Branch where BranchCity = "Delhi");



create table if not exists Borrower(
CustomerName varchar(20),
LoanNumber int,
foreign key(CustomerName) references BankCustomer(CustomerName),
foreign key(LoanNumber) references Loan(LoanNumber)
);

insert into Borrower values
('Avinash', 1),
('Dinesh', 2),
('Mohan', 3),
('Nikil', 4),
('Ravi', 5);

select CustomerName from Borrower a where not exists(
select * from BankAccount b, Depositer d where b.AccNo = d.AccNo and d.CustomerName = a.CustomerName
);

select CustomerName from Borrower a where exists(
select * from BankAccount b, Depositer d where b.AccNo = d.AccNo and d.CustomerName = a.CustomerName
and BranchName in (select BranchName from Branch where BranchCity = "Bangalore")
);

select BranchName from Branch where Assets > all (select Assets from Branch where BranchCity = "Bangalore");

-- delete from BankAccount where BranchName = (select BranchName from Branch where BranchCity = "Bombay");

-- update BankAccount set Balance = Balance *(105/100);

