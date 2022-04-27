-- 8일차 - 뷰, 시퀸스, 인덱스
/*
    뷰(view) : 가상의 테이블을 뷰(view)라 한다.
        -- 테이블은 데이터 값을 가지고 있다.
        -- 뷰는 데이터 값을 가지지 않는다. 실행 코드만 들어가 있다.
        -- 뷰를 사용하는 목적 :
            1. 보안을 위해서 : 실제 테이블의 특정 컬럼만 가져와서 실제 테이블의 중요 컬럼을
                             숨길수 있다.
            2. 복잡한 쿼리를 뷰를 생성해서 편리하게 사용할 수 있다. ( 복잡한 JOIN 쿼리)
          - 뷰는 일반적으로 select 구문이 온다.
          - 뷰는 insert, update, delete 구문이 올 수 없다. -> select문 뒤에 안됨.
          - 뷰에 값을 insert 하면 실제 테이블에 저장이 된다. 실제 테이블의 제약조건을 잘 만족 해야한다.
          - 뷰에 값을 insert 할 경우 실제 테이블의 제약조건에 따라서 insert 될 수도 있고, 그렇지
            않을 수도 있다.
          - 그룹 함수를
*/

create table dept_copy60
as
select * from department;

create table emp_copy60
as
select * from employee;

-- 뷰 생성
Create view v_emp_job
as
select eno, ename, dno, job
from emp_copy60
where job like 'SALESMAN';

-- 뷰 생성 확인
select * from user_views;

-- 뷰의 실행 ( select * from 뷰이름)
select * from v_emp_job;

-- 복잡한 조인 쿼리를 뷰에 만들어 두기
create view v_join
as
select e.dno, ename, job, dname,loc
from employee e, department d
where e.dno = d.dno
and job = 'SALESMAN';



select * from v_join;

-- 뷰를 사용해서 실제 테이블의 중요한 정보 숨기기. (보안)
select * from emp_copy60;

create view simple_emp
as
select ename,job,dno
from emp_copy50;

select * from simple_emp;  -- view를 사용해서 실제 테이블의 중요 컬럼을 숨긴다.

select * from user_views;

-- 뷰를 생성할때 반드시 별칭 이름을 사용해야 하는 경우, group by할때 

create view v_groupping
as
select dno, count(*) groupCount, avg(salary) AVG, sum(salary) SUM
from emp_copy60
group by dno;

select * from v_groupping;

-- 뷰를 생성할때 as 하위에 select 문이 와야한다. insert, update, delete 문은 올 수 없다.
create view v_error
as
insert into dno
values(60,'HR','PUSAN');

-- view 에 값을 insert 할 수 있을까? 컬럼의 제약 조건을 만족하면 view에도 값을 넣을 수 있다.
    -- view는 가상이기 때문에 실제 테이블에 값이 insert 된다.
create view v_dept
as
select dno,dname
from dept_copy60;

select * from v_dept;

insert into v_dept  -- View 에 값을 Insert, 제약조건이 일치할때 잘 Insert 된다.
values (70,'HR');

select * from dept_copy60;

-- v_dept 가 존재하지 않을 경우 : create, 존재할 경우 : replace(수정)
create or replace view v_dept       
as
select dname, loc
from dept_copy60;

select * from v_dept;

insert into v_dept
values('HR2','PUSAN');

select * from v_dept;
select * from dept_copy60;

update dept_copy60
set dno = 80
where dno is null;
commit;

alter table dept_copy60
add constraint PK_dept_copy60 Primary Key (dno);

select * from user_constraints
where table_name = 'DEPT_COPY60';

select * from v_dept;

insert into v_dept
values ('HR3','PUSAN2');  -- 제약조건 위배로 인한 실행 x

select * from user_views;

select * from v_groupping; -- 그룹핑된 view 에는 insert 할 수 없다.

create or replace view v_groupping
as
select dno, count(*) groupCount, round(avg(salary),2) AVG, sum(salary) SUM
from emp_copy60
group by dno;

select * from v_groupping;

drop view v_groupping;

-- Insert , Update, Delete 가 가능한 뷰
create view v_dept10
as
select dno, dname, loc
from dept_copy60;

insert into v_dept10
values (90,'HR4','PUSAN');

select * from v_dept10;

update v_dept10
set dname = 'HR5',loc='Pusan5'
where dno = 90;

delete v_dept10
where dno = 90;

-- 읽기만 가능한 뷰를 생성 : (insert, update, delete 못하도록 설정 )
create view v_readonly
as
select dno,dname,loc
from dept_copy60 with read only;

insert into v_readonly
values(90,'HR4','DAEGU');

update v_readonly
set dname = 'HR77', loc = 'PUSAN77'
where dno = 30;

delete v_readonly
where dno = 30;




