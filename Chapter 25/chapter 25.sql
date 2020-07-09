--THE INTERVAL ( YEAR TO MONTH / day TO second)
--year any positive or nagative number
--month 00-11
--day any positive or nagative number
--hour 00-23
--minute 00-59
--second 00 to 59.9
SELECT INTERVAL '55-11' YEAR TO MONTH 
FROM DUAL;

SELECT INTERVAL '1-4' YEAR TO MONTH 
FROM DUAL;

SELECT INTERVAL '555-11' YEAR TO MONTH 
FROM DUAL; -- if the year more than 2 digits, then you should use size

SELECT INTERVAL '555-11' YEAR(3) TO MONTH 
FROM DUAL; 

SELECT INTERVAL '1000-11' YEAR(4) TO MONTH 
FROM DUAL; 

SELECT INTERVAL '350'  MONTH  --YEAR TO MONTH 
FROM DUAL; 

SELECT INTERVAL '10'  year --YEAR TO MONTH 
FROM DUAL; 

SELECT INTERVAL '33 20:20:20' day TO second 
FROM DUAL

SELECT INTERVAL '333 20:20:20' DAY(3) TO SECOND 
FROM DUAL;


SELECT INTERVAL '500' hour --day TO second 
FROM DUAL;
-----------------------------------------------------------------------------------------------

select sysdate from dual;

select sysdate, sysdate +10 from dual;

--i want the date after 1 year and 2 month from the sysdate
--to_yminterval

select sysdate, sysdate + interval '01-02' YEAR TO MONTH  
from dual;

select sysdate, sysdate + to_yminterval ('01-02')
from dual;

-- i want to add  6 days and 2 hours to sysdate
--to_dsinterval
select sysdate, sysdate + to_dsinterval ('6 02:00:00')
from dual;

select to_char(sysdate, 'dd-mm-yyyy hh:mi:ss') ,
to_char(  sysdate + to_dsinterval ('6 02:00:00') , 'dd-mm-yyyy hh:mi:ss') 
from dual;
---------------------------------------------

--extract function

select to_char(sysdate,'yyyy') the_year, 
       to_char(sysdate,'mm') the_month, 
       to_char(sysdate,'dd') the_day
from dual;

select 
extract (year from sysdate) , 
extract (month from sysdate),
extract (day from sysdate)
from dual;

select employee_id, first_name , hire_date,
extract (year from hire_date) hire_year,
extract (month from hire_date) hire_month
from employees;
-------------------------------------------------------

drop table date_table;

--DATE datatype and timestamp datatype
create table date_table
( date1 date,
  date2 timestamp,
  date3 timestamp with time zone
);

--sysdate return the cuurent date and time for the server 
--current_timestamp return the cuurent date and time for user session (timestamp with time zone)
insert into date_table
values (sysdate,current_timestamp,current_timestamp );

select * from date_table;

select to_char(date1,'dd-mm-yyyy hh:mi:ss') date1,date2 
from date_table;
---------------------------------------------

--all zones names stored in this table 
select * from V$TIMEZONE_NAMES 
where tzname like '%America/Chicago%'
--LMT - Local Mean Time
--CST – Central Standard Time
--CDT – Central Daylight Time 
--EST – Eastern Standard Time
--CWT - Central West Time


--time zone can be set to absolute offset or named region
--the DBTIMEZONE display the database time zone,  this in def of create database statement
select DBTIMEZONE from dual;

--SESSIONTIMEZONE return the session time zone
---You can set the default client session time zone using the ORA_SDTZ environment variable
select SESSIONTIMEZONE from dual;

-- return the cuurent date for user session (date)
select current_date from dual; 

select to_char(current_date,'dd-mm-yyyy hh:mi:ss'), to_char(sysdate,'dd-mm-yyyy hh:mi:ss')
from dual; 

 --return the cuurent date and time for user session (timestamp with time zone)
select current_timestamp from dual;

 --return the cuurent date and time for user session (timestamp)
select localtimestamp from dual
----------------------------
alter session set time_zone = 'Asia/Amman';

select to_char(current_date,'dd-mm-yyyy hh:mi:ss'), to_char(sysdate,'dd-mm-yyyy hh:mi:ss')
from dual; 

 --return the cuurent date and time for user session (timestamp with time zone)
select current_timestamp from dual;

 --return the cuurent date and time for user session (timestamp)
select localtimestamp from dual

alter session set time_zone = 'Asia/Muscat';

drop table web_order;

create table web_order
( cust_id number,
  name varchar2(100),
  item varchar2(100),
  delivary_location varchar2(100),
  order_date timestamp with time zone,
  delivary_period number,
  delivary_date timestamp with local time zone
);

insert into web_order values (1,'Naser','Iphone 6 64GB Gold','Amman',
                    current_timestamp,3,current_timestamp+3 );

select * from web_order;

--suppose this code in jordan
alter session set time_zone = 'Asia/Amman';

select * from web_order;

------------------------------------------------------------------------



--TZ_OFFSET

SELECT TZ_OFFSET('Asia/Dubai'),TZ_OFFSET('America/Chicago') 
from dual;

--from_tz
/*FROM_TZ function is a built in function that provides conversion of a timestamp 
to TIMESTAMP WITH TIME ZONE for a given timezone. 
--Essentially it combines the timestamp and timezone information into a single operation
*/

select from_tz(timestamp '2000-03-6 08:00:00', 'Asia/Amman')
from dual;

--to_timestamp

select to_date ('20-12-2016','dd-mm-yyyy')
from dual;

select to_timestamp ('20-12-2016 12:10:33','dd-mm-yyyy hh:mi:ss')
from dual;
---------------------------------------------------





