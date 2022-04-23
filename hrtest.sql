Oracle : TCP 1521
MS-SQL : TCP 1433
My-SQL : TCP 3306

select ename 사원이름, salary 월급
from employee
where not(salary between 1000 and 1500);

select ename 사원이름, hiredate 입사일
from employee
where hiredate like('81%');

select *
from employee
where substr(hiredate,1,2)='87';

select ename, round(months_between(sysdate,hiredate))
from employee;

select dno, sum(salary)
from employee
group by dno
having sum(salary) >= 3000;

select dno 부서번호,count(*) 부서별사원수, round(avg(salary),2)
from employee
group by dno;