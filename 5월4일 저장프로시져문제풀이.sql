저장 프로시져 문제 

1. 각 부서별로 최소급여, 최대급여, 평균급여를 출력하는 저장프로시져를 생성하시오. 
	[employee ] 테이블 이용
    set serveroutput on;
    create or replace procedure sp_ex1
    is -- 변수 선언부, 커서 선언부
        v_dno employee.dno%type;
        v_min employee.salary%type;
        v_max employee.salary%type;
        v_avg employee.salary%type;
        
        cursor c1
        is
        select dno, min(salary), max(salary), avg(salary)
        from employee
        group by dno;
        
    begin
        dbms_output.put_line('부서번호   최소급여   최대급여   평균급여');
        dbms_output.put_line('---------------------------------');
        open c1;  -- 커서 시작
        loop
            fetch c1 into v_dno, v_min, v_max, v_avg;
            exit when c1%notfound; -- 레코드의 값이 더이상 존재하지 않을때
            dbms_output.put_line(v_dno || '   ' || v_min || '   ' || v_max || '   ' || v_avg);
        end loop;
        close c1;
    end;
    /
    
    exec sp_ex1;

2.  사원번호, 사원이름, 부서명, 부서위치를 출력하는 저장프로시져를 생성하시오.  
	[employee, department ] 테이블 이용
    set serveroutput on;
    create or replace procedure sp_ex2
    is
        v_eno employee.eno%type;
        v_ename employee.ename%type;
        v_dname department.dname%type;
        v_loc department.loc%type;
        
        cursor c1
        is
        select eno, ename, dname, loc
        from employee e, department d
        where e.dno = d.dno;
        
    begin
        dbms_output.put_line('사원번호    사원이름     부서명     부서위치');
        dbms_output.put_line('------------------------------------');
        open c1;
        loop
            fetch c1 into v_eno, v_ename, v_dname, v_loc;
            exit when c1%notfound;
            dbms_output.put_line(v_eno|| '    ' ||v_ename|| '    ' ||v_dname|| '    '||v_loc);
        
        end loop;        
        close c1;
    end;
    /
    
    exec sp_ex2;

3. 급여를 입력 받아  입력받은 급여보다 높은 사원의 사원이름, 급여, 직책을 출력 하세요.
	저장프로시져명 : sp_salary_b
    create or replace procedure sp_ex3 (
        v_salary in employee.salary%type)
    is
        v_emp employee%rowtype;  -- 모든 컬럼의 자료형을 선언
        cursor c1
        is
        select ename, salary, job
        from employee
        where salary > v_salary;
    begin
        dbms_output.put_line('사원이름    급여     직책');
        dbms_output.put_line('---------------------');
        open c1;
        loop
            fetch c1 into v_emp.ename, v_emp.salary, v_emp.job;
            exit when c1%notfound;
            dbms_output.put_line(v_emp.ename|| '    ' || v_emp.salary || '    ' || v_emp.job);
        end loop;
        close c1;
    end;
    /
    
    exec sp_ex3(2500);
    
4. 인풋 매개변수 : emp_c10, dept_c10  두개를 입력 받아 각각 employee, department 테이블을 복사하는 저장프로시져를 생성하세요. 
	저장프로시져명 : sp_copy_table
	-- PL/SQL 내부에서 익명 블락에서 테이블을 생성 : grant create table to public; 권한을줘야된다. sys계정에서 부여
    -- 저장프로시저 실행후 : revoke create table from public;
    grant create table to public;  -- sys계정에서 권한부여
    revoke create table from public; -- sys계정에서 권한제거
    
    create or replace procedure sp_ex4 (
        v_emp in varchar2, v_dept in varchar2  -- 주의 : ';'을 넣으면 안된다. 구분은 ','로 한다. 자료형의 크기를 지정하면 안된다.
    )
    is
        c1 integer;  -- 커서 변수 선언
        v_sql1 varchar2(500); -- 테이블 생성 쿼리를 담을 변수
        v_sql2 varchar2(500);
    begin
        v_sql1 := 'create table '|| v_emp || ' as select * from employee' ;
        v_sql2 := 'create table '|| v_dept || ' as select * from department' ;
        
        c1 := dbms_sql.open_cursor;   -- 커서 오픈
        dbms_sql.parse(c1, v_sql1, dbms_sql.v7);
        dbms_sql.parse(c1, v_sql2, dbms_sql.v7);
        dbms_sql.close_cursor(c1);  -- 커서 종료
        
    end;
    /
    
    exec sp_ex4 ('emp_c10','dept_c10');
    select * from emp_c10;
    select * from dept_c10;



5. dept_c10 테이블에서 dno, dname, loc 컬럼의 값을 인풋 받아 인풋 받은 값을 insert하는 저장프로시져를 생성하시요. 
	입력 값 : 50  'HR'  'SEOUL'
	입력 값 : 60  'HR2'  'PUSAN' 
    
create or replace procedure sp_ex5 (
    v_dno in dept_c10.dno%type,
    v_dname in dept_c10.dname%type,
    v_loc in dept_c10.loc%type
)
is

begin
    insert into dept_c10
    values ( v_dno, v_dname, v_loc );
    
    dbms_output.put_line('정상적으로 잘 입력이 되었습니다.');

end;
/

exec sp_ex5(50, 'HR', 'SEOUL');
exec sp_ex5(56, 'HR2', 'BUSAN');
select * from dept_c10;

6. emp_c10 테이블에서 모든 컬럼의 값을 인풋 받아 인풋 받은 값을 insert하는 저장프로시져를 생성하시요. 
	입력 값 : 8000  'SONG'    'PROGRAMER'  7788  sysdate  4500  1000  50 
    create or replace procedure sp_ex6 (
        v_eno in emp_c10.eno%type,
        v_ename in emp_c10.ename%type,
        v_job in emp_c10.job%type,
        v_manager in emp_c10.manager%type,
        v_hiredate in emp_c10.hiredate%type,
        v_salary in emp_c10.salary%type,
        v_commission in emp_c10.commission%type,
        v_dno in emp_c10.dno%type
    )
    is
    begin
        insert into emp_c10
        values(v_eno, v_ename, v_job, v_manager, v_hiredate, v_salary, v_commission, v_dno);
        
        dbms_output.put_line('정상적으로 잘 입력이 되었습니다.');
        
    end;
    /
    
    select * from emp_c10;
    exec sp_ex6(8000,'SONG','PROGRAMER',7788,sysdate,4500,1000,50);

7. dept_c10 테이블에서 4번문항의 부서번호 50의 HR 을 'PROGRAM' 으로 수정하는 저장프로시져를 생성하세요. 
	<부서번호와 부서명을 인풋받아 수정하도록 하시오.> 
	입력갑 : 50  PROGRAMMER 
    create or replace procedure sp_ex7 (
        v_dno in dept_c10.dno%type,
        v_dname in dept_c10.dname%type
    )
    is
    
    begin
        update dept_c10
        set dname = v_dname
        where dno = v_dno;
        
        dbms_output.put_line('정상적으로 업데이트 되었습니다');
    end;
    /
    
    select * from dept_c10;
    exec sp_ex7(50,'PROGRAM');

8. emp_c10 테이블에서 사원번호를 인풋 받아 월급을 수정하는 저장 프로시져를 생성하시오. 
	입력 값 : 8000  6000
    create or replace procedure sp_ex8 (
        v_eno in emp_c10.eno%type,
        v_salary in emp_c10.salary%type
    )
    is
    
    begin
        update emp_c10
        set salary = v_salary
        where eno = v_eno;
    end;
    /
    
    select * from emp_c10;
    exec sp_ex8(8000,6000);

9. 위의 두 테이블명을 인풋 받아 두 테이블을 삭제하는 저장프로시져를 생성 하시오. 
 create or replace procedure sp_ex9 (
        v_emp in varchar2, v_dept in varchar2  -- 주의 : ';'을 넣으면 안된다. 구분은 ','로 한다. 자료형의 크기를 지정하면 안된다.
    )
    is
        c1 integer;  -- 커서 변수 선언
        v_sql1 varchar2(500); -- 테이블 생성 쿼리를 담을 변수
        v_sql2 varchar2(500);
    begin
        v_sql1 := 'drop table '|| v_emp  ;
        v_sql2 := 'drop table '|| v_dept ;
        
        c1 := dbms_sql.open_cursor;   -- 커서 오픈
        dbms_sql.parse(c1, v_sql1, dbms_sql.v7);
        dbms_sql.parse(c1, v_sql2, dbms_sql.v7);
        dbms_sql.close_cursor(c1);  -- 커서 종료
        
    end;
    /
    select * from emp_c10;
    select * from dept_c10;
    exec sp_ex9 ('emp_c10','dept_c10');
10. 이름을 인풋 받아서 사원명, 급여, 부서번호, 부서명, 부서위치을 OUT 파라미터에 넘겨주는 프로시저를 PL / SQL에서 호출
    create or replace procedure sp_ex10 (
        v_ename in employee.ename%type,
        v_o_ename out employee.ename%type,
        v_salary out employee.salary%type,
        v_dno out employee.dno%type,
        v_dname out department.dname%type,
        v_loc out department.loc%type
    )
    is
    
    begin
        select ename,salary,e.dno, d.dname, d.loc into v_o_ename, v_salary, v_dno, v_dname, v_loc
        from employee e department d
        where e.dno = d.dno and ename = v_ename;
    end;
    /
    
    declare
        v_ename employee.ename%type;
        v_salary employee.salary%type;
        v_dno employee.dno%type;
        v_dname deparment.dname%type;
        v_loc department.loc%type;
        
    begin
        -- 익명 블락에서는 exec / excute 를 생략 함.
        sp_ex10('SCOTT',v_ename,v_salary,v_dno,v_dname,v_loc);
        
        dbms_output.put_line('사원명   월급   부서번호   부서명   부서위치');
        dbms_output.put_line(v_ename||'   '||v_salary||'   ' ||v_dno||'   '||v_dname||'   ' || v_loc);
    end;
    /
    
    
11. 부서번호를 받아서 사원명, 급여, 직책을 OUT 파라미터에 넘겨주는 프로시저를 PL / SQL에서 호출

