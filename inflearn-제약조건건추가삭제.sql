-- 컬럼 레벨 제약조건
drop table test_table10;

create table test_table10 (
    data1 number constraint TEST_TABLE10_DATA1_PK Primary Key,
    data2 number not null constraint TEST_TABLE10_DATA2_UK unique,
    data3 number not null constraint TEST_TABLE10_DATA3_FK references employee(eno),
    data4 number not null constraint TEST_TABLE10_DATA4_CK check(data4 between 1 and 10),
    data5 number not null constraint TEST_TABLE10_DATA5_CK check(data5 in(10,20,30))
);

-- 테이블 레벨 제약조건
drop table test_table11;

create table test_table11(
    data1 number,
    data2 number not null,
    data3 number not null,
    data4 number not null,
    data5 number not null,
    
    constraint TEST_TABLE11_DATA1_PK primary key(data1),
    constraint TEST_TABLE11_DATA2_UK unique(data2),
    constraint TEST_TABLE11_DATA3_FK foreign key(data3) references employee(eno),
    constraint TEST_TABLE11_DATA4_CK check(data4 between 1 and 10),
    constraint TEST_TABLE11_DATA5_CK check(data5 in(10,20,30))
);

-- 복합키
drop table test_table12;

create table test_table12 (
    data1 number,
    data2 number,
    constraint TEST_TABLE12_COMBO_PK primary key(data1,data2)
);

insert into test_table12 (data1,data2)
values (100,200);

insert into test_table12 (data1,data2)
values(100,300);

insert into test_table12 (data1,data2)
values(400,200);

insert into test_table12 (data1,data2)
values(100,200); -- 오류발생 : 복합된 primary key가 서로 값이 다른경우는 가능하지만 다른 컬럼에서 2개의 값이 두개다 일치하면 안됨.

insert into test_table12 (data1,data2)
values(null,null); -- 오류발생 : primary key는 null을 삽입불가능

insert into test_table12 (data1,data2)
values(500,500); -- 삽입가능




-- 제약조건 추가하기
drop table test_table20;

create table test_table20 (
    data1 number,
    data2 number,
    data3 number,
    data4 number,
    data5 number,
    data6 number
);

-- null 제약조건 추가
alter table test_table20
modify data1 not null;

insert into test_table20 (data1)
values (null);

-- primary key 제약조건 추가
alter table test_table20
add constraint TEST_TABLE20_DATA2_PK primary key(data2);

insert into test_table20 (data1,data2)
values(1,10);

insert into test_table20 (data1,data2)
values(2,10);

insert into test_table20 (data1,data2)
values(3,null);

-- 외래키 제약조건 추가
alter table test_table20
add constraint TEST_TABLE20_DATA3_FK Foreign Key(data3)
references employee(eno);

insert into test_table20 (data1,data2,data3)
values(10,100,7369);

insert into test_table20 (data1,data2,data3)
values(10,100,1111);


-- unique 제약 조건 추가
alter table test_table20
add constraint TEST_TABLE20_DATA4_UK unique(data4);

insert into test_table20 (data1,data2,data4)
values(12,102,100);

insert into test_table20 (data1,data2,data4)
values(12,102,100);


-- check 제약 조건
alter table test_table20
add constraint TEST_TABLE20_DATA5_CK check(data5 between 1 and 10);

insert into test_table20 (data1,data2,data5)
values (14,104,5);

insert into test_table20 (data1,data2,data5)
values (15,105,20);

alter table test_table20
add constraint TEST_TABLE20_DATA6_CK check(data6 in(10,20,30));

insert into test_table20 (data1,data2,data6)
values (16,106,20);

insert into test_table20 (data1,data2,data6)
values (16,106,40);

select * from test_table20;


-- 제약조건 제거

create table test_table30 (
    data1 number not null,
    data2 number constraint TEST_TABLE30_DATA2_PK primary key,
    data3 number constraint TEST_TABLE30_DATA3_FK references employee(eno),
    data4 number constraint TEST_TABLE30_DATA4_UK unique,
    data5 number constraint TEST_TABLE30_DATA5_CK check (data5 between 1 and 10),
    data6 number constraint TEST_TABLE30_DATA6_CK check (data6 in (10,20,30))
);


-- not null 제약 조건 제거
alter table test_table30
modify data1 null;

insert into test_table30 (data1,data2)
values(null,100);

-- primary key 제약 조건 제거
alter table test_table30
drop constraint TEST_TABLE30_DATA2_PK;

insert into test_table30 (data2)
values (null);

-- 외래키 제약 조건 제거
alter table test_table30
drop constraint TEST_TABLE30_DATA3_FK;

insert into test_table30(data3)
values(1000);

-- unique 제약조건 제거
alter table test_table30
drop constraint TEST_TABLE30_DATA4_UK;

insert into test_table30 (data4)
values(100);

insert into test_table30 (data4)
values(100);

-- check 제약조건 제거
alter table test_table30
drop constraint TEST_TABLE30_DATA5_CK;

alter table test_table30
drop constraint TEST_TABLE30_DATA6_CK;

insert into test_table30 (data5,data6)
values (20,100);

select * from test_table30;


-- 제약조건 활성/비활






















