create database SupplierDB;
use SupplierDB;

create table if not exists Supplier(
SID int primary key,
SName varchar(20),
City varchar(10)
);

create table if not exists Parts(
PID int primary key,
PName varchar(20),
Color varchar(10)
);

create table if not exists Catalog(
SID int,
PID int,
Cost float,
foreign key(SID) references Supplier(SID),
foreign key(PID) references Parts(PID)
);

insert into Supplier values
(10001, "Acme Widget", "Bangalore"),
(10002, "Johns", "Kolkata"),
(10003, "Vimal", "Mumbai"),
(10004, "Reliance", "Delhi");

insert into Parts values
(20001, "Book", "Red"),
(20002, "Pen", "Red"),
(20003, "Pencil", "Green"),
(20004, "Mobile", "Green"),
(20005, "Charger", "Black");

insert into Catalog values
(10001, 20001, 10),
(10001, 20002, 10),
(10001, 20003, 30),
(10001, 20004, 10),
(10001, 20005, 10),
(10002, 20001, 10),
(10002, 20002, 20),
(10003, 20003, 30),
(10004, 20003, 40);

select * from Supplier s, Parts p, Catalog c where s.SID = c.SID and p.PID = c.PID;

select distinct PName from Parts p, Catalog c where p.PID = c.PID and exists (
select * from Parts p1 where p1.PID = c.PID
);

select SName from Supplier s where not exists (
select * from Parts p where not exists(
select * from Catalog c1 where c1.SID = s.SID and c1.PID = p.PID
));

/*select SID from Catalog c1 group by SID having count(PID) = (
select count(distinct c2.PID) from Catalog c2
);*/

/*select SID from Catalog c1 where PID in (
select PID from Parts where Color = "Red")
group by SID having count(PID) = (
select count(distinct c2.PID) from Catalog c2 where PID in (
select PID from Parts where Color = "Red")
);*/

select SName from Supplier s where not exists (
select * from Parts p where Color = "Red" and not exists(
select * from Catalog c1 where c1.SID = s.SID and c1.PID = p.PID
));

select PName from Supplier s, Parts p, Catalog c where s.SID = c.SID and p.PID = c.PID
group by c.PID
having count(c.PID) = 1;

select SName from Supplier where SID in (
select SID from Catalog c1 where Cost > (
select avg(Cost) from Catalog c2 where c1.SID = c2.SID group by SID
));

select SName, PName from Supplier s, Parts p, Catalog c1
where s.SID = c1.SID and p.PID = c1.PID
and Cost in (
select max(Cost) from Catalog c2
where c2.PID = c1.PID
);
