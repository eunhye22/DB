-- 문제1
-- 각 사원의 급여에 따른 급여 등급을 보고하려고 한다. 
-- 급여 등급은 Job_Grades 테이블에 표시된다. 해당 테이블의 구조를 살펴본 후 
-- 사원의 이름과 성(Name으로 별칭), 업무, 부서이름, 입사일, 급여, 급여등급을 출력하시오.

SELECT
    (first_name  || ' ' || last_name) AS Name,
    job_id AS 업무,
    department_name AS 부서이름, -- departments 테이블
    hire_date AS 입사일,
    salary AS 급여,
    grade_level AS 급여등급 -- gob_grades 테이블
FROM
    employees e,
    departments d,
    job_grades g
WHERE                                      -- Oracle조인 
    e.department_id = d.department_id(+)   -- e.department_id의 모든값들이 보여지도록 left outer join
    AND e.salary BETWEEN g.lowest_sal AND g.highest_sal --비동등조인

ORDER BY 5;


-- 문제2
-- 사원들의 지역별 근무 현황을 조회하고자 한다. 
-- 도시이름이 영문 ‘O’로 시작하는 지역에 살고 있는 사원의 
-- 사원번호, 이름과 성(Name으로 별칭), 업무, 입사일을 출력하시오 (단, 서브쿼리로 해결할 것!)

-- only 서브쿼리
SELECT
    employee_id AS 사원번호,
    (first_name  || ' ' || last_name) AS Name,
    job_id AS 업무,
    hire_date AS 입사일
FROM
    employees e
WHERE
    e.department_id IN (
        SELECT d.department_id
        FROM departments d
        WHERE d.location_id IN (
            SELECT location_id
            FROM locations 
            WHERE city LIKE 'O%'
        )
    );

-- join + 서브쿼리
SELECT
    employee_id AS 사원번호,
    (first_name  || ' ' || last_name) AS Name,
    job_id AS 업무,
    hire_date AS 입사일
FROM
    employees e,
    departments d
WHERE
    e.department_id = d.department_id(+)
    AND
    d.location_id IN
    (SELECT location_id
     FROM locations 
     WHERE city LIKE 'O%'
    );


-- 문제3 
-- 이번 분기에 60번 IT 부서에서는 신규 프로그램을 개발하고 보급하여 회사에 공헌하였다. 
-- 이에 해당 부서의 사원 급여를 12.3% 인상하기로 하였다. 
-- 60번 IT 부서 사원의 급여를 12.3% 인상하여 정수만(반올림) 표시하는 보고서를 작성하시오. 
-- 보고서는 사원번호, 성과 이름(Name으로 별칭), 급여, 인상된 급여(Increase Salary로 별칭)순으로 출력하시오.


-- 모든 사원 출력
SELECT 
    employee_id AS 사원번호,
    (first_name  || ' ' || last_name) AS Name,
    salary AS 급여,
    round(salary*decode(department_id,60,1.123,1))
    AS "Increase Salary"
FROM 
    employees;

-- 60번 IT 부서 사원들만 출력
SELECT 
    employee_id AS 사원번호,
    (first_name  || ' ' || last_name) AS Name,
    salary AS 급여,
    round((salary*1.123),0)
    AS "Increase Salary"
FROM employees
WHERE
    department_id = 60;
     

