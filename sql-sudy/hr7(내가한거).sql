

-- 실습문제 (JOIN)
-- 1. 사원번호가 103번인 사원의 이름(employee_name)과 매니저 이름(manager_name)을 출력하세요.

-- 2. 모든 사원의 first_name과 department_name, 
--    street_address + ',' + city + ',' + state_province를 address라는 alias로 조회하세요.
-- employees, departments, locations 3개 조인

-- 3. 103번 사원의 first_name과 department_name, 
--    street_address + ',' + city + ',' + state_province를 address라는 alias로 
--    지정하여 조회하세요.

-- 4. 부서 이름이 IT로 시작하는 사원의 first_name과 department_name, 
--    street_address + ',' + city + ',' + state_province를 address라는 alias로 
--    지정하여 조회하세요.

-- 5. jobs테이블에서 모든 직무 id(job_id)와 직무명(job_title)을 조회하는데 
--    만약 직무변동 이력이 있다면 해당 이력 정보 
-- (start_date, end_date, job_id, employee_id, first_name, department_id, department_name)
--    도 함께 조회하세요.

--================================

-- 1. 사원번호가 103번인 사원의 이름(employee_name)과 매니저 이름(manager_name)을 출력하세요.
SELECT
    A.employee_id, A.first_name || ' '|| A.last_name AS EMPLOYEE_NAME, A.manager_id, B.first_name || ' '|| B.last_name AS MANAGER_NAME
FROM employees A JOIN employees B
ON a.manager_id = b.employee_id
WHERE a.employee_id = 103
;

-- 2. 모든 사원의 first_name과 department_name, 
--    street_address + ',' + city + ',' + state_province를 address라는 alias로 조회하세요.
-- employees, departments, locations 3개 조인

SELECT
    A.first_name, B.department_name, C.street_address || ',' || c.city || ',' || c.state_province AS address
FROM employees A 
LEFT JOIN departments B
ON A.department_id = B.department_id
LEFT JOIN locations C                           -- 한번 LEFT 조인 했으면 계속 LEFT 조인 해줘야함.
ON B.location_id = C.location_id
;

-- 3. 103번 사원의 first_name과 department_name, 
--    street_address + ',' + city + ',' + state_province를 address라는 alias로 
--    지정하여 조회하세요.

SELECT
    A.first_name, B.department_name, C.street_address || ',' || c.city || ',' || c.state_province AS address
FROM employees A 
LEFT JOIN departments B
ON A.department_id = B.department_id
LEFT JOIN locations C                           -- 한번 LEFT 조인 했으면 계속 LEFT 조인 해줘야함.
ON B.location_id = C.location_id
WHERE a.employee_id = 103
;

-- 4. 부서 이름이 IT로 시작하는 사원의 first_name과 department_name, 
--    street_address + ',' + city + ',' + state_province를 address라는 alias로 
--    지정하여 조회하세요.

SELECT
    A.first_name, B.department_name, C.street_address || ',' || c.city || ',' || c.state_province AS address
FROM employees A 
LEFT JOIN departments B
ON A.department_id = B.department_id
LEFT JOIN locations C
ON B.location_id = C.location_id
WHERE b.department_name LIKE 'IT%'
;

-- 5. jobs테이블에서 모든 직무 id(job_id)와 직무명(job_title)을 조회하는데 
--    만약 직무변동 이력이 있다면 해당 이력 정보 
-- (start_date, end_date, job_id, employee_id, first_name, department_id, department_name)
--    도 함께 조회하세요.

SELECT
    A.job_id, A.job_title
    , B.start_date, B.end_date, B.job_id, B.employee_id
    , C.first_name, C.department_id
    , D.department_name
FROM jobs A 
LEFT JOIN job_history B
ON A.job_id = B.job_id
LEFT JOIN employees C
ON A.job_id = C.job_id
LEFT JOIN departments D
ON c.department_id = d.department_id
;




