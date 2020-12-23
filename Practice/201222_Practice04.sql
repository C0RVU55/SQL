/*
*** Practice04 ***
*/

/*
1. 평균 급여보다 적은 급여을 받는 직원은 몇명인지 구하시요.
*/
--1.평균 급여 2.평균 급여보다 적은 급여 직원 수
SELECT  count(salary)
FROM employees
where salary < (SELECT  avg(salary)
                FROM employees);

/*
2. 평균급여 이상, 최대급여 이하의 월급을 받는 사원의 
직원번호(employee_id), 이름(first_name), 급여(salary), 평균급여, 최대급여를 
급여의 오름차순으로 정렬하여 출력하세요 (51건)
*/
--1.평균급여, 최대급여 2.이 조건에 맞는 사원
SELECT  employee_id "직원번호",
        first_name "이름",
        salary "급여",
        (SELECT  avg(salary)
                FROM employees) "평균급여",
        (SELECT  max(salary)
                FROM employees) "최대급여"
FROM employees
where salary <= (SELECT  max(salary)
                FROM employees) 
and salary >= (SELECT  avg(salary)
                FROM employees)
order by salary asc;

/*
3. 직원중 Steven(first_name) king(last_name)이 소속된 부서(departments)가 있는 곳의 주소를 알아보려고 한다.
도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 도시명(city), 주(state_province), 나라아이디(country_id) 를 출력하세요
(1건)
*/
--1.스티븐킹의 부서 2.부서가 소속된 곳 주소
SELECT  first_name,
        last_name,
        department_id
FROM employees
where first_name = 'Steven' and last_name = 'King';

SELECT  lo.location_id,
        lo.street_address,
        lo.postal_code,
        lo.city,
        lo.state_province,
        lo.country_id 
FROM employees em, departments de, locations lo
where (em.first_name, em.last_name, em.department_id) 
in (SELECT  first_name,
            last_name,
            department_id
    FROM employees
    where first_name = 'Steven' 
    and last_name = 'King')
and em.department_id = de.department_id
and de.location_id = lo.location_id;

/*
4. job_id 가 'ST_MAN' 인 직원의 급여보다 작은 직원의 
사번,이름,급여를 급여의 내림차순으로 출력하세요  -ANY연산자 사용 (74건)
*/
--1.직업아이디 ST_MAN 2.해당 직업아이디보다 급여 적음
SELECT  employee_id,
        first_name,
        salary
FROM employees
where salary <any (SELECT  salary
                    FROM employees
                    where job_id = 'ST_MAN');

/*
5. 각 부서별로 최고의 급여를 받는 사원의 
직원번호(employee_id), 이름(first_name)과 급여(salary) 부서번호(department_id)를 조회하세요 
단 조회결과는 급여의 내림차순으로 정렬되어 나타나야 합니다. 
조건절비교, 테이블조인 2가지 방법으로 작성하세요 (11건)
*/
--1. 부서별 최고 급여 2.직원 정보

--조건절 비교


--테이블 조인
SELECT  em.employee_id "사번",
        em.first_name "이름",
        em.salary "급여",
        em.department_id "부서번호"
FROM employees em, (SELECT  department_id,
                            max(salary) salary
                    FROM employees
                    group by department_id) sa
where em.department_id = sa.department_id
and em.salary = sa.salary
order by em.salary desc;

/*
6. 각 업무(job) 별로 연봉(salary)의 총합을 구하고자 합니다. 
연봉 총합이 가장 높은 업무부터 업무명(job_title)과 연봉 총합을 조회하시오 (19건)
*/
--1.업무별로 묶고 연봉 총합 2.연봉 총합(내림차)
SELECT  jo.job_title "업무명",
        em.salary "연봉 총합"
FROM jobs jo, (SELECT  job_id,
                        sum(salary) salary
                FROM employees
                group by job_id) em
where jo.job_id = em.job_id
order by em.salary desc;

/*
7. 자신의 부서 평균 급여보다 연봉(salary)이 많은 직원의 
직원번호(employee_id), 이름(first_name)과 급여(salary)을 조회하세요 (38건)
*/
--1.부서 평균 급여 2.평균 급여와 연봉 비교
SELECT  em.employee_id "직원번호",
        em.first_name "이름",
        em.salary "급여"
FROM employees em, (SELECT  department_id,
                            avg(salary) salary
                    FROM employees
                    group by department_id) a
where em.department_id = a.department_id
and em.salary > a.salary;

/*
8. 직원 입사일이 11번째에서 15번째의 직원의 사번, 이름, 급여, 입사일을 입사일 순서로 출력하세요
*/
--1.입사일 오름차 2.일련번호 11-15
SELECT  rn,
        r.employee_id "사번",
        r.first_name "이름",
        r.salary "급여",
        r.hire_date "입사일"
FROM (SELECT  rownum rn,
            hi.employee_id,
            hi.first_name,
            hi.salary,
            hi.hire_date
    FROM (select  em.employee_id,
                em.first_name,
                em.salary,
                em.hire_date
        from employees em
        order by hire_Date asc) hi) r
where rn >= 11 
and rn <= 15;