--cartesian product

select dept_name , salary
from instructor i , teaches t 
where i.dept_name = 'Comp. Sci.' AND t.semester = 'Summer' AND i.salary > 80000

--joins

use University;
select distinct name , title
from instructor natural join teaches , course
where teaches.course_id = course.course_id;

--string operations

create table Arhaan(
    name varchar(20) not NULL,
    age int,
    college varchar(20),
    branch varchar(10)
);

insert into Arhaan values ("Arhaan",20,"Manipal IT"," CSE AI ML");
insert into Arhaan values ("Girdhar",20,"MIT Manipal"," CSE AI ML");

select * from Arhaan;

select name,college 
from Arhaan
where name like '%har%';

--Ordering

use Arhaan_main;
select name 
from Arhaan
order by name desc;

