-- 다음과 같은 정보를 저장하기 위한 테이블을 만든다.
-- 학생번호, 학생이름, 학생나이, 학생국어점수, 영어점수, 수학점수

create table stu_table(
    stu_idx number,
    stu_name char(10),
    stu_age number,
    stu_kor number,
    stu_eng number,
    stu_math number
);

insert into stu_table(stu_idx, stu_name, stu_age, stu_kor, stu_eng, stu_math)
values(1111,'홍길동',30,100,80,70);

select * from stu_table;

create table number_table (
    number1 number,
    number2 number(3),
    number3 number(5,2)
);

insert into number_table (number1)
values(30000);

select * from number_table;

insert into number_table (number2)
values(100);

select * from number_table;

insert into number_table (number3)
values(100.11111);

select * from number_table;


-- 서브쿼리로 테이블 만들기
-- emp 테이블 복제한 emp01 테이블을 만드시오.
drop table emp01;

create table emp01
as
select * from employee;

select * from emp01;

-- emp 테이블에서 사원의 번호, 이름, 급여 정보를 가지고 있는 테이블을 생성하시오.
drop table emp02;

create table emp02
as
select eno,ename,salary
from employee;

select * from emp02;

-- 30번 부서에 근무하고 있는 사원들의 사원번호, 이름, 근무부서 이름을 가지고 있는 테이블을 생성
drop table emp03;

create table emp03
as
select e.eno, e.ename, d.dname
from employee e, department d
where e.dno = d.dno and e.dno = 30;

select * from emp03;

-- 각 부서별 급여 총합, 평균, 최고액, 최저액, 사원수를 가지고 있는 테이블을 생성하시오.
drop table emp04;

create table emp04
as
select sum(salary) 총합, trunc(avg(salary)) 평균, max(salary) 최고액, min(salary) 최저액, count(salary) 사원수
from employee
group by dno;

select * from emp04;



















