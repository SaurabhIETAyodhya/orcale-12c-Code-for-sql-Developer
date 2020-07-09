--- with clause
with emp
as
(
select employee_id,first_name from employees
)
select first_name
from emp;
------------------------

with emp
as
(
select employee_id,first_name ,department_id, salary from employees
),
dept_sum_sal
as
(select department_id, sum(salary) sum_sal
from emp
group by department_id
)
select * from dept_sum_sal;

--display each department_name, and count for the employees
select department_id,count(1)
from 
employees
group by department_id;


select department_name, cnt
from
departments dept,
    (select department_id,count(1) cnt
    from 
    employees
    group by department_id) dept_count
where dept.department_id=dept_count.department_id;

with dept_count
as
    (select department_id,count(1) cnt
    from 
    employees
    group by department_id)
select department_name, cnt
from departments ,dept_count
where departments.department_id=dept_count.department_id





--example2
/*  write a query to display the department name and total salaries for the departments
but only for those departments whos toal salaries is greater than  average salary across departments
*/

select department_name ,sum(salary) sum_sal
from
employees e
join
departments d
on ( e.department_id=d.department_id)
group by department_name


select sum(tot_salaries)/count(*)
from 
(
select department_name ,sum(salary) tot_salaries
from
employees e
join
departments d
on ( e.department_id=d.department_id)
group by department_name
)

select department_name ,sum(salary) sum_sal
from
employees e
join
departments d
on ( e.department_id=d.department_id)
group by department_name
having sum(salary) > (select sum(tot_salaries)/count(*)
                        from 
                                (
                                select department_name ,sum(salary) tot_salaries
                                from
                                employees e
                                join
                                departments d
                                on ( e.department_id=d.department_id)
                                group by department_name
                                )
                        )
                        
with 
dept_costs as
(
select department_name ,sum(salary) sum_sal
from
employees e
join
departments d
on ( e.department_id=d.department_id)
group by department_name
),
avg_cost as
(
select sum(sum_sal)/count(*) dept_avg
from dept_costs
)
select  * from dept_costs
where sum_sal> (select dept_avg  from  avg_cost )

---http://www.experts-exchange.com/articles/2375/Subquery-Factoring-WITH-Oracle.html

