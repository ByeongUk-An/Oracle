/* 권한 관리 */
/*
    사용권한 : DBMS는 여러명이 사용
    -- 각 사용자별로 계정을 생성 : DBMS에 접속할 수 있는 사용자를 생성.
      (인증 (Authentication : Credential (Identity + Password) 확인
      (허가 (Authorization : 인증된 사용자에게 Oracle의 시스템 권한, 객체(테이블, 뷰, 트리거, 함수) 권한
        - System Privileges : Oracle의 전반적인 권한
        - Object Privileges : 테이블, 뷰, 트리거, 함수, 저장프로시저, 시퀀스, 인덱스) 접근 권한.
*/

-- Oracle 에서 계정 생성. (일반 계정에서는 계정을 생성할 수 있는 권한이 없다.
show user;
create user usertest01 identified by 1234;
