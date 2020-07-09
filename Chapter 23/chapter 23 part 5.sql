--ahmed connection
--1 create this table
create table course
( course_id number,
  course_name varchar2(100)
);

--2

grant select
on course
to hr
with grant option;


--3 go and open new session or connection to hr
--do this : select * from ahmed.course
--then this:
/*
grant select
on ahmed.course
to demo
with grant option;
*/

--4 open new session or connection to demo
--do this : select * from ahmed.course

--5 now ahmed he will do this
revoke select
on course
from hr;

--6 then hr and also demo can not do this: select * from ahmed.course 


