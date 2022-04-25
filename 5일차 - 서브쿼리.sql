5일차 - 서브쿼리

-- Sub Query : Select 문 내에 Select 문이 있는 쿼리. 
    -- where 조건절 :  sub query
    -- having 조건절 : sub query

 select ename, salary  from employee; 
 select salary from employee where ename='SCOTT'
 
 -- SCOTT의 월급 보다 같거나 많은 사용자를 출력 하라. (서브 쿼리)
 
 select ename, salary from employee where salary >= 3000 
 
  select ename, salary 
  from employee 
  where salary >= (select salary from employee where ename='SCOTT')  
  
  -- SCOTT과 동일한 부서(dno)에 근무하는 사원들 출력 하기. (5분) (sub query)
  select dno from employee where ename = 'SCOTT'
  select ename ,dno from employee where dno = 20
  
    select ename ,dno from employee 
    where dno = (select dno from employee where ename = 'SCOTT')
  
  
  -- 최소 급여를 받는 사원의 이름, 담당업무, 급여 출력 하기. (sub query)
  select min (salary) from employee;
  
  select ename, job, salary 
  from employee
  where salary = (select min (salary) from employee)
  

  
  -- 30번 부서(dno)에서 최소 월급을 받는 사원보다 많은 사원들 이름과, 부서번호와 월급을 출력 해보세요. (7분)
  
  select salary, dno from employee where dno = 30 
  select min(salary) from employee where dno= 30
  
  select ename,  dno, salary 
  from employee
  where salary > (select min(salary) from employee where dno= 30)

    --Having 절에 Sub query 사용하기. 
      
    -- 30번 부서의 최소월급 보다 큰 각 부서의 최소 월급  
    select dno, min(salary), count(dno)
    from employee
    group by dno 
    having min(salary) > ( select min(salary) from employee where dno=30)
    
--단일행 서브 쿼리 : sub query 의 결과 값이 단 하나면 출력.
           -- 단일행 비교 연산자 :  >, = , >=, < , <= , <> , <=   
--다중행 서브 쿼리 : sub query 의 결과 값이 여러개  출력
           -- 다중행 서브쿼리 연산자 : IN, ANY, SOME, ALL, EXISTS
            --IN : 메인 쿼리의 비교 조건 ( '=' 연산자로 비교할 경우) 이 서브쿼리의 결과값중에 하나라도 일치하면 참
            --ANY, SOME : 메인 쿼리의 비교 조건이 서브쿼리의 검색 결과와 하나 이상 일치 하면 참
            --ALL : 메인 쿼리의 비교 조건이 서브 쿼리의 검색 결과와 모든 값이 일치 하면 참
            --EXIST : 메인 쿼리의 비교 조건이 서브 쿼리의 결과값 중에서 만족하는 값이 하나라도 존재하면 참. 
 

-- IN 연산자 사용하기. 
select ename, eno, dno, salary
from employee
order by dno asc

-- 부서별로 최소 월급을 받는 사용자들 출력 하기. (sub query를 반드시 사용해서 출력 ) 

select dno, min(salary), count(*) 
from employee
group by dno

select ename , dno, salary 
from employee 
where salary in (950, 800, 1300)

select ename , dno, salary 
from employee 
where salary in ( select min (salary) from employee group by dno
)

-- ANY 연산자 사용. 
    -- 서브 쿼리가 반환하는 각 각의 값과 비교함. 
    -- ' < any ' 는 최대값 보다 작음을 나타냄. 
    -- ' > any ' 는 최소값 보다 큼을 나타냄. 
    -- ' = any ' 는 IN 과 동일 함. 
    
 예) 직급이 SALESMAN 이 아니면서  급여가 임의의 SALESMAN 보다 작은 사원을 출력. 
            -- 1600 (최대값) 보다 작은 모든 사원(SALESMAN)이 아니고) 
 select eno, ename, job, salary 
 from employee 
 where salary < any (select salary from employee
                        where job = 'SALESMAN') 
                 and job <> 'SALESMAN'        
                
select ename, job, salary from employee order by job;   

--ALL 연산자 
    -- Sub query 의 반환하는 모든 값과 비교. 
    -- ' > all ' : 최대값 보다 큼을 나타냄. 
    -- ' < all ' : 최소값 보다 작음을 나타냄. 

-- 예) 직급이 SALESMAN이 아니면서 직급이 SALESMAN 인 사원 보다 급여가 적은 사원을 모두 출력. 

            -- 1250 (최소값) 보다 작은 사원 ( 직급은 SALESMAN이 아님) 
select eno, ename , job, salary 
from employee
where salary < all (select salary 
                    from employee
                    where job = 'SALESMAN') 
                    and job <> 'SALESMAN' 
                    
-- 담당 업무가 분석가(ANALYST)인 사원보다  급여가 적으면서 업무가 분석가가 이닌 사원들 출력.
select eno, ename, salary, dno 
from employee 
where salary < all ( Select salary 
                     from employee
                     where job = 'ANALYST' ) 
                     and job <> 'ANALYST' 
                     

-- 급여가 평균 급여보다 많은 사원들의 사원번호와 이름을 표시 하되 결과 급여에 대해서 오름차순 하시오. 
select ename, eno, salary 
from employee
where salary  > ( select round (AVG (salary))  from employee)

select min(round (avg(salary),1)) from employee group by job

select job , avg(salary) 
from employee
group by job


subquery 문제. 

Join 문제.

완료 시간 : 6:20분까지.  :  토요일 12 ~ 일요일 저녁 10시 : 오라클 : < 데이터베이스 구현. >

7. SELF JOIN을 사용하여 사원의 이름 및 사원번호를 관리자 이름 및 관리자 번호와 함께 출력 하시오. 
 	각열에 별칭값을 한글로 넣으시오. 
    -- Self JOIN : 반드시 테이블의 별칭을 사용. Select 컬럼을 출력 할때 별칭이름.컬럼명 
        -- 조직도를 출력, 사원의 직속상관 정보를 출력.
    select ename, eno, manager, eno from employee;
    
    -- EQUI JOIN : 오라클 에서만 사용하는 구문  , 두 테이블의 키가 일치하는 것만 출력 
    -- ANSI : INNER JOIN으로 변환 가능 ( 모든 DBMS에서 공통 구문 , MSSQL, MYSQL, IBM DB2)
    
    select e1.ename as 사원이름, e1.eno as 사원번호, e1.manager 관리자번호, e2.ename 관리자이름 
    from employee e1 , employee e2
    where e1.manager = e2.eno 
    
    select * from employee; 
    
    select e1.ename as 사원이름, e1.eno as 사원번호, e1.manager 관리자번호, e2.ename 관리자이름 
    from employee e1 Inner JOIN employee e2
    ON e1.manager = e2.eno   
    

8. OUTER JOIN, SELF JOIN을 사용하여 관리자가 없는 사원을 포함하여 사원번호를 기준으로 내림차순 정렬하여 출력 하시오. 
   
    select e1.ename as 사원이름, e1.eno as 사원번호, e1.manager 관리자번호, e2.ename 관리자이름 
    from employee e1 , employee e2
    where e1.manager = e2.eno (+)
    order by e1.eno desc
    
`   select e1.ename as 사원이름, e1.eno as 사원번호, e1.manager 관리자번호, e2.ename 관리자이름 
    from employee e1 Left Outer JOIN employee e2
    ON e1.manager = e2.eno  
    order by e1.eno desc
    
9. SELF JOIN을 사용하여 지정한 사원<<('SCOTT')>>의 이름, 부서번호, 지정한 사원('SCOTT')과 동일한 부서에서 근무하는 사원을 출력하시오. 
   단, 각 열의 별칭은 이름, 부서번호, 동료로 하시오. 
   
   select e1.ename 이름, e1.dno 부서번호, e2.ename 동료 
   from employee e1, employee e2
   where e1.dno = e2.dno               -- <== 두 테이블의 부서 컬럼을 공통키로 사용. 
   and e1.ename = 'SCOTT' and e2.ename != 'SCOTT' 
   
   select * from employee where ename = 'SCOTT' ; 
   select * from employee where dno = 20 
   
   select ename, dno , ename, dno from employee; 


10. SELF JOIN을 사용하여 WARD 사원보다 늦게 입사한 사원의 이름과 입사일을 출력하시오.
select * from employee;

select * from employee
where hiredate > '81/02/22'

select * from employee
where hiredate > to_date ( 19810222, 'YYYYMMDD')

select * from employee
where hiredate > to_date ( '1981_02_22', 'YYYY_MM_DD')


select ename, hiredate , ename, hiredate from employee; 

select e2.ename 이름, e2.hiredate 입사일 
from employee e1, employee e2
where e2.hiredate > e1.hiredate
and e1.ename = 'WARD'
order by e2.hiredate asc;


11. SELF JOIN을 사용하여 관리자 보다 먼저 입사한 모든 사원의 이름 및 입사일을 관리자 이름 및 입사일과 함께 출력하시오. 
    단, 각 열의 별칭을 한글로 넣어서 출력 하시오. 
    
    select eno, ename, manager, hiredate from employee; 
    
    select e1.ename 사원이름, e1.hiredate 사원의입사일, e2.ename 관리자이름, e2.hiredate 관리자입사일  
    from employee e1, employee e2
    where e1.manager = e2.eno 
    and  e1.hiredate < e2.hiredate 
    
    select eno, ename, manager, hiredate,  eno, ename, manager, hiredate from employee; 
   
<<아래 문제는 모두 Subquery를 사용하여 문제를 푸세요.>>

1. 사원번호가 7788인 사원과 담당 업무가 같은 사원을 표시(사원이름 과 담당업무) 하시오.  

select job , ename from employee where eno = '7788' ; 
select ename, job from employee where job = 'ANALYST' 

select ename, job from employee where job = (select job from employee where eno = '7788'  )


2. 사원번호가 7499인 사원보다 급여가 많은 사원을 표시 (사원이름 과 담당업무) 하시오. 

select ename 사원이름, job 담당업무, salary 월급 
from employee
where salary > (select salary from employee where eno = 7499)

3. 최소 급여를 받는 <<직급별>>로, 사원의 이름, 담당 업무 및 급여를 표시 하시오(그룹 함수 사용)

select job , count(*), min (salary) 
from employee
group by job 

select ename 사원이름, job 담당업무, salary 급여
from employee
where salary in ( select min (salary) 
                from employee
                group by job )
                
4.  <<직급별로 평균 급여를 구하고, 가장 작은  직급 평균에서   가장 작은  사원의  직급과  급여를 표시하시오.>>

select job, round( AVG(salary)) from employee 
group by job 
select * from employee where job = 'CLERK'

select ename 이름,  job 직급, salary 급여 
from employee
where salary = ( select min(salary) from employee
                    group by Job 
                    having avg(salary) = (select min (avg(salary))
                    from employee group by job)
                )

select min (salary) 급여, job 직급
from employee 
group by job 
having avg (salary) <= all (select avg(salary) 
                            from employee 
                            group by job); 

5. 각 부서의 초소 급여를 받는 사원의 이름, 급여, 부서번호를 표시하시오.

select ename 사원이름, job 담당업무, salary 급여
from employee
where salary in ( select min (salary) 
                from employee
                group by job )

6. 담당 업무가 분석가(ANALYST) 인 사원보다 급여가 적으면서 업무가 분석가가 아닌 사원들을 표시 (사원번호, 이름, 담당업무, 급여) 하시오.
    select * from employee where job = 'ANALYST' ; 

    select eno, ename, job, salary 
    from employee 
    where salary < all ( select salary 
                        from employee 
                        where job = 'ANALYST') and job <> 'ANALYST' 
7. 부하직원이 없는 사원의 이름을 표시 하시오. 
select * from employee; 


8. 부하직원이 있는 사원의 이름을 표시 하시오. 
select eno, ename 
from employee
where eno in ( select manager 
                    from employee 
                    where manager is not null )
select * from employee; 

9. BLAKE 와 동일한 부서에 속한 사원의 이름과 입사일을 표시하는 질의를 작성하시오(단, BLAKE 는 제외). 
select * from employee where ename = 'BLAKE'

select ename  성명, hiredate 입사일, dno 부서명 
from employee 
where dno = ( select dno from employee where ename = 'BLAKE' ) and  ename != 'BLAKE'


10. 급여가 평균보다 많은 사원들의 사원번호와 이름을 표시하되 결과를 급여에 대해서 오름 차순으로 정렬 하시오. 
    select eno, ename, salary 
    from employee 
    where salary > ( select round (avg(salary)) from employee ) 
    order by salary asc; 

11. 이름에 K 가 포함된 사원과 같은 부서에서 일하는 사원의 사원번호와 이름을 표시하는 질의를 작성하시오. 
select dno, ename
from employee
where dno in ( select dno from employee where ename like '%K%' )

select * from employee where ename like '%K%' 

12. 부서 위치가 DALLAS 인 사원의 이름과 부서 번호 및 담당 업무를 표시하시오. 
select * from department; 

-- JOIN 을 사용
select ename, e.dno, job, loc             -- 두 테이블의 공통 키 컬럼, EQUI JOIN에서는 테이블명을 명시 
from employee e , department d
where e.dno = d.dno
and loc = 'DALLAS'

--Sub Query 
select ename, e.dno , job , loc 
from employee e, department d 
where e.dno =d.dno
and e.dno in (select dno from department where loc = 'DALLAS')  


13. KING에게 보고하는 사원의 이름과 급여를 표시하시오. 
select * from employee; 

select ename, salary, manager
from employee
where manager = ( select eno from employee where ename='KING' ) 


14. RESEARCH 부서의 사원에 대한 부서번호, 사원이름 및 담당 업무를 표시 하시오.
select * from department

-- JOIN 
select eno 부서번호, ename 사원이름, job 담당업무, dname 부서명 
from employee e, department d
where e.dno  = d.dno 
and d.dname = 'RESEARCH' 

-- Sub Query 
select eno 부서번호, ename 사원이름, job 담당업무, dname 부서명 
from employee e, department d
where e.dno  = d.dno 
and e.dno in ( Select dno from department where dname = 'RESEARCH')  


15. 평균 급여보다 많은 급여를 받고 이름에 M이 포함된 사원과 같은 부서에서 근무하는 사원의 사원번호, 이름, 급여를 표시하시오. 
select round(avg (salary )) from employee 

select eno 사원번호, ename 이름, salary 급여
from employee 
where salary > (select round(avg (salary )) from employee)  
        and dno IN ( select dno from employee where ename like '%M%') 

select * from employee where ename like '%M%' 

16. 평균 급여가 가장 적은 업무를 찾으시오. 
select job 업무 , round ( avg (salary)) 평균급여
from employee
group by job
having avg(salary) = ( select min ( avg(salary) ) from employee group by job )


17. 담당업무가 MANAGER인 사원이 소속된 부서와 동일한 부서의 사원을 표시하시오. 
select ename 사원명 
from employee
where dno in ( select dno from employee where job = 'MANAGER' )

select * from employee where job ='MANAGER' 









            
    
  
  
  
  
  
  
  
  
  
  
  