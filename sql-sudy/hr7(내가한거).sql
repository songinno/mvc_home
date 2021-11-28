

-- �ǽ����� (JOIN)
-- 1. �����ȣ�� 103���� ����� �̸�(employee_name)�� �Ŵ��� �̸�(manager_name)�� ����ϼ���.

-- 2. ��� ����� first_name�� department_name, 
--    street_address + ',' + city + ',' + state_province�� address��� alias�� ��ȸ�ϼ���.
-- employees, departments, locations 3�� ����

-- 3. 103�� ����� first_name�� department_name, 
--    street_address + ',' + city + ',' + state_province�� address��� alias�� 
--    �����Ͽ� ��ȸ�ϼ���.

-- 4. �μ� �̸��� IT�� �����ϴ� ����� first_name�� department_name, 
--    street_address + ',' + city + ',' + state_province�� address��� alias�� 
--    �����Ͽ� ��ȸ�ϼ���.

-- 5. jobs���̺��� ��� ���� id(job_id)�� ������(job_title)�� ��ȸ�ϴµ� 
--    ���� �������� �̷��� �ִٸ� �ش� �̷� ���� 
-- (start_date, end_date, job_id, employee_id, first_name, department_id, department_name)
--    �� �Բ� ��ȸ�ϼ���.

--================================

-- 1. �����ȣ�� 103���� ����� �̸�(employee_name)�� �Ŵ��� �̸�(manager_name)�� ����ϼ���.
SELECT
    A.employee_id, A.first_name || ' '|| A.last_name AS EMPLOYEE_NAME, A.manager_id, B.first_name || ' '|| B.last_name AS MANAGER_NAME
FROM employees A JOIN employees B
ON a.manager_id = b.employee_id
WHERE a.employee_id = 103
;

-- 2. ��� ����� first_name�� department_name, 
--    street_address + ',' + city + ',' + state_province�� address��� alias�� ��ȸ�ϼ���.
-- employees, departments, locations 3�� ����

SELECT
    A.first_name, B.department_name, C.street_address || ',' || c.city || ',' || c.state_province AS address
FROM employees A 
LEFT JOIN departments B
ON A.department_id = B.department_id
LEFT JOIN locations C                           -- �ѹ� LEFT ���� ������ ��� LEFT ���� �������.
ON B.location_id = C.location_id
;

-- 3. 103�� ����� first_name�� department_name, 
--    street_address + ',' + city + ',' + state_province�� address��� alias�� 
--    �����Ͽ� ��ȸ�ϼ���.

SELECT
    A.first_name, B.department_name, C.street_address || ',' || c.city || ',' || c.state_province AS address
FROM employees A 
LEFT JOIN departments B
ON A.department_id = B.department_id
LEFT JOIN locations C                           -- �ѹ� LEFT ���� ������ ��� LEFT ���� �������.
ON B.location_id = C.location_id
WHERE a.employee_id = 103
;

-- 4. �μ� �̸��� IT�� �����ϴ� ����� first_name�� department_name, 
--    street_address + ',' + city + ',' + state_province�� address��� alias�� 
--    �����Ͽ� ��ȸ�ϼ���.

SELECT
    A.first_name, B.department_name, C.street_address || ',' || c.city || ',' || c.state_province AS address
FROM employees A 
LEFT JOIN departments B
ON A.department_id = B.department_id
LEFT JOIN locations C
ON B.location_id = C.location_id
WHERE b.department_name LIKE 'IT%'
;

-- 5. jobs���̺��� ��� ���� id(job_id)�� ������(job_title)�� ��ȸ�ϴµ� 
--    ���� �������� �̷��� �ִٸ� �ش� �̷� ���� 
-- (start_date, end_date, job_id, employee_id, first_name, department_id, department_name)
--    �� �Բ� ��ȸ�ϼ���.

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




