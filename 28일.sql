-- 9일차 시퀀스, 인덱스,

/*
    시퀀스 : 자동 번호 발생기
        -- 번호가 자동 발생이 되면 뒤로 되돌릴 수 없다. (삭제 후 다시 생성해야 한다.)
        -- Primary Key 키 컬럼에 번호를 자동으로 발생시키기 위해서 사용.
*/
-- 초기값 : 10 증가 값 : 10
create sequence sample_seq 
increment by 10  -- 증가값
start with 10  -- 초기값



-- 시퀀스의 정보를 출력 하는 데이터 사전
select * from user_sequences;

select sample_seq.nextval from dual;   -- 시퀀스의 다음 값을 출력
select sample_seq.currval from dual;   -- 시퀀스의 현재 값


-- 초기값 : 2, 증가 값 : 2
create sequence sample1_seq
    increment by 2
    start with 2
    nocache               -- 캐쉬를 사용하지 않겠다. (RAM) -- 서버의 부하를 줄여줄수 있다.
    

select sample1_seq.nextval from dual;
select sample1_seq.currval from dual;

-- 시퀀스를 Primary Key에 적용하기

create table dept_copy80
as
select * from department
where 0=1;

select * from dept_copy80;

-- 시퀀스 생성 : 초기값 : 10, 증가 값 10
create sequence dept_seq
    increment by 10
    start with 10
    nocache;
    
  /* Sequence 에 cache를 사용하는 경우 / 사용하지 않는 경우 */
  -- cache : 서버의 성능을 향상 하기 위해서 사용 (기본값 : 20개)
  -- 서버가 다운된 경우 : 캐쉬된 넘버링이 모두 날라감. 새로운 값을 할당 받는다.
    

    
    

insert into dept_copy80 (dno,dname,loc)
values(dept_seq.nextval, 'HR','SEOUL')

select * from dept_copy80;

create sequence emp_seq_no
    increment by 1
    start with 1
    nocache;
    
create table emp_copy80
as
select * from employee
where 0 = 1;

select * from emp_copy80;

-- 시퀀스를 테이블의 특정 컬럼에 할당.
insert into emp_copy80
values (emp_seq_no.nextval, 'SMITH', 'SALESMAN',2222, sysdate, 3000, 300, 20);

-- 기존의 시퀀스 수정
select * from user_sequences;

alter sequence emp_seq_no
    maxvalue 1000   -- 최대값 : 1000

alter sequence emp_seq_no
    cycle;          -- 최대값 도달후 다시 처음부터 순환

alter sequence emp_seq_no
    cycle;alter sequence emp_seq_no
    nocycle;

select * from user_sequences;

drop sequence sample_seq;


/*
    Index : 테이블의 컬럼에 생성, 특정 컬럼의 검색을 빠르게 사용할 수 있도록 한다.
        - INDEX Page : 컬럼의 중요 키워드르 걸러스 위치정보를 담아놓은 페이지를 INDEX page 라한다.
            - DB공간의 10%
        - 색인(index) : 책의 색인, 책의 내용의 중요 키워드를 수집해서 위치를 알려줌.
        - 테이블 스캔 : 레코드의 처음 ~ 마지막까지 검색 (검색 속도가 느리다.) , 인덱스를 사용하지 않고 검색.
            -- Index가 생성되어있지 않는 컬럼은 테이블 스
        - Primary Key, Unique 키가 적용된 컬럼은 Index Page 가 생성되 검색을 빠르게 한다.
        - Where 절에서 자주 검색을 하는 컬럼에 index를 생성.
        - 테이블의 검색을 자주하는 컬럼에 Index생성, 테이블 스캔을 하지 않고
          Index Page를 검색해서 위치를 빠르게 찾는다.
        - Index 를 생성할때 부하가 많이 걸린다. 주로 업무시간을 피해서 야간에 생성함
        - index는 잘 생성해야 한다..
*/

-- index 정보가 저장되어 있는 데이터 사전.
    -- user_colums, user_ind_columns

select * from user_tab_columns;
select * from user_ind_columns

select * from user_tab_columns
where table_name in ('EMPLOYEE','DEPARTMENT');

select index_name, table_name, column_name
from user_ind_columns
where table_name in('EMPLOYEE','DEPARTMENT');

select * from employee;  -- ENO 컬럼에 Primary key가 들어가 있다. - 자동으로 index가 생성됨.


/*
    index 자동 생성, (Primary Key, Unique) 컬럼에는 Index Page가 자동으로 생성된다.
*/


create table tbl1 (
    a number(4) constraint PK_tbl1_a Primary Key,
    b number(4),
    c number(4)
);

select index_name, table_name, column_name
from user_ind_columns
where table_name in ('TBL1','TBL2', 'EMPLOYEE', 'DEPARTMENT');

select * from tbl1;

create table tbl2 (
    a number(4) constraint PK_tbl2_a primary Key,
    b number(4) constraint UK_tbl2_b unique,
    c number(4) constraint UK_tbl2_c unique,
    d number(4),
    e number(4)
);

create table emp_copy90
as
select * from employee;

select * from emp_copy90;

select index_name, table_name, column_name
from user_ind_columns
where table_name in ('EMP_COPY90');

select * from emp_copy90
where ename = 'KING';    --ename 컬럼이 indexrk djqtdmamfh KING을 검색 하기 위해서 테이블 스캔한다.

select * from emp_copy90
where job = 'SALESMAN';

-- ename 컬럼에 index 생성하기 (야간에 작업해야 한다. 부하가 많이 걸린다.)


-- 컬럼에 index가 생성되어 있지 않으면 테이블 스캔을 한다. 처음부터 하나하나 검색
-- 컬럼에 index가 생성되어 있으면 Index Page(책의 목차)를 검색한다. 빠르게 검색한다.





create index id_emp_ename
on emp_copy90(ename);

-- index 제거
drop index id_emp_ename;

/*
    index는 주기적으로 REBUILD 해 줘야 한다. , (1주일,1달)
        -Index page는 조각난다 (Insert, update, delete) 빈번하게 일어나면 성능저하가 된다.
*/

-- Index REBUILD 를 해야 하는 정보 얻기 : 
     --Index의 Tree 깊이가 4이상인 경우가 조회가 되면 Rebuild 할 필요가 있다.
SELECT I.TABLESPACE_NAME,I.TABLE_NAME,I.INDEX_NAME, I.BLEVEL,
       DECODE(SIGN(NVL(I.BLEVEL,99)-3),1,DECODE(NVL(I.BLEVEL,99),99,'?','Rebuild'),'Check') CNF
FROM   USER_INDEXES I
WHERE   I.BLEVEL > 4
ORDER BY I.BLEVEL DESCSELECT I.TABLESPACE_NAME,I.TABLE_NAME,I.INDEX_NAME, I.BLEVEL,
       DECODE(SIGN(NVL(I.BLEVEL,99)-3),1,DECODE(NVL(I.BLEVEL,99),99,'?','Rebuild'),'Check') CNF
FROM   USER_INDEXES I
WHERE   I.BLEVEL > 4
ORDER BY I.BLEVEL DESC;

-- index rebuild : 
alter index id_emp_ename rebuild;  -- index 를 새롭게 생성한다.

select * from emp_copy90;

/*
    Index 를 사용해야 하는 경우 
        1. 테이블의 행(로우,레코드)의 갯수가 많은 경우 
        2. where절에서 자주 사용되는 컬럼.
        3. Join 시 사용되는 키 컬럼.
        4. 검색 결과가 원본 테이블 데이터의 2% ~ 4% 정도 되는경우
        5. 해당 컬럼이 null 이 포함하는 경우 (색인은 null은 제외)
        
    Index 를 사용하면 안좋은 경우
        1. 테이블의 행의 갯수가 적은경우
        2. 검색 결과가 원본 테이블의 많은 비중을 차지 하는 경우
        3. Insert,Update,Delete 가 빈번하게 일어나는 컬럼.
        
*/


/*
    index 종류
        1. 고유 인덱스 (Unique Index) : 컬럼의 중복되지 않는 고유한 값을 갖는 Index(Primary Key, Unique)
        2. 단일 인덱스 (Single Index) : 한 컬럼에 부여 되는 Index
        3. 결합 인덱스 (Composite Index) : 여러 컬럼을 묶어서 생성한 Index
        4. 함수 인덱스 (Function Index) : 함수를 적용한 컬럼에 생성한 Index
*/

select * from emp_copy90;

-- 단일 인덱스 생성 : 한 컬럼에 부여 되는 Index한 컬럼에 부여 되는 Index
create index idx_emp_copy90_salary
on emp_copy90 (salary);

-- 결합 인덱스 : 여러 컬럼을 묶어서 생성한 Index여러 컬럼을 묶어서 생성한 Index
create table dept_copy91
as
select * from department;

create index idx_dept_copy91_dname_loc
on dept_copy91 (dname, loc);



select index_name, table_name, column_name
from user_ind_columns
where table_name in ('DEPT_COPY91');

-- 함수 기반 인덱스 : 함수를 적용한 컬럼에 생성한 Index함수를 적용한 컬럼에 생성한 Index
create table emp_copy91
as
select * from employee;

create index idx_emp_copy91_allsal
on emp_copy91 (salary * 12);        -- 컬럼에 함수, 계산식을 적용한 인덱스.

/* 인덱스 삭제 */
select index_name, table_name, column_name
from user_ind_columns
where table_name in ('DEPT_COPY91');

drop index idx_emp_copy91_allsal;
































