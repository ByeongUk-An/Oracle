-- Object Privileges : 테이블, 뷰, 트리거, 함수, 저장프로시져, 시퀀스, 인덱스에 부여되는 권한할당.
===============================================================
권한      Table       view        SEQUENCE        PROCEDEUR
---------------------------------------------------------------
Alter      0                        0
DELETE     0          0
EXECUTE                                              0
INDEX      0
INSERT     0          0
REFERENCES 0
SELECT     0          0             0
UPDATE     0          0

-- 특정 테이블에 select 권한 부여 하기
-- sys 계정<최고 관리자 계정으로 접속>
-- Autication (인증) : credential ( ID + Pass)
    create user user_test10 identified by 1234;  -- 계정 생성.    
    
-- Authorization (허가)
grant create session, create table, create view to user_test10;

-- 계정을 생성하면 system 테이블 스페이스를 사용한다.  <== 관리자만 사용가능한 테이블 스페이스
-- 테이블 스페이스 바꾸기. (USERS)
Alter user user_test10
default tablespace "USERS"
temporary tablespace "TEMP";

-- 테이블 스페이스 용량 할당. (
ALTER USER "USER_TEST10" QUOTA UNLIMITED ON "USERS";
-- 특정 계정에서 객체를 생성하면 그 계정이 그 객체를 소유하게 된다.
select * from dba_tables
where owner in ('HR','USER_TEST10');

-- 다른 사용자의 테이블을 접근할려면 권한을 가져야 한다.

-- user_test10 번 계정에서 HR이 소유주인 employee 테이블 접근 할때 -> 객체의 접근권한이 필요하다.
grant select on hr.employee to user_test10;

-- 다른 사용자의 테이블을 접근하려면 권한을 가져야 한다.
grant select on hr.employee to user_test10;

grant 객체의권한 on 객체명 to 사용자

grant select on hr.emp_copy55 to user_test10;

select * from hr.emp_copy55;

-- 권한을 부여 할때
grant insert,update,delete on hr.emp_copy55 to user_test10;

-- 권한을 해제 할때
revoke insert,update,delete on hr.emp_copy55 from user_test10;

/*
    with grant option : 특정 계정에게 권한을 부여하면서 해당권한을 다른사용자에게도 부여할 수 있는 권한
        -- 부여받은 권한을 다른사용자에게 부여해 줄 수 있는권한.
    
*/
grant select on hr.employee to user_test10 with grant option;
    --user_test10 계정은 hr.employee 테이블에 대해서 다른 사용자에게 select 권한을 부여할 수 있다.

grant select on hr.dept_copy55 to user_test10 with grant option;


/* Public : 모든 사용자에게 권한을 부여하는 것. */
grant select,insert,update,delete on hr.dept_copy56 to public;

/*
    룰(Role) : 자주 사용하는 여러개의 권한을 묶어 놓은
    1. DBA : 시스템의 모든 권한이 적용된 role, -- sys(최고 관리자 권한)
    2. CONNECT : 
    3. RESOURCE :
*/
-- 사용자 정의 Role 생성 : 자주 사용하는 권한 들을 묶어서 role을 생성.
1. 롤 생성 :
    create role roletest1;
2. 롤에 권한 부여
    grant create session, create table, create view, create sequence, create trigger to roletest1;
3. 유저에게 롤 부여
    grant roletest1 to user_test10;

/* 현재 사용자에게 부여된 롤 확인 */
select * from user_role_privs;

/* 롤에 부여된 권한 정보 확인 */
select * from role_sys_privs
where role like 'DBA';

select * from role_sys_privs
where role like 'ROLETEST1';

-- 롤 생성 : roletest3
create role roletest3;

-- roletest3 : hr.dept_copy57 (select, insert, delete) : 객체 롤 user_test10 적용.
grant select, insert, delete on hr.dept_copy57 to roletest3;
grant roletest3 to user_test10;












