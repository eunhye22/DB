
-- 무조건 INSERT ALL : WHEN절이 생략된 경우

DROP TABLE myemp_hire;

-- 1st. Table creation.
CREATE TABLE myemp_hire AS    
SELECT
    empno,
    ename,
    hiredate,
    sal
FROM
    emp
WHERE
    1 = 2;        -- 기존 테이블의 스키마만 복사(데이터 제외)

DESC myemp_hire;

DROP TABLE myemp_mgr;

-- 2nd. Table creation.
CREATE TABLE myemp_mgr AS      
SELECT
    empno,
    ename,
    mgr
FROM
    emp
WHERE
    1 = 2;        -- 기존 테이블의 스키마만 복사(데이터 제외)


DESC myemp_mgr;

-- 무조건 INSERT ALL 문장 수행
INSERT ALL 
    INTO myemp_hire VALUES (empno,ename,hiredate,sal)
    INTO myemp_mgr VALUES (empno,ename,mgr)

    SELECT
        empno,
        ename,
        hiredate,
        sal,
        mgr
    FROM
        emp;

-- 잘 복사됐는지 확인
SELECT * FROM myemp_hire;
SELECT * FROM myemp_mgr;


-- 조건 INSERT ALL : WHEN절의 조건식이 참일 경우에만 INSERT 수행
-- 여러 WHEN절이 중복되어 참인 경우에는 각 테이블에 해당행 모두 INSERT됨

-- 1st. Table creation.
CREATE TABLE myemp_hire2 AS    
SELECT
    empno,
    ename,
    hiredate,
    sal
FROM
    emp
WHERE
    1 = 2;        -- 기존 테이블의 스키마만 복사(데이터 제외)

DESC myemp_hire2;

DROP TABLE myemp_mgr2;


CREATE TABLE myemp_mgr2 AS    -- 2nd. Table creation.
SELECT
    empno,
    ename,
    mgr
FROM
    emp
WHERE
    1 = 2;        -- 기존 테이블의 스키마만 복사(데이터 제외)


DESC myemp_mgr2;

--
INSERT ALL
    WHEN sal > 3000 THEN
        INTO myemp_hire2  VALUES (empno, ename, hiredate, sal)

    WHEN mgr = 7698 THEN
        INTO myemp_mgr2   VALUES (empno,ename,mgr)

    SELECT
        empno,
        ename,
        hiredate,
        sal,
        mgr
    FROM
        emp;

-- 확인
SELECT
    *
FROM
    myemp_hire2;


SELECT
    *
FROM
    myemp_mgr2;


--
DROP TABLE myemp_hire3;

-- 조건 INSERT FIRST 문
CREATE TABLE myemp_hire3 AS    -- 1st. Table creation.
SELECT
    empno,
    ename,
    hiredate,
    sal
FROM
    emp
WHERE
    1 = 2;        -- 기존 테이블의 스키마만 복사(데이터 제외)


DESC myemp_hire3;
--

DROP TABLE myemp_mgr3;
--

CREATE TABLE myemp_mgr3 AS     -- 2nd. Table creation.
SELECT
    empno,
    ename,
    mgr
FROM
    emp
WHERE
    1 = 2;        -- 기존 테이블의 스키마만 복사(데이터 제외)


DESC myemp_mgr3;


-- 조건 INSERT *FIRST* 문장 수행
INSERT FIRST
    -- sal = 800 인 사원은, 아래 두 WHEN 절의 조건식을 모두 만족.
    -- 이때, 첫번째 WHEN절에서만 INSERT가 수행되고,
    --      두번째 WHEN절은 설령 조건이 참이어도, INSERT 수행되지 않음.
    WHEN sal = 800 THEN     -- 1st. condition
        INTO myemp_hire3 VALUES (empno, ename, hiredate, sal)

    WHEN sal < 2500 THEN    -- 2nd. condition
        INTO myemp_mgr3  VALUES (empno, ename, mgr)

    SELECT
        empno,
        ename,
        hiredate,
        sal,
        mgr
    FROM
        emp;

-- ------------------------------------------------------

SELECT
    *
FROM
    myemp_hire3;


SELECT
    *
FROM
    myemp_mgr3;
