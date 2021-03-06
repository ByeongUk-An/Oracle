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
where ename like 'F%';

-- 이름이 s로 끝나는 사원의 이름과 사원 번호를 가져온다.
select ename, eno
from employee
where ename like '%S';

-- 이름에 A가 포함되어 있는 사원의 이름과 사원 번호를 가져온다.
select ename,  eno
from employee
where ename like '%A%';

-- 이름의 두번째 글자가 A인 사원의 사원 이름, 사원 번호를 가져온다.
select ename, eno
from employee
where ename like '_A%';

-- 이름이 4글자인 사원의 사원 이름, 사원 번호를 가져온다.
select ename, eno
from employee
where ename like '____';


-- Null
-- 사원중에 커미션을 받지 않는 사원의 사원번호, 이름, 커미션을 가져온다.
select eno, ename, commission
from employee
where commission is null; 

-- 커미션을 받는 사원의 사원번호, 이름, 커미션 가져온다.
select eno, ename, commission
from employee
where commission is not null;

-- 회사 대표(직속상관이 없는 사람)의 이름과 사원번호를 가져온다.
select ename,eno
from employee
where manager is null;

-- 직속상관이 있는 사람의 이름과 사원번호를 가져온다.
select ename,eno
from employee
where manager is not null;


select dno,sum(salary)
from employee
group by dno
having sum(salary) >= 3000;

select ename 사원이름, e.dno 부서번호, job
from employee e, department d
where e.dno = d.dno and ename = 'SCOTT';

select ename 사원이름, dname 부서이름, loc 지역명
from employee e
natural join department d
where commission is not null and not(commission = 0);


-- 사원의 사원번호, 이름, 급여를 가져온다. 급여를 기준으로 오름차순 정렬을 한다.
select eno 사원번호, ename 이름, salary 급여
from employee
order by salary asc;
-- 오름차순일때는 asc 생략가능.
select eno 사원번호, ename 이름, salary 급여
from employee
order by salary;

-- 사원의 사원번호, 이름, 급여를 가져온다. 사원번호를 기준으로 내림차순 정렬을 한다.
select eno 사원번호, ename 이름, salary 급여
from employee
order by eno desc;

-- 사원의 사원번호, 이름을 가져온다, 사원의 이름을 기준으로 오름차순 정렬을 한다.
select eno 사원번호, ename 이름
from employee
order by ename asc;

-- 사원의 사원번호, 이름, 입사일을 가져온다. 입사일을 기준으로 내림차순 정렬을 한다.
select eno 사원번호, ename 이름, hiredate 입사일
from employee
order by hiredate desc;

-- 직무가 SALESMAN인 사원의 사원이름, 사원번호, 급여를 가져온다. 급여를 기준으로 오름차순 정렬을 한다.
select ename 사원이름, eno 사원번호, salary 급여
from employee
where job = 'SALESMAN' 
order by salary asc;

-- 1981년에 입사한 사원들의 사원번호, 사원이름, 입사일을 가져온다. 사원 번호를 기준으로 내림차순 정렬을 한다.
select eno 사원번호, ename 사원이름, hiredate 입사일
from employee
where hiredate between '1981/01/01' and '1981/12/31'
order by eno desc;

-- 사원의 이름, 급여, 커미션을 가져온다. 커미션을 기준으로 오름차순 정렬을 한다.
select ename 이름, salary 급여, commission 커미션
from employee
order by commission asc;

-- 사원의 이름, 급여, 커미션을 가져온다. 커미션을 기준으로 내림차순 정렬을 한다.
select ename 이름, salary 급여, commission 커미션
from employee
order by commission desc;

-- 사원의 이름, 사원번호, 급여를 가져온다. 급여를 기준으로 내림차순 정렬, 이름을 기준으로 오름차순 정렬
select ename 이름, eno 사원번호, salary 급여
from employee
order by salary desc, ename asc;


-- 숫자함수
-- 절대값 구하기 abs()
select -10, abs(-10) from dual;

-- 전직원의 급여를 2000 삭감하고 삭감한 급여액의 절대값을 구한다.
select ename, salary, abs(salary-2000)
from employee

-- 소수점 이하 버림 floor()
select 12.3456, floor(12.3456)
from dual;

-- 전직원의 급여를 2000 삭감하고 삭감한 급여액의 절대값을 구한다.
select salary, salary - 2000, abs(salary-2000)
from employee;

-- 급여가 1500 이상인 사원의 급여를 15% 삭감한다. 단 소수점 이하는 버린다.
select salary, salary * 0.85, floor(salary * 0.85)
from employee
where salary >= 1500;

-- 급여가 2천 이하인 사원들의 급여를 20%씩 인상한다. 단 10의 자리를 기준으로 반올림한다.
select 12.3456, round(12.3456) from dual;
select 12.8888, round(12.8888) from dual;
select 12.8888, round(12.8888,2) from dual;
select 88.8888, round(88.8888,-2) from dual;

-- 급여가 2천 이하인 사원들의 급여를 20%씩 인상한다. 단 10의 자리를 기준으로 반올림한다.
select salary, salary * 1.2, round(salary * 1.2,2)
from employee
where salary <= 2000;

-- 버림. 자리수를 정할 수 있다.
select 1112.3456, trunc(1112.23456,2) from dual;

-- 전 직원의 급여를 10의자리 이하를 삭감한다.
select salary, trunc(salary,-2)
from employee;

-- 나머지 구하기
select mod(10,3), mod(10,4)
from dual;

-- 문자열 함수
-- 대문자 -> 소문자
select 'ABcdEF', lower('ABcdEF') from dual;

-- 사원들의 이름을 소문자로 가져온다.
select ename lower(ename)
from employee;

-- 소문자 --> 대문자
select 'ABcdEF', upper('ABcdEF') from dual;

-- 사원들의 이름을 가져온다. 대문자 -> 소문자 -> 대문자
select ename, lower(ename), upper(lower(ename))
from employee;

-- 첫 글자만 대문자로, 나머지는 소문자로
select 'aBCDEF', initcap('aBCDEF') from dual;

-- 사원이름을 첫 글자는 대문자로 나머지는 소문자로 가져온다.
select ename, initcap(ename)
from employee;

-- 문자열 연결
select concat('abc','def')
from dual;

-- 사원들의 이름과 직무를 다음과 같이 가져온다.
-- 사원의 이름은 000 이고, 직무는 000입니다.
select concat(concat(concat(concat('사원의 이름은 ', ename),' 이고, 직무는 '),job),'입니다')
from employee;

select '사원들의 이름은 ' || ename || '이고, 직무는 ' || job || '입니다'
from employee;

-- 문자열의 길이
select length('abcd'), lengthb('abcd'),length('안녕하세요'),lengthb('안녕하세요')
from dual;

-- 문자열 잘라내기
select substr('abcd',3), substrb('abcd',3),substr('안녕하세요',3),substrb('안녕하세요',3)
from dual;

select substr('abcdefghi',3,4), substr('동해물과 백두산이',3,4)
from dual;

--문자열 찾기
select instr('abcdabcdabcd','bc'), instr('abcdabcdabcd','bc',3),
       instr('abcdabcdabcd', 'bc',3,2)
from dual;

select instr('abcdefg','aaa') form dual;

-- 사원의 이름 중에 A라는 글자가 두번째 이후에 나타나는 사원의 이름을 가져온다.
select ename
from employee
where instr(ename,'A') > 1;

-- 특정 문자열로 채우기
select '문자열', lpad('문자열',20,'*') from dual;
select '문자열', rpad('문자열',20,'*') from dual;

-- 공백제거
select '    문자열    ', ltrim('    문자열    '), rtrim('    문자열    ') from dual;

-- 문자열 변경
select 'abcdefg', replace('abcdefg','abc','kkkkkk') from dual;


--날짜 함수
-- 현재 날짜 구하기
select sysdate from dual;

-- 날짜 데이터 연산(현재시간-10000일)
select sysdate, sysdate - 10000, sysdate + 10000
from dual;

-- 각 사원의입사한 날짜로 부터 1000일 후가 되는 날짜를 가져온다.
select hiredate, hiredate + 1000
from employee;

-- 직무가 SALESMAN인 사원의 입사일 100일전 날짜를 가져온다.
select hiredate, hiredate - 100
from employee
where job = 'SALESMAN';

-- 전 사원의 근무 일을 가져온다.
select  trunc(sysdate - hiredate)
from employee

-- 반올림
select sysdate, round(sysdate,'CC') as "년도두자리", round(sysdate,'YYYY') as "월기준",
                round(sysdate,'DDD') as "시기준", round(sysdate,'HH') as "분기준",
                round(sysdate,'MM') as "일기준", round(sysdate,'DAY') as "주기준",
                round(sysdate,"MI') as "초기준"
from dual;

-- 각 사원의 입사일을 월 기준으로 반올림한다.
select hiredate, round(hiredate, 'YYYY')
from employee;

-- 버림
select sysdate, trunc(sysdate, 'CC') as "년도두자리", trunc(sysdate, 'YYYY') as "월",
                trunc(sysdate, 'DDD') as "시기준", trunc(sysdate,'HH') as "분기준",
                trunc(sysdate, 'MM') as "일기준", trunc(sysdate,'DAY') as "주기준",
                trunc(sysdate, 'MI') as "초기준"
from dual;

-- 1981년에 입사한 사원들의 사원번호, 사원이름, 급여, 입사일을 가져온다.
select eno, ename, salary, hiredate
from employee
where hiredate >= '1981/01/01' and hiredate <= '1981/12/31';

select eno, ename, salary, hiredate
from employee
where hiredate between '1981/01/01' and '1981/12/31';

select eno, ename, salary, hiredate
from employee
where trunc(hiredate, 'YYYY') = '1981/01/01';

-- 두 날짜 사이의 일수를 구한다.
select sysdate - hiredate
from employee;

-- 모든 사원이 근무한 개월 수를 구한다.
select trunc(months_between(sysdate,hiredate))
from employee;

-- 개월수를 더한다.
select sysdate + 100, add_months(sysdate,100)
from dual;

-- 각 사원들의 입사일 후 100개월 되는 날짜를 구한다.
select hiredate, add_months(hiredate,100)
from employee;

-- 지정된 날짜를 기준으로 지정된 요일이 몇일인지...
select sysdate, next_day(sysdate, '월요일') from dual;

-- 지정된 날짜의 월의 마지막 날짜를 구한다.
select sysdate,last_day(sysdate)
from dual;

-- to_char : 오라클 -> 프로그램
select sysdate, to_char(sysdate, 'YYYY-MM-DD HH:MI:SS AM') from dual;

-- o_date : 프로그램 -> 오라클
select to_date('2018-03-20 01;58:20 오후', 'YYYY-MM-DD HH:MI:SS AM') from dual;

-- 사원들의 입사일을 다음과 같은 양식으로 가져온다.
-- 1900-10-10
select hiredate, to_char(hiredate,'YYYY-MM-DD') from employee;


--DECODE
-- 각 사원의 부서이름을 가져온다.
-- 10 : 인사부 20: 개발부 30: 경영지원팀 40: 생산부
select eno, ename, 
       decode(dno, 10, '인사부',
                   20, '개발부',
                   30, '경영지원팀',
                   40, '생산부')
from employee;

-- 직급에 따라 인상된 급여액을 가져온다.
-- CLERK : 10% SALESMAN : 15% PRESIDENT : 200% MANAGER : 5% ANAYST : 20%
select eno, ename, job,
       decode(job, 'CLERK', salary * 1.1,
                   'SALESMAN', salary * 1.15,
                   'PRESIDENT', salary * 3,
                   'MANAGER', salary * 1.05,
                   'ANALYST' , salary * 1.2)
from employee;


-- CASE WHEN THEN
-- 급여액 별 등급을 가져온다.
-- 1000미만 : C등급, 1000이상 2000미만 : B등급, 2000이상 : A등급
select eno,ename,salary,
                      case when salary < 1000 then 'C등급'
                      when salary >= 1000 and salary < 2000 then 'B등급'
                      when salary >= 2000 then 'A등급'
                      end
from employee;

-- 직원들의 급여를 다음과 값이 인상한다.
-- 1000 이하 : 100%, 1000초과 2000미만 : 50%, 2000이상 : 200%
select eno,ename,salary,
       case when salary <= 1000 then salary * 2
            when salary > 1000 and salary <= 2000 then salary * 0.5
            when salary >= 2000 then salary * 3
       end
from employee;

-- 그룹함수
-- 사원들의 급여 총합을 구한다.
select sum(salary)
from employee;

-- 사원들의 커미션을 가져온다. null값이 포함된경우 제외하고 실행된다.
select sum(commission)
from employee;

-- 급여가 1500이상인 사원들의 급여 총합을 구한다.
select sum(salary)
from employee
where salary >= 1500;

-- 20번 부서에 근무하고 있는 사원들의 급여 총합을 구한다.
select sum(salary)
from employee
where dno = 20;

-- 직무가 SALESMAN인 사원들의 급여 총합을 구한다.
select sum(salary)
from employee
where job ='SALESMAN';

-- 전 사원의 평균 급여를 구한다.
select trunc(avg(salary))
from employee;

-- 커미션을 받는 사원들의 커미션 평균을 구한다.
select trunc(avg(commission))
from employee;


-- 전 사원의 커미션의 평균을 구한다.
select trunc(avg(nvl(commission,0)))
from employee;

-- 커미션을 받는 사원들의 평균을 구한다.
select trunc(avg(commission)) 
from employee
where commission is not null;

-- 30번 부서에 근무하고 있는 사원들의 급여 평균을 구한다.
select trunc(avg(salary))
from employee
where dno = 30;

-- 직무가 SALESMAN인 사원들의 급여 + 커미션 평균을 구한다.
select trunc(avg(salary+commission))
from employee
where job = 'SALESMAN'

-- 사원들의 총 수를 구한다.
select count(eno)
from employee;

-- 커미션을 받는 사원들의 총 수를 가져온다.
select count(commission)
from employee
where commission is not null;


-- 사원들의 급여 최대, 최소값을 가져온다.
select max(salary), min(salary)
from employee;


-- Group by
-- 각 부서별 사원들의 급여 평균을 구한다.
select dno, trunc(avg(salary))
from employee
group by dno;

-- 각 직무별 사원들의 급여 총합을 구한다.
select job, sum(salary)
from employee
group by job;

-- 1500이상 급여를 받는 사원들의 부서별 급여 평균을 구한다.
select dno, trunc(avg(salary))
from employee
where salary >= 1500
group by dno;


-- Having
-- 부서별 평균 급여가 2000이상 부서의 급여 평균을 가져온다.
select dno,avg(salary)
from employee
group by dno
having avg(salary) >= 2000;

-- 부서별 최대 급여액이 3000이하인 부의 급여 총합을 가져온다.
select dno, sum(salary)
from employee
group by dno
having max(salary) <= 3000;

-- 부서별 최소 급여액이 1000 이하인 부서에서 직무가 CLERK인 사원들의 급여 총합을 구한다.
select dno,job,sum(salary)
from employee
where job = 'CLERK'
group by dno,job
having min(salary) <= 1000;

-- 각 부서의 급여 최소가 900이상 최대가 10000이하 부서의 사원 중 1500이상의 
-- 급여를 받는 사원들의 평균 급액을 가져온다.
select ename,dno,trunc(avg(salary))
from employee
where salary >= 1500
group by ename,dno
having min(salary) >= 900 and max(salary) <= 10000;


-- Join(조인)
-- 사원테이블(employee)과 부서테이블(department)을 join 한다.
select * from employee;  --14
select * from department;  --8

select * 
from employee e,department d
where e.dno = d.dno; 
;  --56


-- 사원의 사원번호, 이름, 근무부서 이름을 가져온다.
select e.eno, e.ename, d.dname
from employee e, department d
where e.dno = d.dno;

-- 사원의 사원번호, 이름, 근무지역을 가져온다.
select e.eno, e.ename, d.loc
from employee e, department d
where e.dno = d.dno;

-- DALLAS에 근무하고 있는 사원들 사원번호, 이름, 직무를 가져온다.
select e.eno, e.ename, e.job, d.loc
from employee e, department d
where e.dno = d.dno and d.loc = 'DALLAS';


-- SALES 부서에 근무하고있는 사원들의 급여 평균을 가져온다.
select trunc(avg(salary))
from employee e, department d
where e.dno = d.dno and d.dname = 'SALES'

-- 1982에 입사한 사원들의 사원번호, 이름, 입사일, 근무부서 이름을 가져온다.
select e.eno, e.ename, e.hiredate, d.dname
from employee e, department d
where e.dno = d.dno and e.hiredate between '1982/01/01' and '1982/12/31'

-- 각 사원들의 사원번호, 이름, 급여, 급여등급을 가져온다.
select * from salgrade;
select * from employee;

select e.eno, e.ename, e.salary, s.grade
from employee e, salgrade s
where e.salary between s.losal and s.hisal;

-- SALES 부에 근무하고 있는 사원 사원번호, 이름, 급여등급을 가져온다.
select e.eno, e.ename, s.grade
from employee e, salgrade s, department d
where e.dno = d.dno and e.salary between s.losal and s.hisal and d.dname = 'SALES'

-- 각 급 등급별 급여의 총합 평균, 사원의수, 최대급여, 최소급여를 가져온다.
select sum(e.salary), trunc(avg(e.salary)), count(e.salary), max(e.salary), min(e.salary)
from employee e, salgrade s
where e.salary between s.losal and s.hisal
group by s.grade;

-- 급여 등급이 4등급인 사원들의 사원번호, 이름, 급여, 근무부서이름, 근무지역을 가져온다.
select e.eno , e.salary, d.dname, d.loc
from employee e, salgrade s, department d
where e.dno = d.dno and e.salary between s.losal and s.hisal and s.grade = 4



-- SELF JOIN
-- SMITH 사원의 사원번호, 이름, 직속상관 이름을 가져온다.
select * from employee;
-- a1 : SMITH 사원의 정보
-- a2 : 직속상관의 정보
select a1.eno, a1.ename, a2.ename
from employee a1, employee a2
where a1.manager = a2.eno and a1.ename = 'SMITH';
-- FORD 사원 밑에서 일하는 사원들의 사원번호, 이름, 직무를 가져온다.
-- a1 : FORD의 정보
-- a2 : 부하 직원의 정보
select a2.eno, a2.ename, a2.job
from employee a1, employee a2
where a1.eno = a2.manager and a1.ename = 'FORD'

-- SMITH 사원의 직속상관과 동일한 직무를 가지고 있는 사원들의 사원번호, 이름, 직무를 가져온다.
-- a1 : SMITH
-- a2 : SMITH의 직속상관 정보
-- a3 : 직속상관의 동일한 직무를 가지고 있는 사원들의 정보
select a3.eno, a3.ename, a3.job
from employee a1, employee a2, employee a3
where a1.manager = a2.eno and a2.job = a3.job and a1.ename = 'SMITH';


-- OUTER JOIN
-- 각 사원의 이름, 사원번호, 직장상사 이름을 가져온다. 단 직속상관이 없는 사원도 가져온다.
-- a1 : 각 사원의 정보
-- a2 : 직장 상사의 정보
select a1.ename, a1.eno, a2.ename
from employee a1, employee a2
where a1.manager = a2.eno(+);

-- 모든 부서의 소속 사원의 근무부서명, 사원번호, 사원이름, 급여를 가져온다.
-- a1 :  사원부서 
-- a2 : 부서정보

select a2.dname, a1.eno, a1.ename, a1.salary
from employee a1, department a2
where a1.dno(+) = a2.dno;

select distinct dno from employee;
select * from employee;


-- 서브쿼리
-- SCOTT 사원이 근무하고 있는 부서의 이름을 가져온다.
select dname
from department
where dno = (select dno
             from employee
             where ename = 'SCOTT');

-- SMITH와 같은 부서에 근무하고 있는 사원들의 사원번호, 이름, 급여액, 부서이름을 가져온다.
select e.eno, e.ename, e.salary, d.dname
from employee e , department d
where e.dno = d.dno and e.dno = (select dno
                                  from employee
                                  where ename = 'SMITH');

-- MARTIN과 같은 직무를 가지고 있는 사원들의 사원번호, 이름, 직무를 가져온다.
select eno, ename, job
from employee
where job = (
             select job
             from employee
             where ename = 'MARTIN');

-- ALLEN과 같은 직속상관을 가진 사원들의 사원번호, 이름, 직속상관이름을 가져온다.
-- a1 : 사원의 정보
-- a2 : 직속상관 정보
select a1.eno, a1.ename, a2.ename
from  employee a1, employee a2
where a1.manager = a2.eno and a1.manager(select manager
                                         from employee
                                         where ename='ALLEN');
                                         
-- WARD와 같은 부서에 근무하고 있는 사원들의 사원번호, 이름, 부서번호를 가져온다.
select eno, ename, dno
from employee
where dno = (select dno
             from employee
             where ename = 'WARD');

-- SALESMAN의 평균 급여보다 많이 받는 사원들의 사원번호, 이름, 급여를 가져온다.
select eno, ename, salary
from employee
where salary > (select avg(salary) 
                     from employee
                     where job = 'SALESMAN');

-- DALLAS 지역에 근무하는 사원들의 평균 급여를 가져온다.
select trunc(avg(salary))
from employee
where dno = (select dno
             from department
             where loc = 'DALLAS');

-- SALES 부서에 근무하는 사원들의 사원번호, 이름, 근무지역을 가져온다.
select e.eno, e.ename, d.loc
from employee e, department d
where e.dno = d.dno and e.dno = (select dno
               from department
               where dname = 'SALES');

-- CHICAGO 지역에 근무하는 사원들 중 BLAKE이 직속상관인 사원들의 사원번호, 이름, 직무를 가져온다.
-- a1 : 사원들의 정보 
-- a2 : BLAKE 의 manager 번호 
-- a3 : 
select eno, ename, job
from employee
where dno = (select dno
             from department
             where loc = 'CHICAGO') 
      and manager = (select eno
      from employee
      where ename = 'BLAKE');

-- 결과가 하나이상인 서브쿼리
-- 3000 이상의 급여를 받는 사원들과 같은 부서에 근무하고 있는 사원의 사원번호, 이름, 급여를 가져온다.
select eno, ename, salary
from employee
where dno in (select dno
             from employee
             where salary >= 3000);

-- 직무가 CLERK인 사원과 동일한 부서에 근무하고 있는 사원들의 사원번호, 이름, 입사일 가져온다.
select eno, ename, hiredate
from employee
where dno in (select dno
             from employee
             where job = 'CLERK');

-- KING을 직속상관으로 가지고 있는 사원들이 근무하고 있는 근무 부서명, 지역을 가지고온다.
select dname,loc
from department 
where dno in (select dno
            from employee
            where manager = (select eno
                            from employee
                            where ename = 'KING'));

-- CLERK의 직속상관의 사원번호, 이름, 급여를 가져온다.
select eno, ename, salary
from employee
where eno in (select manager
            from employee
            where job = 'CLERK');

-- 각 부서별 급여 평균보다 더 많이 받는 사원의 사원번호, 이름, 급여를 가져온다.
select eno, ename, salary
from employee
where salary > all (select avg(salary)
                from employee
                group by dno);


select eno, ename, salary
from employee
where salary > (select max(avg(salary))
                from employee
                group by dno);

-- 각 부서별 급여 최저치보다 더 많이 받는 사원들의 사원번호, 이름, 급여를 가져온다.
select eno, ename, salary
from employee
where salary > all (select min(salary)
                    from employee
                    group by dno;);

select eno, ename, salary
from employee
where salary > (select max(min(salary))
                    from employee
                    group by dno);

-- SALESMAN 보다 급여를 적게 받는 사원들의 사원번호, 이름, 급여를 가져온다.
select eno, ename, salary
from employee
where salary < all (select salary
                from employee
                where job = 'SALESMAN');

select eno, ename, salary
from employee
where salary < (select min(salary)
                from employee
                where job = 'SALESMAN');

-- 각 부서별 최저 급여 액수보다 많이 받는 사원들이 사원번호, 이름, 급여를 가져온다.
select eno, ename, salary
from employee
where salary > any (select min(salary)
                from employee
                group by dno);

-- DALLAS에 근무하고 있는 사원들 중 가장 나중에 입사한 사원의 입사 날짜보다 더 먼저 입사한 사원들의 사원번호, 이름, 입사일을 가져온다.
select eno, ename, hiredate
from employee 
where hiredate < any (select hiredate
                  from employee
                  where dno = (select dno
                  from department
                  where loc = 'DALLAS'));


-- SET
-- 10번 부서에 근무하고 있는 사원의 사원번호, 이름, 직무, 근무부서 번호를 가져온다.
select eno, ename, job, dno
from employee
where dno = 10;

-- 직무가 CLERK인 사원의 사원번호, 이름, 직무, 근무부서 번호를 가져온다.
select eno, ename, job, dno
from employee
where job = 'CLERK'

-- UNION
select eno, ename, job, dno
from employee
where dno = 10
union
select eno, ename, job, dno
from employee
where job = 'CLERK';


-- UNION ALL
select eno, ename, job, dno
from employee
where dno = 10
union all
select eno, ename, job, dno
from employee
where job = 'CLERK';


-- INTERSECT
select eno, ename, job, dno
from employee
where dno = 10
intersect
select eno, ename, job, dno
from employee
where job = 'CLERK';

-- MINUS 위에있는 코드에 있는 집합을 밑에있는 집합을 뺴고 남은 결과값을 도출
select eno, ename, job, dno
from employee
where dno = 10
minus
select eno, ename, job, dno
from employee
where job = 'CLERK';
























