/*
*** rownum ***
출력되는 일련번호는 출력용이지만 원하는 데이터 추출을 위해 일련번호를 부여할 수 있음
*/

--급여를 가장 많이 받는 직원 5명 이름 출력
SELECT  rownum, --실제로는 없지만 있는 컬럼처럼 사용 가능
        employee_id,
        first_name,
        salary
FROM employees;

--급여 내림차순으로 일련번호를 매기고 싶은데 이렇게 하면 원하는 대로 안 나옴
--rownum은 from에서 1줄씩 읽어올 때 매겨지는데 order by는 출력 직전에 적용돼서 섞임
SELECT  rownum,
        employee_id,
        first_name,
        salary
FROM employees
ORDER BY salary desc;

--정렬하고 rownum 사용 : 이미 테이블이 정렬돼 있다면 from으로 읽어올 때 일련번호가 매겨질 것
--(*은 테스트용이고 실제로 모든 컬럼이 필요하다면 다 치는 게 정확함)
SELECT  rownum,
        o.first_name,
        o.salary
FROM (SELECT em.employee_id, 
             em.first_name, --from에서 불러올 가상테이블에 없는 컬럼은 위 컬럼에 불러올 수 없음(rownum 빼고)
             em.salary
      FROM employees em
      order by salary desc) o;

/*
원하는 번호 출력하기
where절로 조건 달면 rownum매기고 where절로 들어가서 true/false 검사하는데
false 걸리면 일련번호가 다시 1부터 시작하게 됨(rownum은 그때그때 번호를 매김) --> 일련번호를 먼저 매겨놔야 됨
--> 조건대로 정렬된 가상테이블1을 불러와서 일련번호를 매겨서 만든 테이블2을 불러와서 where절 써야 함
*/

/*
여기서 rn말고 rownum을 쓰면 기능 중복으로 번호 새로 매기게 돼서 from에서 가져오는 테이블에서 별명으로 가져옴.
ro.rownum은 오류나는데 ro.rn은 됨. 어쨌든 별명을 써야 됨.
*/
SELECT  rn, 
        ro.first_name,
        ro.salary
FROM (SELECT  rownum rn,
            o.first_name,
            o.salary
      FROM (SELECT em.employee_id, 
                 em.first_name, 
                 em.salary
            FROM employees em
            order by salary desc) o) ro
where rn >= 10 --rownum은 현재 테이블에 없기 때문에 from에서 가져온 별명으로 조건 달아야 됨
and rn <= 20;

--07년 입사한 직원 중 급여가 많은 직원 중 3-7등
--1.급여순 정렬+07입사 2.일련번호 부여 3.3-7등
SELECT  rn,
        h.first_name,
        h.salary,
        h.hire_date
FROM (SELECT  rownum rn,
            r.first_name,
            r.salary,
            r.hire_date
    FROM (SELECT  sa.first_name,
                sa.salary,
                sa.hire_date
        FROM employees sa
        where sa.hire_date >= '07/01/01' 
        and sa.hire_date < '08/01/01'
        order by salary desc) r) h
where rn >= 3
and rn <= 7;
--처음에는 입사조건을 마지막에 넣었는데 일련번호 조건이랑 and로 묶이니까 안 맞아서(07입사는 흩어져 있는데 일련번호는 1부터 매겨지니까) 암것도 출력 안 됨. 
--테이블에 이미 07년 입사 직원들만 준비돼 있어야 됨.