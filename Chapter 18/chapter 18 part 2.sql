
--Creating Private SYNONYM E  for EMPLOYEES table

drop SYNONYM E;

CREATE SYNONYM E
FOR EMPLOYEES;


--so you can use the SYNONYM now to call the table 
SELECT * FROM e;

-- the SYNONYM info in dictionary view called user_SYNONYMS/ ALL_SYNONYMS
select * from user_SYNONYMS

--you can drop the SYNONYM
DROP SYNONYM E;


--you should have create public SYNONYM privilages in order to create PUBLIC SYNONYM 
CREATE PUBLIC SYNONYM EMPLOYEES FOR HR.EMPLOYEES;

--now other users that access to EMPLOYEES that can do (select * form EMPLOYEES )
-- no need to make ( select * form hr.EMPLOYEES )




