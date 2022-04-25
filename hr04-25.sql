--Join 문제
-- 7. SELF JOIN을 사용하여 사원의 이름 및 사원번호를 관리자 이름 및 관리자 번호와 함께 출력하시오.
-- 각열에 별칭값을 한글로 넣으시오.
-- Self JOIN : 자기자신의 테이블을 한번 더 조인 하는것 -> 반드시 테이블의 별칭을 사용. 
-- EQUI JOIN : 오라클에서만 사용하는 구문, 두 테이블의 키가 일치하는 것만 출력
-- ANSI : INNER JOIN으로 변환 가능 (모든 DBMS에서 공통 구문, MSSQL MySQL Oracle)
-- select 컬럼을 출력 할때 별칭이름.컬럼명
-- 조직도를 출력, 사원의 직속상관 정보를 출력할때 많이 사용.
select e1.ename as 사원이름, e1.eno as 사원번호, e1.manager as 관리자번호, e2.eno as 관리자이름
from employee e1, employee e2
where e1.manager = e2.eno

select * from employee;

--Inner JOIN 키 값이 공통적인 부분만 출력한다/
select e1.ename as 사원이름, e1.eno as 사원번호, e1.manager 관리자번호, e2.ename as 관리자이름
from employee e1 Inner JOIN employee e2
ON e1.manager = e2.eno;

-- OUTER JOIN, SELF JOIN을 사용하여 관리자가 없는 사원을 포함하여 사원번호를 기준으로
-- 내림차순 정렬하여 출력 하시오
select e1.ename as 사원이름, e1.eno as 사원번호, e1.manager as 관리자번호, e2.eno as 관리자이름
from employee e1, employee e2
where e1.manager = e2.eno(+)
order by e1.eno;


-- ANSI JOIN : Outer JOIN
select e1.ename as 사원이름, e1.eno as 사원번호, e1.manager 관리자번호, e2.ename as 관리자이름
from employee e1 Left Outer JOIN employee e2
ON e1.manager = e2.eno;

-- 9. SELF JOIN을 사용하여 지정한 사원 SCOTT 의 이름, 부서번호, 지정한 사원 SCOTT과 동일한 부서에서 근무
-- 하고있는 동료의 이름을 가져오시오
-- 단, 각 열의 별칭은 이름, 부서번호, 동료로 하시오.

select e1.ename 이름, e1.dno 부서번호, e2.ename 동료
from employee e1, employee e2
where e1.dno = e2.dno and e1.ename = 'SCOTT' and e2.ename <> 'SCOTT';

-- SELF JOIN 을 사용하여 WARD 사원보다 늦게 입사한 사원의 이름과 입사일을 출력하시오.
-- 81/02/22
select ename, hiredate
from employee
where hiredate > '81/02/22';

select * from employee
where hiredate > to_date ('81/02/22');

select * 
from employee
where hiredate > to_date (19810222,'YYYYMMDD');

select * 
from employee
where hiredate > to_date ('1981_02_22','YYYY_MM_DD');

select e2.ename, e2.hiredate 
from employee e1, employee e2
where e2.hiredate > e1.hiredate and e1.ename = 'WARD'
order by e2.hiredate asc;

-- 11. SELF JOIN을 사용하여 관리자 보다 먼저 입사한 모든 사원의 이름 및 입사일을 관리자 이름 
-- 및 입사일과 함께 출력하시오.
-- e1 : 사원
-- e2 : 관리자
select e1.ename as 사원이름, e1.hiredate as 사원입사일, e2.ename as 관리자이름, e2.hiredate as 관리자입사일
from employee e1, employee e2
where e1.manager = e2.eno and e2.hiredate > e1.hiredate;

select eno, ename, manager, hiredate, eno, ename, manager, hiredate from employee;

--subquery
--1. 사원번호가 7788인 사원과 담당 업무가 같은 사원을 표시 사원이름 담당업무
select ename, job
from employee
where eno = '7788' and job = (select job
                              from employee
                              where eno = '7788');

-- 2. 사원번호가 7499인 사원보다 급여가 많은 사원을 표시 사원이름 담당업무를 가져오시오
select ename, job, salary
from employee
where salary > (select salary
                from employee
                where eno = '7499');

-- 3. 최소 급여를 받는 <<직급별>>로, 사원의 이름, 담당 업무 및 급여르 ㄹ 표시 하시오


select ename 사원이름, job 담당업무, salary 급여
from employee
where salary in (select min(salary)
                from employee
                group by job);


-- 4. <<직급별로 평균 급여를 구하고, 가장 작은 직급 평균에서 가장 작은 사원의 
-- 직급과 급여를 표시하시오.
select job, round(avg(salary)) from employee
group by job

select ename,job, salary
from employee
where salary = (select min(salary)
                from employee
                group by job
                having avg(salary) = (select min(avg(salary))
                                      from employee
                                      group by job));
                
select min (salary) 급여, job 직급
from employee
group by job
having avg(salary) <= all (select avg(salary)
                           from employee
                           group by job);

-- 5. 각 부서의 최소 급여를 받는 사원의 이름, 급여, 부서번호를 표시하시오
select ename, salary, dno
from employee
where salary in (select min (salary)
                from employee
                group by job);

-- 6. 담당 업무가 ANALYST 인 사원보다 급여가 적으면서 업무가 ANALYST가 아닌 사원들을 표시
-- 사원번호, 이름, 담당업무, 급여 표시
select eno, ename, job, salary
from employee
where salary < all (select salary
                    from employee
                    where job = 'ANALYST' and job <> 'ANALYST');

-- 7. 부하직원이 있는 사원의 이름을 표시하시오.
select eno, ename, manager
from employee
where eno in (select manager
                  from employee
                  where manager is not null);












