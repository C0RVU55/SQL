--이거는 테스트만 해보는 툴이라 따로 저장을 자주 하진 않음.

/*
*** select 문 ***
*/
SELECT * from employees;
SELECT * from departments;

--원하는 컬럼 조회하기 : select 컬럼명(,로 구분) from 테이블명
select employee_id, 
         first_name, 
         last_name 
from employees;

--사원 이름(first_name)과 전화번호, 입사일, 연봉 출력
--먼저 테이블이 무슨 뜻인지 테이블 명세서를 보면서 내용을 파악해야 됨.
SELECT first_name,
            phone_number,
            hire_date,
            salary
FROM employees;

/*
컬럼명 대신 별명 쓰기 : 원본이 바뀌진 않고 표기만 이렇게 됨 (as 생략가능)
"" 표기 : 대소문자, 공백, 특수문자 (한글은 ""로 쓰는 게 안전함)
--이름 전화번호 입사일 급여 > 컬럼 내가 정한 순서대로 출력됨
*/
--오류 찾기 : 테이블명 맞나 확인 > 칼럼명 확인 > 기본 문법 확인
--테이블 순서는 임시저장된 상태이기 때문에 order절 없으면 계속 바뀜. 데이터의 수말고는 그냥 보여주기만 하는 거. 
select employee_id as "사원번호",
        last_name as "성",
        first_name as "이름",
        salary as "급여",
        phone_number 전화번호,
        email "이메일",
        hire_date "입사일"
from employees;

select first_name "이름",
        phone_number "전화번호",
        hire_date "입사일",
        salary "급여"
from employees;

/*
*** 연산자 ***
*/

--연결 연산자 : || 이고 ''로 문자열 추가 가능
select first_name || ' ' || last_name as name
from employees;

--큰따옴표는 작은따옴표 안에 넣으면 되는데 작은따옴표는 2개 넣어야 됨 > ' ''내용'' ' 
SELECT first_name || ' hire date is ' || hire_date
FROM employees;

--산술 연산자 : + - * /
SELECT first_name,
            salary as "급여",
            salary * 12 as "연봉",
            (salary+300)*12 as "상여금"
FROM employees;

/*
문자열에 숫자로 계산 불가능
SELECT job_id*12
FROM employees;
*/

--예제
SELECT first_name || '-' || last_name "성명",
            salary "급여",
            salary*12 "연봉",
            salary*12+5000 "연봉2",
            phone_number "전화번호"
FROM employees;

--select from 절 처리 방법 : 테이블 > 1row 읽음 > select절에 맞는 부분만 projection(화면에 보여줌) > 테이블의 모든 절 훑을 때까지 반복

/* 
select문 > where절(=, !=, <, >, <=, >=)
절마다 where 조건 맞나 비교하는데 1절 전부 임시저장해서 비교하는 거. 안 맞는 절은 버리고 다음 절로 넘어감.
*/

SELECT first_name
FROM employees
where department_id = 10; 

--월급 15000이상인 사원의 이름, 월급 출력
SELECT salary,
            first_name
FROM employees
where salary>=15000;

--07/01/01 이후 입사한 사원 이름, 입사일 출력
SELECT hire_date,
            first_name
FROM employees
where hire_date>='07/01/01'; --날짜 표기 07-01-01 07:01:01 07.01.01 다 됨
 
--Lex인 사원 월급 출력
SELECT salary
FROM employees
where first_name = 'Lex'; --select에서 first_name 빼면 이름 빼고 salary만 출력됨. select에서는 뭘 출력할지를 정하는 거.