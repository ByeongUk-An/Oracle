-- 1. employee 테이블의 구조를 복사하여 emp_sample 란 이름의 테이블을 만드시오. 
-- 사원 테이블의 사원번호 컬럼에 테이블 레벨로 primary key 제약조건을 지정하되 
-- 제약조건 이름은 my_emp_pk로 지정하시오. 
create table emp_sample
as
select * from employee;

alter table emp_sample
add constraint MY_EMP_PK Primary Key (eno);

select * from all_constraints
where constraint_name = 'MY_EMP_PK';
commit;



--2. department 테이블의 구조를 복사하여 dept_sample 란 이름의 테이블을 만드시오. 
--   부서 테이블의 부서번호 컬럼에 레벨로 primary key 제약 조건을 지정하되
--   제약 조건이름은 my_dept_pk로 지정하시오. 
create table dept_sample
as
select * from department;

alter table dept_sample
add constraint MY_DEPT_PK Primary Key (dno);

select * from user_constraints
where table_name = 'DEPT_SAMPLE';
commit;


-- 3. 사원 테이블의 부서번호 컬럼에 존재하지 않는 부서의 사원이 배정되지 않도록 외래키 제약조건을 지정하되 
--  제약 조건이름은 my_emp_dept_fk 로 지정하시오. [주의 : 위 복사한 테이블을 사용하시오]
alter table emp_sample
add constraint MY_EMP_DEPT_FK FOREIGN KEY (dno) references DEPT_SAMPLE (dno);

select * from user_constraints
where table_name = 'EMP_SAMPLE';


-- 4.사원테이블의 커밋션 컬럼에 0보다 큰 값만을 입력할 수 있도록 제약 조건을 지정하시오.
--   [주의 : 위 복사한 테이블을 사용하시오]
alter table emp_sample
add constraint MY_EMP_PK Check (commission > 0);

























