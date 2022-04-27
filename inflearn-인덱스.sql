drop table test_table100;

create table test_table100(
    data1 number constraint TEST_TABLE100_DATA1_PK primary key,
    data2 number not null
);

select index_name, table_name, column_name
from user_ind_columns;

drop table emp01;

create table emp01
as
select * from employee;

select * from emp01;

insert into emp01
select * from emp01;


select count(*) from emp01;

insert into emp01 (ename)
values('홍길동');

select * from emp01
where ename = '홍길동';

create index emp01_idx
on emp01(ename);