/*
*** JOIN ***
*/

SELECT
    *
FROM employees, departments; --,로 여러 테이블에 접근
/*
데이터 수가 엄청 늘어나 있음.
employees을 기준으로 1줄을 departments 전체줄에 일일이 매칭시켜서 1*27이 반복되기 때문.
모든 경우의 수를 만들어 주는 거라(cartesian product) where로 걸러 줘야함.
기준 테이블의 참조키를 2번째 테이블의 primary key와 매칭시킴.
*/

--equl join (결과에 null 제외돼서 null 없거나 null 상관없으면 이걸로 많이 씀)
SELECT  e.first_name,
        department_name, --한 테이블에만 있는 거라 안 헷갈려서 오류 안 남
        e.department_id --"column ambiguously defined" 해당 컬럼이 두 테이블에 다 있어서 어느 컬럼을 출력할지 모르는 거 --> e.depart- 또는 d.depart-로 정해야 함
FROM employees e, departments d --별명 붙이는 건데 as 안 씀. 조건절이 길어지기 때문에 테이블별명은 최대한 짧게 씀.
where e.department_id = d.department_id; --두 테이블의 같은 컬럼으로 조건 걸고 결과값에서 null은 제외됨

--모든 직원 이름, 부서명, 업무명
SELECT  first_name,
        department_name,
        job_title
FROM employees e, departments d, jobs j
where e.department_id = d.department_id 
and e.job_id = j.job_id; --**테이블들 안에서 중복되는 컬럼끼리** =로 묶어서 이 조건 아닌 값은 버림

--null을 고려해야할 경우 사용할 수 있는 join
/*
outer join - on : 
left outer join(왼쪽을 기준으로 출력) 
right outer join(오른쪽을 기준으로 출력) 
full outer join(양쪽 다 출력)
*/
--기준 테이블에서 특정 컬럼 데이터가 null이면 다 null로 나옴
SELECT  e.department_id,
        e.first_name,
        d.department_name
FROM employees e left outer join departments d
on e.department_id = d.department_id; --where절까지 한번에 쓴 거

/*
부서테이블을 기준으로 직원테이블을 보니 부서아이디 데이터중 11개만 직원테이블에 사용되고 있음 
--> 나머지 16개 부서아이디는 직원테이블에서 매칭되는 거 없어서 null로 출력됨
또 부서번호가 null인 kimberley는 직원테이블 기준일 때는 출력되는데
부서테이블이 기준일 경우 부서테이블에 부서번호 null인 데이터가 없어서 조건에서 걸려서 버려짐
*/
SELECT  e.department_id,
        first_name,
        d.department_name
FROM employees e right outer join departments d --오른쪽이 어색하면 테이블 위치 바꿔서 left outer join해도 똑같음
on e.department_id = d.department_id
order by e.department_id asc;

--다른 표기법(오라클 전용) : 위와 같은 표현인데 null이 나올 테이블 쪽에 (+) 붙임. 데이터 다 포함하라는 의미로.
--헷갈리는데 기준 아닌 테이블에 (+) 붙임. left면 오른쪽에 +, right면 왼쪽에 + (양쪽은 안 됨)
SELECT  first_name,
        e.department_id,
        d.department_name
FROM employees e, departments d
where e.department_id(+) = d.department_id; 

--full outer join : null도 다 나옴
SELECT  e.department_id,
        e.first_name,
        d.department_id
FROM employees e full outer join departments d
on e.department_id = d.department_id;

--alias(대체컬럼명, 별명)
SELECT  e.department_id, --별명 대신 원래 테이블명 쓰면 오류남. 무조건 별명 써야 됨.
        e.first_name,
        d.department_name,
        d.department_id
FROM employees e, departments d
where e.department_id = d.department_id;

/*
self join
컬럼명이 같은데 연관관계가 아닌 경우도 있음. 
여기선 매니저아이디가 직원아이디를 자신참조해서 직원아이디랑 같음. 
그래서 부서테이블의 매니저아이디가 직원아이디랑 연관 있는 거.
*/
SELECT  emp.employee_id,
        emp.first_name,
        emp.manager_id,
        man.first_name manager
FROM employees emp, employees man --emp의 manager_id가 fk, man의 employee_id가 pk
where emp.manager_id = man.employee_id; --매니저아이디가 직원아이디 참조한 거라 가상의 man테이블의 직원아이디와 같은 매니저아이디를 찾는 게 조건

--잘못된 사용 예 : 오류는 안 나지만 join되지 않은 테이블끼리 join시켜서 잘못된 예. 데이터가 비슷하게 생기긴 했지만 상관없는 컬럼명끼리 묶인 상태.
SELECT
    *
FROM employees em, locations lo
where em.salary = lo.location_id;