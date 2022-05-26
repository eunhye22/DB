-- MERGE문
-- 스키마(구조)가 같은 두 개의 테이블을 비교하여, 하나의 테이블로 합침


-- (1) 조인 조건이 일치하면(참)

-- MERGE 테이블의 기존 데이터 변경(갱신)

-- (2) 조인 조건이 불일치하면(거짓)



-- *실습용 테이블 및 데이터 생성*
-- pt_01
-- 1월 판매현황 테이블
DROP TABLE pt_01;

CREATE TABLE pt_01 (
    판매번호 VARCHAR2(8),
    제품번호 NUMBER,
    수량 NUMBER,
    금액 NUMBER
); 

DESC pt_01;

-- pt_02
-- 2월 판매현황 테이블
CREATE TABLE pt_02 (
    판매번호 VARCHAR2(8),
    제품번호 NUMBER,
    수량 NUMBER,
    금액 NUMBER
);


-- 최종 병합된 데이터를 저장할 테이블 생성
CREATE TABLE p_total (
    판매번호 VARCHAR2(8),
    제품번호 NUMBER,
    수량 NUMBER,
    금액 NUMBER
);

-- MERGE 문의 전제조건대로, 병합대상 테이블의 스키마는 모두 동일
DESC pt_01;
DESC pt_02;
DESC p_total;

BEGIN 

    -- 1월달 판매현황 테이블 데이터 생성
    INSERT INTO pt_01 VALUES ('20170101', 1000, 10, 500);
    INSERT INTO pt_01 VALUES ('20170102', 1001, 10, 400);
    INSERT INTO pt_01 VALUES ('20170103', 1002, 10, 300);

    -- 2월달 판매현황 테이블 데이터 생성
    INSERT INTO pt_02 VALUES ('20170101', 1003, 5, 500);
    INSERT INTO pt_02 VALUES ('20170102', 1004, 5, 400);
    INSERT INTO pt_02 VALUES ('20170103', 1005, 5, 300);

    COMMIT;

END;


-- ------------------------------------------------------
--  MERGE 문 수행 #1
-- ------------------------------------------------------
TRUNCATE TABLE p_total;

MERGE INTO p_total total    -- MERGE 결과 저장 테이블 지정.

    -- MERGE 대상 테이블 지정(Alias 가능, 이때, **AS 키워드 사용불가**)
    USING pt_01 p01 
    ON (total.판매번호 = p01.판매번호)    -- 동등 조인조건

    -- --------------------------------------
    -- (1) JOIN 조건에 일치하는 행들은....
    -- --------------------------------------
    WHEN MATCHED THEN

        -- MERGE 대상테이블(p01)의 데이터를 이용하여,
        -- MERGE 저장테이블(total)의 데이터 변경(갱신).
        UPDATE SET
            total.제품번호 = p01.제품번호
    
    -- --------------------------------------
    -- (2) JOIN 조건에 일차하지 않는 행들은...
    -- --------------------------------------
    WHEN NOT MATCHED THEN

        -- MERGE 대상테이블(p01)의 데이터를 이용하여,
        -- MERGE 저장테이블(total)의 데이터 신규 생성.
        INSERT
        VALUES (p01.판매번호, p01.제품번호, p01.수량, p01.금액);
        
-- ------------------------------------------------------

SELECT *
FROM p_total;

-- ------------------------------------------------------
-- MERGE 문 수행 #2
-- ------------------------------------------------------
TRUNCATE TABLE p_total;


MERGE INTO p_total total    -- MERGE 결과 저장 테이블 지정.

    -- MERGE 대상 테이블 지정(Alias 가능, 이때, **AS 키워드 사용불가**)
    USING pt_02 p02
    ON ( total.판매번호 = p02.판매번호)    -- 동등 조인조건

    -- --------------------------------------
    -- (1) JOIN 조건에 일치하는 행들은....
    -- --------------------------------------
    WHEN MATCHED THEN

        -- MERGE 대상테이블(p02)의 데이터를 이용하여,
        -- MERGE 저장테이블(total)의 데이터 변경(갱신).
        UPDATE SET 
            total.제품번호 = p02.제품번호

    -- --------------------------------------
    -- (2) JOIN 조건에 일차하지 않는 행들은...
    -- --------------------------------------
    WHEN NOT MATCHED THEN

        -- MERGE 대상테이블(p02)의 데이터를 이용하여,
        -- MERGE 저장테이블(total)의 데이터 신규 생성.
        INSERT
        VALUES ( p02.판매번호, p02.제품번호, p02.수량, p02.금액);
        
-- ------------------------------------------------------


SELECT
    *
FROM
    pt_02;


SELECT
    *
FROM
    p_total;


