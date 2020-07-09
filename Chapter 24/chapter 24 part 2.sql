drop table emp_sales;

create table emp_sales
( emp_id number,
  week_id number,
  sales_sun number,
  sales_mon number,
  sales_tue number,
  sales_wed number,
  sales_thur number
);

insert into emp_sales values (1,14,2000,3000,4000,2500,1500);

select * from emp_sales;

drop table sales_info;

create table sales_info
( emp_id number,
  week_id number,
  sales number,
  day varchar2(10)
);

select * from sales_info;

insert all
into sales_info VALUES (emp_id,week_id,sales_sun,'SUN')
into sales_info VALUES (emp_id,week_id,sales_MON,'MON')
into sales_info VALUES (emp_id,week_id,sales_tue,'TUE')
into sales_info VALUES (emp_id,week_id,sales_wed,'WED')
into sales_info VALUES (emp_id,week_id,sales_thur,'THUR')
select 
emp_id ,week_id ,sales_sun ,sales_mon ,sales_tue ,sales_wed ,sales_thur 
FROM
emp_sales;

SELECT * FROM sales_info;

-------------------------------------------------
--HOW TO create matrix report using PIVOT 
select  department_id, job_id, count(1)
from
employees
where job_id in ('MK_MAN','MK_REP','PU_CLERK','PU_MAN')
group by department_id,job_id
order by 1,2

--------------case 1 -------------------
select * from 
(
select   department_id, job_id
from
employees
where job_id in  ('MK_MAN','MK_REP','PU_CLERK','PU_MAN') 
)
pivot
(
count(1) for job_id in  ('MK_MAN','MK_REP','PU_CLERK','PU_MAN')
)
ORDER BY 1

--------------case 2------------------

select * from 
(
select   department_id, job_id
from
employees
)
pivot
(
count(1) for job_id in  ('MK_MAN','MK_REP','PU_CLERK','PU_MAN')
)
ORDER BY 1

-----------case 3---------subquery will not work
select * from 
(
select   department_id, job_id
from
employees
)
pivot
(
count(1) for job_id in  (select distinct job_id from employees)
)
ORDER BY 1

--------------
select * from 
(
select   department_id, job_id, hire_date
from
employees
where job_id in  ('MK_MAN','MK_REP','PU_CLERK','PU_MAN') --try to remove this line also
)
pivot
(
count(1) for job_id in  ('MK_MAN','MK_REP','PU_CLERK','PU_MAN')
)
ORDER BY 1



----------------------------------------------------------
/*
SELECT * FROM
(
  SELECT column1, column2
  FROM tables
  WHERE conditions
)
PIVOT 
(
  aggregate_function(column2)
  FOR column2
  IN ( expr1, expr2, ... expr_n) 
)
ORDER BY expression
*/

