-- 2일차 : DQL ; Select

-- desc 테이블명 : 테이블의 구조를 확인
desc employee;

/*
SQL : 구조화된 질의 언어
Select 구문의 전체 필드 내용
Select <== 컬러명
Distinct <== 컬럼내의 값의 중복을 제거해라.
From <== 테이블명, 뷰명.
Where <== 조건
Group By <== 특정 값을 그룹핑.
Having <== 그룹핑한 값을 정렬
Order by <== 값을 정렬해서 출력
*/

select * from employee;

-- 특정 컬럼만 출력 하기
select job, salary from employee;

-- 특정 컬럼을 여러번 출력
select eno, ename,job from employee;

-- 컬럼에 알리어스(Alias) : 컬럼의 이름을 변경,
    -- 컬럼에 연산을 하거나 함수를 사용하면 컬럼명이 없어진다.
select eno, ename as 이름, salary * 12 as 연봉 from employee;

-- 사원번호가 7782인 사원의 이름을 검색.
select * from employee where eno = 7782;

-- 월급이 3000 이상인 사원의 이름과 부서 입사날짜
select * from employee;
select ename 이름, job 직업, hiredate 날짜,salary 급여 from employee;

-- NULL 검색 : is 키워드 사용.
select * from employee where commission is null;

1. 덧셈 연산자를 사용하여 모든 사원에 대해서 $300의 급여 인상을 계산한후 사원이름, 급여, 인상된 급여를 출력하세요. 
desc employee;

select *
from employee;

select eno as 사원번호, ename 사원명, job 직책, manager "직속상관 ID", hiredate 입사날짜, salary 월급, commission 보너스, dno 부서번호
from employee;

select ename, salary, salary + 300 as 인상된급여
from employee;



2. 사원의 이름, 급여, 연간 총 수입이 많은것 부터 작은순으로 출력 하시오. 연간 총 수입은 월급에 12를 곱한후 $100의 상여금을 더해서 계산 하시오. 

select ename, salary, commission from employee;

select ename, salary, commission,salary * 12, salary * 12 + NVL(commission,0) + 100 as 총연봉
from employee;




3. 급여가 2000을 넘는 사원의 이름과 급여를 급여가 많은것 부터 작은순으로 출력하세요. 
desc employee;


select ename, salary  --컬럼명
from employee           -- 테이블, 뷰
where salary >= 2000     -- 조건
order by salary desc    -- 정렬


4. 사원번호가 7788인 사원의 이름과 부서번호를 출력하세요.

select ename, dno, eno
from employee
where eno = 7788



5. 급여가 2000에서 3000사이에 포함되지 않는 사원의 이름과 급여를 출력 하세요. 
    -- between 은 a에서 b사이   not 은 반대
select ename, salary
from employee
where salary not between 2000 and 3000;


6. 1981년 2월 20일부터 81년 5월 1일 사이의 입사한 사원의 이름 담당업무, 입사일을 출력하시오

select ename, job, hiredate
from employee
where hiredate between '1981/2/20' and '1981/5/1';


7. 부서번호가 20및 30에 속한 사원의 이름과 부서번호를 출력하되 이름을 기준(오차순)으로 출력하시오. 
select ename, dno
from employee
where dno = 20 or dno = 30
order by ename asc;

select ename, dno
from employee
where dno in (20, 30)
order by ename asc;


8. 사원의 급여가 2000에서 3000사이에 포함되고 부서번호가 20 또는 30인 사원의 이름, 급여와 부서번호를 출력하되 이름을 오름차순으로 출력하세요. 
select ename, salary, dno
from employee
where (salary between 2000 and 3000) and (dno in (20,30);


9. 1981년도 입사한 사원의 이름과 입사일을 출력 하시오 ( like 연산자와 와일드 카드 사용)
select ename, hiredate
from employee
where hiredate like '81%'


10. 관리자가 없는 사원의 이름과 담당업무를 출력하세요.
select * from employee;

select ename, manager
from employee
where manager is null;


11. 커밋션을 받을 수 있는 자격이 되는 사원의 이름, 급여, 커미션을 출력하되 급여및 커밋션을 기준으로 내림차순 정렬하여 표시하시오.
select * from employee
order by commission desc;

select ename, salary, commission
from employee
where commission is not null
order by salary asc, commission desc;


12. 이름이 세번째 문자인 R인 사원의 이름을 표시하시오. 
select ename
from employee
where ename like '__R%';


13. 이름에 A 와 E 를 모두 포함하고 있는 사원의 이름을 표시하시오. 
select ename
from employee
where ename like '%A%' and ename like '%E%'


14. 담당 업무가 사무원(CLERK) 또는 영업사원(SALESMAN)이며서 급여가 $1600, $950, 또는 $1300 이 아닌 사원의 이름, 담당업무, 급여를 출력하시오. 
select ename, job, salary
from employee
where (job = 'CLERK' or job = 'SALESMAN') and salary not in(1600,950,1300);


15. 커미션이 $500이상인 사원의 이름과 급여 및 커미션을 출력하시오.  
select ename, salary, commission
from employee
where commission >= 500;


-- 숫자 함수

/*
    ROUND : 특정 자릿수에서 반올림.
    TRUNK : 특정 자릿수에서 잘라낸다. (버린다).
    MOD   : 입력 받은 수를 나눈 나머지 값만 출력

*/

-- round ( 대상 ) : 소숫점 뒷자리를 반올림
-- round (대상, 소숫점자릿수) :
    -- 소숫점 자릿수 : 양수 일떄 소숫점 오른쪽으로 자릿수 만큼 이동해서 그 자릿수 뒤에서 반올림.
    -- 소숫점 자릿수 : 음수 일때 소숫점 왼쪽으로 자릿수 만큼 이동하고 그 자릿수에서 반올림.
select 98.7654, round(98.7654), round(98.7654,2),round(98.7654,-1),round(98.7654,-2),round(98.7654,-3)
    ,round(98.7654,3)
from dual;

-- trunc (  대상 ) : 소숫점 뒷자리를 버림
select 98.7654, trunc (98.7654), trunc (98.7654,2), trunc (98.7654, -1)
from dual;

-- mod (대상, 나누는수) : 대상을 나누어서 나머지 값만 출력
select mod (31,2), mod(31,5), mod(31,8)
from dual

select * from employee;

select salary, mod (salary, 300) from employee;

--employee 테이블에서 사원번호가 짝수인 사원들만 출력.
select * 
from employee
where mod(eno,2) = 0;

/*
    sysdate : 시스템에 저장된 현재 날짜를 출력.
    months_between : 두 날짜 사이의 몇 개월인지 반환
    add_months : 특정 날짜에 개월수를 더한다.
    next_day : 특정 날짜에서 최초로 도래하는 인자로 받은  요일의 날짜를 반환.
    last_day : 달의 마지막 날짜를 반환
    round : 인자로 받은 날짜를 특정 기준으로 반올림.
    trunc : 인자로 받은 날짜를 특정 기준으로 버린다.
*/

-- 자신의 시스템의 날짜 출력
select sysdate
from dual;

select sysdate -1 as 어제날짜, sysdate as 오늘날짜, sysdate + 1 내일날짜
from dual;

select * from employee
order by hiredate asc;

select hiredate, hiredate -1, hiredate + 10 
from employee;

desc employee;

























