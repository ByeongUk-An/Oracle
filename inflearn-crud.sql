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


drop table emp03;
drop table emp04;

create table emp03
as
select eno,ename,job from employee where 1=0;

create table emp04
as
select eno,ename,hiredate from employee where 1=0;

insert all
into emp03 (eno,ename,job) values (eno,ename,job)
into emp04 (eno,ename,hiredate) values (eno,ename,hiredate)
select eno, ename, job, hiredate from employee;

select * from emp03;
select * from emp04;


-- 사원번호 이름 급여를 저장할 수 있는 빈 테이블을 만들고
-- 급여가 1500 이상인 사원들의 사원번호, 이름, 급여를 저장한다.

drop table emp05;

create table emp05
as
select eno, ename, salary from employee where 1=0;

insert into emp05 (eno,ename,salary)
select eno, ename, salary
from employee
where salary >= 1500;

select * from emp05;

-- 사원번호, 이름, 부서명을 저장할 수 있는 빈 테이블을 만들고
-- DALLAS 지역에 근무하고 있는 사원들의 사원번호, 이름, 부서명을 저장한다.
drop table emp06;

create table emp06
as
select a1.eno,a1.ename,a2.dname
from employee a1, department a2
where a1.dno = a2.dno and a2.dno = (select dno
                                    from department
                                    where loc = 'DALLAS');

select * from emp06;

-- Update
drop table emp01;

create table emp01
as
select * from employee;

select * from emp01;

-- 사원들의 부서 번호를 40번으로 변경한다.
update emp01
set dno = 40;

select * from emp01;

-- 사원들의 입사일을 오늘로 변경한다.
update emp01
set hiredate = sysdate;

select * from emp01;

-- 사원들의 직무를 개발자로 변경
update emp01
set job = '개발자';

select * from emp01;

-- 여러 컬럼을 update
drop table emp01;

create table emp01
as
select * from employee;

select * from emp01;

-- 사원들의 부서번호를 40, 입사일을 오늘, 직무를 개발자로 변경한다.
update emp01
set dno = 40, hiredate = sysdate, job = '개발자';

select * from emp01;

-- where 조건절을 활용한 update
drop table emp01;

create table emp01
as
select * from employee;

select * from emp01;

-- 10번 부서에 근무하고 있는 사원들을 40번 부서로 수정한다.
update emp01
set dno = 40
where dno = 10;

select * from emp01;

-- SALESMAN 들의 입사일을 오늘, COMMISTION을 2000으로 수정한다.
update emp01
set hiredate = sysdate, commission = 2000
where job = 'SALESMAN'

select * from emp01;

-- 전체 사원의 평균 급여보다 낮은 사람들의 급여를 50% 인상한다.
update emp01
set salary = salary * 1.5
where salary < (select avg(salary)
             from emp01);

select * from emp01;

-- MANAGER 사원들의 직무를 Developer로 변경한다.
update emp01
set job = 'Developer'
where job = 'MANAGER';

select * from emp01;

-- 30번 부서에 근무하고 있는 사원들의 급여를 전체 평균 급여로 설정한다.
update emp01
set salary = (select trunc(avg(salary))
              from emp01)
where dno = 30;

select * from emp01;

-- BLAKE 밑에서 근무하고 있는 사원들의 부서를 DALLAS 지역의 부서번호로 변경한다.
update emp01
set dno = (select dno
            from department
            where loc = 'DALLAS')
where manager = (select eno
                 from emp01
                 where ename = 'BLAKE');

select * from emp01;

-- 20번 부서에 근무하고 있는 사원들의 직속상관을 KING으로 하고 급여를 전체급여의 최고액으로 설정한다.
update emp01
set manager = (select eno
               from emp01
               where ename = 'KING'), 
    salary = (select max(salary)
              from emp01)
where dno = 20;

select * from emp01;

drop table emp01;

create table emp01
as
select * from employee;

select * from emp01;

-- 직무가 CLERK 인 사원들의 직무와 급여액을 20번 부서에 근무하고 있는 사원 중
-- 급여 최고액을 받는 사원의 직무와 급여액으로 변경한다.
update emp01
set (job,salary) = (select job, salary
                    from emp01
                    where salary = (select max(salary)
                                    from emp01))
where job = 'CLERK';


-- delete 구문
drop table emp01;

create table emp01
as
select * from employee;

select * from emp01;

delete from emp01;

select * from emp01;

drop table emp01;

create table emp01
as
select * from employee;

select * from emp01;

-- 사원번호가 7499인 사원의 정보를 삭제한다.
delete from emp01
where eno = 7499;

select * from emp01;

-- 사원의 급여가 평균 급여 이하인 사원의 정보를 삭제한다.
delete from emp01
where salary <= (select avg(salary)
                from emp01);

select * from emp01;

-- 커미션을 받지 않는 사원들의 정보를 삭제한다.
drop table emp01;

create table emp01
as
select * from employee;

select * from emp01;

delete from emp01
where commission is null;

select * from emp01;
























