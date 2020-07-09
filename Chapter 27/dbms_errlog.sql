select employee_id , first_name||' '||last_name name
from employees


create table emp_c
( employee_id number,
 ename varchar2(15)
 );
 
insert into emp_c
select employee_id , first_name||' '||last_name name
from employees


---the solution
exec dbms_errlog.create_error_log('emp_c');


desc err$_emp_c


insert into emp_c
select employee_id , first_name||' '||last_name name
from hr.employees
log errors reject limit unlimited;

select * from err$_emp_c