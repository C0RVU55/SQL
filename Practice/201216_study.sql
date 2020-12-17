--����

--Ư�� ���̺��� ��� Į�� ���
SELECT
    *
FROM employees;

--���� ���̺��� ������ȣ�� empNo, �̸��� E-name, �޿��� �� ������ ���
SELECT employee_id "empNo",
        first_name "E-name",
        salary "�� ��"
FROM employees;

--���� ���̺��� �̸� �Ǵ� ' ' �Ǵ� �� ���
SELECT first_name || ' ' || last_name
FROM employees;

--���� ���̺��� �̸� �Ǵ� ' hire date is ' �Ǵ� �Ի��� ���
SELECT first_name || ' hire date is ' || hire_date
FROM employees;

--���� ���̺��� �̸�, �޿�, �޿�*12 ���
SELECT first_name,
        salary,
        salary*12
FROM employees;

--���� ���̺��� �̸�, �޿�, �޿�*12, (�޿�+300)*12 ���
SELECT first_name,
        salary,
        salary*12,
        (salary+300)*12
FROM employees;

--���� ���̺��� �μ���ȣ�� 10�� ���� �̸� ���
SELECT first_name
FROM employees
where department_id = 10;

--���� ���̺��� �޿��� 14000�̻� 17000������ ���� �̸�. �޿� ���
SELECT first_name,
        salary
FROM employees
where salary between 14000 and 17000;

--���� ���̺��� �̸��� Neena, Lex, John�� ���� �̸�, ��, �޿� ��� 
SELECT first_name,
        last_name,
        salary
FROM employees
where first_name in ('Neena', 'Lex', 'John');

--���� ���̺��� �̸��� L�� �����ϴ� ���� �̸�, ��, �޿� ���
SELECT first_name,
        last_name,
        salary
FROM employees
where first_name like 'L%';

--���� ���̺��� �޿��� 13000�̻� 15000�����̰� Ŀ�̼��ۼ�Ʈ�� null�� �ƴ� ���� �̸�, �޿�, Ŀ�̼��ۼ�Ʈ, �޿�*Ŀ�̼��ۼ�Ʈ
SELECT first_name,
        salary,
        commission_pct,
        salary*commission_pct
FROM employees
where salary between 13000 and 15000 and commission_pct is not null;

--���� ���̺��� �̸�, �޿� ����ϰ� �޿� ������ ����
SELECT first_name,
        salary
FROM employees
order by salary desc;
--���� ���̺��� �޿� 9000�̻��� ���� �̸�, �μ���ȣ, �޿� ����ϰ� �μ���ȣ ������ ����, ������ �޿� ������ ����
SELECT first_name "�̸�",
        department_id "�μ���ȣ",
        salary "�޿�"
FROM employees
where salary >= 9000
order by department_id asc, salary desc;

