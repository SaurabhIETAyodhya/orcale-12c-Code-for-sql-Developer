--we will learn more about constaints
--DEFERRABLE INITIALLY DEFERRED
-- DEFERRABLE INITIALLY immediate

DROP TABLE EMP_SAL;

CREATE TABLE EMP_SAL
( EMP_ID NUMBER,
  SAL NUMBER,
  BONUS NUMBER,
  CONSTRAINT SAL_CK CHECK (SAL>100),
  constraint bouns_ck check(BONUS>0)
);

--look at the columns DEFERRABLE and DEFErred
SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME='EMP_SAL';

--any dml that not meet the condition, the error will be immediate
INSERT INTO EMP_SAL(EMP_ID,SAL,BONUS)
VALUES (1,90,5);

INSERT INTO EMP_SAL(EMP_ID,SAL,BONUS)
VALUES (1,100,-2);

--lets drop the constraints and re create it with new options
ALTER TABLE EMP_SAL
DROP CONSTRAINT SAL_CK;

ALTER TABLE EMP_SAL
DROP CONSTRAINT bouns_ck;

ALTER TABLE EMP_SAL
ADD CONSTRAINT SAL_CK CHECK (SAL>100) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE EMP_SAL
ADD CONSTRAINT bouns_ck CHECK (BONUS>0) DEFERRABLE INITIALLY immediate;

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME='EMP_SAL';

--the first one DEFERRABLE INITIALLY DEFERRED, it wil be viloated when you try to commit
INSERT INTO EMP_SAL(EMP_ID,SAL,BONUS)
VALUES (1,90,5);

--the second one DEFERRABLE INITIALLY immediate, it wil be viloated immediate
INSERT INTO EMP_SAL(EMP_ID,SAL,BONUS)
VALUES (1,200,-1);


SET CONSTRAINT SAL_CK immediate;

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME='EMP_SAL';

INSERT INTO EMP_SAL(EMP_ID,SAL,BONUS)
VALUES (1,90,5);
---------------------------------------------------------------------------------

DROP TABLE EMP_SAL;

CREATE TABLE EMP_SAL
( EMP_ID NUMBER,
  SAL NUMBER,
  BONUS NUMBER,
  CONSTRAINT SAL_CK CHECK (SAL>100) ,
  constraint bouns_ck check(BONUS>0)
);

--now you can not change the constraint to IMMEDIATE/ DEFERRED because it was created in normal way 
SET CONSTRAINT SAL_CK IMMEDIATE;
SET CONSTRAINT SAL_CK DEFERRED;

--------------------------------------------------------------------------------

--here will learn the GLOBAL TEMPORARY TABLE
--it is a table that hold data that exist only for the duration of the transction (session)
--each session can see and modify only its data

DROP TABLE CART;

CREATE GLOBAL TEMPORARY TABLE CART
( ITEM_NO NUMBER, QTY NUMBER )
ON COMMIT DELETE ROWS;


INSERT INTO CART VALUES (1,10);
INSERT INTO CART VALUES (2,4);

SELECT * FROM CART;

COMMIT;
SELECT * FROM CART;

DROP TABLE CART2;

CREATE GLOBAL TEMPORARY TABLE CART2
( ITEM_NO NUMBER, QTY NUMBER )
ON COMMIT preserve ROWS;

INSERT INTO CART2 VALUES (1,10);
INSERT INTO CART2 VALUES (2,13);
INSERT INTO CART2 VALUES (3,1);
COMMIT;

SELECT * FROM CART2;






