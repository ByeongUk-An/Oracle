create table emp_copy
as
select * from employee;

create table dept_copy
as
select * from department;

select * from user_constraints;

alter table emp_copy
add constraint EMP_COPY_ENO_PK Primary KEY(eno);


alter table dept_copy
add constraint DEPT_COPY_DON_PK Primary Key(dno);

alter table emp_copy
add constraint EMP_COPY_DNO_FK FOREIGN Key (dno) REFERENCES dept_copy(dno);


create view v_emp_job
as
select eno,ename,dno,job
from employee
where job = 'SALESMAN';


select * from v_emp_job;





EQUI 조인을 사용하여 SCOTT 사원의 사원번호, 사원이름, 직책, 부서번호,  부서이름을 출력 하시오


create view v_auto_join
as
select e.eno, e.ename, e.job, e.dno, d.dname
from employee e , department d
where e.dno = d.dno and e.ename = 'SCOTT';

select * from v_auto_join;

select * from employee;

create index idx_employee_ename
on employee(ename);

select * from employee;

select ename as 사원명, nvl2(commission,salary+commission,salary) as 연봉
from employee;

drop table emp_copy;
drop table dept_copy;

create table dept_copy
as
select * from department
where 0=1;

select * from dept_copy;

create sequence dept_seq
start with 1
increment by 1
nocache;

insert into dept_copy(dno,dname,loc)
values (dept_seq.nextval,'ClERK','NEWYORK');


select e1.eno as 사원번호, e1.ename as 사원이름, e1.manager as 직속상사번호, e2.ename as 직속상사이름
from employee e1, employee e2
where e1.manager = e2.eno;

select * from employee;

























