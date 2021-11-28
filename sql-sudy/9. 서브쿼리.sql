

-- #단일행 서브쿼리
-- 서브쿼리의 조회 결과가 1건 이하인 경우

-- 부서번호가 100004번인 부서의 모든 사원정보 조회.

SELECT
    *
FROM tb_emp
WHERE dept_cd = '100004'
;

-- '이나라'가 속해있는 부서의 모든 사원정보 조회 (서브쿼리용)

SELECT
    *
FROM tb_emp
WHERE dept_cd = (SELECT dept_cd FROM tb_emp WHERE emp_nm = '이나라')  -- 이관심으로 하면 안나옴.
;

-- = 연산자는 단일행 서브쿼리랑 동등비교해야함. 결과값이 1개 나오는 거랑만 가능. 그래서 이관심 안됨.
-- 그래서 서브쿼리 WHERE에 PK를 적어주는 게 좋음.

--이나라의 부서코드 찾기
SELECT dept_cd FROM tb_emp WHERE emp_nm = '이나라'
;

-------------------------------------------------

-- 20200525에 받은 급여가 회사의 5월 전체(2020525) 평균 급여보다 높은 사원들의 사원정보(사번,이름,언제 얼마받았나) 조회

SELECT
    A.emp_no, A.emp_nm
    , B.pay_de, B.pay_amt
FROM tb_emp A
JOIN tb_sal_his B
ON A.emp_no = B.emp_no
WHERE B.pay_de = '20200525'
    AND B.pay_amt >= (
                                SELECT
                                    AVG(pay_amt)
                                FROM  tb_sal_his
                                WHERE pay_de = '20200525' -- 비연관, 단일행
                                )
ORDER BY A.emp_no, B.pay_de
;

-- 5월 전체급여평균 구하기 (서브쿼리용)

SELECT
    AVG(pay_amt)
FROM  tb_sal_his
WHERE pay_de = '20200525'
;
 
 -------------------------------------------------------------------------------------
 -- #다중행 서브쿼리
 -- 서브쿼리의 조회 건수가 여러 행인 것.
 
 -- 한국데이터베이스진흥원에서 발급한 자격증을 가지고 있는 사원의 사원번호,이름,자격증 개수를 조회.
 
 
 -- 한국db진흥원에서 발급한 자격증 찾기 (서브쿼리용)
SELECT
   certi_cd
FROM tb_certi
WHERE issue_insti_nm = '한국데이터베이스진흥원'
;
--> certi_cd가 100001~100006

-- 누가 무슨자격증 땄나
SELECT
    A.emp_no, B.emp_nm, COUNT(A.certi_cd)
FROM tb_emp_certi A
JOIN tb_emp B
ON A.emp_no = B.emp_no
WHERE A.certi_cd IN (SELECT certi_cd FROM tb_certi WHERE issue_insti_nm = '한국데이터베이스진흥원') -- 비연관, 다중행
GROUP BY A.emp_no, B.emp_nm
ORDER BY A.emp_no
;
 
 -- # 다중 컬럼 서브쿼리
 
 --부서원이 2명 이상인 부서 중, 각 부서의 가장 연장자의 사원정보를 조회.
 
 
 SELECT
    A.emp_no, A.emp_nm, A.birth_de
  , A.dept_cd, B.dept_nm
 FROM tb_emp A
 JOIN tb_dept B
 ON A.dept_cd = B.dept_cd
 WHERE (A.dept_cd, A.birth_de) IN (
                                SELECT
                                        dept_cd, MIN(birth_de) -- 다중컬럼, 2개-> 그래서 위에 where절도 괄호로 묶어서 2개 맞춰줌. (비교대상 맞춰주기)
                                FROM tb_emp
                                GROUP BY dept_cd
                                HAVING COUNT(*) >= 2
                                )
 ORDER BY A.emp_no
 ;
 
 -- #EXISTS 문
 ----EXISTS 설명
SELECT 'X' FROM tb_emp WHERE addr LIKE '%서울%';  -->조회된 애들이 몇건있는지 그냥 궁금한것. (1이나 X씀)

 -- 주소가 강남인 직원들이 근무하고 있는 부서들의 부서정보를 조회
 
SELECT
    emp_nm, addr, dept_cd
FROM tb_emp
WHERE addr LIKE '%강남%'
; 

SELECT * FROM tb_dept WHERE dept_cd IN ('100009', '100010');


SELECT
    A.dept_cd, A.dept_nm
FROM tb_dept A
WHERE EXISTS (
                        SELECT
                            1    -- 아무거나 써놓음. 알고 싶은 정보가 아님.
                        FROM tb_emp B
                        WHERE addr LIKE '%강남%'
                            AND A.dept_cd = B.dept._cd              -- 연관서브쿼리, 다중행
                      ); -- 강남사는 애들이 존재하는 부서의 부서 정보(코드,이름)


-- # 스칼라 서브쿼리 (SELECT 절에 쓰는 서브쿼리)

SELECT
    A.emp_no, A.emp_nm, A.addr, A.birth_de
    , B.dept_nm
    , C.certi_cd
    , D. certi_nm  -- 이렇게 조회할거 하나씩 추가할때마다 join,on을 계속 추가해주는게 불편함.
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
;

--그래서 조인 1개 할때는 select절에 서브쿼리 이용해서 그냥 조회
SELECT
    A.emp_no, A.emp_nm
    ,(SELECT dept_nm FROM tb_dept B WHERE A.dept_cd = B.dept_cd) AS dept_nm -- 연관서브쿼리 (A.dept_cd 썼음.)
    , A.addr, A.birth_de
FROM tb_emp A
;

-- # 인라인뷰 (FROM절에 쓰는 서브쿼리)

SELECT
   B.emp_no, B.emp_nm ,A.pay_avg
FROM (
            SELECT emp_no ,AVG(pay_amt) AS pay_avg
            FROM tb_sal_his
            GROUP BY emp_no
            ) A, tb_emp B
WHERE A.emp_no = B.emp_no
;  -- 테이블 이름자리에 서브쿼리



