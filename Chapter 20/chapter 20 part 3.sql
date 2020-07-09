--we will learn the sql loader
--SQL*Loader is a bulk loader utility used for moving data from external files into the Oracle database

DROP TABLE EMP_LOAD;

CREATE TABLE EMP_LOAD
(EMPNO NUMBER ,
FNAME VARCHAR2(100),
LNAME VARCHAR2(100) 
);

SELECT * FROM EMP_LOAD;


--we have file  emp.csv   in  E:\load
--we want to move the data from this file to the table EMP_LOAD
--we use SQL*Loader
--we need to do a file called conrol file .ctl ( example emp.ctl )
/*
Load Data
INFILE 'E:\load\emp.csv'
APPEND
INTO Table emp_load
FIELDS TERMINATED BY ',' 
(empno,
fname,
lname
)
*/
-- then after this  we execute this commnad sqlldr control=E:\load\emp.ctl log=E:\load\emp.log  from cmd windows command
--sqlldr control=E:\load\emp.ctl log=E:\load\emp.log
SELECT * FROM EMP_LOAD;
--go to the E:\load and see the log file , it will give you details about the loaded data

truncate table  EMP_LOAD;

--now update the file emp.csv, make some ids to be characters
--we want to know the bad file, the records that not inserted 
--sqlldr control=E:\load\emp.ctl log=E:\load\emp.log
-------------------------------------------------------------------------------------------------------------

--now we will learn how to create external tables
--external table is read only table whose metadata is stored in the Db, 
--but whose data is stored outside the db.
--no DML allowed, no indexes can be created on external tables
--you can access the data with 2 methods (oracle_loader or oracle_datapump )
--to read external data, first you need to create directory in the database
/*to create DIRECTORY you need create any DIRECTORY priv, the dba should give you this
conn sqlplus sys as sysdba
alter session set container=orclpdb;
grant create any DIRECTORY to hr;
*/

CREATE OR REPLACE DIRECTORY EMP_DIR
AS 'E:\external';

SELECT * FROM ALL_DIRECTORIES
WHERE DIRECTORY_NAME='EMP_DIR';

drop table EMP_LOAD_ext;

CREATE TABLE EMP_LOAD_ext
     (EMPLOYEE_NUMBER      NUMBER,
      FNAME   VARCHAR2(100),
      LNAME   VARCHAR2(100)
      )
    ORGANIZATION EXTERNAL
      (TYPE ORACLE_LOADER
      DEFAULT DIRECTORY EMP_DIR
      ACCESS PARAMETERS
        (RECORDS DELIMITED BY NEWLINE
         FIELDS TERMINATED BY ','
        )
      LOCATION ('old_emp_data.csv')
     )
     reject limit unlimited;

SELECT * FROM EMP_LOAD_EXT;

DELETE EMP_LOAD_EXT; --operation not supported on external organized table

DROP TABLE EMP_PUMP;

  cREATE TABLE EMP_pump
     (EMPLOYEE_NUMBER  ,
      FNAME ,
      LNAME 
      )
    ORGANIZATION EXTERNAL
      (TYPE ORACLE_DATAPUMP
      DEFAULT DIRECTORY EMP_DIR
      LOCATION ('EMP.dmp')
     )
     AS 
     SELECT EMPLOYEE_ID, FIRST_NAME,LAST_NAME
     from EMPLOYEES;
     
SELECT * FROM EMP_PUMP;


--drop table EMP_PUMP_READ;

CREATE TABLE EMP_PUMP_READ
     (EMPLOYEE_NUMBER NUMBER ,
      FNAME   VARCHAR2(100),
      LNAME  VARCHAR2(100) 
      )
    ORGANIZATION EXTERNAL
      (TYPE ORACLE_DATAPUMP
      DEFAULT DIRECTORY EMP_DIR
      LOCATION ('EMP.dmp')
     );
     
select * from EMP_PUMP_READ;

