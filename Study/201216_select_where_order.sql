/*
*** 조건 where / in ***
*/

--조건이 2개 이상일 때 한번에 조회
SELECT first_name,
            salary
FROM employees
where salary <= 14000
or salary >= 17000; --경계값까지 포함하면 where salary between 14000 and 17000; 로 써도 됨

SELECT first_name,
            hire_date
FROM employees
where hire_date >= '04/01/01'
and hire_date <= '05/12/31';

--여러 조건 검사 : in('조건')
SELECT first_name, 
                last_name,
                salary
FROM employees
where first_name in ('Neena','Lex'); 
/*
''조건인 걸로 한 번 검사하고 다음 ''조건으로 또 한 번 검사
where first_name = 'Neena' or first_name = 'Lex' or first_name = 'John';
풀어쓰면 위와 같음
*/

SELECT first_name,
            last_name,
            salary
FROM employees
where salary in ('2100', '3100', '4100', '5100');

/*
*** Like 연산자로 비슷한 데이터 찾기 ***
*/
-- % : 공백 포함 임의 길이 문자열 / _ : 한 글자 문자
SELECT first_name,
                last_name,
                salary
FROM employees
where first_name like 'L%'; --처음에 L인 거 통과되는 것 중에 select에 있는 거 출력

SELECT first_name,
                last_name,
                salary
FROM employees
where first_name like '_a____%';

--예제
SELECT first_name,
                salary
FROM employees
where first_name like '%am%';

SELECT first_name,
                salary
FROM employees
where first_name like '_a%';

SELECT first_name,
                salary
FROM employees
where first_name like '___a%';

SELECT first_name,
                salary
FROM employees
where first_name like '__a_';

/*
*** NULL ***
아무 값도 정해지지 않아서 모든 데이터타입에 사용 가능
null로 계산하면 결과값 null 나옴(계산 못한다는 뜻)
not null이나 primary key 속성에는 사용할 수 없음
*/

--문제 풀어써보기 : 직원 테이블에서 급여가 13000에서 15000사이인 직원의 이름, 급여, 커미션%, 급여*커미션 출력
SELECT first_name,
            salary,
            commission_pct,
            salary*commission_pct 
FROM employees
where salary between 13000 and 15000;

--null값만 출력하기 / 제외하기 : is null / is not null (commission_pct = null < 이게 아님)
SELECT first_name,
            salary,
            commission_pct,
            salary*commission_pct 
FROM employees
where salary between 13000 and 15000 and
            commission_pct is not null;
            
SELECT first_name,
            salary,
            commission_pct,
            salary*commission_pct 
FROM employees
where commission_pct is not null;

SELECT first_name
FROM employees
where commission_pct is null
            and manager_id is null;

/*
primary key : 중복 안 되고 null 안 됨
테이블에는 반드시 각 절을 구분할 pk가 있어서 이걸로 원하는 데이터 하나만 뽑을 수 있게 해야 됨
*/
SELECT
    *
FROM employees
where employee_id = 110;

/*
*** order by : 정렬 ***
select 문(순서 고정)
    select 절 (해당 데이터 projection은 order절 후 맨 마지막에 실행돼서 select에 없는 칼럼이라도 where, order절은 적용됨)
    from 절
    where 절
    order by 절 (위에 거 다 하고 마지막에 순서 정하는 거. 이 절 적용하기 전엔 데이터들이 임시로 있는 상태라 순서 고정 안 됨.)
*/
SELECT first_name,
            salary
FROM employees
order by salary desc; --내림차

SELECT first_name,
            salary
FROM employees
where salary >= 9000
order by salary asc; --오름차 (기본이라 생략해도 되는데 써주는 게 좋긴 함) / 정렬 조건은 ,로 나열 가능

--예제
--부서번호 오름차순, 부서번호 급여 이름 출력
SELECT department_id,
            salary,
            first_name
FROM employees
order by department_id asc;

--급여 10000이상 직원이름, 급여 출력하는데 급여는 내림차
SELECT first_name,
                salary
FROM employees
where salary >= 10000
order by salary desc;

--부서번호 오름차 정렬하는데 같으면 급여 높은 순으로 부서번호, 급여, 이름 출력
SELECT department_id,
                salary,
                first_name
FROM employees
order by department_id asc, salary desc; --"부서번호가 같으면"은 부서번호 정렬(메인되는 걸 먼저 써야됨)에서 급여 정렬로 넘어갈 때를 의미