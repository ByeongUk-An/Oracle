create table emp01 (
    ano number(20) not null,
    name varchar(20) null,
    job varchar(20) null
);

insert into emp01 (ano, name, job)
values(1111,'홍길동','인사');

insert into emp01 (ano, name, job)
values(2222,'김길동','개발');

insert into emp01 (ano, name, job)
values(3333,'최길동','인사');

insert into emp01 (ano, name, job)
values(4444,'박길동','생산');

select * from emp01;

commit;

-- 컬럼 목록을 생략하는 경우
insert into emp01
values (5555,'황길동','개발');

select * from emp01;

-- 컬럼 목록에 모든 컬럼이 있지 않을 경우
insert into emp01 (ano,name)
values (6666,'안병욱');

-- null을 명시적으로 저장
insert into emp01 (ano,name,job)
values (7777,'박보검',null);

select * from emp01;

drop table emp02;

create table emp02
as
select eno, ename, job from employee where 1 = 0;

insert into emp02(eno,ename,job)
select eno,ename,job from employee;

select * from emp02;

























