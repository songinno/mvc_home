

SELECT
    first_name, last_name
FROM employees
WHERE LOWER(first_name) = 'david'              --LOWER 없이 'DAVID'로 검색하면 안뜸.
;

SELECT
    first_name, last_name
FROM employees
WHERE UPPER(first_name) = 'DAVID'              --UPPER없이 'david'로 검색하면 안뜸.
;
---------------------------------------------------------------------------------------------------------------------

-- # 실습문제 
-- 1. employees 테이블에서 모든 사원의 first_name과 first_name의 글자 수를 조회하세요.
SELECT
    first_name,
    LENGTH (first_name)
FROM employees
;

-- 2. employees 테이블에서 first_name과 last_name과 이 둘을 연결한 이름을 조회하세요.
SELECT
    first_name
    ,last_name
    ,CONCAT(first_name, last_name)
FROM employees
;

-- 3. employees 테이블에서 job_id가 it_prog인 사원의 first_name과 salary를 출력하세요. (앞에 3글자를 추출하고 총 글자수 남은 부분을*로 채우기)
--  조건1 ) 비교하기 위한 값은 소문자로 입력할 것!
--  조건2 ) 이름은 앞 3글자까지만 출력하고 나머지는 *로 마킹할 것. 이 열의 별칭은 name입니다.
--  조건3 ) 급여는 전체 10자리로 출력하되 나머지자리는 *로 출력합니다. 이 열의 별칭은 salary입니다.
SELECT
    RPAD(SUBSTR(first_name, 1, 3), LENGTH(first_name) , '*' ) AS name
    , LPAD(salary, 10, '*') AS salary
FROM employees
WHERE LOWER(job_id) = 'it_prog'
;
