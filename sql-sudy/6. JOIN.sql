
-- < JOIN 기초>

--부서 이름은 tb_emp 테이블에 없음. 부서 이름도 나오게 하고싶음. tb_dept 테이블에는 있음.
SELECT
    emp_no, emp_nm, addr, dept_cd
FROM tb_emp
;

SELECT
    dept_cd, dept_nm
FROM tb_dept;


-- 두 SELECT문을 합치고 싶음.

SELECT
    E.emp_no, E.emp_nm, E.addr, E.dept_cd, D.dept_nm  -- dept_cd 가 두 테이블 모두에 있어서 하나 지정해줘야함.
FROM tb_emp E, tb_dept D -- 보기 쉽게 별칭으로 해줌.
WHERE E.dept_cd = D.dept_cd
;

-- [조인 기초 테스트 데이터]

CREATE TABLE TEST_A (
    id NUMBER(10) PRIMARY KEY
    , content VARCHAR2(200)
);
CREATE TABLE TEST_B (
    b_id NUMBER(10) PRIMARY KEY
    , reply VARCHAR2(100)
    , a_id NUMBER(10)
);

INSERT INTO TEST_A  VALUES (1, 'aaa');
INSERT INTO TEST_A  VALUES (2, 'bbb');
INSERT INTO TEST_A  VALUES (3, 'ccc');

INSERT INTO TEST_B  VALUES (1, 'ㄱㄱㄱ', 1);
INSERT INTO TEST_B  VALUES (2, 'ㄴㄴㄴ', 1);
INSERT INTO TEST_B  VALUES (3, 'ㄷㄷㄷ', 2);
INSERT INTO TEST_B  VALUES (4, 'ㄹㄹㄹ', 3);
COMMIT;


SELECT * FROM TEST_A;
SELECT * FROM TEST_B;

--
SELECT
    id, content, reply
FROM test_a, test_b
WHERE test_a.id = test_b.a_id --2) 그래서 이렇게 맞는것만 나오게 매칭해줘야함. => '조인 조건'
;
-- 1)조인을 하면 총 12행. A 1행당 B 4행을 모두 조회. 

--------------------------------------------------------------

--자격증 관련 테이블

SELECT * FROM tb_emp_certi;

SELECT * FROM tb_certi;



SELECT
    A.emp_no, A.certi_cd, B.certi_nm, A. acqu_de
FROM tb_emp_certi A, tb_certi B
WHERE A.certi_cd = B.certi_cd
;

-- 3개 테이블 조인

SELECT
    A.emp_no, C.emp_nm, A.certi_cd, B.certi_nm, A. acqu_de
FROM tb_emp_certi A, tb_certi B, tb_emp C
WHERE A.certi_cd = B.certi_cd
    AND A.emp_no = C.emp_no
;


-- 4개 테이블 조인

SELECT
    A.emp_no, C.emp_nm, C.dept_cd, D.dept_nm, A.certi_cd, B.certi_nm, A. acqu_de
FROM tb_emp_certi A, tb_certi B, tb_emp C, tb_dept D
WHERE A.certi_cd = B.certi_cd
    AND A.emp_no = C.emp_no
    AND C.dept_cd = D.dept_cd
;


--부서별 자격증 수
SELECT
    C.dept_cd, COUNT(*)
FROM tb_emp_certi A, tb_certi B, tb_emp C, tb_dept D
WHERE A.certi_cd = B.certi_cd
    AND A.emp_no = C.emp_no
    AND C.dept_cd = D.dept_cd
GROUP BY C.dept_cd
;


----------------
-- 3테이블 조인 + 2019년에 정보만 제한 조회 + 이 씨들만 보고싶음
SELECT
    A.emp_no, C.emp_nm, A.certi_cd, B.certi_nm, A. acqu_de
FROM tb_emp_certi A, tb_certi B, tb_emp C
WHERE A.certi_cd = B.certi_cd
    AND A.emp_no = C.emp_no
    AND A.acqu_de BETWEEN '20190101' AND '20191231'
    AND C.emp_nm LIKE '이%'
ORDER BY A.acqu_de
;

------------------------------------------------------------------------

-- # INNER JOIN
-- 1. 2개 이상의 테이블이 공통된 컬럼에 의해 논리적으로 결합되는 조인기법입니다.
-- 2. WHERE절에 사용된 컬럼들이 동등연산자(=)에 의해 조인됩니다.

SELECT 
    E.emp_no, E.emp_nm, E.addr, E.dept_cd, D.dept_nm
FROM tb_emp E, tb_dept D
WHERE E.dept_cd = D.dept_cd
    AND addr LIKE '%용인%'
ORDER BY E.emp_no
;

SELECT 
    *                                        -- DEPT_CD 2번 나옴. emp랑 dept꺼
FROM tb_emp E, tb_dept D
WHERE E.dept_cd = D.dept_cd
    AND addr LIKE '%용인%'
ORDER BY E.emp_no
;

-- # NATURAL JOIN
-- 1. NATURAL JOIN은 동일한 이름을 갖는 컬럼들에 대해 자동 조인하는 기법입니다.
-- 2. 즉, 자동으로 2개 이상의 테이블에서 같은 이름을 가진 컬럼을 찾아 INNER조인을 수행합니다.
-- 3. 이 때 조인되는 동일 이름의 컬럼은 데이터 타입이 같아야 하며, ALIAS나 테이블명을 붙일 수 없습니다.
-- 4. SELECT * 문법을 사용하면, 공통 컬럼으로 자동 조인하며 결과집합에서 한번만 표기됩니다.

SELECT
    A.emp_no, A.emp_nm, dept_cd, B.dept_nm  -- dept_cd가 겹침. -> A. 또는 B. 이라고 안써줘야함. 어디꺼인지. 지가 알아서 함 + WHERE 조인 조건도 필요X
FROM tb_emp A NATURAL JOIN tb_dept B                 --> , 대신 NATURAL JOIN이라고 씀.
;

SELECT
    *
FROM tb_emp A NATURAL JOIN tb_dept B
;

-- # USING절 조인
-- 1. NATURAL조인에서는 자동으로 이름이 일치하는 모든 컬럼에 대해 조인이
--    일어나지만 USING을 사용하면 원하는 컬럼에 대해서만 선택적으로 조인이 가능합니다.
-- 2. USING절에서도 조인 컬럼에 대해 ALIAS나 테이블명을 붙일 수 없습니다.


SELECT
    A.emp_no, A.emp_nm, dept_cd, B.dept_nm   -- dept_cd 앞에 어디꺼인지 안적어놔야함. (네츄럴 조인처럼)
FROM tb_emp A JOIN tb_dept B             -- JOIN 기본값 INNER JOIN. INNER생략 가능.
USING (dept_cd)
;


-- # JOIN ON절
-- 1. 조인 조건 서술부(ON절)와 일반 조건 서술부(WHERE절)를 분리해서 작성하는 방법입니다.
-- 2. ON절을 사용하면 JOIN이후에 논리 연산이나 서브쿼리와 같은 추가 서술을 할 수 있습니다.


--4개 테이블 조인한거.
SELECT
    A.emp_no, C.emp_nm, C.dept_cd, D.dept_nm, A.certi_cd, B.certi_nm, A. acqu_de
FROM tb_emp_certi A, tb_certi B, tb_emp C, tb_dept D
WHERE A.certi_cd = B.certi_cd
    AND A.emp_no = C.emp_no
    AND C.dept_cd = D.dept_cd
    AND C.birth_de BETWEEN '19800101' AND '19891231'
;
--N개의 조건을 조인하면, 조인 조건은 N-1개이다.


SELECT 
    E.emp_no, E.emp_nm, E.addr, E.dept_cd, D.dept_nm
FROM tb_emp E 
INNER JOIN tb_dept D
ON E.dept_cd = D.dept_cd
WHERE addr LIKE '%용인%'
ORDER BY E.emp_no
;

-- * SELECT절 기본 순서

--SELECT [DISTINCT] { 열이름 .... } 
-- FROM  테이블 또는 뷰 이름
-- JOIN  테이블 또는 뷰 이름
-- ON    조인 조건
-- WHERE 조회 조건
-- GROUP BY  열을 그룹화
-- HAVING    그룹화 조건      (GROUP BY랑 HAVING은 바뀌어도됨.)
-- ORDER BY  정렬할 열 [ASC | DESC];

SELECT
    A.emp_no, C.emp_nm, C.dept_cd, D.dept_nm, A.certi_cd, B.certi_nm, A. acqu_de
FROM tb_emp_certi A 
JOIN tb_certi B 
ON A.certi_cd = B.certi_cd
JOIN tb_emp C 
ON A.emp_no = C.emp_no
JOIN tb_dept D
ON C.dept_cd = D.dept_cd
WHERE C.birth_de BETWEEN '19800101' AND '19891231'
;























