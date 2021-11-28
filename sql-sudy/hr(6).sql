-- # ���� ������ ���輺

-- INNER JOIN����
SELECT
    A.employee_id, A.first_name
    , D.department_id, D.department_name
FROM employees A, departments D
WHERE a.department_id = d.department_id
;  
--> ������ 106��

-- ������������
SELECT
    A.employee_id, A.first_name
    , department_id, D.department_name
FROM employees A NATURAL JOIN departments D
; 
--> ������ 32��

-- �� ���̺� �Ȱ��� �̸��� �÷��� 2����. �װ� �ΰ� �� �����°���.
SELECT
    A.employee_id, A.first_name
    , D.department_id, D.department_name
FROM employees A, departments D
WHERE a.department_id = d.department_id
    AND a.manager_id = d.manager_id
;  -- �� ������.

-----------------------------------------------------------------------------
--USING JOING����

SELECT
    A.employee_id, A.first_name
    , department_id, D.department_name
FROM employees A INNER JOIN departments D          
USING (department_id) 
; 
--> 106�� ����o

















