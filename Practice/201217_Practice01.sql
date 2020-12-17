/*
*** Practice01 ***
*/

--1. 직원 테이블에서 이름, 성, 월급, 전번, 입사일 출력하고 입사일 오름차순
SELECT  first_name || ' ' || last_name "이름",
        salary "월급",
        phone_number "전화번호",
        hire_date "입사일"
FROM employees
order by hire_date asc;

--2. 업무 테이블에서 월급 내림차순으로 업무이름, 최고월급 출력
SELECT  job_title,
        max_salary
FROM jobs
ORDER BY max_salary desc;

--3. 직원 테이블에서 이름, 매니저 아이디, 커미션 비율, 월급 출력하는데 매니저 있고 커미션비율 없고 월급 3000초과
SELECT  first_name,
        manager_id,
        commission_pct,
        salary
FROM employees
where manager_id is not null 
    and commission_pct is null
    and salary > 3000;
    
--4. 업무 테이블에서 업무 이름, 최고월급 출력하는데 업무 이름은 최고월급 10000 이상, 최고월급은 내림차 정렬
SELECT  job_title,
        max_salary
FROM jobs
where max_salary >= 10000 
order by max_salary desc;

--5. 직원 테이블에서 이름, 월급 커미션퍼센트 출력하는데 월급 14000 미만 10000 이상인 직원이고 월급 내림차 정렬하고 null은 0
SELECT  first_name,
        salary,
        nvl(commission_pct, 0)
FROM employees
where salary >= 10000
    and salary < 14000
order by salary desc;

--6. 직원 테이블에서 이름, 월급, 입사일, 부서번호 출력하는데 부서번호 10 90 100이고 입사일 표기는 1977-12
SELECT  first_name,
        salary,
        to_char(hire_date, 'YYYY-MM'),
        department_id            
FROM employees
where department_id in (10, 90, 100);

--7. 직원 테이블에서 이름, 월급 출력하는데 이름에 S 또는 s 들어감
SELECT  first_name,
        salary
FROM employees
where first_name like ('%S%') or first_name like ('%s%');

--8. 부서 테이블에서 부서이름 출력하는데 이름 긴 순서대로
SELECT  department_name
FROM departments
order by LENGTH(department_name) desc;

--9. 국가 테이블에서 국가명 대문자 출력인데 지사가 있을 것으로 예상되는 국가고 오름차
SELECT  upper(country_name)
FROM countries
where country_name is not null
order by country_name asc;

--10. 직원 테이블에서 이름, 월급, 전번, 입사일 출력하는데 03/12/31 이전 입사한 직원이고 전번은 545-343-3433 형태
--처음에 replace가 아니라 to_char(phone_number, '999-999-9999') 이렇게 하니까 오류났는데 전번은 숫자가 아니라 문자열이라 그럼
SELECT  first_name,
        salary,
        replace(phone_number, '.', '-'), 
        hire_date
FROM employees
where hire_date <= '03/12/31';
