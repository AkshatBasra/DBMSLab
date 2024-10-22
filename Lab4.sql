use BankDB;

select CustomerName from Depositer where AccNo in (select AccNo from BankAccount where BranchName in (select BranchName from Branch where BranchCity = "Delhi"));

select CustomerName from Depositer where AccNo in (select AccNo from BankAccount where BranchName = "SBI_ParliamentRoad");

select BranchName from Branch where BranchCity = "Delhi";

select CustomerName from Depositer d, BankAccount a where d.AccNo = a.AccNo 
and BranchName in (select BranchName from Branch where BranchCity = "Delhi");

select CustomerName from Depositer where AccNo in (select AccNo from BankAccount a, Branch b where a.BranchName = b.BranchName and BranchCity = "Delhi");

select CustomerName from Depositer where AccNo in (4, 9, 11);

select CustomerName from Depositer d, BankAccount b where d.AccNo = b.AccNo and BranchName in (select BranchName from Branch where BranchCity = "Delhi");

select distinct 
  CustomerName
from 
  Depositer d 
where 
  not exists (
    (select BranchName from Branch where BranchName = 'Delhi') 
    except
    (select BranchName from BankAccount b where d.AccNo = b.AccNo)
  );

select * from Depositer;
select * from BankAccount;

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
);

select BranchName from Branch where Assets >all (select Assets from Branch where BranchCity = "Bangalore");

-- delete from BankAccount where BranchName = (select BranchName from Branch where BranchCity = "Bombay");

update BankAccount set Balance = Balance *(105/100);

