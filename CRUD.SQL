--6일차 - CRUD (Create, Read, Upadte, Delete)

-- 테이블 생성 (Create)
Create Table dept (
    dno number(2) not null,
    dname varchar(14) not null,
    loc varchar2(13) null
    );
    
    select * from dept;
    
    -- DML : 테이블의 값(레코드르,로우) 를 넣고 (insert), 삭제 (deloete
        -- 트랜잭션을 발생 시킴 : log 에 기록을 먼저 하고 DataBase에 적용한다.
        begin transaction;  -- 트랜 잭션 시작 (insert, update, delete 구문이 시작되면 자동으로 시작)
        rollback;           -- 트랜 잭션을 롤백(RAM에 적용된 트랜잭션을 삭제)
        commit;             -- 트랜 잭션을 적용(실제 DataBase에 영원히 적용)
        
    /*
        insert into 테이블명 (컬럼명, 컬럼명, 컬럼명)
        values (값1, 값2, 값3)
    */
    
    insert into dept (dno,dname,loc)
    values(10,'MANAGER','SEOUL');
    -- insert, update, delete 구문은 자동으로 트랜잭션이 시작 (begin transaction;)
    rollback;
    commit;
    
    /*  insert 시 컬럼명을 생략
        insert int dept
        values (값1, 값2, 값3)
        */
        
  insert into dept
  values (20, 'ACCOUNTING', 'DAEGU');
        
commit;
    
desc dept;

/*
    NULL 허용 컬럼에 값을 넣지 않기
*/
select * from dept;
insert into dept (dno,dname)
values (30,'REASEARCH');

-- 데이터 유형에 맞지 않는 값을 넣으면 오류 발생

insert into dept (dno,dname,loc)
values(300,'SALES','TAEGUE');  --오류 발생, NUMBER(2)

insert into dept (loc,dname,dno)
values ('TAEGUN', 'SALESSSSSSSSSSSSSS',60); -- 오류 발생, dname varchar(14)
        
-- 자료형 (문자 자료형)
    -- char (10) : 고정크기 10바이트 , 3바이트만 넣을 경우 빈공간 7바이트가 생김
        -- 자릿수를 알수 있는 고정 크기 칼럼 (주문번호,전화번호
        -- 장점 : 성능이 빠르다.  단점 : 하드공간낭비가 생길수 있다.
    -- varchar2 (10) : 가변크기 10바이트, 3바이트만 넣을 경우 3바이트만 공간할당, 빈공간을 남기지않는다.
        -- 자릿수가 가변크기인 경우 (주소, 메일주소, 공간크기가 지정되어있지않은 자릿수)
        -- 장점 : 하드공간낭비가 없다. 단점 : 성능이 느리다.
    -- Nchar (10) : 유니코드 10자 (한글, 중국어, 일본어...)
    -- Nvarchar2 (10) : 유니코드 10자 (한글, 중국어, 일본어...)

-- 자료형 (숫자 자료형)
    -- NUMBER (2) : 정수 2자리만 입력가능
    -- NUMBER (7,3) : 전체 7자리 소숫점 3자리까지 저장이 된다.
    -- NUMBER (8,5) : 전체 8자리, 소수점 5자리
    
create Table test1_tbl (
    a number(3,2) not null,
    b number(5,5) not null,
    c char(6) null,
    d varchar2(10) null,
    e Nchar(6) null,
    f NVARCHAR2(10) null
    );
        
desc test1_tbl;  
select * from test1_tbl;
insert into test1_tbl (a,b,c,d,e,f)
values (3.22,55.555,'aaaaaa','bbbbb','한','한');

drop table test1_tbl;

insert into test1_tb1(a, b, c, d, e, f)
values(3.22,77.55555,'한글셋','한글');

create table member1 (
    no number (10) not null,
    id varchar2 (50) not null,
    passwd varchar2 (50) not null,
    name Nvarchar2 (6) not null,
    phone varchar2(50) null,
    address varchar(100) null,
    mdate date not null,
    email varchar2 (50) null
    );

select * from member1;

desc member1;
insert into member1 (no,id,passwd,name,phone,address,mdate,email)
values (1,'quddnr005','mn369s12#','안병욱','010-6510-0166','인천광역시 서구 석남동',sysdate,'quddnr005@naver.com');

insert into member1 (no,id,passwd,name,phone,address,mdate,email)
values (2,'quddnr006','mn369s12#','안병진','010-3333-0166','인천광역시 서구 호남동',sysdate,'hello005@naver.com');

insert into member1 (no,id,passwd,name,phone,address,mdate,email)
values (3,'quddnr006','mn369s12#','안병진','010-3333-0166','인천광역시 서구 호남동',sysdate,'hello005@naver.com');

insert into member1 (no,id,passwd,name,phone,address,mdate,email)
values (4,'quddnr006','mn369s12#','안병진','010-3333-0166','인천광역시 서구 호남동',sysdate,'hello005@naver.com');
commit;    
    
drop table member1;
select * from member1;
        
-- 데이터 수정 (update : 데이터 수정후 commit;   
    -- 반드시 where 조건을 사용해야 한다. 그렇지 않으면 모든 레코드가 수정됨.
/*
    update 테이블명
    set 컬럼명 = 수정할값
    where 컬럼명 = 값
*/
update member1
set name= '안병호'  -- 수정값
where no = 2; --조건
commit;  -- insert,delete,update 를 한후 항상 해주어야한다.

select * from member1;

update member1
set name = '을지문덕'
where no = 1;
commit;        
        
update member1
set name = '김유신'
where no = 1;

update member1
set email = 'abcd@abcd.naver'
where no = 1;
        
update member1
set id = 'abcd'
where no = 3;
        
update member1
set mdate = '2022.01.01'
where no = 4;

commit;        
select * from member1;
        
-- 하나의 레코드에서 여러컬럼 동시에 수정하기
update member1
set name = '노재희', email = 'kkk@kkk.com', phone = '010-4938-5798'
where no = 1;
commit;
select * from member1;

update member1
set mdate = to_date('2022-01-01','YYYY-MM--DD')
where no = 3;

commit;

select * from member1;
        
  -- 레코드 ( 로우 ) 삭제 ( delete : 반드시 where 조건을 사용해야함. )
  /*
    delete 테이블명
    where 컬럼명 = 값
  */
  
  delete member1
  where no = 3;
select * from member1;
commit;

delete member1
where no = 4;
rollback;
        
/*
    update, delete는 반드시 where 조건을 사용해야한다. 트랜잭션을 종료 (rollback,commit)
*/        

/*
    update, delete 시 where 절에 사용되는 컬럼은 고유한 컬럼이어야 한다. (Primary key, Unique 컬럼
    을 사용해야 한다. 그렇지 않으면 여러 컬럼이 업데이트 되거나 삭제될수가 있다.
*/
select * from member1;        
desc member1;
update member1
set name = '딩코딩코하자'
where no = 1;
        

-- 제약 조건 : 컬럼의 무결성을 확보하기 위해서 사용, 무결성 : 결함 없는 데이터
    -- Primary key
            -- 하나의 테이블에 한번만 사용 할 수 있다. 중복된 데이터를 넣지 못하도록 설정.
        
create table member2 (
    no number (10) not null Primary key,
    id varchar2 (50) not null,
    passwd varchar2 (50) not null,
    name Nvarchar2 (6) not null,
    phone varchar2(50) null,
    address varchar(100) null,
    mdate date not null,
    email varchar2 (50) null
    );
commit;
insert into member2 (no,id,passwd,name,phone,address,mdate,email)
values (1,'quddnr005','mn369s12#','안병욱','010-6510-0166','인천광역시 서구 석남동',sysdate,'quddnr005@naver.com');

insert into member2 (no,id,passwd,name,phone,address,mdate,email)
values (2,'quddnr006','mn369s12#','안병진','010-3333-0166','인천광역시 서구 호남동',sysdate,'hello005@naver.com');

insert into member2 (no,id,passwd,name,phone,address,mdate,email)
values (3,'quddnr006','mn369s12#','안병진','010-3333-0166','인천광역시 서구 호남동',sysdate,'hello005@naver.com');

insert into member2 (no,id,passwd,name,phone,address,mdate,email)
values (4,'quddnr006','mn369s12#','안병진','010-3333-0166','인천광역시 서구 호남동',sysdate,'hello005@naver.com');        

update member2
set name = '노재희'
where no = 3;

select * from member2
        
        
/*
    제약조건
        -- UNIQUE : 중복되지 않는 고유한 값을 저장. 하나의 테이블에서 여러 컬럼에 지정
            -- NULL을 허용
*/
        
        
create table member3 (
    no number (10) not null Primary key,
    id varchar2 (50) not null UNIQUE,
    passwd varchar2 (50) not null,
    name Nvarchar2 (6) not null,
    phone varchar2(50) null,
    address varchar(100) null,
    mdate date not null,
    email varchar2 (50) null
    );
commit;      
        
insert into member3 (no,id,passwd,name,phone,address,mdate,email)
values (1,'quddnr005','mn369s12#','안병욱','010-6510-0166','인천광역시 서구 석남동',sysdate,'quddnr005@naver.com');

insert into member3 (no,id,passwd,name,phone,address,mdate,email)
values (2,'quddnr006','mn369s12#','안병진','010-3333-0166','인천광역시 서구 호남동',sysdate,'hello005@naver.com');

insert into member3 (no,id,passwd,name,phone,address,mdate,email)
values (3,'quddnr001','mn369s12#','안병혁','010-3333-0166','인천광역시 서구 호남동',sysdate,'hello005@naver.com');

insert into member3 (no,id,passwd,name,phone,address,mdate,email)
values (4,'quddnr0106','mn369s12#','안병진','010-3333-0166','인천광역시 서구 호남동',sysdate,'hello005@naver.com');        

select * from member3;
commit;
        
        
        
        
        
        
        
        
        
        