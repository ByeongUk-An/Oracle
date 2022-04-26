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

desc dept20;
alter table dept20
modify dno number(4);

desc dept20;
alter table dept20
modify address Nvarchar2(200);

-- 특정 컬럼 삭제 : 업무시간 외에 작업. (부하가 많이 걸릴수 있다.)
desc dept20;
alter table dept20
drop column birth;

select * from dept20;

desc dept20;
alter table dept20
drop column email;

select * from dept20;


-- 컬럼을 삭제시에 부하가 많이 발생이 됨.
    -- SET UNUSED : 특정 컬럼을 사용 중지 (업무중), 야간에 삭제.

select * from dept20;
desc dept20;    

alter table dept20  -- 업무중일때 특정 컬럼을 사용중지
set unused (address);

alter table dept20  -- 야간에 사용 중지된 컬럼을 삭
drop unused column; -- 사용하지 않는 컬럼을 삭제 함.


/* 컬럼 이름 변경 */
desc dept20;    

alter table dept20
rename column LOC to LOCATIONS;

alter table dept20
rename column dno to D_Number;

/* 테이블 이름 변경 */
rename dept20 to dept30;

desc dept30;

/* 테이블 삭제 */
drop table dept30;


/*
    DDL : Create (생성), Alter (수정), Drop (삭제)
        테이블, 뷰, 인덱스, 트리거, 시퀀스, 함수, 저장프로시저
*/

/*
    DML : Insert (레코드 추가), Update (레코드 수정), Delete (레코드 삭제)
        << 테이블의 값 (레코드, 로우) >>
*/

/*
    DQL : Select
*/

/*
    테이블의 전체 내용이나 테이블 삭제시
    1. delete : 테이블의 레코드를 삭제, where 조건 없이 사용하면 모든 레코드를 삭제  <<포멧>>
    2. truncate : 테이블의 레코드를 삭제, 속도가 굉장히 빠르다. <<빠른포멧>>
    3. drop : 테이블 자체를 삭제
*/

create table emp10
as
select * from employee;

select * from emp10;

-- emp10 : delete를 사용해서 삭제.
delete emp10;
commit;

select * from emp10;

-- emp20 : truncate를 사용해서 삭제.
truncate table emp20;

select * from emp20;

-- emp30 : drop을 사용해서 삭제.
drop table emp30;

select * from emp30;







































































