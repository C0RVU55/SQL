/*
inner join --> 양쪽 다 만족, 결과에 null제외
inner join - on (,랑 where절로 썼던 거)
(null 안 나오니까 0이나 음수 넣어서 구분하기도 함.)

outer join --> 기준이 되는 쪽 다 포함
left outer join - on
right outer join - on
full outer join - on

select문은 테이블을 불러와도 다 가상의 테이블 만들어서 하는 거라
진짜 데이터에 영향 안 줌.
*/

/*
*** SubQuery ***
*/

--den보다 급여를 많은 사람의 급여는?
--급여 10000이상이면 그냥 where절 쓰면 되는데 조건이 위와 같다면? 매번 den의 월급이 바뀐다면?
--> where절에 질문(den의 급여는?)을 조건으로 넣으면 됨.

--정렬은 되도록 쓰지 않음.

/*****
단일행(괄호 안 값이 1줄짜리) :  => <= 이런 거 쓰고 주의할 점 <> 같지 않다
*****/
SELECT  employee_id,
        first_name,
        salary
FROM employees
where salary > (SELECT  salary --***조건에 걸려고 하는 컬럼만 넣어야 됨***
                FROM employees
                where first_name = 'Den'); --'den의 급여는?' 이 질문(쿼리)를 괄호 쳐서 다른 쿼리에 넣으면 됨.
                
--급여를 가장 적게 받는 사람의 이름 급여 사번
--질문을 나눈 후 조합 : 1.가장 적은 급여 액수 2100 / 2.2100받는 직원 이름 급여 사번
SELECT  first_name,
        salary,
        employee_id
FROM employees
where salary = (select min(salary)
                from employees);
                
--평균급여보다 적게받는 사람의 이름, 급여
--1.평균 급여 2. 사람 < 평균 급여
SELECT  first_name,
        salary
FROM employees
where salary < (SELECT  avg(salary) 
                FROM employees);

/*****                
다중행 연산자(괄호 안 값이 여러 개, 리스트) : any, all, in...
*****/
--1.부서번호가 110인 직원 이름, 급여 2.이 직원들과 급여가 같은 직원의 사번, 이름, 급여
--where절이 salary = 12008 or salary = 8300이랑 in (12008, 8300)랑 같은 상황
SELECT  employee_id,
        first_name,
        salary
FROM employees
where salary in (SELECT salary
                FROM employees
                where department_id = 110);
                
--부서별로 최고 급여 받는 사원 출력
--1.최고 급여, 부서 별로 2.그게 누구?
SELECT  department_id,
        employee_id,
        first_name,
        salary
FROM employees
where (department_id, salary) in (SELECT department_id,
                                         max(salary)
                                 FROM employees
                                 group by department_id);
 --조건 대상이 여러 개면 이렇게 쓸 수 있음. in 양옆의 컬럼명 모양이 같아야 됨.
 --부서번호와 최대급여 리스트를 가지고 있어야 한다는 생각을 하고 시작해야 됨.
 
 --부서번호 110인 직원 급여보다 큰 모든 직원의 사번, 이름, 급여 (or연산 --> 8300보다 큰)
 SELECT employee_id,
        first_name,
        salary
 FROM employees
 where salary >any ( SELECT salary --where salary > 12008 or salary > 8300 이랑 같음
                 FROM employees
                 where department_id = 110);
                 
/*****
테이블에서 join
*****/
--각 부서별로 최고급여 받는 사원 출력
--가상테이블 직원테이블과 부서별 급여 테이블을 뽑고 급여 테이블을 조인시키는데 부서번호와 급여 같은 것만 출력
SELECT  e.department_id,
        e.employee_id,
        e.first_name,
        e.salary
FROM employees e, (SELECT department_id, --서브쿼리로 가상의 테이블(각 부서별 최고급여 테이블)을 만들어서 넣음 --> join으로 사용
                          max(salary) salary --컬럼명을 바꿔서 'salary'로 인식하게 함.
                    FROM employees
                    group by department_id) s
where e.department_id = s.department_id
and e.salary = s.salary; --컬럼명 여기서 쓸 거라서