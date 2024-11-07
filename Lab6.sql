use EmployeeDB;

create view managerinfo as
select MGRNo, count(MGRNo) as mcount, avg(sal) as avgsal from Employee group by MGRNo;

select EName from Employee where EmpNo in (
select MGRNo from managerinfo where mcount = (
select max(mcount) from managerinfo
));

select * from Employee;

select EName from Employee where EmpNo in (
select MGRNo from Employee e where sal > (
select avgsal from managerinfo m where e.MGRNo = m.MGRNo
));

select Ename from Employee where Hiredate = (
select min(HireDate) from Employee where HireDate > (
select min(HireDate) from Employee
));

select e.EmpNo, EName, Sal from Employee e, Incentives i where e.EmpNo = i.EmpNo and IncentiveAmount = (
select max(IncentiveAmount) from Incentives where IncentiveDate between "2019-01-31" and "2019-01-01" and IncentiveAmount < (
select max(IncentiveAmount) from Incentives where IncentiveDate between "2019-01-31" and "2019-01-01"
));

select e.EmpNo, e.EName from Employee e, Employee m
where e.EmpNo = m.MGRNo and e.DeptNo = m.DeptNo;
