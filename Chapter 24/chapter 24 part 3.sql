-- the Merge Statement
--in the this statemnet you can insert,update, delete a row conditionaly into a table
--it Avoid multiple DML statemnets
-- is is helpfull in warehouse applications
drop table table_a;
drop table table_b;

create table table_a
( id number,
  name varchar2(100)
);

insert into table_a values (1,'khaled');
insert into table_a values (2,'ali');
insert into table_a values (3,'ahmed');
commit;

select * from table_a;

create table table_b
( id number,
  name varchar2(100)
);

insert into table_b values (1,'xxxxx');
insert into table_b values (2,'xxxxx');
commit;

select * from table_b

merge into table_b b
using (select * from table_a) a
on ( b.id=a.id)
when matched then
update
set b.name=a.name
when not matched then
insert values (a.id, a.name );

commit;

select * from table_b;
---------------------------------------------------------------------------------------

select * from recyclebin
order by 2;

purge recyclebin;

select * from recyclebin;


create table emp_copy3
as
select * from employees;

select * from emp_copy3;

drop table emp_copy3;

select * from emp_copy3;


select * from recyclebin;

flashback  table emp_copy3 to before drop;

select * from emp_copy3;

select * from recyclebin;
---------------------------------------------------------------------------------------------------------------

select salary from 
employees
where employee_id=107;

update
employees
set salary=salary+100
where employee_id=107;

commit;

select salary from 
employees
where employee_id=107;


select salary from 
employees
versions between scn minvalue and maxvalue
where employee_id=107;

select versions_starttime,versions_endtime, salary from 
employees
versions between scn minvalue and maxvalue
where employee_id=107;

update
employees
set salary=salary+100
where employee_id=107;
commit;

select versions_starttime,versions_endtime, salary from 
employees
versions between scn minvalue and maxvalue
where employee_id=107;






