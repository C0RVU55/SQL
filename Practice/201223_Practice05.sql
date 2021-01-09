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

/*###
3. 매니저별로 평균급여 최소급여 최대급여를 알아보려고 한다.
-통계대상(직원)은 2005년 이후의 입사자 입니다.
-매니저별 평균급여가 5000이상만 출력합니다.
-매니저별 평균급여의 내림차순으로 출력합니다.
-매니저별 평균급여는 소수점 첫째자리에서 반올림 합니다.
-출력내용은 매니저아이디, 매니저이름(first_name), 매니저별평균급여, 매니저별최소급여, 매니저별최대급여 입니다.
(9건)
*/
--1.직원 조건 : 05년 이후 입사, 매니저별 평균급여 5000이상 2.매니저별 최대/최소 급여
--직원테이블 하나 두고 여기에 매니저이름, 매니저별 급여 평균, 매니저별 최저급여, 매니저별 최고급여 테이블 다 만들어서 이퀄조인 - 실패
--직원테이블 하나 두고 매니저이름 이퀄조인하고 매니저별 평균/최저/최고급여 묶기?

--매니저별 담당직원들의 평균급여 최소급여 최대급여 조회
--통계대상(직원)은 2005년 1월 1일 이후 / 매니저 평균급여 소수점 첫째자리에서 반올림
select  emp.manager_id "매니저아이디",
        round(avg(emp.salary),1) "매니저별평균급여",
        min(emp.salary) "매니저별최소급여",
        max(emp.salary) "매니저별최대급여"
from employees emp, employees man
where emp.manager_id = man.employee_id
and emp.hire_date >= '05/01/01'
group by emp.manager_id;

--employees 테이블과 다시 조인
--매니저별 평균급여 5000 이상 / 평균급여 내림차
select  ms."매니저아이디",
        em.first_name "매니저이름",
        ms."매니저별평균급여" "매니저별평균급여",
        ms."매니저별최소급여" "매니저별최소급여",
        ms."매니저별최대급여" "매니저별최대급여"
from (select  emp.manager_id "매니저아이디",
              round(avg(emp.salary),1) "매니저별평균급여",
              min(emp.salary) "매니저별최소급여",
              max(emp.salary) "매니저별최대급여"
      from employees emp, employees man
      where emp.manager_id = man.employee_id
      and emp.hire_date >= '05/01/01'
      group by emp.manager_id) ms, employees em
where ms."매니저아이디" = em.employee_id
and ms."매니저별평균급여" >= 5000
order by ms."매니저별평균급여" desc;


/*
문제4.
각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명(department_name), 매니저(manager)의 이름(first_name)을 조회하세요.
부서가 없는 직원(Kimberely)도 표시합니다.
(106명)
*/
--1.직원테이블에 부서테이블 조인 2.직원테이블 자기참조해서 이름 출력 3.null값출력을 위해 em, ma을 자기참조로 묶고 부서테이블 아우터조인시키기
SELECT  em.employee_id "사번",
        em.first_name "이름",
        de.department_name "부서명",
        ma.first_name "매니저이름"
FROM employees em, departments de, employees ma
where em.department_id = de.department_id
and em.manager_id = ma.employee_id;


/*###
문제5.
2005년 이후 입사한 직원중에 입사일이 11번째에서 20번째의 직원의 
사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 출력하세요
*/
--먼저 where절 넣고 직원, 부서 테이블 조인
select  employee_id,
        first_name,
        department_name,
        salary,
        hire_date
from employees emp, departments dep
where emp.department_id = dep.department_id
and hire_date >= '05/01/01';

--rownum / 입사일 오름차
select  rownum,
        employee_id,
        first_name,
        department_name,
        salary,
        hire_date
from (select  employee_id,
              first_name,
              department_name,
              salary,
              hire_date
      from employees emp, departments dep
      where emp.department_id = dep.department_id
      and hire_date >= '05/01/01') o
order by hire_date asc;

-- 합침 / 입사일 11번째에서 20번째 직원

select  rm,
        employee_id "사번",
        first_name "이름",
        department_name "부서명",
        salary "급여",
        hire_date "입사일"
from (select    rownum as rm,
                employee_id,
                first_name,
                department_name,
                salary,
                hire_date
        from (select  employee_id,
                      first_name,
                      department_name,
                      salary,
                      hire_date
              from employees emp, departments dep
              where emp.department_id = dep.department_id
              and hire_date >= '05/01/01'
              order by hire_date asc) o
        ) result
where rm >= 11
and rm <= 20;

/*###
6. 가장 늦게 입사한 직원의 이름(first_name last_name)과 연봉(salary)과 근무하는 부서 이름(department_name)은?
*/
SELECT  first_name || ' ' || last_name,
        salary,
        department_name
FROM employees em, departments de
where em.department_id = de.department_id
and em.hire_date = (SELECT  max(hire_date)
                    FROM employees);

------------------------------------------


/*
7. 평균연봉(salary)이 가장 높은 부서 직원들의 
직원번호(employee_id), 이름(firt_name), 성(last_name)과  업무(job_title), 연봉(salary)을 조회하시오.
*/
--1.평균 연봉이 가장 높은 부서 연봉 2.이 부서 직원들 정보


/*
8. 평균 급여(salary)가 가장 높은 부서는? 
*/


/*문제9.
평균 급여(salary)가 가장 높은 지역은? 
*/

/*문제10.
평균 급여(salary)가 가장 높은 업무는? 
*/