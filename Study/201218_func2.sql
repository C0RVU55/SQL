/*
*** 그룹함수 ***
*/

/*
SELECT  avg(salary),
        first_name
FROM employees;
*/
--그룹함수는 하나만 써야 됨. 위처럼 다른 컬럼이랑 못씀.
SELECT  avg(salary)
FROM employees;

--그룹함수 count() : 개수 세기
SELECT  count(*) --안에 데이터가 있든 없든 row값 추출
FROM employees;

SELECT  count(commission_pct) --특정 컬럼인 경우 null 제외
FROM employees;

--조건 추가 가능
SELECT  count(*)
FROM employees
where salary > 16000;

--그룹함수 sum() : 일단 숫자면 다 더해지긴 함
select  sum(salary),
        count(*) --이렇게 그룹함수끼리 같이 쓸 수는 있음
from employees;

--그룹함수 avg() : null빼고 계산함. (null 제외하고 싶으면 그냥 계산하고 바꾸고 싶으면 nvl 씀)
SELECT  count(*),
        sum(salary),
        avg(nvl(salary, 0))
FROM employees;

--그룹함수 max() min() : 근데 데이터를 정렬 후에 구하는 거라 데이터가 많으면 속도가 느림
SELECT  max(salary) 
FROM employees;

/*
*** group by 절 ***
*/
SELECT  department_id,
        avg(salary)
FROM employees
group by department_id --원래 avg랑 다른 컬럼명 못 쓰는데 부서번호가 그룹 기준이 돼서 같이 사용 가능.
order by department_id;

SELECT  department_id,
        job_id,
        avg(salary),
        sum(salary)
FROM employees
group by department_id, job_id --부서번호를 기준으로 묶고 다음 기준으로 세분화 (,로 나열함)
order by department_id;

--예제 : 연봉 합계 20000이상인 부서의 부서번호, 인원수, 급여합계
SELECT  department_id,
        count(*),
        sum(salary)
FROM employees
where sum(salary) >= 20000 --where절에는 그룹함수 사용 불가 > having절 사용
group by department_id;

/*
*** having절 ***
그룹함수와 group by에 참여한 함수만 사용 가능
*/
SELECT  department_id,
        count(*),
        sum(salary)
FROM employees
group by department_id
having sum(salary) >= 20000
    and department_id = 100;

/*
*** case - end ***
case when 조건식 then 실행내용
    when 조건식 then 실행내용
    else 실행내용
end
*/
SELECT  employee_id,
        salary,
        job_id,
        case when job_id = 'AC_ACCOUNT' then salary * 0.1
            when job_id = 'SA_REP' then salary * 0.2
            when job_id = 'ST_CLERK' then salary * 0.3
            else salary * 0
        end bonus
FROM employees;

--decode 문 : case - end 다른 표현 > decode(컬럼멍, 조건식, 실행내용, 조건식, 실행내용..., else실행내용)
SELECT  employee_id,
        salary,
        decode(job_id, 'AC_ACCOUNT', salary + salary * 0.1,
                    'SA_REP', salary + salary * 0.2,
                    'ST_CLERK', salary + salary * 0.3,
                salary *0 ) bonus
FROM employees;

--차이점 : case는 부등호 등 다른 조건식도 쓸 수 있는데 decode는 =만 돼서 switch문에 더 가까움.

SELECT  first_name,
        department_id,
        case when department_id >= 10 and department_id <= 50 then 'A-TEAM' --,없음 주의
            when department_id >= 60 and department_id <= 100 then 'B-TEAM'
            when department_id >= 110 and department_id <= 150 then 'C-TEAM'
            else '팀없음'
        end "팀"
FROM employees;