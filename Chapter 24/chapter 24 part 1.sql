-- using the explicit  default value in insert or update statement

drop table emp_default;

create table emp_default
(empno number,
 ename varchar2(100),
 status varchar2(100) default 'Active'
 );
 
-- If you didn’t mention the column in the insert, it will take the default value
insert into emp_default(empno,ename)
values (1,'David');
 
select * from emp_default;

--you can mention the column in the insert and in the same time take the default

insert into emp_default(empno,ename,status)
values (2,'Lara',default);

select * from emp_default;

insert into emp_default(empno,ename,status)
values (3,'karem',null);

select * from emp_default;

update emp_default
set status=default
where empno=3;

select * from emp_default;
--------------------------------------------------------------------------------------------------

--copy rows from another table
insert into emp_default(empno,ename)
select employee_id, first_name
from
employees
where department_id = 90;

select * from emp_default;

insert into emp_default(empno,ename)
select employee_id, first_name
from
employees
where department_id = 30;

select * from emp_default;

insert into emp_default(empno,ename)
select employee_id, first_name
from
employees
where department_id = 70
union all
select employee_id, first_name
from
employees
where department_id = 80

select * from emp_default;
------------------------------------------------------------------------------------------------------

--1 unconditional insert

select employee_id, hire_date,salary, manager_id
from employees


drop table sal_hist;

create table sal_hist
( empid number,
  hiredate date,
  salary number );
  
drop table manager_hist;

create table manager_hist
( empid number,
  hiredate date,
  mgr number 
);

insert all
into sal_hist (empid,hiredate,salary ) values (employee_id,hire_date,salary)
into manager_hist(empid,hiredate,mgr) values (employee_id,hire_date,manager_id)
select employee_id, hire_date,salary, manager_id
from employees


select * from sal_hist;

select * from manager_hist;

delete from sal_hist;

delete from manager_hist;

commit;

--------------------------------------------------------------------------------
--2 conditional insert
insert all
when salary >9000 then
into sal_hist (empid,hiredate,salary ) values (employee_id,hire_date,salary)
when manager_id is not null  then
into manager_hist(empid,hiredate,mgr) values (employee_id,hire_date,manager_id)
select employee_id, hire_date,salary, manager_id
from employees;

select * from sal_hist;

select * from manager_hist;

select empid from sal_hist
INTERSECT
select empid from manager_hist

delete from sal_hist;

delete from manager_hist;



commit;
-------------------------------------------------------------------------------

--3 insert first
-- when the first condition is met then it skip the condition in when clause and not look on it
insert first
when salary >6000 then
into sal_hist (empid,hiredate,salary ) values (employee_id,hire_date,salary)
when manager_id is not null  then
into manager_hist(empid,hiredate,mgr) values (employee_id,hire_date,manager_id)
select employee_id, hire_date,salary, manager_id
from employees;

select * from sal_hist;

select * from manager_hist;

select empid from sal_hist
INTERSECT
select empid from manager_hist
-----------------------------------------------------------------------------

 

 
 
 
