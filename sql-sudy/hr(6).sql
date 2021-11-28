-- # 네츄럴 조인의 위험성

-- INNER JOIN으로
SELECT
    A.employee_id, A.first_name
    , D.department_id, D.department_name
FROM employees A, departments D
WHERE a.department_id = d.department_id
;  
--> 인출행 106개

-- 네츄럴조인으로
SELECT
    A.employee_id, A.first_name
    , department_id, D.department_name
FROM employees A NATURAL JOIN departments D
; 
--> 인출행 32개

-- 두 테이블에 똑같은 이름의 컬럼이 2개임. 그거 두개 다 가져온거임.
SELECT
    A.employee_id, A.first_name
    , D.department_id, D.department_name
FROM employees A, departments D
WHERE a.department_id = d.department_id
    AND a.manager_id = d.manager_id
;  -- 이 상태임.

-----------------------------------------------------------------------------
--USING JOING으로

SELECT
    A.employee_id, A.first_name
    , department_id, D.department_name
FROM employees A INNER JOIN departments D          
USING (department_id) 
; 
--> 106행 인출o

















