
-- < JOIN ����>

--�μ� �̸��� tb_emp ���̺� ����. �μ� �̸��� ������ �ϰ����. tb_dept ���̺��� ����.
SELECT
    emp_no, emp_nm, addr, dept_cd
FROM tb_emp
;

SELECT
    dept_cd, dept_nm
FROM tb_dept;


-- �� SELECT���� ��ġ�� ����.

SELECT
    E.emp_no, E.emp_nm, E.addr, E.dept_cd, D.dept_nm  -- dept_cd �� �� ���̺� ��ο� �־ �ϳ� �����������.
FROM tb_emp E, tb_dept D -- ���� ���� ��Ī���� ����.
WHERE E.dept_cd = D.dept_cd
;

-- [���� ���� �׽�Ʈ ������]

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

INSERT INTO TEST_B  VALUES (1, '������', 1);
INSERT INTO TEST_B  VALUES (2, '������', 1);
INSERT INTO TEST_B  VALUES (3, '������', 2);
INSERT INTO TEST_B  VALUES (4, '������', 3);
COMMIT;


SELECT * FROM TEST_A;
SELECT * FROM TEST_B;

--
SELECT
    id, content, reply
FROM test_a, test_b
WHERE test_a.id = test_b.a_id --2) �׷��� �̷��� �´°͸� ������ ��Ī�������. => '���� ����'
;
-- 1)������ �ϸ� �� 12��. A 1��� B 4���� ��� ��ȸ. 

--------------------------------------------------------------

--�ڰ��� ���� ���̺�

SELECT * FROM tb_emp_certi;

SELECT * FROM tb_certi;



SELECT
    A.emp_no, A.certi_cd, B.certi_nm, A. acqu_de
FROM tb_emp_certi A, tb_certi B
WHERE A.certi_cd = B.certi_cd
;

-- 3�� ���̺� ����

SELECT
    A.emp_no, C.emp_nm, A.certi_cd, B.certi_nm, A. acqu_de
FROM tb_emp_certi A, tb_certi B, tb_emp C
WHERE A.certi_cd = B.certi_cd
    AND A.emp_no = C.emp_no
;


-- 4�� ���̺� ����

SELECT
    A.emp_no, C.emp_nm, C.dept_cd, D.dept_nm, A.certi_cd, B.certi_nm, A. acqu_de
FROM tb_emp_certi A, tb_certi B, tb_emp C, tb_dept D
WHERE A.certi_cd = B.certi_cd
    AND A.emp_no = C.emp_no
    AND C.dept_cd = D.dept_cd
;


--�μ��� �ڰ��� ��
SELECT
    C.dept_cd, COUNT(*)
FROM tb_emp_certi A, tb_certi B, tb_emp C, tb_dept D
WHERE A.certi_cd = B.certi_cd
    AND A.emp_no = C.emp_no
    AND C.dept_cd = D.dept_cd
GROUP BY C.dept_cd
;


----------------
-- 3���̺� ���� + 2019�⿡ ������ ���� ��ȸ + �� ���鸸 �������
SELECT
    A.emp_no, C.emp_nm, A.certi_cd, B.certi_nm, A. acqu_de
FROM tb_emp_certi A, tb_certi B, tb_emp C
WHERE A.certi_cd = B.certi_cd
    AND A.emp_no = C.emp_no
    AND A.acqu_de BETWEEN '20190101' AND '20191231'
    AND C.emp_nm LIKE '��%'
ORDER BY A.acqu_de
;

------------------------------------------------------------------------

-- # INNER JOIN
-- 1. 2�� �̻��� ���̺��� ����� �÷��� ���� �������� ���յǴ� ���α���Դϴ�.
-- 2. WHERE���� ���� �÷����� �������(=)�� ���� ���ε˴ϴ�.

SELECT 
    E.emp_no, E.emp_nm, E.addr, E.dept_cd, D.dept_nm
FROM tb_emp E, tb_dept D
WHERE E.dept_cd = D.dept_cd
    AND addr LIKE '%����%'
ORDER BY E.emp_no
;

SELECT 
    *                                        -- DEPT_CD 2�� ����. emp�� dept��
FROM tb_emp E, tb_dept D
WHERE E.dept_cd = D.dept_cd
    AND addr LIKE '%����%'
ORDER BY E.emp_no
;

-- # NATURAL JOIN
-- 1. NATURAL JOIN�� ������ �̸��� ���� �÷��鿡 ���� �ڵ� �����ϴ� ����Դϴ�.
-- 2. ��, �ڵ����� 2�� �̻��� ���̺��� ���� �̸��� ���� �÷��� ã�� INNER������ �����մϴ�.
-- 3. �� �� ���εǴ� ���� �̸��� �÷��� ������ Ÿ���� ���ƾ� �ϸ�, ALIAS�� ���̺���� ���� �� �����ϴ�.
-- 4. SELECT * ������ ����ϸ�, ���� �÷����� �ڵ� �����ϸ� ������տ��� �ѹ��� ǥ��˴ϴ�.

SELECT
    A.emp_no, A.emp_nm, dept_cd, B.dept_nm  -- dept_cd�� ��ħ. -> A. �Ǵ� B. �̶�� �Ƚ������. �������. ���� �˾Ƽ� �� + WHERE ���� ���ǵ� �ʿ�X
FROM tb_emp A NATURAL JOIN tb_dept B                 --> , ��� NATURAL JOIN�̶�� ��.
;

SELECT
    *
FROM tb_emp A NATURAL JOIN tb_dept B
;

-- # USING�� ����
-- 1. NATURAL���ο����� �ڵ����� �̸��� ��ġ�ϴ� ��� �÷��� ���� ������
--    �Ͼ���� USING�� ����ϸ� ���ϴ� �÷��� ���ؼ��� ���������� ������ �����մϴ�.
-- 2. USING�������� ���� �÷��� ���� ALIAS�� ���̺���� ���� �� �����ϴ�.


SELECT
    A.emp_no, A.emp_nm, dept_cd, B.dept_nm   -- dept_cd �տ� ������� �����������. (���� ����ó��)
FROM tb_emp A JOIN tb_dept B             -- JOIN �⺻�� INNER JOIN. INNER���� ����.
USING (dept_cd)
;


-- # JOIN ON��
-- 1. ���� ���� ������(ON��)�� �Ϲ� ���� ������(WHERE��)�� �и��ؼ� �ۼ��ϴ� ����Դϴ�.
-- 2. ON���� ����ϸ� JOIN���Ŀ� �� �����̳� ���������� ���� �߰� ������ �� �� �ֽ��ϴ�.


--4�� ���̺� �����Ѱ�.
SELECT
    A.emp_no, C.emp_nm, C.dept_cd, D.dept_nm, A.certi_cd, B.certi_nm, A. acqu_de
FROM tb_emp_certi A, tb_certi B, tb_emp C, tb_dept D
WHERE A.certi_cd = B.certi_cd
    AND A.emp_no = C.emp_no
    AND C.dept_cd = D.dept_cd
    AND C.birth_de BETWEEN '19800101' AND '19891231'
;
--N���� ������ �����ϸ�, ���� ������ N-1���̴�.


SELECT 
    E.emp_no, E.emp_nm, E.addr, E.dept_cd, D.dept_nm
FROM tb_emp E 
INNER JOIN tb_dept D
ON E.dept_cd = D.dept_cd
WHERE addr LIKE '%����%'
ORDER BY E.emp_no
;

-- * SELECT�� �⺻ ����

--SELECT [DISTINCT] { ���̸� .... } 
-- FROM  ���̺� �Ǵ� �� �̸�
-- JOIN  ���̺� �Ǵ� �� �̸�
-- ON    ���� ����
-- WHERE ��ȸ ����
-- GROUP BY  ���� �׷�ȭ
-- HAVING    �׷�ȭ ����      (GROUP BY�� HAVING�� �ٲ���.)
-- ORDER BY  ������ �� [ASC | DESC];

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























