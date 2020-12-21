/*
*** Practice03 ***
*/

/*
1.직원들의 사번(employee_id), 이름(firt_name), 성(last_name)과 부서명(department_name)을 조회하여 
부서이름(department_name) 오름차순, 사번(employee_id) 내림차순 으로 정렬하세요. (106건)
*/
SELECT  employee_id "사번",
        first_name "이름",
        last_name "성",
        department_name "부서명"
FROM employees em, departments de
where em.department_id = de.department_id
order by de.department_name asc, em.employee_id desc;

/*
2. employees 테이블의 job_id는 현재의 업무아이디를 가지고 있습니다.
직원들의 사번(employee_id), 이름(firt_name), 급여(salary), 부서명(department_name), 
현재업무(job_title)를 사번(employee_id) 오름차순 으로 정렬하세요.
부서가 없는 Kimberely(사번 178)은 표시하지 않습니다.
(106건)
*/
SELECT  em.employee_id,
        em.first_name,
        em.salary,
        de.department_name,
        jo.job_title
FROM employees em, jobs jo, departments de
where em.job_id = jo.job_id and em.department_id = de.department_id
order by em.employee_id asc;

/*
2-1. 문제2에서 부서가 없는 Kimberely(사번 178)까지 표시해 보세요
(107건)
*/
SELECT  em.employee_id,
        em.first_name,
        em.salary,
        de.department_name,
        jo.job_title
FROM employees em 
left outer join jobs jo on em.job_id = jo.job_id
left outer join departments de on em.department_id = de.department_id
order by em.employee_id asc;
--테이블 3개일 때 join은 join을 2번 써주면 되는데 조건(on)을 각 join문에 따로 써야 됨.
--on과 where의 차이 : on은 join과 같이 실행되고 where은 join 후에 실행돼서 결과 범위가 달라짐.

/*
문제3.
도시별로 위치한 부서들을 파악하려고 합니다.
도시아이디, 도시명, 부서명, 부서아이디를 도시아이디(오름차순)로 정렬하여 출력하세요 
부서가 없는 도시는 표시하지 않습니다.
(27건)
*/
SELECT  lo.location_id "도시아이디",
        lo.city "도시명",
        de.department_name "부서명",
        de.department_id "부서아이디"
FROM departments de left outer join locations lo
on de.location_id = lo.location_id
order by lo.location_id asc;

/*
3-1.
문제3에서 부서가 없는 도시도 표시합니다. 
(43건)
*/
SELECT  lo.location_id "도시아이디",
        lo.city "도시명",
        de.department_name "부서명",
        de.department_id "부서아이디"
FROM departments de right outer join locations lo
on de.location_id = lo.location_id
order by lo.location_id asc;

/*
4. 지역(regions)에 속한 나라들을 
지역이름(region_name), 나라이름(country_name)으로 출력하되 
지역이름(오름차순), 나라이름(내림차순) 으로 정렬하세요.
(25건)
*/
SELECT  re.region_name "지역이름",
        co.country_name "나라이름"
FROM regions re left outer join countries co
on re.region_id = co.region_id
order by re.region_id asc, co.country_name desc;

/*
5. 자신의 매니저보다 채용일(hire_date)이 빠른 사원의 
사번(employee_id), 이름(first_name)과 채용일(hire_date), 매니저이름(first_name), 매니저입사일(hire_date)을 조회하세요.
(37건)
*/
SELECT  em.employee_id "사번",
        em.first_name "이름",
        em.hire_date "채용일",
        ma.first_name "매니저이름",
        ma.hire_date "매니저입사일"
FROM employees em, employees ma
where em.manager_id = ma.employee_id
and em.hire_date < ma.hire_date;

/*
6. 나라별로 어떠한 부서들이 위치하고 있는지 파악하려고 합니다.
나라명, 나라아이디, 도시명, 도시아이디, 부서명, 부서아이디를 나라명(오름차순)로 정렬하여 출력하세요.
값이 없는 경우 표시하지 않습니다.
(27건)
*/
SELECT  co.country_name "나라명",
        co.country_id "나라아이디",
        lo.city "도시명",
        lo.location_id "도시아이디",
        de.department_name "부서명",
        de.department_id "부서아이디"
FROM departments de
left outer join locations lo on de.location_id = lo.location_id
left outer join countries co on lo.country_id = co.country_id
order by co.country_name asc;

/*
7. job_history 테이블은 과거의 담당업무의 데이터를 가지고 있다.
과거의 업무아이디(job_id)가 ‘AC_ACCOUNT’로 근무한 사원의 사번, 이름(풀네임), 업무아이디, 시작일, 종료일을 출력하세요.
이름은 first_name과 last_name을 합쳐 출력합니다.
(2건)
*/
SELECT  em.employee_id "사번",
        first_name || ' ' || last_name "이름(풀네임)",
        jh.job_id "업무아이디", --과거의 업무아이디가 있는 곳은 jh라서 em으로 하면 결과 안 나옴.
        jh.start_date "시작일",
        jh.end_date "종료일"
FROM employees em left outer join job_history jh
on em.employee_id = jh.employee_id
where jh.job_id = 'AC_ACCOUNT'; --여기도 마찬가지

/*
8. 각 부서(department)에 대해서 부서번호(department_id), 부서이름(department_name), 
매니저(manager)의 이름(first_name), 위치(locations)한 도시(city), 나라(countries)의 이름(countries_name)
그리고 지역구분(regions)의 이름(resion_name)까지 전부 출력해 보세요.
(11건)
*/
--null 제외하려면 아래처럼 해야 됨
SELECT  de.department_id "부서번호",
        de.department_name "부서명",
        em.first_name "매니저이름",
        lo.city "도시",
        co.country_name "국가명",
        re.region_name "지역명"
FROM departments de, employees em, locations lo, countries co, regions re 
where de.manager_id = em.employee_id 
and de.location_id = lo.location_id
and lo.country_id = co.country_id
and co.region_id = re.region_id
order by de.department_id asc;

/*
9. 각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명(department_name), 매니저(manager)의 이름(first_name)을 조회하세요.
부서가 없는 직원(Kimberely)도 표시합니다.
(106명)
*/
SELECT  em.employee_id "사번",
        em.first_name "이름",
        de.department_name "부서명",
        ma.first_name "매니저이름"
FROM employees em left outer join departments de
on em.department_id = de.department_id
, employees ma --outer join이랑 equl join(,) 같이 사용 가능
where em.manager_id = ma.employee_id; --순서 헷갈리지 말기 : 직원1(직원)테이블의 매니저번호 = 직원2(매니저)테이블의 직원번호 

