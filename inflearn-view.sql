-- 사원의 사원번호, 이름, 급여, 근무부서이름, 근무지역을 가지고 있는 뷰를 생성한다.

drop view emp_dept_view;

create view emp_dept_view
as
select a1.eno, a1.ename, a1.salary, a2.dname, a2.loc
from employee a1, department a2
where a1.dno = a2.dno;

-- 뷰를 조회한다.
select * from emp_dept_view;

-- 테이블을 생성
drop table emp100;

create table emp100
as
select * from employee;

drop table dept100;

create table dept100
as
select * from department;


create view emp100_dept100_view
as
select a1.eno, a1.ename, a1.salary, a2.dname, a2.loc
from emp100 a1, dept100 a2
where a1.dno = a2.dno;

select a1.eno, a1.ename, a1.salary, a2.dname, a2.loc
from emp100 a1, dept100 a2
where a1.dno = a2.dno;

select * from emp100_dept100_view;

-- 원본 테이블에 데이터를 저장한다.
insert into emp100 (eno,ename,salary,dno)
values(5000,'홍길동',2000,10);

select * from emp100;

select * from emp100_dept100_view;

-- 뷰를 통해서 데이터 저장되지 않을때 (조인을 하였을때)
insert into emp100_dept100_view (eno,ename,salary)
values( 6000,'이순신',3000);

-- 뷰를 통해서 데이터 저장 (조인을 하지 않았을때)
create view emp200_view
as
select eno,ename,salary
from emp100;

insert into emp200_view (eno,ename,salary)
values (7777,'안순신',2000);





















