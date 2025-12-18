drop table employees purge;

create table employees (
   employee_id number primary key,
   first_name  varchar2(50),
   salary      number
);

insert into employees (
   employee_id,
   first_name,
   salary
) values ( 100,
           'Ali',
           2500 );
insert into employees (
   employee_id,
   first_name,
   salary
) values ( 101,
           'Sara',
           3200 );
insert into employees (
   employee_id,
   first_name,
   salary
) values ( 102,
           'Youssef',
           8000 );
insert into employees (
   employee_id,
   first_name,
   salary
) values ( 103,
           'Nadia',
           16000 );

commit;