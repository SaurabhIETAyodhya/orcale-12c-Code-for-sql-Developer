--naming rules

--1 the object( table) should start by letter
CREATE TABLE 2EMP
( empno NUMBER );

--2 the table name should be 30 char or less 
CREATE TABLE employees_and_hr_infomation_table
( empno NUMBER );

--3 table name contain only A-Z |  a-z  | _  |  $ |  #
CREATE TABLE EMP-t
( empno NUMBER );

--4 table name should be not dublicates with another object owned by same user
CREATE TABLE EMPLOYEES
( empno NUMBER );

--5 should be not oracle reserved word ( select, from , where, table, ..... ) 
CREATE TABLE select
( empno NUMBER );
----------------------------------------------------------------------------------------------------------------------------------------------
--about number data type

create table test
( n1 number ,
  n2 number (5,3)
);


insert into test values (1655.66,1.34);

select * from test;

insert into test values (20.25,23.347);
select * from test;

insert into test values (444.25,23.3493666);

select * from test;

insert into test values (444.25,500);

------------------------------------------------------------------

--creating tables examples ( no constraints)

--1 create table without any constraints
CREATE TABLE XX_EMP_test
( EMP_ID NUMBER,
  eNAME VARCHAR2(100),
  SALARY NUMBER (8,2 ),
  START_DATE DATE,
  COMMISSION NUMBER (2,2),
  EMP_PIC BLOB,
  EMP_NOTES long --so it is better to use clob , refer to the page 5 in the presntation
)

SELECT * FROM XX_EMP_TEST; --not case sensitive

SELECT * FROM xx_eMP_tEST; --not case sensitive
-------------

-- 2 creating table/ columns using double quotation " ", this is not recommended from orracle 

CREATE TABLE  "XX_eMP_dOUBLE"
( EMP_ID NUMBER,
"Ename" VARCHAR2(100)
);

SELECT * FROM "XX_eMP_dOUBLE"; --so you use the double quotation when you want to query the table, it is case sensetive

SELECT EMP_ID, "Ename" 
FROM "XX_eMP_dOUBLE"; --also because you used double quotation when you defined the Ename, so it shoukd be "Ename" 

---------------------
--3 using the default

CREATE TABLE XX_EMP_test1
( EMP_ID NUMBER,
  eNAME VARCHAR2(100),
  SALARY NUMBER (8,2 ),
  START_DATE DATE default sysdate,
  COMMISSION NUMBER (2,2)
);

INSERT INTO XX_EMP_TEST1( EMP_ID, ENAME )
VALUES                  (1, 'khaled' );

COMMIT;

SELECT * FROM XX_EMP_TEST1;
----------------------

--4  you can query the table you created by using the dictionary tables user_tables

SELECT table_name FROM USER_TABLES;

SELECT OWNER, TABLE_NAME FROM ALL_TABLES 
WHERE OWNER='HR';  --ALL_TABLES YOU CAN SEE ALL THE TABLES IN DATABASE FOR ANY OWNER

-----------------------

--5 creating table with constraints, column level syntax
--this is not the best practice, use table level syntax better
CREATE TABLE XX_EMP_COL_CONST
 (EMP_ID NUMBER CONSTRAINT XX_EMP_COL_CONST_PK PRIMARY KEY,
  ENAME VARCHAR2(100) CONSTRAINT XX_EMP_COL_CONST_UK1 UNIQUE,
  SALARY NUMBER NOT NULL,
  GENDER CHAR(1) CONSTRAINT XX_EMP_COL_CONST_CHQ CHECK ( GENDER IN  ('M','F') ),
  DEPT_ID NUMBER CONSTRAINT XX_EMP_COL_CONST_FK1 REFERENCES DEPARTMENTS (DEPARTMENT_ID)
  );
  
SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME='XX_EMP_COL_CONST';

--TRY TO SEE THE CHECK CONSTRAINT
INSERT INTO XX_EMP_COL_CONST (EMP_ID,ENAME,SALARY,GENDER,DEPT_ID)
VALUES                       (1, 'khaled',500,'D',NULL );

INSERT INTO XX_EMP_COL_CONST (EMP_ID,ENAME,SALARY,GENDER,DEPT_ID)
VALUES                       (1, 'khaled',500,NULL,NULL );

SELECT * FROM XX_EMP_COL_CONST;

--TRY TO SEE THE UNIQUE CONSTRAINT

INSERT INTO XX_EMP_COL_CONST (EMP_ID,ENAME,SALARY,GENDER,DEPT_ID)
VALUES                       (2, 'khaled',500,NULL,NULL );

----------------------------
--6 creating table with constraints, table level syntax
--this is  the best practice
--you can make the PK more than one columm,
--it force you to name the constraint 
CREATE TABLE XX_EMP_COL_CONST1
 (EMP_ID1 NUMBER,
  emp_id2 number,
  ENAME VARCHAR2(100),
  SALARY NUMBER NOT NULL,
  GENDER CHAR(1) ,
  DEPT_ID NUMBER ,
  CONSTRAINT XX_EMP_COL_CONST1_PK PRIMARY KEY (EMP_ID1,EMP_ID2),
  CONSTRAINT XX_EMP_COL_CONST1_UK1 UNIQUE(ENAME),
  CONSTRAINT XX_EMP_COL_CONST1_CHQ CHECK ( GENDER IN  ('M','F') ),
  CONSTRAINT XX_EMP_COL_CONST1_FK1 foreign key (DEPT_ID)REFERENCES DEPARTMENTS (DEPARTMENT_ID)
  );
  
desc  XX_EMP_COL_CONST1
---------------

--7  on delete cascade
delete from departments; --it is master table, you can not delete it

CREATE TABLE DPET1
(DEPTNO NUMBER,
 DNAME VARCHAR2(100),
 CONSTRAINT DPET1_PK PRIMARY KEY (DEPTNO ) 
 );
 
INSERT INTO DPET1 (DEPTNO,DNAME)
VALUES (1,'HR DEPT');
INSERT INTO DPET1 (DEPTNO,DNAME)
VALUES (2,'PO DEPT');
COMMIT;

SELECT  * FROM DPET1;

CREATE TABLE EMP1
( EMPID NUMBER PRIMARY KEY,
  ENAME VARCHAR2(100),
  DEPTNO NUMBER,
  CONSTRAINT EMP1_FK FOREIGN KEY (DEPTNO) REFERENCES DPET1(DEPTNO) ON DELETE CASCADE
);

INSERT INTO EMP1 VALUES (1, 'khaled','1');
INSERT INTO EMP1 VALUES (2, 'ali','1');
INSERT INTO EMP1 VALUES (3, 'ahmed','1');
INSERT INTO EMP1 VALUES (4, 'rania','2');
INSERT INTO EMP1 VALUES (5, 'lara','2');
COMMIT;

SELECT * FROM EMP1;

DELETE FROM DPET1
WHERE DEPTNO=1;

SELECT * FROM EMP1;
------------------------------------------------------------------------


--8  on delete set null


CREATE TABLE DPET2
(DEPTNO NUMBER,
 DNAME VARCHAR2(100),
 CONSTRAINT DPET2_PK PRIMARY KEY (DEPTNO ) 
 );
 
INSERT INTO DPET2 (DEPTNO,DNAME)
VALUES (1,'HR DEPT');
INSERT INTO DPET2 (DEPTNO,DNAME)
VALUES (2,'PO DEPT');
COMMIT;

SELECT  * FROM DPET2;

CREATE TABLE EMP2
( EMPID NUMBER PRIMARY KEY,
  ENAME VARCHAR2(100),
  DEPTNO NUMBER,
  CONSTRAINT EMP2_FK FOREIGN KEY (DEPTNO) REFERENCES DPET2(DEPTNO) ON DELETE set null
);

INSERT INTO EMP2 VALUES (1, 'khaled','1');
INSERT INTO EMP2 VALUES (2, 'ali','1');
INSERT INTO EMP2 VALUES (3, 'ahmed','1');
INSERT INTO EMP2 VALUES (4, 'rania','2');
INSERT INTO EMP2 VALUES (5, 'lara','2');
COMMIT;

SELECT * FROM EMP2;

DELETE FROM DPET2
WHERE DEPTNO=1;

SELECT * FROM EMP2;
---------------------------------------------------------------------




  

 
 
  
  
  















