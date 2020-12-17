/*
*** 단일행 함수 ***
각각 데이터를 1건씩 처리
*/

--문자함수 INITCAP(컬럼명) : 첫 글자만 대문자 출력. 괄호 안에 ''로 원하는 문자열 넣으면 첫 글자 대문자인 해당 문자열 들어감.
SELECT  email,
        initcap(email),
        department_id
FROM employees
where department_id = 100;

--문자함수 LOWER(컬럼명) UPPER(컬럼명)
SELECT  first_name,
        lower(first_name),
        upper(first_name)
FROM employees
where department_id = 100;

--문자함수 SUBSTR(컬럼명, 시작위치, 글자수) : 원하는 문자만 추출. '시작위치'포함 '글자수'만큼 자름 (1부터 시작)
SELECT  first_name,
        substr(first_name, 3 --시작위치부터 끝까지
        substr(first_name, -3, 2) --음수는 뒤부터 셈
FROM employees
where department_id = 100;

--문자함수 LPAD(컬럼명, 자리수, '채울문자') RPAD(컬럼명, 자리수, '채울문자') : 각각 왼쪽, 오른쪽 공백에 특별한 문자로 채움
SELECT  first_name,
        lpad(first_name, 10, '*'), --총 10자리를 만드는데 공백은 *로 채움. 10자리 넘어가면 잘림.
        rpad(first_name, 10, '*')
FROM employees
where department_id = 100;

--문자함수 REPLACE(컬럼명, 문자1, 문자2) : 문자1을 문자2로 바꿈
SELECT  first_name,
        replace(first_name, 'a', '*') --문자1에 asdf 이런 거 넣으면 없어서 아무 변화 없음
FROM employees
where department_id = 100;

--문자함수 LTRIM(컬럼명, 제거할문자열) RTRIM(컬럼명, 제거할문자열) : 왼쪽, 오른쪽부터 지정문자열 제거
SELECT  first_name,
        ltrim(first_name, 'J')
FROM employees
where department_id = 100;

--함수 조합 예제
SELECT  first_name,
        substr(first_name, 2, 4),
        replace(first_name, substr(first_name, 2, 4), '****') --글자수 4글자니까 바꿀 글자도 숫자 맞게 넣어야 됨
FROM employees
where department_id = 100;

-------------------------------------------------

--숫자함수 ROUND(숫자, 출력 원하는 자리수) : 주어진 숫자의 반올림함. 소수점 '원하는 자리수'만큼 출력하는데 뒤에서 반올림.
SELECT  round(123.345, 2) "r2",
        round(123.456, 0) "r0", --0은 소수점 없음
        round(123.568, -1) --소수점 위로 올라감. 이름 따로 안 지으면 여기 써 있는 거 그대로 출력.
FROM dual; --테스트를 위한 가상 테이블. 아무 값도 없음.

SELECT  salary,
        round(salary, -3)
FROM employees;

--숫자함수 TRUNC(숫자, 출력 원하는 자리수) : 원하는 자리수만 남기고 버림.
SELECT  trunc(123.456, 2) "r2",
        trunc(123.456, 0) "r0",
        trunc(123.456, -2) "r-2"
FROM dual;

-------------------------------------------------

--날짜함수 SYSDATE : 현재 날짜와 시간 출력. 괄호 없음.
SELECT  sysdate
FROM dual;

--날짜함수 MONTH_BETWEEN(d1, d2) : d1와 d2 사이 개월수 출력
SELECT  sysdate,
        hire_date,
        months_between(sysdate, hire_date) "workMonth",
        trunc(months_between(sysdate, hire_date), 0) "workMonth" --개월수를 소수점까지 계산해서 trunc 조합함.
FROM employees
where department_id = 100;

--날짜함수 LAST_DAY(d1) : 해당 달의 마지막 날 출력
SELECT  last_day('20/02/06'),
        last_day(sysdate) --실행한 날짜로 바뀔 것
FROM dual;

-------------------------------------------------

/*
변환함수
TO_CHAR(n, fmt)-->     <--TO_CHAR(d,fmt)
숫자      문자열      date
TO_NUMBER(s,fmt)<--        -->TO_DATE(s,fmt)
*/
--숫자형-->문자형 : TO_CHAR(숫자, '출력모양')
SELECT  first_name,
        salary,
        TO_CHAR(salary*12, '$999,999.00'), --출력모양의 범위 넘어가면 안 되고 9로 정해져 있음.
        TO_CHAR(salary*12, '999,999.00'),
        TO_CHAR(salary*12, '999,999'),
        TO_CHAR(salary*12, '099,999')
FROM employees
where department_id = 100;

--to_char(날짜, 출력모양)
--날짜는 테이블에 보이는 것과 달리 내부로직에 의해 계산돼서 출력됨. 날짜 숫자가 저장돼 있는 게 아님.
SELECT  sysdate,
        to_char(sysdate, 'YYYY') YYYY,
        to_char(sysdate, 'YY') YY,
        to_char(sysdate, 'MM') MM,
        to_char(sysdate, 'DD') DD,
        to_char(sysdate, 'DAY') DAY,
        to_char(sysdate, 'HH') HH,
        to_char(sysdate, 'HH24') HH,--시간 다른 표기방식
        to_char(sysdate, 'MI') MI, --월이랑 겹치니까 MI
        to_char(sysdate, 'SS') SS,
        to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
FROM dual;

--년월일 시분초
SELECT  sysdate,
        to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS'),
        to_char(sysdate, 'YYYY"년" MM"월"DD"일"'),
        to_char(sysdate, 'YYYY/MM/DD')
FROM dual;

-------------------------------------------------

--일반함수 NVL(컬럼명, null일때치환할값) NVL2(컬럼명, null아닐때값, null일때값)
SELECT  first_name,
        commission_pct,
        nvl(commission_pct, 0), --문자 넣으면 자료형 안 맞음
        nvl2(commission_pct, 100, 0)
FROM employees;