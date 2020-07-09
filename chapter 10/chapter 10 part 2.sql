--we want to know what is nonEquijoins
--lets create the table, the creation of table will be discussed in details later 
CREATE TABLE JOB_GRADES 
(
 GRADE_LEVEL VARCHAR2(3),
 LOWEST_SAL NUMBER,
 HIGHEST_SAL NUMBER
 );

--here we insert the records for this table 
 insert into JOB_GRADES (GRADE_LEVEL, LOWEST_SAL,HIGHEST_SAL)
 values ('A',1000, 2999);
 insert into JOB_GRADES (GRADE_LEVEL, LOWEST_SAL,HIGHEST_SAL)
 values ('B',3000, 5999);
 insert into JOB_GRADES (GRADE_LEVEL, LOWEST_SAL,HIGHEST_SAL)
 values ('C',6000, 9999);
 insert into JOB_GRADES (GRADE_LEVEL, LOWEST_SAL,HIGHEST_SAL)
 values ('D',10000, 14999);
 insert into JOB_GRADES (GRADE_LEVEL, LOWEST_SAL,HIGHEST_SAL)
 values ('E',15000, 24999);
 insert into JOB_GRADES (GRADE_LEVEL, LOWEST_SAL,HIGHEST_SAL)
 VALUES ('F',25000, 40000);
 commit; 
 
 select * from job_grades;
 
 --this is the nonEquijoins, try to make join using another operators other than =

SELECT EMP.EMPLOYEE_ID, EMP.FIRST_NAME, EMP.SALARY, grades.grade_level
 FROM
 EMPLOYEES EMP ,
 JOB_GRADES GRADES 
 where EMP.salary between GRADES.lowest_sal and grades.highest_sal;
 
 
SELECT EMP.EMPLOYEE_ID, EMP.FIRST_NAME, EMP.SALARY, grades.grade_level
 FROM
 EMPLOYEES EMP ,
 JOB_GRADES GRADES 
 WHERE EMP.SALARY >= GRADES.LOWEST_SAL 
 and EMP.SALARY<=grades.highest_sal ;
--------------------------------------------------------------------------------------------------
---before we learn outer join, let make this  Equijoin
--u will find one missing employee

SELECT 
EMPLOYEES.EMPLOYEE_ID , 
EMPLOYEES.FIRST_NAME, 
EMPLOYEES.DEPARTMENT_ID, 
DEPARTMENTS.DEPARTMENT_NAME
FROM EMPLOYEES,
DEPARTMENTS
WHERE EMPLOYEES.DEPARTMENT_ID=DEPARTMENTS.DEPARTMENT_ID
ORDER BY EMPLOYEE_ID;

--outer join, case1
SELECT 
EMPLOYEES.EMPLOYEE_ID , 
EMPLOYEES.FIRST_NAME, 
EMPLOYEES.DEPARTMENT_ID, 
DEPARTMENTS.DEPARTMENT_NAME
FROM EMPLOYEES,
DEPARTMENTS
WHERE EMPLOYEES.DEPARTMENT_ID=DEPARTMENTS.DEPARTMENT_ID(+)
ORDER BY EMPLOYEE_ID;

---outer join, case2
SELECT 
EMPLOYEES.EMPLOYEE_ID , 
EMPLOYEES.FIRST_NAME, 
DEPARTMENTS.DEPARTMENT_ID, 
DEPARTMENTS.DEPARTMENT_NAME
FROM EMPLOYEES,
DEPARTMENTS
WHERE EMPLOYEES.DEPARTMENT_ID(+)=DEPARTMENTS.DEPARTMENT_ID
ORDER BY EMPLOYEE_ID;

--self join

SELECT EMPLOYEE_ID, FIRST_NAME, MANAGER_ID
FROM EMPLOYEES;

--i want to display manager name, so it is self join

SELECT 
worker.EMPLOYEE_ID, 
WORKER.FIRST_NAME, 
WORKER.MANAGER_ID,
manager.first_name
FROM 
EMPLOYEES WORKER,
EMPLOYEES MANAGER
WHERE WORKER.MANAGER_ID=MANAGER.EMPLOYEE_ID;

SELECT 
worker.EMPLOYEE_ID, 
WORKER.FIRST_NAME, 
WORKER.MANAGER_ID,
manager.first_name
FROM 
EMPLOYEES WORKER,
EMPLOYEES MANAGER
WHERE WORKER.MANAGER_ID=MANAGER.EMPLOYEE_ID(+);

--example
/*
Retrieve all the employees (employee id, first name, dept. id ) who’s salary >2500
And display their department name, and department location and department city and country
All employees should appear even if they have no department
*/

--the number of records should be like this
--because the employees table is the main table 

SELECT count(1) 
FROM 
EMPLOYEES
WHERE  SALARY>2500;

--now we detrmine the column we need to pick it
--from EMPLOYEES we need employee_id, first_name,department_id
--from departments we need department_name and location_id
--form locations we need city and country_id
--from countries try we need country_name

SELECT EMP.EMPLOYEE_ID,EMP.FIRST_NAME,EMP.DEPARTMENT_ID,
DEPT.DEPARTMENT_NAME , DEPT.LOCATION_ID,
LOC.CITY,
cont.country_name
FROM
EMPLOYEES EMP,
DEPARTMENTS DEPT,
LOCATIONS LOC ,
COUNTRIES CONT
WHERE EMP.DEPARTMENT_ID=DEPT.DEPARTMENT_ID(+)
AND DEPT.LOCATION_ID=LOC.LOCATION_ID(+)
AND LOC.COUNTRY_ID=CONT.COUNTRY_id(+)
and SALARY>2500;













