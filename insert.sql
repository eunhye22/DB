
-- 단일 행 INSERT문

-- INSERT문 연습을 위해 일부 행 삭제 진행
DELETE FROM dept
WHERE
    deptno IN (50, 60, 70, 80);

-- 조회
SELECT *
FROM dept
ORDER BY deptno;


-- 하나의 트랜젝션에 여러개의 DML 문장이 들어있을 때 BEGIN - END문 사용
BEGIN        -- To begin a transaction

    -- 컬럼명을 명시한 INSERT문
    INSERT INTO dept (deptno,dname,loc)
    VALUES (50, '개발', '서울');

    -- 컬럼명을 생략한 INSERT문
    -- 반드시, 해당 컬럼의 스키마에 있는 컬럼의 순서대로 "전부" 준비해야함.
    INSERT INTO dept
    VALUES (60, '인사', '경기');

    -- 묵시적으로 널(null) 값 저장
    -- 1) 묵시적 방법(Implicitly)
    INSERT INTO dept (deptno,dname) 
    VALUES ( 70, '인사');

    -- 명시적으로 널(null) 값 저장
    --2) 명시적 방법(Explicitly)
    INSERT INTO dept (deptno, dname, loc)
    VALUES (80, '인사', NULL);

    -- ROLLBACK;
    COMMIT;
END;        -- To end a transaction



-- (주의) INSERT 문장 수행시, 오류 발생 예

-- 1)   
-- INSERT INTO dept (deptno,dname,loc)
-- VALUES (11, '인사');

-- 2)
-- INSERT INTO dept
-- VALUES (12, '인사');

-- 3) 
-- INSERT INTO dept (deptno, dname, loc)
-- VALUES ('개발', 13, '인사');

-- 4) VALUES 절의 컬럼값 지정시, 반드시 리터럴 형식에 맞게 설정해야함
-- 리터럴 규칙 : 반드시 ''로 묶어야함 (누락시, 식별자로 인식) / 숫자 리터럴은 '' 없이 사용
-- INSERT INTO dept (deptno,dnam,loc)
-- VALUES ('개발', 14, 인사);


-- 복수 행 INSERT문

-- 1) 기존 테이블을 이용하여 새로운 테이블 생성 (CTAS)
-- CTAS : 기존 테이블 스키마 복사 시 NOT NULL 제약조건을 제외한 그 외 제약조건은 복사되지 않음

-- DROP TABLE mydept;

CREATE TABLE mydept
AS 
SELECT * FROM dept
WHERE 1 = 2;        -- 기존 테이블의 스키마만 복사(데이터 제외)

DESC mypt;


-- 복수 행 INSERT문 수행

INSERT INTO mydept
SELECT
    deptno,
    dname,
    loc
FROM   
    mydept;


SELECT *
FROM mydept;


