-- 데이터 무결성과 제약 조건

-- 1. employee 테이블의 구조를 복사하여 emp_sample 란 이름의 테이블을 만드시오.
-- 사원 테이블의 사원번호 컬럼에 테이블 레벨로 primary key 제약조건을 지정하되 제약조건 이름은 my_emp_pk로 지정하시오. 
create table emp_sample
as
select * from employee;

alter table emp_sample
add constraint MY_EMP_PK Primary Key(eno);

-- 2. department 테이블의 구조를 복사하여 dept_sample 란 이름의 테이블을 만드시오. 부서 테이블의 부서번호 컬럼에 레벨로 primary key 제약 조건을 지정하되 제약 조건이름은 my_dept_pk로 지정하시오.
create table dept_sample
as
select * from department;

alter table dept_sample
add constraint MY_DEPT_PK Primary Key(dno);


-- 3. 사원 테이블의 부서번호 컬럼에 존재하지 않는 부서의 사원이 배정되지 않도록 외래키 제약조건을 지정하되 제약 조건이름은 my_emp_dept_fk 로 지정하시오. [주의 : 위 복사한 테이블을 사용하시오]
alter table emp_sample
add constraint MY_EMP_DEPT_FK FOREIGN KEY (dno) REFERENCES dept_sample (dno);

-- 4. 사원테이블의 커밋션 컬럼에 0보다 큰 값만을 입력할 수 있도록 제약 조건을 지정하시오. [주의 : 위 복사한 테이블을 사용하시오]
update emp_sample
set commission = 0
where commission is null;
commit;

alter table emp_sample
add constraint MY_EMP_CK Check (commission >= 0);
select * from emp_sample;



-- 5. 사원테이블의 웝급 컬럼에 기본 값으로 1000 을 입력할 수 있도록 제약 조건을 지정하시오. [주의 : 위 복사한 테이블을 사용하시오]
alter table emp_sample
modify salary default 1000;

-- 6. 사원테이블의 이름 컬럼에 중복되지 않도록  제약 조건을 지정하시오. [주의 : 위 복사한 테이블을 사용하시오]
alter table emp_sample
add constraint MY_EMP_UK unique(ename);

-- 7. 사원테이블의 커밋션 컬럼에 null 을 입력할 수 없도록 제약 조건을 지정하시오. [주의 : 위 복사한 테이블을 사용하시오]
alter table emp_sample
modify commission constraint MY_EMP_NN not null;

-- 8. 위의 생성된 모든 제약 조건을 제거 하시오. 
select * from user_constraints
where table_name in ('EMP_SAMPLE','DEPT_SAMPLE');

alter table emp_sample
drop primary key;

alter table emp_sample
drop constraint MY_EMP_CK;

alter table emp_sample
drop constraint MY_EMP_UK;

alter table emp_sample
drop constraint MY_EMP_NN;

alter table emp_sample
modify commission default null;

alter table emp_sample
drop constraint MY_EMP_DEPT_FK;

alter table dept_sample
drop constraint MY_DEPT_PK;
----------------------------------------------------------------------------
--뷰 문제 

-- 1. 20번 부서에 소속된 사원의 사원번호과 이름과 부서번호를 출력하는 select 문을 하나의 view 로 정의 하시오.
	--뷰의 이름 : v_em_dno 
    create view v_em_dno
    as
    select eno, ename from emp_sample;

    select * from v_em_dno;

-- 2. 이미 생성된 뷰( v_em_dno ) 에 대해서 급여 역시 출력 할 수 있도록 수정하시오.
    create or replace view v_em_dno
    as
    select eno, ename, salary from emp_sample;

    select * from v_em_dno;

-- 3. 생성된  뷰를 제거 하시오. 
    drop view v_em_dno;
    
    select * from v_em_dno;

-- 4. 각 부서의 급여의  최소값, 최대값, 평균, 총합을 구하는 뷰를 생성 하시오. 
	--뷰이름 : v_sal_emp
    create view v_sal_emp
    as
    select min(salary) 최소값, max(salary) 최대값, round(avg(salary),2) 평균, sum(salary) 총합
    from emp_sample
    group by dno;
    
    select * from v_sal_emp;

-- 5. 이미 생성된 뷰( v_em_dno ) 에 대해서 읽기전용 뷰로 수정하시오. 
-- 3번 문제에서 뷰를 제거해서 재생성
    create view v_em_dno
    as
    select eno, ename, salary from emp_sample;
    
    create or replace view v_em_dno
    as
    select eno, ename, salary
    from emp_sample
    where dno = 20 with read only;
    
    
    
    





















