

-- #������ ��������
-- ���������� ��ȸ ����� 1�� ������ ���

-- �μ���ȣ�� 100004���� �μ��� ��� ������� ��ȸ.

SELECT
    *
FROM tb_emp
WHERE dept_cd = '100004'
;

-- '�̳���'�� �����ִ� �μ��� ��� ������� ��ȸ (����������)

SELECT
    *
FROM tb_emp
WHERE dept_cd = (SELECT dept_cd FROM tb_emp WHERE emp_nm = '�̳���')  -- �̰������� �ϸ� �ȳ���.
;

-- = �����ڴ� ������ ���������� ������ؾ���. ������� 1�� ������ �Ŷ��� ����. �׷��� �̰��� �ȵ�.
-- �׷��� �������� WHERE�� PK�� �����ִ� �� ����.

--�̳����� �μ��ڵ� ã��
SELECT dept_cd FROM tb_emp WHERE emp_nm = '�̳���'
;

-------------------------------------------------

-- 20200525�� ���� �޿��� ȸ���� 5�� ��ü(2020525) ��� �޿����� ���� ������� �������(���,�̸�,���� �󸶹޾ҳ�) ��ȸ

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
                                WHERE pay_de = '20200525' -- �񿬰�, ������
                                )
ORDER BY A.emp_no, B.pay_de
;

-- 5�� ��ü�޿���� ���ϱ� (����������)

SELECT
    AVG(pay_amt)
FROM  tb_sal_his
WHERE pay_de = '20200525'
;
 
 -------------------------------------------------------------------------------------
 -- #������ ��������
 -- ���������� ��ȸ �Ǽ��� ���� ���� ��.
 
 -- �ѱ������ͺ��̽���������� �߱��� �ڰ����� ������ �ִ� ����� �����ȣ,�̸�,�ڰ��� ������ ��ȸ.
 
 
 -- �ѱ�db��������� �߱��� �ڰ��� ã�� (����������)
SELECT
   certi_cd
FROM tb_certi
WHERE issue_insti_nm = '�ѱ������ͺ��̽������'
;
--> certi_cd�� 100001~100006

-- ���� �����ڰ��� ����
SELECT
    A.emp_no, B.emp_nm, COUNT(A.certi_cd)
FROM tb_emp_certi A
JOIN tb_emp B
ON A.emp_no = B.emp_no
WHERE A.certi_cd IN (SELECT certi_cd FROM tb_certi WHERE issue_insti_nm = '�ѱ������ͺ��̽������') -- �񿬰�, ������
GROUP BY A.emp_no, B.emp_nm
ORDER BY A.emp_no
;
 
 -- # ���� �÷� ��������
 
 --�μ����� 2�� �̻��� �μ� ��, �� �μ��� ���� �������� ��������� ��ȸ.
 
 
 SELECT
    A.emp_no, A.emp_nm, A.birth_de
  , A.dept_cd, B.dept_nm
 FROM tb_emp A
 JOIN tb_dept B
 ON A.dept_cd = B.dept_cd
 WHERE (A.dept_cd, A.birth_de) IN (
                                SELECT
                                        dept_cd, MIN(birth_de) -- �����÷�, 2��-> �׷��� ���� where���� ��ȣ�� ��� 2�� ������. (�񱳴�� �����ֱ�)
                                FROM tb_emp
                                GROUP BY dept_cd
                                HAVING COUNT(*) >= 2
                                )
 ORDER BY A.emp_no
 ;
 
 -- #EXISTS ��
 ----EXISTS ����
SELECT 'X' FROM tb_emp WHERE addr LIKE '%����%';  -->��ȸ�� �ֵ��� ����ִ��� �׳� �ñ��Ѱ�. (1�̳� X��)

 -- �ּҰ� ������ �������� �ٹ��ϰ� �ִ� �μ����� �μ������� ��ȸ
 
SELECT
    emp_nm, addr, dept_cd
FROM tb_emp
WHERE addr LIKE '%����%'
; 

SELECT * FROM tb_dept WHERE dept_cd IN ('100009', '100010');


SELECT
    A.dept_cd, A.dept_nm
FROM tb_dept A
WHERE EXISTS (
                        SELECT
                            1    -- �ƹ��ų� �����. �˰� ���� ������ �ƴ�.
                        FROM tb_emp B
                        WHERE addr LIKE '%����%'
                            AND A.dept_cd = B.dept._cd              -- ������������, ������
                      ); -- ������� �ֵ��� �����ϴ� �μ��� �μ� ����(�ڵ�,�̸�)


-- # ��Į�� �������� (SELECT ���� ���� ��������)

SELECT
    A.emp_no, A.emp_nm, A.addr, A.birth_de
    , B.dept_nm
    , C.certi_cd
    , D. certi_nm  -- �̷��� ��ȸ�Ұ� �ϳ��� �߰��Ҷ����� join,on�� ��� �߰����ִ°� ������.
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
;

--�׷��� ���� 1�� �Ҷ��� select���� �������� �̿��ؼ� �׳� ��ȸ
SELECT
    A.emp_no, A.emp_nm
    ,(SELECT dept_nm FROM tb_dept B WHERE A.dept_cd = B.dept_cd) AS dept_nm -- ������������ (A.dept_cd ����.)
    , A.addr, A.birth_de
FROM tb_emp A
;

-- # �ζ��κ� (FROM���� ���� ��������)

SELECT
   B.emp_no, B.emp_nm ,A.pay_avg
FROM (
            SELECT emp_no ,AVG(pay_amt) AS pay_avg
            FROM tb_sal_his
            GROUP BY emp_no
            ) A, tb_emp B
WHERE A.emp_no = B.emp_no
;  -- ���̺� �̸��ڸ��� ��������



