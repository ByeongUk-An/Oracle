-- 그룹함수 문제

-- 1. 모든 사원의 급여 최고액, 최저액, 총액, 및 평균 급여를 출력 하시오. 
--컬럼의 별칭은 동일(최고액,최저액,총액,평균)하게 지정하고 평균에 대해서는 정수로 반올림
select max(salary) 최고액, min(salary) 최저액, sum(salary) 총액, round(avg(salary)) 평균급여
from employee;

-- 2. 각 담당업무 유형별로 급여 최고액,최저액,총액 및 평균액을 출력하시오. 
-- 컬럼의 별칭은 동일(최고액,최저액,총액,평균)하게 지정하고 평균에 대해서는 정수로 반올림 하시오.
select job 직무, max(salary) 최고액, min(salary) 최저액, sum(salary) 총액, round(avg(salary)) 평균급여
from employee
group by(job);

-- rollup, cube : group by 절에서 사용하는 특수한 키워드.
select job 직무, max(salary) 최고액, min(salary) 최저액, sum(salary) 총액, round(avg(salary)) 평균급여
from employee
group by rollup(job);

select job 직무, max(salary) 최고액, min(salary) 최저액, sum(salary) 총액, round(avg(salary)) 평균급여
from employee
group by cube(job)
order by job;

-- 두 개이상의 컬럼을 그룹핑
select dno, job, max(salary) 최고액, min(salary) 최저액, sum(salary) 총액, round(avg(salary)) 평균급여
from employee
group by dno, job -- 두개이상의 컬럼을 그룹핑 : 두 컬럼이 모두 만족될때 그룹



-- 3. count(*)함수를 사용하여 담당 업무가 동일한 사원수를 출력하시오.
select jb from employee;

select distinct job from employee;


select job, count(*)
from employee
group by job;

-- 4. 관리자 수를 나열 하시오. 컬럼의 별칭은 "관리자수" 로 나열 하시오. 
select manager from employee;

select count( distinct manager) from employee;  -- count 는 null을 포함하지 않는다.

select distinct manager from employee;

select manager, count(manager) 관리자수
from employee
group by manager;

-- 5. 급여 최고액, 최저 급여액의 차액을 출력 하시오, 컬럼의 별칭은 "DIFFERENCE"로 지정하시오. 
select (max(salary) - min(salary)) as DIFFERENCE
from employee;

--6. 직급별 사원의 최저 급여를 출력하시오. 관리자를 알 수 없는 사원 및 
--   최저 급여가 2000미만인 그룹은 제외 시키고 결과를 급여에 대한 내림차순으로 정렬하여 출력 하시오. 
select job, min(salary)
from employee
where manager is not null
group by job
having min(salary) > 2000
order by min(salary) desc;

-- 7. 각 부서에대해 부서번호, 사원수, 부서내의 모든 사원의 평균 급여를 출력하시오. 
--컬럼의 별칭은 [부서번호, 사원수, 평균급여] 로 부여하고 평균급여는 소숫점 2째자리에서 반올림 하시오. 
select dno 부서번호, count(*) 사원수, round(avg(salary),2) 평균급여
from employee
group by dno;

-- 8. 각 부서에 대해 부서번호이름, 지역명, 사원수, 부서내의 모든 사원의 평균 급여를 출력하시오. 
-- 컬럼의 별칭은 아래 [ 출력예시] 로 지정하고 평균급여는 정수로 반올림 하시오.  
select dno dname, count(*) as "사원 수", round(avg(salary)) as "평균 급여",
decode(dno,
        '10','ACCOUNTING',
        '20','RESEARCH',
        '30','SALES',
        '40','OPERATIONS'
        ) as "부서이름",
decode(dno,
        '10','NEW YORK',
        '20','DALLAS',
        '30','CHICAGO',
        '40','BOSTON'
        ) as "지역명"
from employee
group by dno;
        
-- where 와 having 절이 같이 사용 되는 경우
    -- where : 실제 테이블의 조건으로 검색
    -- having : group by 결과에 대해서 조건을 처리.
    
select * from employee;
-- 월급이 1500 이하는 제외하고 각 부서별로 월급의 평균을 구하되 월급의 평균이 2500이상인것만 출력
select dno, count(*), round(avg(salary)) as 부서별평균
from employee
where salary > 1500
group by dno
having round (avg(salary)) > 2500

-- ROLLUP
-- CUBE
    -- Group by 절에서 사용하는 특수한 함수
    -- 여러 컬럼을 나열 할 수 있다.
    -- group by 절의 자세한 정보를 출력...

--Rollup : 부서별 합계와 평균을 출력 후, 마지막 라인에 전체 합계, 평균
select dno, count(*), sum(salary), round(avg(salary))
from employee
group by dno, rollup(dno)
order by dno;

-- cube : 부서별 합계와 평균을 출력 후, 마지막 라인에 전체 합계, 평균
select dno, count(*), sum(salary), round(avg(salary))
from employee
group by cube(dno)
order by dno;

-- Rollup : 두 컬럼이상
select dno, job, count(*), max(salary), sum(salary), avg(salary)
from employee
group by rollup (dno,job)  -- 두개의 컬럼이 적용됨, 두 컬럼에 걸쳐서 동일할때 그룹핑.

-- cube
select dno, job, count(*), max(salary), sum(salary), avg(salary)
from employee
group by cube (dno, job)
order by dno, job;


-- JOIN : 여러 테이블을 합쳐서 각 테이블의 컬럼을 가져온다.
    -- department 와 employee는 원래는 하나의 테이블이었으나 모델링(중복제거, 성능향상)을 통해서 두테이블을 분리
    -- 두 테이블의 공통키 컬럼 (dno), employee 테이블의 dno 컬럼은 department 테이블의 dno 컬럼을 참조
    -- 두개 이상의 테이블의 컬럼을 JOIN구문을 사용해서 출력.
select * from department;  -- 부서정보를 저장 하는 테이블
select * from employee;  -- 사원정보를 저장하는 테이블

-- EQUI JOIN : 오라클에서 제일 많이 사용하는 JOIN , Oracle 에서만 사용
    -- from 절 : 조인할 테이블을 "," 로 처리,
    -- where 절 : 두 테이블의 공통의 키 컬럼 " = " 로 처리
    -- and 절 : 조건을 처리.
select  *
from employee, department
where department.dno = employee.dno
and job = "MANAGER"

-- JOIN시 테이블 알리어스
selet *
from employee as e, department as d
where e.dno =d.dnosdddddddd

-- 두 테이블을 JOIN 해서 월급(salary)의 최대값을 부서명(dname)으로 출력해 보세요.
select dname,count(*), max(salary)
from department d , employee e
where d.dno = e.dno
group by dname

-- NATURAL JOIN : Oracle 9i 지원
    -- EQUI JOIN 의 Where 절을 없앰 : 두 테이블의 공통의 키 컬럼을 정의 " = "
    -- 공통의 키 컬럼을 Oracle 내부적으로 자동으로 처리.
    -- 공통 키컬럼을 별칭 이름을 사용하면 오류 발생.

select eno, ename, dname, dno
from employee e natural join department d

-- 주의 : select 절의 공통키 컬럼을 출력시 테이블명을 명시하면 오류 발생.

-- EQUI JOIN vs NATURAL JOIN 의 공통 키 컬럼 처리
    --EQUI JOIN : select에서 반드시 공통 키 컬럼을 출력 할때 테이블명을 반드시 명시.
    --NATURAL JOIN : select에서 반드시 공통 키 컬럼을 출력 할때 테이블명을 명시 X.
    
-- EQUI JOIN : 오라클에서 제일 많이 사용하는 JOIN, Oracle 에서만 사용가능
    -- from 절 : 조인할 테이블을 "," 로 처리,
    -- where 절 : 두 테이블의 공통의 키 컬럼을 " = " 로 처리
    -- and 절 : 조건을 처리
    -- on 절 : 두 테이블의 공통의 키 컬럼을 " = " 로 처리
        -- where 절 : 조건을 처리
select ename, salary, dname, e.dno
from employee e, department d
where e.dno = d.dno

-- NATURAL JOIN
select ename, salary, dname, dno
from employee e natural join department d


-- Where 절 :
select *
from employee, department
where department.dno = employee.dno  -- 공통 키 적용
and job = 'MANAGER'                  -- 조건을 처리



-- ON 절 : 공통 키 컬럼을 처리한 경우
select *
from employee e JOIN department d
on e.dno = d.dno
where job = 'MANAGER'


-- 1. EQUI 조인을 사용하여 SCOTT 사원의 부서 번호와 부서 이름을 출력 하시오. 
select e.ename, e.dno, d.dname
from employee e, department d
where e.dno = d.dno and e.ename='SCOTT';

-- 2. INNER JOIN과 ON 연산자를 사용하여 사원이름과 함께 그 사원이 소속된 부서이름과 지역명을 출력하시오. 
select e.ename, d.dname, d.loc
from employee e inner join department d
on e.dno = d.dno
order by dname;

-- 제약 조건 : 테이블의 컬럼에 할당되어서 데이터의 무결성을 확보
    -- Primary Key : 테이블에 한번만 사용할 수 있다. 하나의 컬럼, 두개이상을 그룹핑해서 적용.
                -- 중복된 값을 넣을 수 없다. NULL을 넣을 수 없다.
    -- UNQUE : 테이블에 여러 컬럼에 할당 할 수 있다.
                -- NULL 넣을수 있다. 단 한번만 NULL
    -- Foreign Key : 다른 테이블의 특정 컬럼의 값을 참조해서만 넣을 수 있다.
                -- 자신의 컬럼에 임의의 값을 할당하지  못한다.
    -- NOT NULL : NULL 값을 컬럼에 할당할 수 없다.
    -- CHECK : 컬럼에 값을 할당 할 때 체크해서 (조건에 만족)
    -- Default

-- 3. INNER JOIN과 USING 연산자를 사용하여 10번 부서에 속하는 모든 담당 업무의 고유한 목록(한번씩만 표시)을 부서의 지역명을 포함하여 출력 하시오. 
 --나중에 풀기
 
-- 4. NATUAL JOIN을 사용하여 커밋션을 받는 모든 사원의 이름, 부서이름, 지역명을 출력 하시오. 
select e.ename 사원이름 , d.dname 부서이름, d.loc 지역명
from employee e NATURAL JOIN department d
where not commission is null;

--5. EQUI 조인과 WildCard를 사용하여 이름에 A 가 포함된 모든 사원의 이름과 부서명을 출력 하시오. 
select e.ename 이름, d.dname 부서명
from employee e, department d
where e.dno = d.dno
and e.ename like '%A%';

--6. NATURAL JOIN을 사용하여 NEW YORK에 근무하는 모든 사원의 이름, 업무, 부서번호 및 부서명을 출력하시오. 
select e.ename 사원명, e.job 업무, dno 부서번호, d.dname 부서명
from employee e natural join department d
where d.loc = 'NEW YORK';





 




















