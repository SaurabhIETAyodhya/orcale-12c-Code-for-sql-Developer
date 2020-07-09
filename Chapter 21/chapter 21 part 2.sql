--scalar subquery
--it is a subquery that return exactly one column value from one row

select employee_id, first_name,last_name, salary ,(select max(salary) from employees) max_sal
from
employees;

--we want to display the department name also in the query using subquery
--it is scalar subquery
-- and in same time it is called correlated subquery
--correlated subquery,  the subquery refernces a column in the parent query
select employee_id, first_name,last_name, department_id,
  (select department_name from departments b where b.department_id=e.department_id ) dept_name
from
employees e ;


select employee_id, first_name,last_name, department_id,
nvl( (select department_name from departments b where b.department_id=e.department_id ),'no dept') dept_name
from
employees e ;


--another example for correlated subquery
--find the employees who earn more than the average salary in their departments

select department_id, avg(salary) 
from
employees
group by department_id;

select * from employees
where department_id = 100
and salary>8609

select employee_id, first_name,last_name, department_id, salary
from 
employees e
where salary > (select ROUND(avg(salary)) from employees c where c.department_id=e.department_id )
order by department_id;

select employee_id, first_name,last_name, department_id, salary,
    (select ROUND(avg(salary))  from employees R where R.department_id=e.department_id ) AVG_SAL
from 
employees e
where salary > (select ROUND(avg(salary)) from employees c where c.department_id=e.department_id )
order by department_id;

--------------------------------------------
--exists and not exists

--display all the departments that have employees
select * from departments d
where exists (select 1 from employees e where e.department_id=d.department_id)

select * from departments d
where department_id in  (select department_id from employees e)

--display all the departments that have no employees
select * from departments d
where not exists (select 1 from employees e where e.department_id=d.department_id)

--when we have null values, then the not in return zero records
select * from departments d
where department_id not in  (select department_id from employees e)

