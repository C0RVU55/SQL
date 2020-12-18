/*
*** practice02 ***
*/

--1. 매니저 있는 직원 수
SELECT  count(*)
FROM employees
where manager_id is not null;

--2. 직원 테이블에서 최고임금과 최저임금을 각각 컬럼명으로 출력하고 차이값
SELECT  max(salary) "최고임금",
        min(salary) "최저임금",
        MAX(salary) - min(salary) "최고임금 - 최저임금"
FROM employees;

--3. 마지막으로 신입 들어온 날 2014년 07년 10일 형식으로 출력
SELECT  max(to_char(hire_date, 'YYYY"년" MM"월" DD"일"'))
FROM employees;

--4. 직원 테이블에서 평균임금, 최고임금, 최저임금, 부서아이디 출력하는데 부서별로 묶고 내림차 정렬
SELECT  avg(salary),
        max(salary),
        min(salary),
        department_id
FROM employees
group by department_id
order by department_id desc;

--5. 직원 테이블에서 평균/최고/최저임금, 업무아이디 출력하는데 업무아이디별로 묶고 최저 내림차, 평균임금(소수점 반올림), 오름차로 정렬
SELECT  round(avg(salary), 0),
        max(salary),
        min(salary),
        job_id
FROM employees
group by job_id
order by min(salary) desc, avg(round(salary, 0)) asc;

--6. 가장 오래 일한 직원 입사일 2001-01-13 토요일 형식으로 출력
SELECT  min(to_char(hire_date, 'YYYY-MM-DD DAY'))
FROM employees;

--7. 직원 테이블에서 부서번호, 평균임금, 최저임금, 평균-최저 출력하는데 평균-최저 < 2000인 부서고 평균-임금을 내림차 정렬
SELECT  department_id,
        round(avg(salary), 0) "평균임금",
        min(salary) "최저임금",
        round(avg(salary), 0) - min(salary) "평균 - 최저"
FROM employees
group by department_id
having round(avg(salary), 0) - min(salary) < 2000
order by round(avg(salary), 0) - min(salary) desc;

--8. 업무 테이블에서 최고임금과 최저임금 차이 출력하는데 업무별로 하고 내림차
SELECT  job_title,
        max_salary - min_salary
FROM jobs
order by max_salary - min_salary desc;

--9. 직원 테이블에서 관리자, 평균/최소/최대급여 출력
--입사자는 2005 이후 입사, 관리자별로 묶어서 평균급여 5000 이상
--평균급여 소수점 첫째자리 반올림해서 내림차
SELECT  manager_id "관리자",
        round(avg(salary), 0) "평균급여",
        min(salary) "최소급여",
        max(salary) "최대급여"
FROM employees
group by manager_id, hire_date
having hire_date >= '05/12/31' 
    and round(avg(salary), 0) >= 5000
order by round(avg(salary), 0) desc; 

--10. 직원 테이블에서 입사일 별로 직원 나누고 입사일 오름차 정렬
SELECT  first_name,
        hire_date,
        case when hire_date < '02/12/31' then '창립멤버'
            when hire_date > '02/12/31' and hire_date < '04/01/01' then '03년입사'
            when hire_date > '03/12/31' and hire_date < '05/01/01' then '04년입사'
            else '상장이후입사' --''는 표시할 내용이지 컬럼명이 아님
        end optDate
FROM employees
order by hire_date asc;

