DESC mydept;
-- 심플한 DELETE문
BEGIN

    DELETE FROM mydept
    WHERE deptno = 30;

    ROLLBACK;

END;

-- 서브쿼리를 이용한 DELETE문
DESC mydept;

BEGIN       -- To start a transaction.

    DELETE FROM mydept
    WHERE loc = (

        SELECT
            loc
        FROM
            dept
        WHERE
            deptno = 20

    );
    
    -- 다중컬럼 조건식 지정 (Pairwise 방식)
    -- WHERE (loc, dname) = (

    --     SELECT
    --         loc,
    --         dname
    --     FROM
    --         dept
    --     WHERE
    --         deptno = 20

    -- );


    ROLLBACK;

END;        -- To end a transaction.

--
DELETE mydept2;    -- 삭제한 행의 로그(TX로그)를 남기면서 삭제 (DML)

TRUNCATE TABLE mydept2;    -- 복구 불가능하게. TX로그를 남기지 않고 바로 절삭 (DDL)

