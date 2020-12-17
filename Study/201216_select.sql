--�̰Ŵ� �׽�Ʈ�� �غ��� ���̶� ���� ������ ���� ���� ����.

/*
*** select �� ***
*/
SELECT * from employees;
SELECT * from departments;

--���ϴ� �÷� ��ȸ�ϱ� : select �÷���(,�� ����) from ���̺��
select employee_id, 
         first_name, 
         last_name 
from employees;

--��� �̸�(first_name)�� ��ȭ��ȣ, �Ի���, ���� ���
--���� ���̺��� ���� ������ ���̺� ������ ���鼭 ������ �ľ��ؾ� ��.
SELECT first_name,
            phone_number,
            hire_date,
            salary
FROM employees;

/*
�÷��� ��� ���� ���� : ������ �ٲ��� �ʰ� ǥ�⸸ �̷��� �� (as ��������)
"" ǥ�� : ��ҹ���, ����, Ư������ (�ѱ��� ""�� ���� �� ������)
--�̸� ��ȭ��ȣ �Ի��� �޿� > �÷� ���� ���� ������� ��µ�
*/
--���� ã�� : ���̺�� �³� Ȯ�� > Į���� Ȯ�� > �⺻ ���� Ȯ��
--���̺� ������ �ӽ������ �����̱� ������ order�� ������ ��� �ٲ�. �������� ������� �׳� �����ֱ⸸ �ϴ� ��. 
select employee_id as "�����ȣ",
        last_name as "��",
        first_name as "�̸�",
        salary as "�޿�",
        phone_number ��ȭ��ȣ,
        email "�̸���",
        hire_date "�Ի���"
from employees;

select first_name "�̸�",
        phone_number "��ȭ��ȣ",
        hire_date "�Ի���",
        salary "�޿�"
from employees;

/*
*** ������ ***
*/

--���� ������ : || �̰� ''�� ���ڿ� �߰� ����
select first_name || ' ' || last_name as name
from employees;

--ū����ǥ�� ��������ǥ �ȿ� ������ �Ǵµ� ��������ǥ�� 2�� �־�� �� > ' ''����'' ' 
SELECT first_name || ' hire date is ' || hire_date
FROM employees;

--��� ������ : + - * /
SELECT first_name,
            salary as "�޿�",
            salary * 12 as "����",
            (salary+300)*12 as "�󿩱�"
FROM employees;

/*
���ڿ��� ���ڷ� ��� �Ұ���
SELECT job_id*12
FROM employees;
*/

--����
SELECT first_name || '-' || last_name "����",
            salary "�޿�",
            salary*12 "����",
            salary*12+5000 "����2",
            phone_number "��ȭ��ȣ"
FROM employees;

--select from �� ó�� ��� : ���̺� > 1row ���� > select���� �´� �κи� projection(ȭ�鿡 ������) > ���̺��� ��� �� ���� ������ �ݺ�

/* 
select�� > where��(=, !=, <, >, <=, >=)
������ where ���� �³� ���ϴµ� 1�� ���� �ӽ������ؼ� ���ϴ� ��. �� �´� ���� ������ ���� ���� �Ѿ.
*/

SELECT first_name
FROM employees
where department_id = 10; 

--���� 15000�̻��� ����� �̸�, ���� ���
SELECT salary,
            first_name
FROM employees
where salary>=15000;

--07/01/01 ���� �Ի��� ��� �̸�, �Ի��� ���
SELECT hire_date,
            first_name
FROM employees
where hire_date>='07/01/01'; --��¥ ǥ�� 07-01-01 07:01:01 07.01.01 �� ��
 
--Lex�� ��� ���� ���
SELECT salary
FROM employees
where first_name = 'Lex'; --select���� first_name ���� �̸� ���� salary�� ��µ�. select������ �� ��������� ���ϴ� ��.