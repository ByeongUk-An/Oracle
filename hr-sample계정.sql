-- 2���� : DQL : Select

-- desc ���̺�� : ���̺��� ������ Ȯ��
desc departments;

select * from departments;

/*
SQL : ����ȭ�� ���� ���
Select ������ ��ü �ʵ� ����

Select   <== �÷���
Distinct <== �÷����� ���� �ߺ��� �����ض�.
From     <== ���̺��, ���.
Where    <== ����
Group By <== Ư�� ���� �׷���.
Having   <== �׷����� ���� ����
Order by <== ���� �����ؼ� ���
*/
desc employees;
select * from employees;

-- Ư�� �÷��� ��� �ϱ�
select job_id, salary from employees;

-- Ư�� �÷��� ������ ���
select email,salary,email,job_id,salary from employees;

select employee_id,first_name,last_name from employees;

-- �÷��� ������ ������ �� �ִ�.
select employee_id,first_name,employee_id * 12 from employees;

--�÷��� �˸��(Alias) : �÷��� �̸��� ����,
   -- �÷��� ������ �ϰų� �Լ��� ����ϸ� �÷����� ��������.
Select employee_id,first_name as ù�����̸�,last_name, employee_id * 12 as ���� from employees;
Select employee_id as ���̵�, first_name as ù��°�̸�, last_name as �������̸� from employees;
    -- as�� ������ �����ϴ�.
Select employee_id ���̵�, first_name �޷� from employees;
    -- �����̳� Ư�����ڰ� ��� ������ "" ���� ó��.
Select employee_id "��� #��ȣ", first_name �޷� from employees;

-- nvl �Լ� : ����ÿ� null�� ó���ϴ� �Լ�
select * from employees;

-- nvl �Լ��� ������� �ʰ� ��ü ������ ���
select employee_id �����ȣ, first_name ù��°�̸�, salary ����, commission_pct ���ʽ�,
salary * 12,
salary * 12 + commission_pct ��ü���� from employees;

-- nvl �Լ��� ����ؼ� ����
select employee_id �����ȣ, first_name ù��°�̸�, salary ����, commission_pct ���ʽ�,
salary * 12,
salary * 12 + NVL(commission_pct,0) ��ü���� from employees;

-- Ư�� �÷��� ������ �ߺ� ������ ���
select * from employees;
select first_name from emplyees;
select distinct first_name from employees;

--select first_name, distinct last_name from employee; �ٸ��÷� ������ ������ ���� �ִ�.

-- ������ ����ؼ� �˻� (Where)
select * from employees;
select employee_id �����ȣ, first_name �����, job_id ��å, manager_id ���ӻ��,
salary ����, commission_pct ���ʽ� from employees;

-- �����ȣ�� 116�� ����� �̸��� �˻�.
select * from employees where employee_id = 116;

select first_name from employees where employee_id = 115;

-- ��� ��ȣ�� 115�� ����� �����,��å,���� �˻�
select first_name �����, job_id ��å, salary ���� from employees where employee_id = 112;

select * from employees where first_name = 'Jose Manuel';

-- ���ڵ带 �����ö�
    -- number �϶��� ''�� ������ �ʴ´�.
    -- ���ڵ�����(char,varchar2)�� ��¥(date)�� �����ö��� ' ' �� ó��.
    -- ��ҹ��ڸ� ����
    
-- �Ի糯¥�� '06/03/07' �� ��� ���
select first_name from employees where hire_date = '06/03/07';

-- �λ簡 IT_PROG�� ��� ������� ���
select first_name, job_id from employees where job_id = 'IT_PROG';

-- ������ 3000 �̻��� ����� �̸��� �μ� �Ի糯¥
select * from employees;
select first_name, job_id, hire_date,salary from employees
where salary >= 3000;

-- NULL �˻� : is Ű���� ���.
select * from employees where commission_pct is null;

-- commission�� 300 �̻��� ����̸���, ��å, ������ ���
select first_name, job_id, salary, commission_pct from employees where commission_pct >= 0.1;

--Ŀ�Լ��� ���� ������� �̸��� ���.
select first_name , commission_pct from employees where commission_pct is null;

-- ���ǿ��� and, or , not


-- ������ 500 �̻� 2500 �̸��� ������� �̸�, �����ȣ, �Ի糯¥�� ���.
select * from employees;
select employee_id �����ȣ,first_name �̸�, hire_date �Ի糯¥ from employees
where 2500 > salary and salary >= 500;

-- ��å�� FT_ACCOUNT �̰ų�, �μ��ڵ尡 60 �� ����� �̸�, ��å, ����, �μ��ڵ带 ���
select first_name �̸�, job_id ��å, salary ����, department_id from employees
where job_id = 'FT_ACCOUNT' or department_id = 60;

-- Ŀ�Լ��� ���� ������߿� �μ��ڵ尡 40�� ������� �̸�, �μ��ڵ�� �Ի糯¥�� ���
select first_name,department_id 
from employees 
where commission_pct is null and department_id = 100;
-- Ŀ�Լ��� null�� �ƴ� ������� �̸�, �Ի糯¥, ����
select *
from employees
where commission_pct is not null;

-- ��¥ �˻� :
select * from employees;

-- 20058/3/1 ~ 2007/10/15 ���̿� �Ի��� ����� �̸��� ��å

select first_name,email,hire_date
from employees
where hire_date >= '2005/03/01' and hire_date < '2007/10/15';

-- between A and B : A �̻� B ����
select first_name, job_id, hire_date
from employees
where hire_date between '2005/01/01' and '2006/01/01';

-- IN ������

-- ������ 300, 500, 1400�� ����� �̸�, ��å, �Ի����� ���.
select first_name, job_id
from employees
where salary in (300,2400,8000);

-- like : �÷����� Ư���� ���ڿ��� �˻�  <== �۰˻� ����� ����Ҷ�
    -- % : �ڿ� ����ڰ� �͵� �������.
    -- _ : �ѱ��ڰ� ����� �͵� �������.
    
--J�� �����ϴ� �̸��� ���� ����� ��� �˻� �ϱ�.

select * from employees
where first_name like 'J%';

-- �̸��� ia�� ������ ����� �˻� �ϱ�.

select first_name from employees
where first_name like '%ia';

-- J�� ���۵ǰ� J���� �α��ڰ� ����� �͵� ������� ��� ���. �ڿ��� ia �� ������ ��.
select first_name
from employees
where first_name like J_MES';

--������ ���ڰ� R�� ������ ��� ��� �ϱ�
select * 
from employees
where first_name like '%s';

-- prog �ܾ �� ��å�� ���
select *
from employees
where job_id like '%PROG';

-- 05�⵵�� �Ի��� ����� ����ϱ�.
select * 
from employees
where hire_date between '05/01/01' and '07/05/31';

select *
from employee
where hire_date like '81%'

--05�� 7���� �Ի��� ����� ���
select *
from employees
where hire_date like '05/07%';

-- ���� : order by , asc(������������) , desc (������������)

select *
from employees
order by employee_id;

select *
from employees
order by employee_id asc;

select *
from employees
order by employee_id desc;

--�̸� �÷��� ����
-- z���� a����
select *
from employees
order by first_name desc;

--a���� z����
select *
from employees
order by first_name asc;


--��¥ ����
select *
from employees
order by hire_date desc;

-- �����亯�� �Խ��ǿ��� �ַ� ���. �ΰ��̻��� �÷��� �����Ҷ�

select * from employees
order by employee_id desc;

-- �ΰ��� �÷��� ����
select *
from employees
order by employee_id, first_name;

select employee_id, first_name
from employees
order by employee_id desc, first_name desc;

-- where ���� order by ���� ���� ���ɶ�.

select *
from employees
where commission_pct is null
order by first_name;

select * from employees;
--1.
select first_name ����̸�,salary �޿�, salary+300 �λ�޿� from employees;

--2.
select first_name ����̸�, salary/12 �޿�, salary+100 ����
from employees
order by salary;

--3.
select first_name ����̸�, salary
from employees
where salary >= 2000
order by salary;

--4. �����ȣ 100��
select employee_id �����ȣ, first_name �̸�, department_id �μ���ȣ
from employees
where employee_id = 100;

--5. 
select first_name �̸�, salary �޿� 
from employees
where not salary >= 2000 or not salary <=3000
order by salary;

--6. 02/01/01 ���� 05/05/05 �� ������ �Ի��� ������ �Ի��� 
select * from employees;
select first_name �Ի���, job_id ����, hire_date �Ի���
from employees
where hire_date between '02/01/01' and '05/05/05';

--7.�μ���ȣ 30,90
select first_name ����̸�, department_id �μ���ȣ
from employees
where department_id = 30 or department_id =90
order by department_id;

--8.
select first_name ����̸�, salary �޿�, department_id �μ���ȣ
from employees
where department_id = 30 or department_id = 90
order by first_name asc;

--9.
select first_name ����̸�,hire_date �Ի���
from employees
where hire_date like '00%';


-- �پ��� �Լ� ����ϱ�
/*
    1. ���ڸ� ó���ϴ� �Լ�
        - UPPER : �빮�ڷ� ��ȯ
        - LOWER : �ҹ��ڷ� ��ȯ
        - INITCAP : ù �ڴ� �빮�ڷ� �������� �ҹ��ڷ� ��ȯ
        
        dual ���̺� : �ϳ��� ����� ��� �ϵ��� �ϴ� ���̺�
*/

select '�ȳ��ϼ���' �ȳ�
from dual

select 'Oracle mania' , upper ('Oracle mania'), lower ('Oracle mania'),initcap('Oracle mania')
from dual

select * from employees;

select first_name, lower(first_name), initcap (first_name), upper(first_name) from employees;

select * from employees
where first_name = 'david';  -- �ҹ��ڸ� �־����� �˻��� �ȵȴ�.

select * from employees
where lower(first_name) = 'david';

select * from employees
where initcap(first_name) = 'David';


-- ���� ���̸� ��� �ϴ� �Լ�
    -- length : ������ ���̸� ��ȯ, �����̳� �ѱ� ������� ���ڼ��� ��������
    -- lengthb : ������ ���̸� ��ȯ�ϴµ� �ѱ��� 3byte�� ��ȯ
    
    select length ('Oracle mania'), length ('����Ŭ �ŴϾ�') from dual;
    
    select lengthb ('Oracle mania'), lengthb ('����Ŭ �ŴϾ�') from dual;

    select * from employees;
    
    select first_name, length(first_name), job_id, length(job_id)
    from employees;

-- ���� ���� �Լ�
    -- concat : ���ڿ� ���ڸ� �����ؼ� ���
    -- substr : ���ڸ� Ư�� ��ġ���� �߶���� �Լ� (����, �ѱ� ��� 1byte�� ó��)
    -- substrb :���ڸ� Ư�� ��ġ���� �߶���� �Լ� (������ 1byte, �ѱ��� 3byte)
    -- instr : ������ Ư�� ��ġ�� �ε��� ���� ��ȯ
    -- instrb : ������ Ư�� ��ġ�� �ε��� ���� ��ȯ(������ 1byte, �ѱ��� 3byte �� ó��)
    -- lpad, rpad : �Է� ���� ���ڿ����� Ư���� ���ڸ� ����.
    -- trm : �߶󳻰� ���� ���ڸ� ��ȯ.

select 'Oracle', 'mania', concat('Oracle','mania') from dual;

-- substr (���, ������ġ, ���ⰹ��) : Ư����ġ���� ���ڸ� �߶�´�.
select 'Oracle mania' , substr('Oracle mania', 3, 5) from dual;
select '����Ŭ �ŴϾ�' , substr('����Ŭ �ŴϾ�',2,4) from dual;

select 'Oracle mania' , substr ('Oracle mania' ,-4,3) , substr ('����Ŭ �ŴϾ�', -6,4)
from dual;

select first_name, substr (first_name,2,3), substr(first_name, -5,2) 
from employees;

select substrb ('Oracle mania' , 3, 3), substrb ('����Ŭ �ŴϾ�', 3,6) from dual;

select * from employees;

select concat ( first_name,' '|| job_id) from employees;

select '�̸��� : ' || first_name || ' �̰�, ��å�� : ' || job_id || ' �Դϴ�.' as �÷�����
from employees;

select * from employees;

select '�̸��� : ' || first_name || ' �̰�, ���ӻ������� : ' || manager_id || '�Դϴ�' as ���ӻ�����
from employees;

-- �̸��� N���� ������ ����� ����ϱ� (substr �Լ��� ����ؼ� ���)
select first_name 
from employees
where substr (first_name, -1, 1) = 'n';

select first_name from employees
where first_name like '%n';

--05�⵵ �Ի��� ����� ��� �ϱ� (substr �Լ��� ����ؼ� ���)
select * from employees
where substr (hire_date, 1,2) = '05';

select * from employees
where hire_date like '05%';

-- instr (���, ã������, ������ġ, ���° �߰�) : ��󿡼� ã�� ������ �ε������� ���.

select 'Oracle mania' , instr ('Oracle mania','a') from dual;

-- 
select 'Oracle mania' , instr ('Oracle mania','a', 5,2) from dual;

-- -5�� Oracle mania �� ������ �� ������ a���� �������� 5����
select 'Oracle mania' , instr ('Oracle mania','a', -5,1) from dual;

select job_id, first_name from employees
where lower (job_id) = 'it_prog';

select distinct instr ( job_id,'A'1,1) from employees where job_id = 'IT_PROG';

-- lpad, rpad : Ư�� ���̸�ŭ ���ڿ��� �����ؼ� ����, �����ʿ� ������ Ư�� ���ڷ� ó��
    --lpad (���, �÷��� ���ڿ�ũ��, Ư����������)
    --rpad (���, �÷��� ���ڿ�ũ��, Ư����������)
select lpad(1234, 10, '#') from dual;  --���� Ư������

select rpad(1234,10,'#') from dual;  --������ Ư������

select salary from employees;

-- TRIM : ��������, Ư�� ���ڵ� ����
    --LTRIM : ���� ���� ����
    --RTRIM : ������ ���� ����
    --TRIM : ����, ������ ������ ����.
select ltrim ('   Oracle mania   '), rtrim ('   Oracle mania   '), trim('   Oracle mania   ')
from dual;




























