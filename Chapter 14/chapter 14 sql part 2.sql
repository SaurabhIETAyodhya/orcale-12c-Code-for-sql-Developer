--create table as subquery

--1
CREATE TABLE E_EMP
AS SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID 
FROM EMPLOYEES
WHERE DEPARTMENT_ID=90;

DESC E_EMP;

SELECT * FROM E_EMP;

--2

CREATE TABLE E_EMP2(emp_id,   fname       ,lname   ,sal default 0, dept_id)
AS 
SELECT          EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY      , DEPARTMENT_ID 
FROM EMPLOYEES
WHERE DEPARTMENT_ID=90;

DESC E_EMP2;

SELECT * FROM E_EMP2;
---------------------------------------------------------------------------------------------

--using alter to add column

SELECT * FROM E_EMP;

ALTER TABLE E_EMP
ADD (GENDER CHAR(1) );

SELECT * FROM E_EMP;

ALTER TABLE E_EMP
ADD (COMMESSION NUMBER default 0  not null );

SELECT * FROM E_EMP;

ALTER TABLE E_EMP
ADD (COMMESSION1 NUMBER DEFAULT 0  );

SELECT * FROM E_EMP;

ALTER TABLE E_EMP
ADD (COMMESSION2 NUMBER not null); -- it will not work , only worked if the table is empty, or using default value

SELECT * FROM E_EMP;

ALTER TABLE E_EMP
ADD ( CREATED_DATE DATE default sysdate, CREATED_BY varchar2(100) DEFAULT USER );

select * from E_EMP;

--------------------------------------------------------

--using alter to modify a table
SELECT * FROM E_EMP;

ALTER TABLE E_EMP
MODIFY (CREATED_BY VARCHAR2(200) );

ALTER TABLE E_EMP
MODIFY (CREATED_BY VARCHAR2(50) );

ALTER TABLE E_EMP
MODIFY (CREATED_BY VARCHAR2(1) );

select * from E_EMP;

ALTER TABLE E_EMP
MODIFY (CREATED_BY  not null );

UPDATE E_EMP
SET GENDER='M';

select * from E_EMP;

ALTER TABLE E_EMP
MODIFY (GENDER  NUMBER );

ALTER TABLE E_EMP
MODIFY (GENDER  VARCHAR2(11) );

ALTER TABLE E_EMP
MODIFY (GENDER  CHAR(10) );

ALTER TABLE E_EMP
MODIFY (GENDER  VARCHAR2(9) );

ALTER TABLE E_EMP
MODIFY (GENDER  VARCHAR2(10) );

UPDATE E_EMP
SET GENDER=NULL;
COMMIT;

ALTER TABLE E_EMP
MODIFY (GENDER  VARCHAR2(9) );

ALTER TABLE E_EMP
MODIFY (GENDER  VARCHAR2(5) );

ALTER TABLE E_EMP
MODIFY (GENDER  VARCHAR2(1) );

ALTER TABLE E_EMP
MODIFY (GENDER  char(2) );

ALTER TABLE E_EMP
MODIFY (GENDER  VARCHAR2(1) );
----------------------------------------------------------------------------------

--drop a column
--try to drop column department_id from departments table, it will give you error
select * from E_EMP;

ALTER TABLE E_EMP
drop column CREATED_BY;   ---alter table  E_EMP  drop column (created_by, created_date );  this not allowed

SELECT * FROM E_EMP;

ALTER TABLE  E_EMP  DROP  ( GENDER, CREATED_DATE );

select * from E_EMP;

---------------------------++++++--------------------------

--set unesed

SELECT * FROM E_EMP2;

ALTER TABLE E_EMP2
SET UNUSED (SAL);

SELECT * FROM E_EMP2;

SELECT * FROM USER_UNUSED_COL_TABS;

UPDATE E_EMP2
SET SAL=100;
-----------------
SELECT * FROM E_EMP2;

ALTER TABLE E_EMP2
SET UNUSED (fname) ONLINE; -- it allow DML operation  while making the column unsed , it could take time

SELECT * FROM E_EMP2;

UPDATE E_EMP2
SET fname='xx';

SELECT * FROM USER_UNUSED_COL_TABS;

ALTER TABLE E_EMP2
drop unused columns; -- it remove the column phyiscaly

--------------------------------------------------------

---alter table read write

SELECT * FROM E_EMP2;

ALTER TABLE E_EMP2 READ ONLY;

DELETE FROM E_EMP2; --not allowed

alter table E_EMP2
add ( created_by varchar2(100)); -- DDL allowed because this statement not change data 

alter table E_EMP2
drop (created_by); --this DDL not allowed because this statement change data 

ALTER TABLE E_EMP2 READ write;   ---DML allowed now 

DELETE FROM E_EMP2;

------------------------------------
--drop table
SELECT * FROM E_EMP2;

DROP TABLE E_EMP2;

select * from E_EMP2;

SELECT * FROM USER_RECYCLEBIN
WHERE original_name='E_EMP2';

------------
create table x_test
as select * from jobs;

select * from x_test

drop table x_test purge;

SELECT * FROM USER_RECYCLEBIN
WHERE original_name='X_TEST';






















