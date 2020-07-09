
--1 nvl function

SELECT EMPLOYEE_ID, FIRST_NAME, COMMISSION_PCT, nvl(COMMISSION_PCT,0)
FROM EMPLOYEES;

SELECT EMPLOYEE_ID, FIRST_NAME, job_id, NVL(job_id,'No JOB Yet')
FROM EMPLOYEES

SELECT EMPLOYEE_ID, FIRST_NAME, hire_date, NVL(hire_date,'1-jan-03')
FROM EMPLOYEES;



--because COMMISSION_PCT is number, so if you want to display 'no comm', then you should use to_char
SELECT EMPLOYEE_ID, FIRST_NAME, COMMISSION_PCT, NVL(to_char(COMMISSION_PCT),'no comm')
FROM EMPLOYEES;

--2 using nvl2 function
--if exp1 is not null, then it return exp2
--if exp1 is  null, then it return exp3
SELECT EMPLOYEE_ID, FIRST_NAME, COMMISSION_PCT, NVL2(COMMISSION_PCT,COMMISSION_PCT,0)
FROM EMPLOYEES;

SELECT EMPLOYEE_ID, FIRST_NAME, COMMISSION_PCT, 
NVL2(COMMISSION_PCT,'sal and comm','only salary') income
FROM EMPLOYEES;



--3 using nullif
--if exp1=exp2 then it return null, else it return exp1

SELECT FIRST_NAME, LENGTH(FIRST_NAME), LAST_NAME, LENGTH(LAST_NAME),
nullif(LENGTH(FIRST_NAME), LENGTH(LAST_NAME) ) results
FROM EMPLOYEES;

--4 coalesce function
--it return the first non-null value

SELECT EMPLOYEE_ID,FIRST_NAME, COMMISSION_PCT, MANAGER_ID, SALARY,
COALESCE(COMMISSION_PCT,MANAGER_ID,SALARY),
nvl(  nvl(COMMISSION_PCT,MANAGER_ID), SALARY ) --nested nvl equal to COALESCE
FROM EMPLOYEES;
------------------------------------------------------------------------------------------------------------
--5 case statment

SELECT first_name, job_id, salary,
       CASE job_id WHEN 'IT_PROG'  THEN  1.10*salary
                   WHEN 'ST_CLERK' THEN  1.15*salary
                   WHEN 'SA_REP'   THEN  1.20*salary
       ELSE      SALARY 
       END     "REVISED_SALARY"
FROM   EMPLOYEES;

--you can make the condition after when 
SELECT FIRST_NAME, JOB_ID, SALARY,
       CASE  WHEN JOB_ID='IT_PROG'  THEN  1.10*SALARY
             WHEN JOB_ID='ST_CLERK' THEN  1.15*SALARY
              WHEN job_id='SA_REP'   THEN  1.20*salary
       ELSE      SALARY 
       END     "REVISED_SALARY"
FROM   EMPLOYEES;

---if you didnt put else then null will appear for not match conditions
SELECT first_name, job_id, salary,
       CASE job_id WHEN 'IT_PROG'  THEN  1.10*salary
                   WHEN 'ST_CLERK' THEN  1.15*salary
                   WHEN 'SA_REP'   THEN  1.20*salary
       END     "REVISED_SALARY"
FROM   EMPLOYEES;

--this below statment is not logicaly coorect
--if the first condition is met then it show the result regardless another conditions
SELECT SALARY, 
CASE WHEN SALARY >3000 THEN 'salary > 3000'
     WHEN SALARY >4000 THEN 'salary > 4000'
     WHEN SALARY >10000 THEN 'salary > 10000'
END FFF
FROM EMPLOYEES;

--so it should be like this 
SELECT SALARY, 
CASE WHEN SALARY >10000 THEN 'salary > 10000'
     WHEN SALARY >4000 THEN 'salary > 4000'
     WHEN SALARY >3000 THEN 'salary > 3000'
END FFF
FROM EMPLOYEES;

--6 decode 

SELECT last_name, job_id, salary,
       DECODE(job_id, 'IT_PROG',  1.10*salary,
                      'ST_CLERK', 1.15*salary,
                      'SA_REP',   1.20*salary,
              salary)
       REVISED_SALARY
FROM   EMPLOYEES;

--if you didnt put default value for non-match condition then null will be return for theses values
SELECT last_name, job_id, salary,
       DECODE(job_id, 'IT_PROG',  1.10*salary,
                      'ST_CLERK', 1.15*salary,
                      'SA_REP',   1.20*SALARY
              )
       REVISED_SALARY
FROM   EMPLOYEES;

--example display tax for employees as follow:
--if his salary <3000 then tax=0
--if his salary 3000-7000 then tax=10%
--if his salary >7000 then tax=20%
--so here you should use case , not decode , case is more filxable

SELECT EMPLOYEE_ID,FIRST_NAME, SALARY,
  CASE WHEN SALARY<3000 THEN '0%'
  WHEN SALARY BETWEEN 3000 AND 7000 THEN '10%'
  WHEN SALARY> 7000 THEN '20%'
end tax
FROM EMPLOYEES;







