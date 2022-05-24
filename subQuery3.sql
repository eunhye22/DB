-- **다중컬럼 Sub-query**


-- 부서별로, 가장 많은 월급을 받는 사원정보 조회
SELECT
    last_name,
    department_id,
    salary
FROM
    employees
WHERE
    (department_id, salary) IN (
        -- 복수행 비상관 서브쿼리 : 각 부서별, 최대 월급여 반환
        -- 메인쿼리로 결과값 전달
        SELECT department_id, max(salary)
        FROM employees
        GROUP BY department_id -- NULL 그룹도 포함
    )
ORDER BY 2;


-- **인라인 뷰(Inline View)**
    -- FROM절에서 sub-query 수행
    -- alias 사용해야함. (AS는 xx)

SELECT
    e.department_id,
    sum(salary) AS 총합,
    round(avg(salary),2) AS 평균,
    count(*) AS 인원수
FROM
    --CROSS JOIN(== Cartesian Product) Size : 107 x 27 = 2,889
    employees e,
    departments d
WHERE
    e.department_id = d.department_id
GROUP BY
    e.department_id
ORDER BY 1;

-- 위 조인 쿼리를, 좀 더 효율적으로 수행가능한 형식으로 변경
-- 인라인 뷰 크기 : 12
SELECT
    e.department_id,
    d.department_name,
    총합,
    평균,
    인원수
FROM
    (SELECT
        department_id,
        sum(salary) AS 총합,
        avg(salary) AS 평균,
        count(*) AS 인원수
    FROM
        employees
    GROUP BY
        department_id
    ) e,
    departments d
WHERE
    e.department_id = d.department_id
ORDER BY 1;




SELECT
    department_id,
    (   SELECT department_name  
        FROM departments d
        WHERE e.department_id = d.department_id
        ) AS 부서명,
    sum(salary) AS 총합,
    avg(salary) AS 평균,
    count(*) AS 인원수 
FROM
    employees e
GROUP BY
    department_id
ORDER BY 1;

