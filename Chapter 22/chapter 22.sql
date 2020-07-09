--inserting by using a subquery as a target
desc departments

select department_id , department_name
from departments
where department_id=10;


--insert into departments (department_id , department_name) values  (106,'Test D')

insert into 
(
select department_id , department_name
from departments
where department_id=10
)
values (106,'Test D');


select * from departments
where department_id=106;

----you can use with check option

insert into 
(
select department_id , department_name
from departments
where department_name like 'Test%'
with check option
)
values (107,'OP');

insert into 
(
select department_id , department_name
from departments
where department_name like 'Test%'
with check option
)
values (107,'Test d');

select * from departments
where department_id=107;

------------------------

--updating by using a subquery as a target

select employee_id,first_name, salary 
from employees
where department_id=20;

update
(
select employee_id,first_name, salary 
from employees
where department_id=20
)
set salary=salary+100;

select employee_id,first_name, salary 
from employees
where department_id=20;

--Deleting by using a subquery as a target

delete
(
select * from departments
where department_id=106
);

------------------------------------------------------------------------

--correlated update
drop table emp_copy;

create table emp_copy
as select * from employees;

select * from emp_copy;

update emp_copy
set salary=0;

commit;
select * from emp_copy;

update emp_copy e_copy
set salary=(select salary from employees e where e.employee_id=e_copy.employee_id);

select * from emp_copy;

--you have to be carfull when you use the correlated update
--in the prevous example the no of records are the same in both tables

insert into emp_copy(EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,HIRE_DATE,JOB_ID,SALARY)
values              (98989,'David','David','David',sysdate,'IT_PROG',9000);

select * from emp_copy
where EMPLOYEE_ID=98989;

--this statment is wrong now, because it will update all the rows
--the records that not match the conditions whill be set to null
update emp_copy e_copy
set salary=(select salary from employees e where e.employee_id=e_copy.employee_id);

select * from emp_copy;

rollback;

insert into emp_copy(EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,HIRE_DATE,JOB_ID,SALARY)
values              (98989,'David','David','David',sysdate,'IT_PROG',9000);

update emp_copy e_copy
set salary=(select salary from employees e where e.employee_id=e_copy.employee_id)
where exists (select 1 from employees e where e.employee_id=e_copy.employee_id)

select * from emp_copy
where EMPLOYEE_ID=98989;

---------------------------------------------------------

--correlated delete

delete from emp_copy
where exists (select 1 from employees e where e.employee_id=emp_copy.employee_id)

select * from emp_copy;
--------------------------------------------------------





