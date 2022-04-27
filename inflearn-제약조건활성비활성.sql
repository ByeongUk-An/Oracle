-- 제약조건 활성/비활성

create table test_table40(
    data1 number constraint TEST_TABLE40_DATA1_PK primary key
);

insert into test_table40 (data1)
values (100);

alter table test_table40
disable constraint TEST_TABLE40_DATA1_PK;

insert into test_table40 (data1)
values (100);

select * from test_table40;

-- 오류발생 : 활성화가 안되는 이유는 기존에 값을 넣은것이 중복된 값이 primary key 를 위배되기 때문
alter table test_table40
enable constraint TEST_TABLE40_DATA1_PK;

delete from test_table40;

insert into test_table40 (data1)
values (100);

insert into test_table40 (data1)
values (200);

select * from test_table40;

alter table test_table40
enable constraint TEST_TABLE40_DATA1_PK;

insert into test_table40 (data1)
values (100);












