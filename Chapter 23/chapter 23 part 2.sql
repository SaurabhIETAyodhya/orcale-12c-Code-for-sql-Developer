--the user demo can know his privileges by using this query
select * from session_privs;

--now if he have create table privileges then he can insert,update,delete, 
--select, alter, index on any table he create

create table emp
( empid number constraint emp_pk primary key,
  ename varchar2(100)
);

insert into emp values (1,'khaled');

select * from emp;

alter table emp
add (salary number);

select * from emp;


create sequence emp_s;

--he can create index for the table he create 
create index ename_ind on emp (ename);


create or replace view emp_v
as
select empid, ename
from emp;

--now the user demo he want to change his password , because the dba create for 
--his default password demo1234

alter user demo identified by demo_green;


select * from hr.employees;

--the demo user can make select * from employees without hr. only if there is public syonym for hr.employees

select * from all_synonyms
where table_name='EMPLOYEES'


update hr.employees
set department_id =null
where employee_id=1;

update hr.employees
set salary =500
where employee_id=1;



select * from session_privs;

select * from user_sys_privs;


select * from user_tab_privs_recd
order by 2;

select * from user_col_privs_recd;

grant select on emp to hr;

select * from user_tab_privs_made;

grant update (ename) on emp to hr;

select * from user_col_privs_made;
