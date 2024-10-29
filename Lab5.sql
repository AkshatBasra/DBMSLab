create database if not exists EmployeeDB;
use EmployeeDB;

create table if not exists Dept(
DeptNo int,
DName varchar(20),
DLoc varchar(20),
primary key(DeptNo)
);

create table if not exists Employee(
EmpNo int,
EName varchar(20),
MGRNo int,
HireDate date,
Sal int,
DeptNo int,
primary key(EmpNo),
foreign key(DeptNo) references Dept(DeptNo)
on update cascade on delete cascade
);

create table if not exists Incentives(
EmpNo int,
IncentiveDate date,
IncentiveAmount int,
primary key(IncentiveDate),
foreign key(EmpNo) references Employee(EmpNo)
on update cascade on delete cascade
);

create table if not exists Project(
PNo int,
PLoc varchar(20),
PName varchar(10),
primary key(PNo)
);

create table if not exists AssignedTo(
EmpNo int,
PNo int,
JobRole varchar(10),
foreign key(EmpNo) references Employee(EmpNo)
on update cascade on delete cascade,
foreign key(PNo) references Project(PNo)
on update cascade on delete cascade
);

insert into Dept values
(10, "CSE", "4th Floor PJ"),
(11, "ISE", "5th Floor PJ"),
(12, "ECE", "3rd Floor PJ"),
(13, "ME", "Mech Block"),
(14, "EEE", "6th floor PG");

insert into Employee values
(1, "A", NULL, "2000-05-16", 10000, 10),
(2, "B", 1, "2000-08-25", 2000, 10),
(3, "C", 1, "2008-06-18", 3000, 12),
(4, "D", NULL, "2004-10-28", 2000, 11),
(5, "E", 4, "2004-10-30", 3000, 11);

insert into Incentives values
(1, "2020-06-18", 1000),
(2, "2020-10-06", 2000),
(3, "2020-05-20", 3000),
(4, "2020-08-19", 2000),
(5, "2020-08-16", 1000);

insert into Project values
(101, "Bengaluru", "AB"),
(102, "Bengaluru", "CD"),
(103, "Hyderabad", "EF"),
(104, "Mysuru", "GH"),
(105, "Delhi", "IJ"),
(106, "Hyderabad", "KL"),
(107, "Noida", "MN");

insert into AssignedTo values
(1, 102, "Manager"),
(3, 103, "Analyst"),
(2, 104, "Member"),
(4, 105, "Manager"),
(5, 106, "Manager");

select EmpNo from AssignedTo 
where PNo in (
select PNo from Project
where PLoc in("Bengaluru", "Hyderabad", "Mysuru")
);

select EmpNo from Employee e where not exists(
select * from Incentives i where e.EmpNo = i.EmpNo
);

select e.EmpNo, EName, DName, JobRole, DLoc, PLoc from Employee e, Dept d, AssignedTo a, Project p
where e.DeptNo = d.Deptno and e.EmpNo = a.EmpNo and a.PNo = p.PNo;
