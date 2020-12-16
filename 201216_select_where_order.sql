/*
*** ���� where / in ***
*/

--������ 2�� �̻��� �� �ѹ��� ��ȸ
SELECT first_name,
            salary
FROM employees
where salary <= 14000
or salary >= 17000; --��谪���� �����ϸ� where salary between 14000 and 17000; �� �ᵵ ��

SELECT first_name,
            hire_date
FROM employees
where hire_date >= '04/01/01'
and hire_date <= '05/12/31';

--���� ���� �˻� : in('����')
SELECT first_name, 
                last_name,
                salary
FROM employees
where first_name in ('Neena','Lex'); 
/*
''������ �ɷ� �� �� �˻��ϰ� ���� ''�������� �� �� �� �˻�
where first_name = 'Neena' or first_name = 'Lex' or first_name = 'John';
Ǯ��� ���� ����
*/

SELECT first_name,
            last_name,
            salary
FROM employees
where salary in ('2100', '3100', '4100', '5100');

/*
*** Like �����ڷ� ����� ������ ã�� ***
*/
-- % : ���� ���� ���� ���� ���ڿ� / _ : �� ���� ����
SELECT first_name,
                last_name,
                salary
FROM employees
where first_name like 'L%'; --ó���� L�� �� ����Ǵ� �� �߿� select�� �ִ� �� ���

SELECT first_name,
                last_name,
                salary
FROM employees
where first_name like '_a____%';

--����
SELECT first_name,
                salary
FROM employees
where first_name like '%am%';

SELECT first_name,
                salary
FROM employees
where first_name like '_a%';

SELECT first_name,
                salary
FROM employees
where first_name like '___a%';

SELECT first_name,
                salary
FROM employees
where first_name like '__a_';

/*
*** NULL ***

�ƹ� ���� �������� �ʾƼ� ��� ������Ÿ�Կ� ��� ����
null�� ����ϸ� ����� null ����(��� ���Ѵٴ� ��)
not null�̳� primary key �Ӽ����� ����� �� ����
*/

--���� Ǯ��Ẹ�� : ���� ���̺��� �޿��� 13000���� 15000������ ������ �̸�, �޿�, Ŀ�̼�%, �޿�*Ŀ�̼� ���
SELECT first_name,
            salary,
            commission_pct,
            salary*commission_pct 
FROM employees
where salary between 13000 and 15000;

--null���� ����ϱ� / �����ϱ� : is null / is not null (commission_pct = null < �̰� �ƴ�)
SELECT first_name,
            salary,
            commission_pct,
            salary*commission_pct 
FROM employees
where salary between 13000 and 15000 and
            commission_pct is not null;
            
SELECT first_name,
            salary,
            commission_pct,
            salary*commission_pct 
FROM employees
where commission_pct is not null;

SELECT first_name
FROM employees
where commission_pct is null
            and manager_id is null;

/*
primary key : �ߺ� �� �ǰ� null �� ��
���̺��� �ݵ�� �� ���� ������ pk�� �־ �̰ɷ� ���ϴ� ������ �ϳ��� ���� �� �ְ� �ؾ� ��
*/
SELECT
    *
FROM employees
where employee_id = 110;

/*
*** order by : ���� ***

select ��(���� ����)
    select �� (�ش� ������ projection�� order�� �� �� �������� ����ż� select�� ���� Į���̶� where, order���� �����)
    from ��
    where ��
    order by �� (���� �� �� �ϰ� �������� ���� ���ϴ� ��. �� �� �����ϱ� ���� �����͵��� �ӽ÷� �ִ� ���¶� ���� ���� �� ��.)
*/
SELECT first_name,
            salary
FROM employees
order by salary desc; --������

SELECT first_name,
            salary
FROM employees
where salary >= 9000
order by salary asc; --������ (�⺻�̶� �����ص� �Ǵµ� ���ִ� �� ���� ��) / ���� ������ ,�� ���� ����

--����
--�μ���ȣ ��������, �μ���ȣ �޿� �̸� ���
SELECT department_id,
            salary,
            first_name
FROM employees
order by department_id asc;

--�޿� 10000�̻� �����̸�, �޿� ����ϴµ� �޿��� ������
SELECT first_name,
                salary
FROM employees
where salary >= 10000
order by salary desc;

--�μ���ȣ ������ �����ϴµ� ������ �޿� ���� ������ �μ���ȣ, �޿�, �̸� ���
SELECT department_id,
                salary,
                first_name
FROM employees
order by department_id asc, salary desc; --"�μ���ȣ�� ������"�� �μ���ȣ ����(���εǴ� �� ���� ��ߵ�)���� �޿� ���ķ� �Ѿ ���� �ǹ�