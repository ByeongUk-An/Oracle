--7일차 - 제약 조건

-- 테이블 복사 : 테이블의 전체를 복사함.
    -- 테이블을 복사하면, 컬럼과 레코드만 복사가 됨.
    -- 테이블의 할당된 제약조건은 복사 되지 않는다. (Alter Table을 사용해서 할당 해야 한다.)
    -- 제약조건 : 컬럼에 할당되어 있다. 무결성을 체크
        -- NOT NULL, Primary Key, Unique, Foreign Key, Check, Default


create table dept_copy
as
select * from department;

desc department;
desc dept_copy;

select * from dept_copy;

create table emp_copy
as
select * from employee;

select * from emp_copy;

-- 테이블 복사 : 특정 컬럼만 복사하
create table emp_second
as
select eno, ename, salary, dno from employee;

select * from emp_second;

-- 테이블 복사 : 조건을 사용해서 테이블 복사.
create table emp_third
as
select eno, ename, salary
from employee
where salary > 2000;

select * from emp_third;

-- 테이블 복사 : 컬럼명을 바꾸어서 복사
create table emp_forth
as
select eno 사원번호, ename 사원명, salary 월급
from employee

select * from emp_forth;

select 사원번호, 사원명, 월급 from emp_forth;  -- 테이블명, 컬럼명, <== 영문 사용을 권장.

-- 테이블 복사 : 계산식을 이용해서 테이블 복사 -> 반드시 별칭 이름을 사용해야 한다.
create table emp_fifth
as
select eno, ename, salary * 12 from employee;   -- 문제발생

create table emp_fifth
as
select eno, ename, salary * 12 as salary from employee;

-- 테이블 복사 : 테이블 구조만 복사, 레코드는 복사하지 않는다.
create table emp_sixth
as
select * from employee
where 1=0;       -- where 조건 : false 를 리턴

select * from emp_sixth;

-- 테이블 수정 : Alter Table
create table dept20
as
select * from department;

desc dept20;
select * from dept20;

-- 기존의 테이블에서 컬럼을 추가 : 주의 : 반드시 추가할 컬럼에 NULL을 허용해야 한다.
Alter Table dept20
add (birth date);

desc dept20;
select * from dept20;

alter table dept20
add (email varchar2(100));

alter table dept20
add (address varchar2(200));

-- 컬럼의 자료형을 수정 :
desc dept20;
alter table dept20
modify dname varchar2(50);






























































































