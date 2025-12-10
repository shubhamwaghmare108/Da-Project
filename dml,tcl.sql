use b06;
show tables;
select * from studentrd;

alter table studentrd
drop column state,
drop column city;

rename table studentrd to student;
alter table student
add column city varchar(10) first,
add column state varchar(15) after city;

select * from student;

alter table student
modify stuid int first,
modify studentname varchar(15) after stuid,
modify mobno varchar(10) after studentname,
modify city varchar(10) after mobno,
modify state varchar(15) after city;

select * from student;

alter table student
rename column mobno to phonenumber;

desc student;

drop table student;
show tables;
show databases;

drop database b06;


create database b06;
use b06;

create table student(
stuid int,
stuname varchar(20),
city varchar(10),
state varchar(5));

insert into student values
(1,"shubham","nagpur","maharastra"),
(2,"shubham","nagpur","maharastra"),
(3,"shubham","nagpur","maharastra"),
(4,"shubham","nagpur","maharastra");

alter table student
modify column state varchar(20);

select count(*) from student;
select * from student;

alter table student
modify column state varchar(10);

alter table student
modify column state int;

alter table student
modify column stuid varchar(10);
select * from student;
desc student;

alter table student
modify column stuid int;
desc student;

insert into student values
(1,"shubham","nagpur","maharastra"),
(2,"shubham","nagpur","maharastra"),
(3,"shubham","nagpur","maharastra"),
(4,"shubham","nagpur","maharastra");

insert into student(stuname,stuid,state)
values
("ptyr",6,"dfgh");
desc student;
select * from student;
insert into student(stuname,stuid,state)
values
(6,6,"dfgh");
select * from student;
desc student;
insert into student(stuname,stuid,state)
values
(6,'6adsf',"dfgh");

insert into student(stuname,stuid,state)
values
(6,6.32,"dfgh");
select * from student;
# type casting is possible if possible

insert into student(stuname,stuid,state)
values
(6,6.32,6,"dfgh");

select * from student;
start transaction;
set sql_safe_updates=0;
update student
set stuid=5;
select * from student;
rollback;
select * from student;

start transaction;
delete from student;
select * from student;
rollback;
select * from student;

start transaction;
update student
set stuname="vikas"
where stuid=1;
select * from student;
commit;
select * from student;

start transaction;
select count(*) from student;
delete from student
where stuid=1;
select count(*) from student;
savepoint s1;
delete from student
where stuid=6;
select count(*) from student;
savepoint s2;
select distinct(stuid) from student;
delete from student
where stuid=2;
select count(*) from student;
rollback to s2;
select count(*) from student;
rollback to s1;
select count(*) from student;
rollback to s2;
rollback;
select count(*) from student; 


