--we will learn how to add constraints to the tables
--we will create 2 tables EMP2, dept2 same employees and departments
DROP TABLE EMP2;

CREATE TABLE EMP2 
AS SELECT * FROM EMPLOYEES;

DESC EMP2;

SELECT * FROM EMP2;


DROP TABLE dept2;

CREATE TABLE DEPT2 
AS SELECT * FROM DEPARTMENTS ;

DESC DEPT2;

SELECT * FROM DEPT2;

--now there are many methods to add constraints to the table 

--1 adding primary key 

--mathod 1, here the constraint name will be sys_cn%

ALTER TABLE EMP2
MODIFY EMPLOYEE_ID PRIMARY KEY;

SELECT * FROM USER_CONSTRAINTs
WHERE TABLE_NAME='EMP2';

ALTER TABLE EMP2
DROP CONSTRAINT &cons;

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME='EMP2';

--mathod 2, here you will give the name of the constraint, this is better

ALTER TABLE EMP2
add constraint EMP2_pk  PRIMARY KEY(EMPLOYEE_ID );

SELECT * FROM USER_CONSTRAINTs
WHERE TABLE_NAME='EMP2';

ALTER TABLE dept2
add constraint dept2_pk  PRIMARY KEY(department_id );
----------------------------------------------------------------------------------------------------------------

--2 adding foreign key 
--method 1
ALTER TABLE EMP2
MODIFY DEPARTMENT_ID  REFERENCES DEPT2 (department_id);

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME='EMP2';

ALTER TABLE EMP2
DROP CONSTRAINT &con_name;

--method 2

ALTER TABLE EMP2
add constraint EMP2_fk_dept foreign key(department_id) REFERENCES dept2 (department_id);

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME='EMP2';
--------------------------------------------------------------------------------------------------------------------
--3 adding not null constraint
-- this will work only if the table is empty,  or the column has value for all rows
ALTER TABLE EMP2
MODIFY FIRST_NAME  NOT NULL;
-----------------

DELETE FROM DEPT2;

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN ('EMP2','DEPT2')
AND CONSTRAINT_TYPE IN ('P','R')
ORDER BY TABLE_NAME;

ALTER TABLE DEPT2
DROP PRIMARY KEY ; ---or you can do like this alter table DEPT2 drop constraint dept2_pk

--when you do this, it will drop all the related constraints
ALTER TABLE DEPT2
DROP PRIMARY KEY CASCADE;

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN ('EMP2','DEPT2')
AND CONSTRAINT_TYPE IN ('P','R')
ORDER BY TABLE_NAME;

--------------------------------------------------------------------------------------
ALTER TABLE dept2
ADD CONSTRAINT DEPT2_PK  PRIMARY KEY(DEPARTMENT_ID );

ALTER TABLE EMP2
add constraint EMP2_fk_dept foreign key(department_id) REFERENCES dept2 (department_id);

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN ('EMP2','DEPT2')
AND CONSTRAINT_TYPE IN ('P','R')
ORDER BY TABLE_NAME;

ALTER TABLE DEPT2
DROP COLUMN DEPARTMENT_ID;

ALTER TABLE DEPT2
DROP COLUMN DEPARTMENT_ID CASCADE CONSTRAINTS;

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN ('EMP2','DEPT2')
AND CONSTRAINT_TYPE IN ('P','R')

SELECT * FROM DEPT2;

SELECT * from EMP2;

----------------------------------------------------------

--rename the column name  

SELECT * FROM  EMP2;

SELECT * FROM USER_CONS_COLUMNS
WHERE TABLE_NAME='EMP2';

ALTER TABLE EMP2
RENAME COLUMN FIRST_NAME TO FNAME;

SELECT * FROM  EMP2;

SELECT * FROM USER_CONS_COLUMNS
WHERE TABLE_NAME='EMP2';


SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN ('EMP2','DEPT2')
AND CONSTRAINT_TYPE IN ('P','R')
ORDER BY TABLE_NAME;

--CHANGE THE CONSTRAINT NAME

ALTER TABLE EMP2
RENAME CONSTRAINT EMP2_PK TO NEW_EMP2_PK;

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN ('EMP2','DEPT2')
AND CONSTRAINT_TYPE IN ('P','R')
ORDER BY TABLE_NAME;
-----------------------------------------------------

DROP TABLE EMP2;

CREATE TABLE EMP2 
AS SELECT * FROM EMPLOYEES;

DROP TABLE dept2;

CREATE TABLE DEPT2 
AS SELECT * FROM DEPARTMENTS ;

ALTER TABLE DEPT2
ADD CONSTRAINT DEPT2_PK  PRIMARY KEY(DEPARTMENT_ID );

ALTER TABLE EMP2
add constraint EMP2_pk  PRIMARY KEY(EMPLOYEE_ID );

ALTER TABLE EMP2
add constraint EMP2_fk_dept foreign key(department_id) REFERENCES dept2 (department_id);

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN ('EMP2','DEPT2')
AND CONSTRAINT_TYPE IN ('P','R')
ORDER BY TABLE_NAME;

SELECT * FROM USER_indexes
where table_name='EMP2';

ALTER TABLE EMP2
DISABLE CONSTRAINT EMP2_PK;

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN ('EMP2','DEPT2')
AND CONSTRAINT_TYPE IN ('P','R')
ORDER BY TABLE_NAME;

SELECT * FROM USER_INDEXES
where table_name='EMP2';

ALTER TABLE EMP2
enable CONSTRAINT EMP2_PK;

SELECT * FROM USER_INDEXES
WHERE TABLE_NAME='EMP2';
---
ALTER TABLE DEPT2
disable CONSTRAINT DEPT2_PK;

ALTER TABLE DEPT2
DISABLE CONSTRAINT DEPT2_PK CASCADE ;

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN ('EMP2','DEPT2')
AND CONSTRAINT_TYPE IN ('P','R')
ORDER BY TABLE_NAME;
-----------------------------------------------------





