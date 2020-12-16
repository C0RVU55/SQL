--연습

--특정 테이블에서 모든 칼럼 출력
SELECT
    *
FROM employees;

--직원 테이블에서 직원번호를 empNo, 이름을 E-name, 급여를 연 봉으로 출력
SELECT employee_id "empNo",
        first_name "E-name",
        salary "연 봉"
FROM employees;

--직원 테이블에서 이름 또는 ' ' 또는 성 출력
SELECT first_name || ' ' || last_name
FROM employees;

--직원 테이블에서 이름 또는 ' hire date is ' 또는 입사일 출력
SELECT first_name || ' hire date is ' || hire_date
FROM employees;

--직원 테이블에서 이름, 급여, 급여*12 출력
SELECT first_name,
        salary,
        salary*12
FROM employees;

--직원 테이블에서 이름, 급여, 급여*12, (급여+300)*12 출력
SELECT first_name,
        salary,
        salary*12,
        (salary+300)*12
FROM employees;

--직원 테이블에서 부서번호가 10인 직원 이름 출력
SELECT first_name
FROM employees
where department_id = 10;

--직원 테이블에서 급여가 14000이상 17000이하인 직원 이름. 급여 출력
SELECT first_name,
        salary
FROM employees
where salary between 14000 and 17000;

--직원 테이블에서 이름이 Neena, Lex, John인 직원 이름, 성, 급여 출력 
SELECT first_name,
        last_name,
        salary
FROM employees
where first_name in ('Neena', 'Lex', 'John');

--직원 테이블에서 이름이 L로 시작하는 직원 이름, 성, 급여 출력
SELECT first_name,
        last_name,
        salary
FROM employees
where first_name like 'L%';

--직원 테이블에서 급여가 13000이상 15000이하이고 커미션퍼센트가 null이 아닌 직원 이름, 급여, 커미션퍼센트, 급여*커미션퍼센트
SELECT first_name,
        salary,
        commission_pct,
        salary*commission_pct
FROM employees
where salary between 13000 and 15000 and commission_pct is not null;

--직원 테이블에서 이름, 급여 출력하고 급여 내림차 정렬
SELECT first_name,
        salary
FROM employees
order by salary desc;
--직원 테이블에서 급여 9000이상인 직원 이름, 부서번호, 급여 출력하고 부서번호 오름차 정렬, 같으면 급여 내림차 정렬
SELECT first_name "이름",
        department_id "부서번호",
        salary "급여"
FROM employees
where salary >= 9000
order by department_id asc, salary desc;

