-- 2일차 : DQL : Select

-- desc 테이블명 : 테이블의 구조를 확인
desc departments;

select * from departments;

/*
SQL : 구조화된 질의 언어
Select 구문의 전체 필드 내용

Select   <== 컬럼명
Distinct <== 컬럼내의 값의 중복을 제거해라.
From     <== 테이블명, 뷰명.
Where    <== 조건
Group By <== 특정 값을 그룹핑.
Having   <== 그룹핑한 값을 정렬
Order by <== 값을 정렬해서 출력
*/
desc employees;
select * from employees;

-- 특정 컬럼만 출력 하기
select job_id, salary from employees;

-- 특정 컬럼을 여러번 출력
select email,salary,email,job_id,salary from employees;

select employee_id,first_name,last_name from employees;

-- 컬럼에 연산을 적용할 수 있다.
select employee_id,first_name,employee_id * 12 from employees;

--컬럼명 알리어스(Alias) : 컬럼의 이름을 변경,
   -- 컬럼에 연산을 하거나 함수를 사용하면 컬럼명이 없어진다.
Select employee_id,first_name as 첫번쨰이름,last_name, employee_id * 12 as 연봉 from employees;
Select employee_id as 아이디, first_name as 첫번째이름, last_name as 마지막이름 from employees;
    -- as를 생략이 가능하다.
Select employee_id 아이디, first_name 메롱 from employees;
    -- 공백이나 특수문자가 들어 갈때는 "" 으로 처리.
Select employee_id "사원 #번호", first_name 메롱 from employees;

-- nvl 함수 : 연산시에 null을 처리하는 함수
select * from employees;

-- nvl 함수를 사용하지 않고 전체 연봉을 계산
select employee_id 사원번호, first_name 첫번째이름, salary 연봉, commission_pct 보너스,
salary * 12,
salary * 12 + commission_pct 전체연봉 from employees;

-- nvl 함수를 사용해서 연산
select employee_id 사원번호, first_name 첫번째이름, salary 연봉, commission_pct 보너스,
salary * 12,
salary * 12 + NVL(commission_pct,0) 전체연봉 from employees;

-- 특정 컬럼의 내용을 중복 제거후 출력
select * from employees;
select first_name from emplyees;
select distinct first_name from employees;

--select first_name, distinct last_name from employee; 다른컬럼 떄문에 오류가 날수 있다.

-- 조건을 사용해서 검색 (Where)
select * from employees;
select employee_id 사원번호, first_name 사원명, job_id 직책, manager_id 직속상관,
salary 연봉, commission_pct 보너스 from employees;

-- 사원번호가 116인 사원의 이름을 검색.
select * from employees where employee_id = 116;

select first_name from employees where employee_id = 115;

-- 사원 번호가 115인 사원의 사원명,직책,연봉 검색
select first_name 사원명, job_id 직책, salary 연봉 from employees where employee_id = 112;

select * from employees where first_name = 'Jose Manuel';

-- 레코드를 가져올때
    -- number 일때는 ''를 붙이지 않는다.
    -- 문자데이터(char,varchar2)나 날짜(date)를 가져올때는 ' ' 를 처리.
    -- 대소문자를 구분
    
-- 입사날짜가 '06/03/07' 인 사원 출력
select first_name from employees where hire_date = '06/03/07';

-- 부사가 IT_PROG인 모든 사원들을 출력
select first_name, job_id from employees where job_id = 'IT_PROG';

-- 월급이 3000 이상인 사원의 이름과 부서 입사날짜
select * from employees;
select first_name, job_id, hire_date,salary from employees
where salary >= 3000;

-- NULL 검색 : is 키워드 사용.
select * from employees where commission_pct is null;

-- commission이 300 이상인 사원이름과, 직책, 월급을 출력
select first_name, job_id, salary, commission_pct from employees where commission_pct >= 0.1;

--커밋션이 없는 사원들의 이름을 출력.
select first_name , commission_pct from employees where commission_pct is null;

-- 조건에서 and, or , not


-- 월급이 500 이상 2500 미만인 사원들의 이름, 사원번호, 입사날짜를 출력.
select * from employees;
select employee_id 사원번호,first_name 이름, hire_date 입사날짜 from employees
where 2500 > salary and salary >= 500;

-- 직책이 FT_ACCOUNT 이거나, 부서코드가 60 인 사원의 이름, 직책, 월급, 부서코드를 출력
select first_name 이름, job_id 직책, salary 월급, department_id from employees
where job_id = 'FT_ACCOUNT' or department_id = 60;

-- 커밋션이 없는 사용자중에 부서코드가 40인 사용자의 이름, 부서코드와 입사날짜를 출력
select first_name,department_id 
from employees 
where commission_pct is null and department_id = 100;
-- 커밋션이 null이 아닌 사용자의 이름, 입사날짜, 월급
select *
from employees
where commission_pct is not null;

-- 날짜 검색 :
select * from employees;

-- 20058/3/1 ~ 2007/10/15 사이에 입사한 사원의 이름과 직책

select first_name,email,hire_date
from employees
where hire_date >= '2005/03/01' and hire_date < '2007/10/15';

-- between A and B : A 이상 B 이하
select first_name, job_id, hire_date
from employees
where hire_date between '2005/01/01' and '2006/01/01';

-- IN 연산자

-- 연봉이 300, 500, 1400인 사원의 이름, 직책, 입사일을 출력.
select first_name, job_id
from employees
where salary in (300,2400,8000);

-- like : 컬럼내의 특정한 문자열을 검색  <== 글검색 기능을 사용할때
    -- % : 뒤에 어떤글자가 와도 상관없다.
    -- _ : 한글자가 어떤값이 와도 상관없다.
    
--J로 시작하는 이름을 가진 사원을 모두 검색 하기.

select * from employees
where first_name like 'J%';

-- 이름이 ia로 끝나는 사원을 검색 하기.

select first_name from employees
where first_name like '%ia';

-- J로 시작되고 J뒤의 두글자가 어떤것이 와도 상관없는 사원 출력. 뒤에는 ia 로 마무리 됨.
select first_name
from employees
where first_name like J_MES';

--마지막 글자가 R로 끝나는 사원 출력 하기
select * 
from employees
where first_name like '%s';

-- prog 단어가 들어간 직책을 출력
select *
from employees
where job_id like '%PROG';

-- 05년도에 입사한 사원을 출력하기.
select * 
from employees
where hire_date between '05/01/01' and '07/05/31';

select *
from employee
where hire_date like '81%'

--05년 7월에 입사한 사원만 출력
select *
from employees
where hire_date like '05/07%';

-- 정렬 : order by , asc(오름차순정렬) , desc (내림차순정렬)

select *
from employees
order by employee_id;

select *
from employees
order by employee_id asc;

select *
from employees
order by employee_id desc;

--이름 컬럼을 정렬
-- z부터 a까지
select *
from employees
order by first_name desc;

--a부터 z까지
select *
from employees
order by first_name asc;


--날짜 정렬
select *
from employees
order by hire_date desc;

-- 질문답변형 게시판에서 주로 사용. 두개이상의 컬럼을 정렬할때

select * from employees
order by employee_id desc;

-- 두개의 컬럼이 정렬
select *
from employees
order by employee_id, first_name;

select employee_id, first_name
from employees
order by employee_id desc, first_name desc;

-- where 절과 order by 절이 같이 사용될때.

select *
from employees
where commission_pct is null
order by first_name;

select * from employees;
--1.
select first_name 사원이름,salary 급여, salary+300 인상급여 from employees;

--2.
select first_name 사원이름, salary/12 급여, salary+100 연봉
from employees
order by salary;

--3.
select first_name 사원이름, salary
from employees
where salary >= 2000
order by salary;

--4. 사원번호 100번
select employee_id 사원번호, first_name 이름, department_id 부서번호
from employees
where employee_id = 100;

--5. 
select first_name 이름, salary 급여 
from employees
where not salary >= 2000 or not salary <=3000
order by salary;

--6. 02/01/01 부터 05/05/05 일 사이의 입사사원 담당업무 입사일 
select * from employees;
select first_name 입사사원, job_id 업무, hire_date 입사일
from employees
where hire_date between '02/01/01' and '05/05/05';

--7.부서번호 30,90
select first_name 사원이름, department_id 부서번호
from employees
where department_id = 30 or department_id =90
order by department_id;

--8.
select first_name 사원이름, salary 급여, department_id 부서번호
from employees
where department_id = 30 or department_id = 90
order by first_name asc;

--9.
select first_name 사원이름,hire_date 입사일
from employees
where hire_date like '00%';


-- 다양한 함수 사용하기
/*
    1. 문자를 처리하는 함수
        - UPPER : 대문자로 변환
        - LOWER : 소문자로 변환
        - INITCAP : 첫 자는 대문자로 나머지는 소문자로 변환
        
        dual 테이블 : 하나의 결과를 출력 하도록 하는 테이블
*/

select '안녕하세요' 안녕
from dual

select 'Oracle mania' , upper ('Oracle mania'), lower ('Oracle mania'),initcap('Oracle mania')
from dual

select * from employees;

select first_name, lower(first_name), initcap (first_name), upper(first_name) from employees;

select * from employees
where first_name = 'david';  -- 소문자를 넣었을떄 검색이 안된다.

select * from employees
where lower(first_name) = 'david';

select * from employees
where initcap(first_name) = 'David';


-- 문자 길이를 출력 하는 함수
    -- length : 문자의 길이를 반환, 영문이나 한글 관계없이 글자수를 리턴해줌
    -- lengthb : 문자의 길이를 반환하는데 한글을 3byte로 반환
    
    select length ('Oracle mania'), length ('오라클 매니아') from dual;
    
    select lengthb ('Oracle mania'), lengthb ('오라클 매니아') from dual;

    select * from employees;
    
    select first_name, length(first_name), job_id, length(job_id)
    from employees;

-- 문자 조작 함수
    -- concat : 문자와 문자를 연결해서 출력
    -- substr : 문자를 특정 위치에서 잘라오는 함수 (영문, 한글 모두 1byte로 처리)
    -- substrb :문자를 특정 위치에서 잘라오는 함수 (영문은 1byte, 한글은 3byte)
    -- instr : 문자의 특정 위치의 인덱스 값을 반환
    -- instrb : 문자의 특정 위치의 인덱스 값을 반환(영문은 1byte, 한글은 3byte 로 처리)
    -- lpad, rpad : 입력 받은 문자열에서 특수를 문자를 적용.
    -- trm : 잘라내고 남은 문자를 반환.

select 'Oracle', 'mania', concat('Oracle','mania') from dual;

-- substr (대상, 시작위치, 추출갯수) : 특정위치에서 문자를 잘라온다.
select 'Oracle mania' , substr('Oracle mania', 3, 5) from dual;
select '오라클 매니아' , substr('오라클 매니아',2,4) from dual;

select 'Oracle mania' , substr ('Oracle mania' ,-4,3) , substr ('오라클 매니아', -6,4)
from dual;

select first_name, substr (first_name,2,3), substr(first_name, -5,2) 
from employees;

select substrb ('Oracle mania' , 3, 3), substrb ('오라클 매니아', 3,6) from dual;

select * from employees;

select concat ( first_name,' '|| job_id) from employees;

select '이름은 : ' || first_name || ' 이고, 직책은 : ' || job_id || ' 입니다.' as 컬럼연결
from employees;

select * from employees;

select '이름은 : ' || first_name || ' 이고, 직속상관사번은 : ' || manager_id || '입니다' as 직속상관출력
from employees;

-- 이름이 N으로 끝나는 사원들 출력하기 (substr 함수를 사용해서 사용)
select first_name 
from employees
where substr (first_name, -1, 1) = 'n';

select first_name from employees
where first_name like '%n';

--05년도 입사한 사원들 출력 하기 (substr 함수를 사용해서 사용)
select * from employees
where substr (hire_date, 1,2) = '05';

select * from employees
where hire_date like '05%';

-- instr (대상, 찾을글자, 시작위치, 몇번째 발견) : 대상에서 찾을 글자의 인덱스값을 출력.

select 'Oracle mania' , instr ('Oracle mania','a') from dual;

-- 
select 'Oracle mania' , instr ('Oracle mania','a', 5,2) from dual;

-- -5는 Oracle mania 로 봤을떄 맨 오르쪽 a부터 왼쪽으로 5번쨰
select 'Oracle mania' , instr ('Oracle mania','a', -5,1) from dual;

select job_id, first_name from employees
where lower (job_id) = 'it_prog';

select distinct instr ( job_id,'A'1,1) from employees where job_id = 'IT_PROG';

-- lpad, rpad : 특정 길이만큼 문자열을 지정해서 왼쪽, 오른쪽에 공백을 특정 문자로 처리
    --lpad (대상, 늘려줄 문자열크기, 특수문자적용)
    --rpad (대상, 늘려줄 문자열크기, 특수문자적용)
select lpad(1234, 10, '#') from dual;  --왼쪽 특수문자

select rpad(1234,10,'#') from dual;  --오른쪽 특수문자

select salary from employees;

-- TRIM : 공백제거, 특정 문자도 제거
    --LTRIM : 왼쪽 공백 제거
    --RTRIM : 오른쪽 공백 제거
    --TRIM : 왼쪽, 오른쪽 공백을 제거.
select ltrim ('   Oracle mania   '), rtrim ('   Oracle mania   '), trim('   Oracle mania   ')
from dual;




























