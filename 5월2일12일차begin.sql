12일차 - PL/SQL : 오라클에서 프로그래밍 요소를 적용한 SQL
        MSSQL : T-SQL
    SQL : 구조화된 질의언어, 단점 : 유연한 프로그래밍 기능을 적용할 수 없다.
    
set serveroutput on  -- PL/SQL의 출력을 활성화
BEGIN
    dbms_output_line('God Dman!!!');
END;

/* PL SQL의 기본 작성 구문 */

begin
    -- PL / SQL 구문
end;
/

    -- 자료형 선언
        1. Oracle 의 자료형을 사용.
        2. 참조자료형 : 테이블의 컬럼의 선언된 자료형을 참조해서 사용.
            %type : 테이블의 특정컬럼의 자료형을 참조해서 사용.
            $rowtype : 테이블 전체 컬럼의 자료형을 모두 참조 해서 사용.

-- PL/SQL에서 기본 출력
set serveroutput on
begin
    dbms_output.put_line('Welcome to Oracle');
end;
/

-- PL / SQL에서 변수 선언
set serveroutput on

DECLARE
EX_NUM CONSTANT NUMBER := 10; --상수 선언
EX_STR VARCHAR2(10); --변수 선언

BEGIN
EX_STR := 'EXAMPLE'; --변수 초기값 설정
DBMS_OUTPUT.PUT_LINE(EX_NUM); --상수 출력
DBMS_OUTPUT.PUT_LINE(EX_STR); --변수 출력
END;

desc employee;



set serveroutput on
declare -- 변수 선언 (변수 선언부)
    v_eno number(4);              -- 오라클의 자료형
    v_ename employee.ename%type;  -- 참조 자료형 : 테이블의 컬럼의 자료형을 참조해서 적용.
begin
    v_eno := 7788;
    v_ename := 'SCOTT';
    DBMS_OUTPUT.PUT_LINE('사원번호   사원이름');
    DBMS_OUTPUT.PUT_LINE('---------------');
    DBMS_OUTPUT.PUT_LINE(v_eno || '    ' || v_ename);
end;
/
    

/* 사원번호와 사원이름 출력 하기 */
set serveroutput on
declare
    v_eno employee.eno%type;
    v_ename employee.ename%type;
begin
    DBMS_OUTPUT.PUT_LINE('사원번호   사원이름');
    DBMS_OUTPUT.PUT_LINE('---------------');
    select eno,ename into v_eno,v_ename
    from employee
    where ename = 'SCOTT';
        
    DBMS_OUTPUT.PUT_LINE(v_eno || '    ' || v_ename);
end;
/

select eno,ename
from employee
where ename = 'SCOTT';

/* PL/SQL 에서 제어문 사용하기 */

/* If ~ End if 문 사용하기 */

set serveroutput on
declare
    v_employee employee%rowtype; -- fowtype : empllyee테이블의 모든 컬럼의 자료형을 참조해서 사용.
                        -- v_employee 변수는 employee 테이블의 모든 컬럼을 참조.
    annsal number (7,2); -- 총연봉을 저장하는 변수
begin
    select * into v_employee
    from employee
    where ename = 'SCOTT'
    if(v_employee.commission is null) than
        v_employee.commission := 0;
    end if;
    annsal := v_employee.salary *12 + v_employee.commission;
    dbms_output.put_line('사원번호   사원이름   연봉');   
    dbms_output.put_line('----------------------');
    dbms_output.put_line(v_employee.eno || '   ' || v_employee.ename || '   ' || annsal);

end;
/

/*
    v_employee.eno := 7788
*/

select * from employee
where ename = 'SCOTT';

/* PL/SQL 을 사용해서 department 테이블을 변수에 담아서 출력 해보세요.
   조건은 dno = 20을 변수에 담아서 출력 해보세요.
*/

set serveroutput on
declare
    v_dno department.dno%type;
    v_dname department.dname%type;
    v_loc department.loc%type;
begin
    select dno, dname, loc into v_dno,v_dname,v_loc
    from department
    where dno = 20;
    
    dbms_output.put_line('부서번호   부서명   위치');
    dbms_output.put_line('---------------------');
    dbms_output.put_line(v_dno || '   ' || v_dname || '   ' || v_loc);
end;
/




set serveroutput on
declare
    v_department department%rowtype;
begin
    select dno, dname, loc into v_department
    from department
    where dno = 20;
    
    dbms_output.put_line('부서번호   부서명   위치');
    dbms_output.put_line('---------------------');
    dbms_output.put_line(v_department.dno || '   ' || v_department.dname || '   ' || v_department.loc);
end;
/


/* IF ~ ElSIF ~ END IF */
set serveroutput on
declare
    v_eno employee.eno%type;
    v_ename employee.ename%type;
    v_dno employee.dno%type;
    v_dname department.dname%type := null;
begin
    select eno, ename, dno into v_eno, v_ename, v_dno
    from employee
    where ename = 'SCOTT';
    
    if(v_dno = 10) then
        v_dname := 'ACCOUNT';
    elsif (v_dno 20) then
        v_dname := 'RESEARCH';
    elsif (v_dno := 30) then
        v_dname := 'SALES';
    elsif (v_dno = 40) then
        v_dname := 'OPERATIONS';
    end if;
    
    dbms_output.put_line('사원번호   사원명   부서명');
    dbms_output.put_line('---------------------');
    dbms_output.put_line(v_eno || '    ' || v_ename || '   ' || v_dname);
end;
/

/*
    employee 테이블의 eno, ename, salary, dno 을 PL/SQL 을 사용해서 출력
    조건은 보너스 1400인 사원에 대해서
*/

-- %type
set serveroutput on
declare
    v_eno employee.eno%type;
    v_ename employee.ename%type;
    v_salary employee.salary%type;
    v_dno employee.dno%type;
begin
    select eno,ename,salary,dno into v_eno, v_ename, v_salary, v_dno
    from employee
    where commission = 1400;
    dbms_output.put_line('사원번호   사원명   월급   부서번호');
    dbms_output.put_line('-----------------------------');
    dbms_output.put_line(v_eno||'   ' || v_ename || '    '|| v_salary || '   ' || v_dno);
end;
/

-- %rowtype
set serveroutput on
declare
    v_employee employee%rowtype;
begin
    select * into v_employee
    from employee
    where commission = 1400;
    dbms_output.put_line('사원번호   사원명   월급   부서번호');
    dbms_output.put_line('-----------------------------');
    dbms_output.put_line(v_employee.eno||'   ' || v_employee.ename || '    '|| v_employee.salary || '   ' || v_employee.dno);
end;
/

/* 커서 (cursor) : PL/SQL에서 select 한 결과가 단일 레코드가 아니라 레코드셋인 경우   */

declare
    cursor 커서명            1. 커서 선언
    is                       
    커서를 부착할 select 구문
begin
    
    open 커서명 ;            2. 커서 오픈
    loop
       fetch 구문           3. 커서를 이동하고 출력
    end loop;              4. 커서를 종료
    close 커서명 ;
    
end;
/


-- 커서를 사용해서 department 테이블의 모든 내용을 출력 하기
set serveroutput on
declare
    v_dept department%rowtype;  --변수 선언
    cursor c1                     --1. 커서 선언
    is
    select * from department;
begin
    dbms_output.put_line('부서번호   부서명   부서위치');
    dbms_output.put_line('----------------------');
    open c1;                      --2. 커서 오픈
    loop
       fetch c1 into v_dept.dno, v_dept.dname, v_dept.loc;
       exit when c1%notfound;
       dbms_output.put_line(v_dept.dno || '   ' || v_dept.dname || '   ' || v_dept.loc);
    end loop;                    
    close c1;                     --4. 커서를 종료
end;
/

/* 커서의 속성을 나타내는 속성값 
커서명%notfound : 커서영역 내의 모든 자료가 FETCH 되었다면 true를 리턴
커서명%found : 커서영역 내의 모든 자료가 FETCH 되지않은자료가 있다면 true를 리턴
커서명%isopen : 커서가 오픈되었다면 true
커서명%rowcount : 커서가 얻어온 레코드 갯수
*/

/*
    사원명, 부서명(department),부서위치, 월급을 출력 하세요. PL/SQL
*/

set serveroutput on
declare
    v_emp employee%rowtype;
    v_dept department%rowtype;
    cursor c1
    is
    select e.eno, d.dname, d.loc, e.salary from employee e, department d
    where e.dno = d.dno;
begin
    dbms_output.put_line('사원명   부서명   부서위치   월급');
    dbms_output.put_line('--------------------------');
    open c1;
    loop
       fetch c1 into v_emp.eno, v_dept.dname, v_dept.loc, v_emp.salary;
       exit when c1%notfound;
       dbms_output.put_line(v_emp.eno || '   ' || v_dept.dname || '   ' || v_dept.loc || '   ' || v_emp.salary);
    end loop;                    
    close c1;                     
end;
/




















