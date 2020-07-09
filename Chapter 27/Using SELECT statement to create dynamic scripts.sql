select table_name 
from 
user_tables

alter table REGIONS
add creation_date date;

select * from REGIONS;

alter table REGIONS
drop column creation_date;


select 'alter table ' ||table_name ||' add creation_date date; '
from 
user_tables

select 'alter table ' ||table_name ||' drop column creation_date ; '
from 
user_tables





