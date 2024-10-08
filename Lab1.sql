use InsuranceDB;

create table if not exists Person(
driver_id char(3) primary key,
name varchar(10),
address varchar(30));

create table if not exists Car(
reg_num char(8) primary key,
model varchar(10),
year int);

show tables;

create table if not exists Accident(
report_num int primary key,
accident_date date,
location varchar(30));

create table if not exists Owns(
driver_id char(3),
reg_num char(8),
foreign key(driver_id) references Person(driver_id),
foreign key(reg_num) references Car(reg_num));

create table if not exists Participated(
driver_id char(3),
reg_num char(8),
report_num int,
damage_amount int,
foreign key(driver_id) references Person(driver_id),
foreign key(reg_num) references Car(reg_num),
foreign key(report_num) references Accident(report_num));

desc Participated;

select * from Participated;

insert into Person values('A01','Richard','Srinivas Nagar'),
('A02','Pradeep','Rajaji Nagar'),
('A03','Smith','Ashok Nagar'),
('A04','Venu','NR Colony'),
('A05','John','Hanumanthnagar');

insert into Car values('KA052250','Indica',1990),
('KA031181','Lancer',1957),
('KA095447','Toyota',1998),
('KA053408','Honda',2008),
('KA041702','Audi',2005);

insert into Owns values('A01','KA052250'),
('A02','KA031181'),
('A03','KA095447'),
('A04','KA053408'),
('A05','KA041702');

insert into Accident values(11,'2003-01-01','Mysore Road'),
(12,'2004-02-02','South End Circle'),
(13,'2003-01-21','Bull Temple Road'),
(14,'2008-02-17','Mysore Road'),
(15,'2005-03-04','Kanakpura Road');

insert into Participated values('A01','KA052250',11,10000),
('A02','KA053408',12,50000),
('A03','KA095447',13,25000),
('A04','KA031181',14,3000),
('A05','KA041702',15,5000);

select accident_date,location from Accident;

update Participated set damage_amount = 25000 where report_num = 12;
select * from Participated;

select driver_id, damage_amount from Participated where damage_amount >= 25000;

select * from Car order by year;

select count(report_num) from Participated where reg_num in (select reg_num from Car where model = 'Lancer');

select count(distinct driver_id) from Participated,Accident where Participated.report_num = Accident.report_num and year(Accident.accident_date) = 2008;

select * from Participated order by damage_amount desc;

select avg(damage_amount) from Participated;

delete from Participated where damage_amount < (select avg(damage_amount) from Participated);
select * from Participated;

select name, damage_amount from Person,Participated where Person.driver_id = Participated.driver_id and damage_amount > (select avg(damage_amount) from Participated);

select max(damage_amount) from Participated;