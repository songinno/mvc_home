-- OUTER JOIN 실습환경 세팅
INSERT INTO tb_dept VALUES ('100014', '4차산업혁명팀', '999999');
INSERT INTO tb_dept VALUES ('100015', '포스트코로나팀', '999999');
COMMIT;

SELECT * FROM tb_dept;

ALTER TABLE tb_emp DROP CONSTRAINT fk_tb_emp01;

INSERT INTO tb_emp (emp_no, emp_nm, birth_de, sex_cd, addr, tel_no, direct_manager_emp_no, 
                    final_edu_se_cd, sal_trans_bank_cd, sal_trans_accnt_no, dept_cd, lunar_yn)
VALUES ('1000000041', '이순신', '19811201', '1', '경기도 용인시 수지구 죽전1동 435', '010-5656-7878',
        NULL, '006', '003', '114-554-223433', '000000', 'N');

INSERT INTO tb_emp (emp_no, emp_nm, birth_de, sex_cd, addr, tel_no, direct_manager_emp_no, 
                    final_edu_se_cd, sal_trans_bank_cd, sal_trans_accnt_no, dept_cd, lunar_yn)
VALUES ('1000000042', '정약용', '19820402', '1', '경기도 고양시 덕양구 화정동 231', '010-4054-6547',
        NULL, '004', '001', '110-223-553453', '000000', 'Y');

INSERT INTO tb_emp (emp_no, emp_nm, birth_de, sex_cd, addr, tel_no, direct_manager_emp_no, 
                    final_edu_se_cd, sal_trans_bank_cd, sal_trans_accnt_no, dept_cd, lunar_yn)
VALUES ('1000000043', '박지원', '19850611', '1', '경기도 수원시 팔달구 매탄동 553', '010-1254-1116',
        NULL, '004', '001', '100-233-664234', '000000', 'N');
        
INSERT INTO tb_emp (emp_no, emp_nm, birth_de, sex_cd, addr, tel_no, direct_manager_emp_no, 
            final_edu_se_cd, sal_trans_bank_cd, sal_trans_accnt_no, dept_cd, lunar_yn)
VALUES ('1000000044', '장보고', '19870102', '1', '경기도 성남시 분당구 정자동 776', '010-1215-8784',
        NULL, '004', '002', '180-345-556634', '000000', 'Y');
        
INSERT INTO tb_emp (emp_no, emp_nm, birth_de, sex_cd, addr, tel_no, direct_manager_emp_no, 
            final_edu_se_cd, sal_trans_bank_cd, sal_trans_accnt_no, dept_cd, lunar_yn)
VALUES ('1000000045', '김종서', '19880824', '1', '경기도 고양시 일산서구 백석동 474', '010-3687-1245',
        NULL, '004', '002', '325-344-45345', '000000', 'Y');
        
COMMIT;
    
 
SELECT * FROM tb_emp ORDER BY emp_no DESC;
SELECT emp_no, emp_nm, dept_cd FROM tb_emp ORDER BY emp_no DESC;

SELECT * FROM tb_dept;

-- # OUTER JOIN
-- 1. 조인 조건을 만족하지 않는 행들도 조회할 때 사용하는 조인기법입니다.
-- 2. OUTER조인 연산자 기호는 (+)기호입니다.
-- 3. INNER조인은 조인 조건을 만족하지 않으면 해당 행을 조회하지 않습니다
--   그러나 OUTER JOIN은 방향(LEFT, RIGHT, FULL)에 맞게 조건에 매칭되지 
--   않는 행들도 모두 NULL로 처리해서 조회합니다.

-- 필수`선택관계 : 게시물과 댓글. 게시물 입장에서 댓글 꼭 없어도 됨. 선택관계.(있어도,없어도됨.) 댓글입장에서는 게시판은 필수관계
-- 강의- 수강생 : 둘다 필수관계.
--선택관계에서도 조회가 가능한게 outer join

-- # LEFT OUTER JOIN
-- 조인되는 왼쪽 테이블은 모두 조회하고, 오른쪽 테이블은 조인조건에 매칭된 것만 조회합니다.

--예시)
-- 나는 사원정보는 일단 다 보고 싶은데 혹시 부서테이블에서 부서코드가 매칭되면
-- 보너스로 부서이름도 찍어줘라

--inner join
SELECT
    A.emp_no, A.emp_nm, A.dept_cd, B.dept_nm
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = B.dept_cd          -- 조인 전 46건 조회. 조인 후 41건 조회. 부서 없는 5명 조회 안됨. (inner join의 문제점?)
;                                            -- 매칭안되는 5명 dept_cd : 0000000 배제됨.

--ex) 문제에서 고객-구매정보 에서, inner조인하면 구매 하나도 안한사람(예비고객)은 조회가 안됨. 모든 고객한테 쿠폰을 뿌릴 수 없음. 
--ex2) 게시물+댓글 (댓글 없어도 보여야하니까)


--OUTER 조인


--ANSI 표준 (LEFT,RIGHT)

--#LEFT OUTER JOIN
SELECT
    A.emp_no, A.emp_nm, A.dept_cd, B.dept_nm
FROM tb_emp A -- 왼쪽
LEFT OUTER JOIN tb_dept B -- 오른쪽
ON A.dept_cd = B.dept_cd  
;     --> 46개                           -- LEFT는 다 보여주고, RIGHT는 매칭되면 보여주라

-- RIGHT로 쓰려면
SELECT
    B.emp_no, B.emp_nm, B.dept_cd, A.dept_nm
FROM tb_dept A -- 왼쪽
RIGHT OUTER JOIN tb_emp B -- 오른쪽
ON A.dept_cd = B.dept_cd  
;     

--Oracle 표현법
SELECT
    A.emp_no, A.emp_nm, A.dept_cd, B.dept_nm
FROM tb_emp A, tb_dept B        -- A가 LEFT, B가 RIGHT
WHERE A.dept_cd = B.dept_cd(+)
;
--LEFT JOIN으로 해도됨.
SELECT
    A.emp_no, A.emp_nm, A.dept_cd, B.dept_nm
FROM tb_emp A -- 왼쪽
LEFT JOIN tb_dept B -- 오른쪽
ON A.dept_cd = B.dept_cd  
;


-- #RIGHT OUTER JOIN
SELECT
    A.emp_no, A.emp_nm, A.dept_cd, B.dept_nm
FROM  tb_emp A-- 왼쪽
RIGHT OUTER JOIN tb_dept B -- 오른쪽
ON A.dept_cd = B.dept_cd  
;     

--Oracle 표현법
SELECT
    A.emp_no, A.emp_nm, A.dept_cd, B.dept_nm
FROM tb_emp A, tb_dept B        -- 일단 부서는 다 보여줘.
WHERE A.dept_cd(+) = B.dept_cd
;
--RIGHT JOIN으로해도됨.
SELECT
    A.emp_no, A.emp_nm, A.dept_cd, B.dept_nm
FROM tb_emp A -- 왼쪽
RIGHT JOIN tb_dept B -- 오른쪽
ON A.dept_cd = B.dept_cd  
;


-- # FULL OUTER JOIN
SELECT
    A.emp_no, A.emp_nm, A.dept_cd, B.dept_nm
FROM tb_emp A 
FULL OUTER JOIN tb_dept B 
ON A.dept_cd = B.dept_cd  
; --> 왼쪽 오른쪽 다 보여줘.



-- # SELF JOIN

--1. 자기 자신의 테이블끼리 조인하는 기법입니다.
--2. 자기 테이블의 컬럼들을 매칭하여 조회합니다.


SELECT
    A.emp_no, A.emp_nm, A.direct_manager_emp_no
FROM tb_emp A
;
--옆에 상사 이름을 적어주고 싶음. 자기랑 자기가 조인해야함.
--direct_manager_emp_no도 곧 emp_no, 상사이름도 곧 사원이름.
--왼쪽을 A 부하직원, 오른쪽을 B 상사직원 테이블이라고 가정.
--B.emp_no는 상사의 사원번호
-- A는 전체 다 끄집어내고, B에서는 상사 이름을 찾아서 넣겠다. B.emp_nm
-- A.direct_manager_emp_no 와 B.emp_no

SELECT
    A.emp_no, A.emp_nm, A.direct_manager_emp_no, B.emp_nm
FROM tb_emp A LEFT JOIN tb_emp B
ON A.direct_manager_emp_no = B.emp_no
ORDER BY A.emp_no
;

-- EX) SNS 회원테이블. 
/*
ID / 닉네임 / 팔로워ID

100/둘리/200
200/뽀로로/NULL
300/바보/200
100/둘리/300
300 /바보/100

둘리 팔로워들 목록 조회하려면 -> 셀프조인으로.
*/





