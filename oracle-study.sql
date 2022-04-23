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

































































