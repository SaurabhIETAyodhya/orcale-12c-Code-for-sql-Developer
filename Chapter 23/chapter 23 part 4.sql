
--USER AHMED CONNECTION

select * from session_privs;     

select * from user_sys_privs;

select * from user_role_privs;

select * from role_sys_privs;

SELECT * FROM ROLE_TAB_PRIVS
WHERE ROLE='IUD_EMP'

create table studnet
( student_id number,
  studnet_name varchar2(100)
);

grant select on
studnet to public; 

select * from hr.locations

select * from demo.emp

update hr.employees
set salary=salary+10
where employee_id=100;
 
