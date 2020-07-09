--using the subquery as a source table

select LOCATION_ID, city 
from LOCATIONS;

select department_id , department_name, LOCATION_ID
from departments;

select dept.department_id , dept.department_name,loc.city
from departments dept ,
(select LOCATION_ID, city  from LOCATIONS) loc -- we name this subqery inline view
where dept.location_id=loc.location_id

-- lets create real example to know why to use inline view

drop table student;

create table student
( student_id number primary key,
  student_name varchar2(100)
);

insert into student values (1,'ahmed ali');
insert into student values (2,'ammer jamal');
insert into student values (3,'sara nayef');
commit;

select * from student;

drop table student_major;

create table student_major
( term varchar2(6),
  student_id number,
  major varchar2(100),
  constraint student_major_pk primary key (term,student_id),
  constraint student_major_fk1 foreign key (student_id) references student (student_id)
);

insert into student_major values (201401,1,'IT');
insert into student_major values (201402,1,'Computer Science');
insert into student_major values (201401,2,'Accounting');
insert into student_major values (201402,2,'Accounting');
insert into student_major values (201401,3,'Markiting');
insert into student_major values (201402,3,'Markiting');
insert into student_major values (201403,3,'Adminstration');
commit;

select student_id,term,major 
from student_major
order by 1,2;

--now we need a report to show each student with his major
--the logic that the latest major should appaer in the report

select student_id,term,major 
from student_major a
where term=(select max(term) from student_major b where b.student_id=a.student_id) 

--so now we can join this select with studnet table to get the name

select st.student_id,st.student_name ,st_major.major
from 
student st,
(
  select student_id,term,major
  from student_major a
  where term=(select max(term) from student_major b where b.student_id=a.student_id) 
) st_major
where st.student_id=st_major.student_id;
-------------------------------------------------------------------------------------------------

--multiple-column subqueries

select * from employees
where first_name='John';

/*display the details for the employees who are managed by the same manager and work
in the same department as the employees with first name of "john"
*/
select * from employees
where manager_id=108 and department_id=100
and first_name<>'John'
union all
select * from employees
where manager_id=100 and department_id=80
and first_name<>'John'
union all
select * from employees
where manager_id=123 and department_id=50
and first_name<>'John';

--this we call it pairwise comparision subquery
select * from employees
where (manager_id,department_id) in  (select manager_id,department_id 
                                       from employees where first_name='John'
                                       )
and first_name<>'John';
-----------

select * from employees
where first_name='John';

/*display the details of the employees  
who are managed by the same manager as the employees 
with first name of "John" and work in the department as employees
with first name  of "john"

*/
select * from employees
where manager_id in (108,100,123)
and department_id in (100,80,50)
and first_name<>'John';

--this we call nonpairwise comparision subquery 
select * from employees
where manager_id in  (select manager_id 
                      from employees where first_name='John'
                      )
and  department_id in  (select department_id 
                        from employees where first_name='John'
                        )
and first_name<>'John';

