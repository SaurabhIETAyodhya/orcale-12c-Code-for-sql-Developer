--let us create table with 2 constraints ( one primary and another unique)

DROP TABLE EMP_IND;

CREATE TABLE EMP_IND
( EMPNO NUMBER CONSTRAINT EMP_IND_PK PRIMARY KEY,
  ENAME VARCHAR2(100) UNIQUE,
  NICKNAME VARCHAR2(100),
  email varchar2(100)
 );

INSERT INTO EMP_IND (EMPNO,ENAME,NICKNAME,EMAIL) 
VALUES ('1','Ahmed Samer','Ahmed.Samer','Ahmed.Samer@gmail.com');
INSERT INTO EMP_IND (EMPNO,ENAME,NICKNAME,EMAIL) 
VALUES ('2','Rami Nader','Rami.Nader','Rami.Nader@hotmail.com');
INSERT INTO EMP_IND (EMPNO,ENAME,NICKNAME,EMAIL) 
VALUES ('3','Khaled Ali','Khaled.Ali','Khaled.Ali@hotmail.com');
INSERT INTO EMP_IND (EMPNO,ENAME,NICKNAME,EMAIL) 
VALUES ('4','Hassan Nabil','Hassan.Nabil','Hassan.Nabil@yahoo.com');
COMMIT;


--the oracle create implicit UNIQUE indexes for the PK, UK and the name for 
--the index will be same the name of constraint name


SELECT * FROM USER_INDEXES
WHERE TABLE_NAME='EMP_IND';

SELECT * FROM USER_IND_COLUMNS
WHERE TABLE_NAME='EMP_IND';

--now the oracle will use the index in the where clause to speed the query

SELECT * FROM
EMP_IND
WHERE EMPNO=1; --you will see that oracle use the index in the explain plan

SELECT * FROM
EMP_IND
WHERE ename='Ahmed Samer';--you will see that oracle use the index in the explain plan

SELECT * FROM
EMP_IND
WHERE NICKNAME='Ahmed.Samer'; --no index on LNAME so the the oracle will make full scan on the table

CREATE INDEX EMP_IND_NICKNAME ON EMP_IND (NICKNAME);

SELECT * FROM USER_INDEXES
WHERE TABLE_NAME='EMP_IND';

--now the server will use the index for NICKNAME in the where clause
SELECT * FROM
EMP_IND
WHERE NICKNAME='Ahmed.Samer';

---now you can create unique index for email, but it is better to add unique constraint

CREATE UNIQUE INDEX EMP_IND_EMAIL ON EMP_IND (EMAIL);

--now if you try to insert existing email then you will see error like constraint 
INSERT INTO EMP_IND (EMPNO,ENAME,NICKNAME,EMAIL) 
VALUES ('10','karem Samer','Ahmed.Samer','Ahmed.Samer@gmail.com');

--also you can create another index for ENAME column, but using function-based index upper(ENAME)

SELECT * FROM
EMP_IND
WHERE upper(ename)='AHMED SAMER';

CREATE INDEX EMP_IND_UP_ENAME ON EMP_IND (UPPER(ENAME));

SELECT * FROM USER_INDEXES
WHERE TABLE_NAME='EMP_IND';

SELECT * FROM USER_IND_COLUMNS
WHERE TABLE_NAME='EMP_IND';

SELECT * FROM USER_IND_EXPRESSIONS
WHERE TABLE_NAME='EMP_IND';

SELECT * FROM
EMP_IND
WHERE UPPER(ENAME)='AHMED SAMER';
------------------------------------------------------------------

--naming the index while creating the table 
DROP TABLE EMP_IND1;

CREATE TABLE EMP_IND1
( EMPNO NUMBER CONSTRAINT EMP_IND1_PK PRIMARY KEY USING INDEX 
                    (create index EMP_IND1_ind on EMP_IND1 (EMPNO)  ),
  FNAME VARCHAR2(100),
  lname VARCHAR2(100),
  EMAIL VARCHAR2(100),
  gender char(1)
 );

--you can create index of composit columns
CREATE INDEX EMP_IND1_COMP ON EMP_IND1 (FNAME,LNAME);

SELECT * FROM USER_INDEXES
WHERE TABLE_NAME='EMP_IND1';

SELECT * FROM USER_IND_COLUMNS
WHERE TABLE_NAME='EMP_IND1';

--you can create index with type bitmap

CREATE  BITMAP INDEX EMP_IND_b ON EMP_IND1 (GENDER); --but this feature in the Enterprise Edition

---finaly you can drop the index

DROP INDEX EMP_IND1_COMP;






 
 