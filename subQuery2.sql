SELECT 
    last_name,
    salary
FROM
    employees
WHERE
    salary IN (

        SELECT salary
        FROM employees
        WHERE last_name In('Whalen', 'Fay')
--      6000 또는 4400

);

-- 직책이 IT_PROG인 사원 월급 조회
SELECT
    last_name,
    salary
FROM
    employees
WHERE
    job_id = 'IT_PROG'
ORDER BY
    2 ASC;



-- ALL
-- 1) 직책이 IT_PROG인 사원의 월급보다 *작은* 사원 정보 조회
-- < ALL ()
SELECT
    last_name,
    department_id,
    salary
FROM
    employees
WHERE
    salary < ALL (
        -- 서브쿼리의 결과값이 몇개이든간에, 그 결과값보다 더 작은 salary를 가져야함.
        -- 즉, 서브쿼리 결과값 중 최솟값보다, 더 작은 값을 가져야함.
        SELECT salary
        FROM employees
        WHERE job_id = 'IT_PROG'
    );

-- 2) 직책이 IT_PROG인 사원의 월급보다 *많은* 사원 정보 조회
-- > ALL ()
SELECT
    last_name,
    department_id,
    salary
FROM
    employees
WHERE
    salary > ALL (
        -- 서브쿼리 결과값 중 최댓값보다, 더 큰 값을 가져야함.
        SELECT salary
        FROM employees
        WHERE job_id = 'IT_PROG'
    );


--ANY
-- 1) 직책이 IT_PROG인 사원의 *최소 월급여보다 많은* 사원 정보 조회
-- > ANY ()
SELECT
    last_name,
    department_id,
    salary
FROM
    employees
WHERE
    salary > ANY (
        SELECT salary
        FROM employees
        WHERE job_id = 'IT_PROG'
    );



-- 2) 직책이 IT_PROG인 사원의 *최대 월급여보다 적은* 사원 정보 조회
-- < ANY()
SELECT
    last_name,
    department_id,
    salary
FROM
    employees
WHERE
    salary < ANY (
        SELECT salary
        FROM employees
        WHERE job_id = 'IT_PROG'
    );


-- EXISTS
-- 1) 모든 사원조회 (if 커밋션을 받는 사원이 한명이라도 있다면)
SELECT
    last_name,
    department_id,
    salary,
    commission_pct
FROM
    employees
WHERE
    EXISTS (
        SELECT employee_id
        FROM employees
        WHERE commission_pct IS NOT NULL
    );

-- EXISTS
-- 2) 모든 사원조회 (if 500000보다 큰 월급여를 받는 사원이 한명이라도 있다면)
SELECT
    last_name,
    department_id,
    salary
FROM
    employees
WHERE
    EXISTS (
        -- 메인쿼리로 결과값 전달(하나도 조회된 결과가 없으므로, false가 전달)
        SELECT 1
        FROM employees
        WHERE salary > 500000
    );



