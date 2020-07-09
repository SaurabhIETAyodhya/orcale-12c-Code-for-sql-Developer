--1 you have to connect sys as sysdba
--2 when the DBA connect, it will be on container db
--so he should move to the pluggable database first 
show con_name

alter session set container=orclpdb

show con_name

--the dba can know the users avilable from this dictionary table all_users
select * from all_users;

--to see the priv map
select * from SYSTEM_PRIVILEGE_MAP

--now lets create new user called demo

--this will create user demo with password demo1234
create user demo identified by demo1234; -- he can not login yet

--now these some sys priv
grant create session to demo;

grant create table to demo;
-- you can do this also : grant create session,create table to demo

GRANT UNLIMITED TABLESPACE TO DEMO;

grant create sequence to DEMO;

grant create view to demo;

grant create synonym to demo;
---------------------------------------------------------------------------
--now these some object priv
grant select on hr.employees to demo;

grant delete on hr.employees to demo;

grant update (salary)  on hr.employees to demo;

grant all on hr.locations to demo;

grant select, insert 
on hr.jobs to demo;

grant select 
on hr.countries
to public;



