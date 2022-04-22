-- 현재 접속한 데이터 베이스내의 테이블을 조회한다.

select * from tab;

-- select 파

-- 원하는 테이블의 구조를 조회한다.
select * from employee;

-- 부서의 모든 정보를 가져온다.
select *
from department;

-- 사원의 정보를 가져온다.
select *
from employee;

-- 사원의 이름과 사원 번호를 가져온다.
select ename,eno
from employee;
-- 사원의 이름과 사원 번호, 직무, 급여를 가져온다.
select ename, eno, job, salary
from employee;
-- 부서 번호와 부서 이름을 가져온다.
select * from department;
select dno, dname
from department;

-- 산술 연산자 파트

-- 각사원들의 급여액과 급여액에서 1000을 더한 값, 200을 뺀 값, 2를 곱한 값, 2로 나눈 값을 가져온다.
select salary, salary+1000, salary-200, salary*2, salary/2
from employee;
-- 각 사원의 급여액, 커미션, 급여 + 커미션 액수를 가져온다.
select salary, commission, salary + commission
from employee;

select salary, nvl(commission,0), salary + nvl(commission,0)
from employee;


-- 사원들의 이름과 직무를 다음 양식으로 가져온다.
-- 000 사원의 담당 직무는 xxx 입니다.
select ename, job
from employee;

select ename || '사원의 담당 직무는 ' || job || '입니다'
from employee;


-- Distinct
-- 사원들이 근문하고 있는 근무 부서의 번호를 가져온다.
select Distinct dno
from employee;


-- Where
-- 근무 부서가 10번인 사원들의 사원번호, 이름, 근무 부서를 가져온다.
select dno, eno, ename, job
from employee
where dno = 10;

-- 근무 부서 번호가 10번이 아닌 사원들의 사원번호, 이름, 근무 부서 번호를 가져온다.
select eno, ename, dno
from employee
where Not dno = 10;

select eno, ename, dno
from employee
where dno <> 10;

-- 급여가 1500이상인 사원들의 사원번호, 이름, 급여를 가져온다
select eno, ename, salary
from employee
where salary >= 1500;

-- 이름이 SCOTT 사원의 사원번호, 이름, 직무, 급여를 가져온다.
select eno, ename, job, salary
from employee
where ename = 'SCOTT'
-- 직무가 SALESMAN인 사원의 사원번호, 이름, 직무를 가져온다.
select eno, ename, job
from employee
where job = 'SALESMAN';
-- 직무가 CLERK이 아닌 사원의 사원번호, 이름, 직무를 가져온다.
select eno, ename, job
from employee
where job <> 'CLERK';   -- <> 사용

select eno, ename, job
from employee
where Not job = 'CLERK'  -- Not 사용

-- 1982년 1월 1일 이후에 입사한 사원의 사원번호, 이름, 입사일을 가져온다.
select eno, ename, hiredate
from employee
where hiredate >= '1982/01/01';

--논리연산자
-- 10번 부서에서 근무하고 있는 직무가 MANAGER인 사원의 사원번호, 이름, 근무부서, 직무를 가져온다.
select eno, ename, job, dno
from employee
where dno = 10 and job = 'MANAGER';

-- 입사년도가 1981년인 사원중에 급여가 1500 이상인 사원의 사원번호, 이름, 급여, 입사일을 가져온다.
select eno, ename, salary, hiredate
from employee
where hiredate >= '1981/01/01' and hiredate <= '1981/12/31' and salary >= 1500;


select eno, ename, salary, hiredate
from employee
where hiredate between '1981/01/01' and '1981/12/31' and salary >= 1500;

-- 20번 부서에 근무하고 있는 사원중에 급여가 1500 이상인 사원의 사원번호, 이름, 부서번호, 급여를 가져온다.
select eno, ename, dno, salary
from employee
where dno = 20 and salary >= 1500;

-- 직속상관 사원 번호가 7698번인 사원중에 직무가 CLERK인 사원의 사원번호, 이름, 직속상관번호, 직무를가져온다.
select eno, ename, manager, job
from employee
where manager = 7698 and job = 'CLERK';

-- 급여가 2000보다 크거나 1000보다 작은 사원의 사원번호, 이름, 급여를 가져온다.
select eno, ename, salary
from employee
where salary > 2000 or salary < 1000;

select eno, ename, salary
from employee
where not(salary >= 1000 and salary <= 2000);

select eno, ename, salary
from employee
where not(salary between 1000 and 2000);

-- 부서번호가 20이거나 30인 사원의 사원번호, 이름, 부서번호를 가져온다.
select eno, ename, dno
from employee
where dno = 20 or dno = 30;

-- 직무가 CLERK, SALESMAN, ANALYST인 사원의 사원번호, 이름, 직무를 가져온다.
select eno, ename, job
from employee
where job = 'CLERK' or job = 'SALESMAN' or job = 'ANALYST';

select eno, ename, job
from employee
where job in ('CLERK','SALESMAN','ANALYST');

-- 사원 번호가 7499, 7566, 7839가 아닌 사원들의 사원번호, 이름을 가져온다.
select eno, ename
from employee
where eno <> 7499 and eno <> 7566 and eno <> 7839;

select eno, ename
from employee
where not(eno = 7499 or eno = 7566 or eno = 7839);

select eno, ename
from employee
where eno Not in (7499,7566,7839);

select eno, ename
from employee
where not(eno in(7499,7566,7839));

--like 연산자
-- 이름이 F로 시작하는 사원의 이름과 사원 번호를 가져온다.
select ename, eno
from employee
where ename like('F%');
























