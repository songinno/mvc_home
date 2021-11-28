-- 1�� SQL�⺻ - 16p (21.08.23)

-- <SELECT �⺻>
SELECT
    certi_cd, certi_nm
FROM tb_certi;  

SELECT
    certi_cd, certi_nm, issue_insti_nm
FROM tb_certi;


SELECT
    *             --> �÷� ���� �� ���������
FROM tb_emp;

-- *DISTINCT : �ߺ��� ����
SELECT DISTINCT  -- SELECT ALL�� �⺻��(�ڿ� �ƹ��͵� �Ƚ�����)
    issue_insti_nm, certi_nm -- �÷� 2�� �̻��̸� �÷� ���� 2�� �� �Ȱ��ƾ� �ߺ����ŵ�. �ȱ׷��� �ȵ�.
FROM tb_certi;


-- *��Ī(ALIAS) ��Ī����

SELECT
    certi_cd AS "�ڰ��� �ڵ�" 
    , certi_nm AS "�ڰ�����" -- �ֵ���ǥ ��������,  ��  ���� �Ҷ��� x
    , issue_insti_nm "�߱ޱ����" -- AS ����������. ""(ū����ǥ)�� ��.
FROM tb_certi;


-- *���տ�����(||)�� ���� �÷����ڿ� ����. ( + �ǹ�)

SELECT
    certi_nm || '('|| certi_cd ||')-'|| issue_insti_nm AS "�ڰ��� ����"
FROM tb_certi;

-- * ���� ���̺�(dual) : �ܼ� ���� ����� ��ȸ�� �� ���

SELECT
    3*7 AS "������"
FROM dual;



--* WHERE ������ : ��ȸ ����� �����ϴ� ������.

SELECT
    emp_no, emp_nm, addr,sex_cd
FROM tb_emp
WHERE sex_cd = 2;

--WHERE ��������, PK�÷��� ����ϸ� -> ������ �������� ��ȸ��.
SELECT
    emp_no, emp_nm, addr,sex_cd
FROM tb_emp
WHERE emp_no = 1000000003;

-- *�񱳿�����

--90�����鸸 �ɷ�����
SELECT
    emp_no, emp_nm, birth_de, tel_no
FROM tb_emp
WHERE birth_de >= '19900101'
    AND birth_de <= '19991231'
;
-- 1) BETWEEN������
SELECT
    emp_no, emp_nm, birth_de, tel_no
FROM tb_emp
WHERE birth_de BETWEEN '19900101' AND '19991231'  -- ���� ������ ��.
;

--�μ��ڵ尡 100004, 100006�� ����鸸 �ɷ��������.
-- 2) IN ������
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
--�μ��ڵ尡 100004, 100006�� ����� ���� ��ȸ. (NOT IN)
SELECT
    emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd NOT IN ('100004', '100006')
;


-- 3) LIKE ������ : �˻��� ���
-- ���ϵ� ī�� ���� =>        % : 0���� �̻�    ,      _ : �� 1����

--�� ���鸸 ��ȸ�ϰ� ����.
SELECT
    emp_no, emp_nm
FROM tb_emp
WHERE emp_nm LIKE '��%'
;

SELECT
    emp_no, emp_nm
FROM tb_emp
WHERE emp_nm LIKE '%��'
;

SELECT
    emp_no, emp_nm, addr
FROM tb_emp
WHERE addr LIKE '%����%'        -- ���뿡  '����'�̶�� ���� ���ִ°� �̾Ƴ�.
;

SELECT
    emp_no, emp_nm
FROM tb_emp
WHERE emp_nm LIKE '��_'                    -- ���� �̾��鼭, �̸� ������ ��� �ɷ���.
;
SELECT
    emp_no, emp_nm
FROM tb_emp
WHERE emp_nm LIKE '_��% '  -- �ι�° ���ڰ� ���� �ֵ�.
;


-- ���� �达�鼭, �μ��� 100003, 4,6�� �� �ϳ��鼭, 90������ ����� ���,�̸�,����,�μ��ڵ� ��ȸ

SELECT
    emp_no, emp_nm, birth_de, dept_cd
FROM tb_emp
WHERE emp_nm LIKE '��%'
    AND dept_cd IN ('100003', '100004', '100006')
    AND birth_de BETWEEN '19900101' AND '19991231'
;


-- *�����񱳿�����

--�̾��� �ƴϸ鼭 ���ڰ� �ƴ� ����� ��ȸ

SELECT
    emp_no
    , emp_nm
    , sex_cd
FROM tb_emp
WHERE sex_cd <> 1
    AND emp_nm NOT LIKE '��%'
;

-- *�ΰ� ��ȸ (IS NULL)

SELECT
    emp_no, emp_nm, direct_manager_emp_no
FROM tb_emp
WHERE direct_manager_emp_no IS null          --   = null (x)
;

-- ���� (IS NOT NULL)
SELECT
    emp_no, emp_nm, direct_manager_emp_no
FROM tb_emp
WHERE direct_manager_emp_no IS NOT null         
;

---�达�鼭, �����̳� �ϻ� ��»�� �̱�-----
--+�ǹ���.  (�ּ� �ޱ� ���ϰ� AND�� �ſ���. WHERE ������ ���ΰɷ� ���� ä���ְ�)
SELECT
    emp_no
    , emp_nm
    , birth_de
    , dept_cd
    , addr
FROM tb_emp
WHERE 1=1
    AND emp_nm LIKE '��%'
    AND addr LIKE '%����%' OR addr LIKE '%�ϻ�%'        ----> '�达�鼭 ����' �Ǵ� '�ϻ��»��'  (OR�� AND�� �켱������ �з���.) =>OR���� () ���ֱ�.
;                                                                             
-- => ��ȣ�� ������.
SELECT
    emp_no
    , emp_nm
    , birth_de
    , dept_cd
    , addr
FROM tb_emp
WHERE 1=1
    AND emp_nm LIKE '��%'
    AND (addr LIKE '%����%' OR addr LIKE '%�ϻ�%') 
;