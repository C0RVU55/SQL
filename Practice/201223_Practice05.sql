/*
*** Practice05 ***
*/

/*
1. 담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의 
이름, 매니저아이디, 커미션 비율, 월급 을 출력하세요. (45건)
*/
SELECT  first_name,
        manager_id,
        commission_pct,
        salary
FROM employees
where manager_id is not null
and commission_pct is null
and salary > 3000;

/*
문제2. 
각 부서별로 최고의 급여를 받는 사원의 
직원번호(employee_id), 이름(first_name), 급여(salary), 입사일(hire_date), 전화번호(phone_number), 부서번호(department_id) 를 조회하세요 
-조건절비교 방법으로 작성하세요
-급여의 내림차순으로 정렬하세요
-입사일은 2001-01-13 토요일 형식으로 출력합니다.
-전화번호는 515-123-4567 형식으로 출력합니다. (11건)
*/
SELECT  employee_id,
        first_name,
        salary,
        to_char(hire_date, 'YYYY-MM-DD') "입사일",
        replace(phone_number, '.', '-') "전화번호",
        department_id
FROM employees
where (department_id, salary)
in (SELECT  department_id,
            max(salary)
    FROM employees
    group by department_id)
order by salary desc;

/*
3. 매니저별로 평균급여 최소급여 최대급여를 알아보려고 한다.
-통계대상(직원)은 2005년 이후의 입사자 입니다.
-매니저별 평균급여가 5000이상만 출력합니다.
-매니저별 평균급여의 내림차순으로 출력합니다.
-매니저별 평균급여는 소수점 첫째자리에서 반올림 합니다.
-출력내용은 매니저아이디, 매니저이름(first_name), 매니저별평균급여, 매니저별최소급여, 매니저별최대급여 입니다.
(9건)
*/
--1.직원 조건 : 05년 이후 입사, 매니저별 평균급여 5000이상 2.매니저별 최대/최소 급여
SELECT  emp.manager_id "매니저아이디",
        mid.ma_name "매니저이름",
        avgs.avg_sal "매니저별평균급여",
        mins.min_sal "매니저별최소급여",
        maxs.max_sal "매니저별최대급여"
FROM employees emp
, (SELECT  em.manager_id ma_id,
        ma.first_name ma_name
    FROM employees em, employees ma
    where em.manager_id = ma.employee_id
    group by em.manager_id, ma.first_name) mid
, (SELECT  manager_id,
            avg(salary) avg_sal
    FROM employees
    group by manager_id) avgs
, (SELECT  manager_id,
            min(salary) min_sal
    FROM employees
    group by manager_id) mins
, (SELECT  manager_id,
            max(salary) max_sal
    FROM employees
    group by manager_id) maxs
where emp.manager_id = mid.manager_id
and mid.manager_id = avgs.manager_id
and avgs.manager_id = mins.manager_id
and emp.manager_id = maxs.manager_id;??????????????????????






/*
문제4.
각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명(department_name), 매니저(manager)의 이름(first_name)을 조회하세요.
부서가 없는 직원(Kimberely)도 표시합니다.
(106명)
*/


/*
문제5.
2005년 이후 입사한 직원중에 입사일이 11번째에서 20번째의 직원의 
사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 출력하세요
*/

/*
6. 가장 늦게 입사한 직원의 이름(first_name last_name)과 연봉(salary)과 근무하는 부서 이름(department_name)은?
*/
SELECT  rn,
        hi.first_name||' '||hi.last_name,
        hi.salary,
        hi.department_name
FROM (SELECT  rownum rn,
            h.first_name||' '||h.last_name,
            h.salary,
            h.department_name
    FROM (SELECT  em.hire_date,
                em.first_name||' '||em.last_name,
                em.salary,
                de.department_name
        FROM employees em, departments de
        where em.department_id = de.department_id
        order by hire_date desc) h) hi
where rn = 1;



/*
7. 평균연봉(salary)이 가장 높은 부서 직원들의 
직원번호(employee_id), 이름(firt_name), 성(last_name)과  업무(job_title), 연봉(salary)을 조회하시오.
*/
--1.평균 연봉이 가장 높은 부서 연봉 2.이 부서 직원들 정보
SELECT  e.employee_id,
        e.first_name,
        e.last_name,
        j.job_title,
        e.salary
FROM employees e, jobs j
???

SELECT  max(s.salary)
FROM (SELECT  department_id,
            avg(salary) salary
    FROM employees
    group by department_id) s;


/*
8. 평균 급여(salary)가 가장 높은 부서는? 
*/


/*문제9.
평균 급여(salary)가 가장 높은 지역은? 
*/

/*문제10.
평균 급여(salary)가 가장 높은 업무는? 
*/