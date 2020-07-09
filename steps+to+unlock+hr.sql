--1
Show con_name;

--2
Select name, con_id 
from v$pdbs;

--3
Alter session set container=orclpdb

--4
Show con_name;

--5
select name, open_mode from v$pdbs;

--6
alter PLUGGABLE DATABASE open;

--7
select * from all_users;

--8
ALTER USER hr identified by hr account unlock;









