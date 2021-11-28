-- 1강 SQL기본 - 16p (21.08.23)

-- <SELECT 기본>
SELECT
    certi_cd, certi_nm
FROM tb_certi;  

SELECT
    certi_cd, certi_nm, issue_insti_nm
FROM tb_certi;


SELECT
    *             --> 컬럼 전부 다 보고싶을때
FROM tb_emp;

-- *DISTINCT : 중복값 제외
SELECT DISTINCT  -- SELECT ALL이 기본값(뒤에 아무것도 안썼을때)
    issue_insti_nm, certi_nm -- 컬럼 2개 이상이면 컬럼 내용 2개 다 똑같아야 중복제거됨. 안그러면 안됨.
FROM tb_certi;


-- *별칭(ALIAS) 별칭지정

SELECT
    certi_cd AS "자격증 코드" 
    , certi_nm AS "자격증명" -- 쌍따옴표 생략가능,  단  띄어쓰기 할때는 x
    , issue_insti_nm "발급기관명" -- AS 생략가능함. ""(큰따옴표)로 씀.
FROM tb_certi;


-- *결합연산자(||)를 통한 컬럼문자열 결합. ( + 의미)

SELECT
    certi_nm || '('|| certi_cd ||')-'|| issue_insti_nm AS "자격증 정보"
FROM tb_certi;

-- * 더미 테이블(dual) : 단순 연산 결과를 조회할 때 사용

SELECT
    3*7 AS "연산결과"
FROM dual;



--* WHERE 조건절 : 조회 결과를 제한하는 조건절.

SELECT
    emp_no, emp_nm, addr,sex_cd
FROM tb_emp
WHERE sex_cd = 2;

--WHERE 조건절에, PK컬럼을 사용하면 -> 무조건 단일행이 조회됨.
SELECT
    emp_no, emp_nm, addr,sex_cd
FROM tb_emp
WHERE emp_no = 1000000003;

-- *비교연산자

--90년대생들만 걸러내기
SELECT
    emp_no, emp_nm, birth_de, tel_no
FROM tb_emp
WHERE birth_de >= '19900101'
    AND birth_de <= '19991231'
;
-- 1) BETWEEN연산자
SELECT
    emp_no, emp_nm, birth_de, tel_no
FROM tb_emp
WHERE birth_de BETWEEN '19900101' AND '19991231'  -- 위와 동일한 값.
;

--부서코드가 100004, 100006인 사람들만 걸러내고싶음.
-- 2) IN 연산자
SELECT
    emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd = '100004'
    OR dept_cd = '100006'
;
SELECT
    emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd IN ('100004', '100006')
;
--부서코드가 100004, 100006인 사람들 빼고 조회. (NOT IN)
SELECT
    emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd NOT IN ('100004', '100006')
;


-- 3) LIKE 연산자 : 검색시 사용
-- 와일드 카드 매핑 =>        % : 0글자 이상    ,      _ : 단 1글자

--이 씨들만 조회하고 싶음.
SELECT
    emp_no, emp_nm
FROM tb_emp
WHERE emp_nm LIKE '이%'
;

SELECT
    emp_no, emp_nm
FROM tb_emp
WHERE emp_nm LIKE '%심'
;

SELECT
    emp_no, emp_nm, addr
FROM tb_emp
WHERE addr LIKE '%용인%'        -- 내용에  '용인'이라는 말이 들어가있는거 뽑아냄.
;

SELECT
    emp_no, emp_nm
FROM tb_emp
WHERE emp_nm LIKE '이_'                    -- 성이 이씨면서, 이름 외자인 사람 걸러냄.
;
SELECT
    emp_no, emp_nm
FROM tb_emp
WHERE emp_nm LIKE '_정% '  -- 두번째 글자가 정인 애들.
;


-- 성이 김씨면서, 부서가 100003, 4,6번 중 하나면서, 90년대생인 사원의 사번,이름,생일,부서코드 조회

SELECT
    emp_no, emp_nm, birth_de, dept_cd
FROM tb_emp
WHERE emp_nm LIKE '김%'
    AND dept_cd IN ('100003', '100004', '100006')
    AND birth_de BETWEEN '19900101' AND '19991231'
;


-- *부정비교연산자

--이씨가 아니면서 남자가 아닌 사람들 조회

SELECT
    emp_no
    , emp_nm
    , sex_cd
FROM tb_emp
WHERE sex_cd <> 1
    AND emp_nm NOT LIKE '이%'
;

-- *널값 조회 (IS NULL)

SELECT
    emp_no, emp_nm, direct_manager_emp_no
FROM tb_emp
WHERE direct_manager_emp_no IS null          --   = null (x)
;

-- 부정 (IS NOT NULL)
SELECT
    emp_no, emp_nm, direct_manager_emp_no
FROM tb_emp
WHERE direct_manager_emp_no IS NOT null         
;

---김씨면서, 수원이나 일산 사는사람 뽑기-----
--+실무팁.  (주석 달기 편하게 AND로 매워줌. WHERE 무조건 참인걸로 옆에 채워넣고)
SELECT
    emp_no
    , emp_nm
    , birth_de
    , dept_cd
    , addr
FROM tb_emp
WHERE 1=1
    AND emp_nm LIKE '김%'
    AND addr LIKE '%수원%' OR addr LIKE '%일산%'        ----> '김씨면서 수원' 또는 '일산사는사람'  (OR이 AND에 우선순위가 밀려서.) =>OR에는 () 쳐주기.
;                                                                             
-- => 괄호로 묶어줌.
SELECT
    emp_no
    , emp_nm
    , birth_de
    , dept_cd
    , addr
FROM tb_emp
WHERE 1=1
    AND emp_nm LIKE '김%'
    AND (addr LIKE '%수원%' OR addr LIKE '%일산%') 
;