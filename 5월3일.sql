/* Cursor for loop 문으로 커서를 사용해서 여러 레코드셋 출력 하기. 
    - open, close 를 생략 해서 사용하는 구문.
    - 한 테이블의 전체 내용을 출력 할때 사용.
*/

set serveroutput on
declare
    v_dept department%rowtype;
    cursor c1                     -- 커서 선언
    is
    select  * from department;
begin
    dbms_output.put_line('부서번호   부서명   지역명');
    dbms_output.put_line('-----------------------');
    for v_dept in c1 loop
        dbms_output.put_line (v_dept.dno || '    ' || v_dept.dname || '   ' || v_dept.loc);
    end loop;
end;
/

/* employee 테이블의 모든 내용을 cursor for loop 문 */
set serveroutput on
declare
    v_emp employee%rowtype;
    cursor c1
    is
    select * from employee;
begin
    dbms_output.put_line('사원번호   사원명   직무   사수   입사날짜   연봉   보너스   부서');
    dbms_output.put_line('-----------------------------------------------------------');
    for v_emp in c1 loop
        dbms_output.put_line(v_emp.eno || '   ' || v_emp.ename || '   ' || v_emp.job || '   ' || v_emp.manager || '   ' || v_emp.hiredate || '   ' || v_emp.salary || '   ' || v_emp.commission || '   ' || v_emp.dno);
    end loop;
end;
/

/* employee 테이블의 사원번호, 사원명,월급을 출력하는데 
월급이 2000이상, 부서가 20번,30번부서만 */

set serveroutput on
declare
    v_emp employee%rowtype;
    cursor c1
    is
    select * from employee
    where salary >= 2000 and dno in(20,30);
begin
    dbms_output.put_line('사원번호   사원명   급여   부서');
    dbms_output.put_line('-----------------------------------------------------------');
    for v_emp in c1 loop
        dbms_output.put_line(v_emp.eno || '   ' || v_emp.ename || '   ' ||  v_emp.salary  || '   ' || v_emp.dno);
    end loop;
end;
/


select * from employee;


13일차 - 저장 프로시져 (Stored Procedure ), 함수(Function), 트리거 (Trigger)

/*
    1. PL/SQL을 사용가능하다. 자동화
    2. 성능이 빠르다.
        일반적인 SQL 구문 : 구문분석 -> 개체이름확인 -> 사용권한확인 -> 최적화 -> 컴파일 -> 실행
        저장프로시저 처음 실행 : 구문분석 -> 개체이름확인 -> 사용권한확인 -> 최적화 -> 컴파일 -> 실행
        저장프로시저 두번째 실행 : 컴파일(메모리에 로드) -> 실행
    3. 입력 매개변수, 출력 매개변수를 사용할 수 있다.
    4. 일련의 작업을 묶어서 저장 (모듈화된 프로그래밍이 가능하다.)
*/

1. 저장프로시져 생성.
-- 스콧 사원의 월급을 출력 하는 저장 프로시져
Create procedure sp_salary
is
    v_salary employoee.salary%type;
begin
    select salary into v_salary
    from employee
    where ename = 'SCOTT';
    
    dbms.output.put_line('SCOTT의 급여는 : ' || v_salary || '입니다.' );
end;
/

/* 저장프로시져 정보를 확인하는 데이터 사전 */
select * from user_source
where name ='SP_SALARY';


3. 저장 프로시져 실행
EXECUTE sp_salary;   -- 전체 이름
EXEC sp_salary;   -- 약식 이름

4. 저장 프로시져 수정
Create or replace procedure sp_salary
is
    v_salary employee.salary%type;
    v_commission employee.commission%type;
begin
    select salary,commission into v_salary, v_commission
    from employee
    where ename = 'SCOTT';
    
    dbms_output.put_line ('SCOTT의 급여는 : ' || v_salary || 
                              '보너스는 : ' || v_commission || ' 입니다' );
end;
/

5. 저장 프로시져 삭제
drop procedure sp_salary; 



-----------<<인풋 매개변수를 처리하는 저장 프로시져>>--------------
create or replace procedure sp_salary_ename(  --  입력매개변수(in), 출력 매개변수(out)를 정의
    v_ename in employee.ename%type   -- 변수명 in 자료형 <== 주의 : ;를 사용하면 안된다.
)
is   -- 변수선언 (저장 프로시져에서 사용할 변수 선언블락)
    v_salary employee.salary%type;
begin
    select salary into v_salary   -- 변수
    from employee
    where ename = v_ename;  -- 인풋 매개변수 : v_ename
    
    DBMS_OUTPUT.PUT_line(v_ename || ' 의 급여는 ' || v_salary || '입니다');
end;
/

exec sp_salary_ename ('JAMES');




/*부서 번호를 인풋 받아서 이름, 직책, 부서번호를 출력하는 저장 프로시져를 생성 */
create procedure sp_dno_ename_job(  --  입력매개변수(in), 출력 매개변수(out)를 정의
    v_dno in employee.dno%type
)
is
v_emp employee%rowtype;
cursor c1
is
select * from employee
where dno = v_dno
begin
   
    open c1;
    loop
        fetch c1 into v_eno, v_ename, v_job, v_dno;
        exit when c1%notfound;
        dbms_output.put_line('사원번호    사원명    직책명    부서번호');
        dbms_output.put_line(v_eno || '   ' || v_ename || '   ' || v_job || '   ' || v_dno);
        end loop;
        close c1;
end;
/


/* 
    테이블이름을 인풋 받아서 employee 테이블을 복사해서 생성하는 저장프로시져를 생성 하세요.
    인풋 값 : emp_copy33
*/
/* 저장 프로시져를 사용해서 테이블 생성 */
create or replace procedure sp_createTable (
    v_name in varchar2
    )
is
    cursor1 INTEGER;
    v_sql varchar2(100);  -- SQL쿼리를 저장하는 변수
begin
    v_sql := 'CREATE TABLE ' || v_name || ' as select * from employee'; -- 테이블 생성쿼리를 변수에 할당. 
    cursor1 := dbms_sql.open_cursor;
    dbms_sql.parse ( cursor1, v_sql, dbms_sql.v7); -- 커서를 사용해서 sql 쿼리를 실행
    dbms_sql.close_cursor(cursor1);  -- 커서 중지
end;
/
    
grant create table to public;  -- <<sys 계정에서 실행>>

exec sp_createTable ('emp_copy33');

select * from emp_copy33;

----------------------<<출력 매개변수 사용>>-----------------------------------
/* 저장 프로시져 : 출력 매개변수가 지원(여러개의), 함수 : 출력 매개변수를 하나만 가짐.
    -- OUT 키워드를 사용.
    -- 저장프로시져를 호출시 먼저 출력 매개변수 선언후 호출이 가능.
    -- 호출시 출력매개변수 이름앞에 ':변수명(출력매개변수명)'
    -- 출력 매개변수를 출력하기 위해서 PRINT 명령문이나 PL/SQL을 사용해서 출력할수 있다.
*/

create or replace procedure sp_salary_ename2 (  -- 입력/출력 매개변수 선언부
    v_ename in employee.ename%type,  -- 입력 매개 변수
    v_salary out employee.salary%type -- 출력 매개 변수
)
is
begin
    select salary into v_salary
    from employee
    where ename = v_ename;
end;
/

select * from user_source where name = 'SP_SALARY_ENAME2'; -- 데이터 사전에서 확인.
  -- 호출부에서 아웃풋 매개변수를 선언
  -- :아웃풋매개변수명 <== : 주의
  -- 주석 처리 주의 : 
variable var_salary varchar2(50);
exec sp_salary_ename2('SCOTT', :var_salary);  
print var_salary;

