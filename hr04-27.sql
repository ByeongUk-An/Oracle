/*제약 조건 수정 (Alter Table) : 기존의 테이블에 제약 조건을 수정*/

create table emp_copy50
as
select * from employee;

create table dept_copy50
as
select * from department;



select * from emp_copy50;
select * from dept_copy50;

select * from user_constraints
where table_name in ('EMPLOYEE','DEPARTMENT');

select * from user_constraints
where table_name in ('EMP_COPY50','DEPT_COPY50');

-- 테이블을 복사하면 레코드만 복사가 된다. 이말의 뜻은 테이블의 제약 조건은 복사 되어 오지 않는다.
-- Alter Table을 사용해서 제약조건을 적용
-- eno : PK  dno: FK   dno는 다른테이블에 PK와UK를 참조한다
select * from emp_copy50;
select * from dept_copy50;

-- Primary Key
alter table emp_copy50
add constraint PK_emp_copy50_eno Primary key(eno);

alter table dept_copy50
add constraint PK_dept_copy50_dno Primary Key(dno);


-- Foreign Key
alter table emp_copy50
add constraint FK_emp_copy50_dno_depet_copy50 FOREIGN KEY (dno) REFERENCES dept_copy50(dno);

-- NOT NULL 제약조건 추가.
desc employee;
desc emp_copy50;  -- Not Null을 넣지 않았지만, Primary Key 제약 조건을 할당,
desc department;
desc dept_copy50;  -- Primary Key 적용으로 자동으로 Not Null

    -- 기존의 null 이 들어가있는 곳에는 not null 컬럼으로 지정할 수 없다.
select ename from emp_copy50
where ename is null;

alter table emp_copy50
modify ename constraint NN_emp_copy50_ename not null;

    --commission 컬럼에 not null 할당 하기 : null 이 들어가 있는 경우 null 을 처리
select * from emp_copy50;

alter table emp_copy50
modify commission constraint NN_emp_copy50_commission not null;

update emp_copy50
set commission = 0
where commission is null;

-- Unique 제약 조건 추가 : 컬럼에 중복된 값이 있으면 하당 하지 못한다.
select ename , count(*)
from emp_copy50
group by ename
having count(*) > 2;

alter table emp_copy50
add constraint UK_emp_copy50_ename UNIQUE (ename);


-- check 제약 조건 추가
select * from emp_copy50;

alter table emp_copy50
add constraint CK_emp_copy50_salary check (salary > 0 and salary < 10000 );

-- default 제약 조건 추가 <제약조건이 아님 : 제약조건 이름을 할당할 수 없다.>
    -- 값을 넣지 않을 경우 default 로 설정된 값이 들어간다.
alter table emp_copy50
modify salary default 1000;

desc emp_copy50;
insert into emp_copy50 (eno, ename, commission)
values (9999, 'JULI', 100);

alter table emp_copy50
modify hiredate default sysdate;

insert into emp_copy50
values(8888,'JULIA',null,null,default,default,1500,null);



-- 제약 조건 제거 : Alter Table 테이블명 drop

-- Primary key 제거 : primary key는 테이블에 하나만 존재
ALTER TABLE EMP_COPY50
   DROP PRIMARY KEY;

ALTER TABLE DEPT_COPY50
   DROP PRIMARY KEY;   -- 오류발생 : FOREIGN KEY가 참조하기 때문에 삭제 불가
   
ALTER TABLE DEPT_COPY50
   DROP PRIMARY KEY CASCADE;   -- cascade(강제)를 사용하면 FOREIGN KEY를 먼저 자동 삭제되고 PRIMARY KEY가 삭제됨
   
SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN ('EMP_COPY50', 'DEPT_COPY50');

-- not null 컬럼 제거 하기 : 제약 조건 이름으로 삭제
alter table emp_copy50
drop constraint NN_EMP_COPY50_ENAME;


-- Unique, Check 제약조건 제거 <<제약조건 이름으로 제거>>
alter table emp_copy50
drop constraint UK_EMP_COPY50_ENAME;

-- default 는 null 허용 컬럼은 default null 로 셋팅 : default 제약 조건을 제거 하는것.
alter table emp_copy50
modify hiredate default null;

select * from emp_copy50;

/* 제약 조건 disable /enable
    - 제약조건을 잠시 중지 시킴.
    - 대량(Bulk Insert) 으로 값을 테이블에 추가할때 부하가 많이 걸린다. disable --> enable
    - Index를 생성시 부하가 많이 걸린다. disable ==> enable
*/

alter table dept_copy50
add constraint PK_dept_copy50_dno Primary Key (dno);
alter table emp_copy50
add constraint PK_emp_copy50_eno Primary Key (eno);

alter table emp_copy50
add constraint FK_emp_copy50_dno Foreign key (dno) references dept_copy(dno);

select * from user_constraints
where table_name in('EMP_COPY50','DEPT_COPY50');

select * from emp_copy50;
select * from dept_copy50;

alter table emp_copy50
disable constraint FK_EMP_COPY50_DNO_DEPET_COPY50;

alter table emp_copy50
enable constraint FK_EMP_COPY50_DNO_DEPET_COPY50;

insert into emp_copy50 (eno,ename,dno)
values (8989,'aaaa',50);

insert into emp_copy50 (eno,ename,dno)
values (8919,'bbbb',60);

insert into dept_copy50
values (50,'HR','SEOUL');

select * from emp_copy50;
































