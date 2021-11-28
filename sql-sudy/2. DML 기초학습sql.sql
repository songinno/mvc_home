
-- <DML : ������ ���۾�> --
-- SLECT, INSERT, UPDATE, DELETE


INSERT INTO BOARD
    (bno, title, content, writer, reg_date)
VALUES
    (1, '�ȳ�~', '��մ� �����Դϴ�.', '������', SYSDATE);  -- ��Ʈ�� ǥ���Ҷ� '' �̰ŷθ�.

--NOT NULL �������ǿ� ����
INSERT INTO BOARD
    (bno, content, writer, reg_date)
VALUES
    (2, '��մ� �����Դϴ�2.', '�Ѹ�', SYSDATE);  
    ---> ������. ORA-01400: cannot insert NULL into ("SQLD"."BOARD"."TITLE") : NOT NULL�ɾ����.

-- PK �������� ����
INSERT INTO BOARD
    (bno, title, content, writer, reg_date)
VALUES
    (1, '���ο� ���̾�', '��մ� �����Դϴ�3.', '�Ѹ�', SYSDATE); 
    ---> ���� ORA-00001: unique constraint (SQLD.PK_BOARD_BNO) violated : PK
    
INSERT INTO BOARD
    (bno, title, writer, reg_date)
VALUES
    (3, '���ο� ���̾�', '�Ѹ�', SYSDATE); 
    
--���̺��� ��� �÷��� ä���� ������ ��� �÷������� ������ �� �ִ�.
INSERT INTO BOARD
    --(bno, title, writer, reg_date)-> ����O
VALUES
    (4, '�ȳ�~4', '��մ� �����Դϴ�4.', '��浿', SYSDATE);

--*������ ����
UPDATE board
SET title = '������ ����'
WHERE bno = 3;           -- => Ư�� ������ 1�� ����. pk�� ����.
    
UPDATE board
SET content = '�¾����ʹ�'
WHERE bno = 3; 

-- 1���Խù� �� �����ϰ����.
UPDATE board
SET title = '�޷ո޷���'
    , content = '��ȣ��ȣ'
    , writer = '�ڿ���'
WHERE bno = 1;

--���ǻ��� : WHERE�� ������ ��� ��ü���� ������.
UPDATE board
Set writer = '������';

-- *������ ����
DELETE FROM board          
    -- DELETE FROM ���� �ܿ��. ���̿� �ƹ��͵� �ȵ�. SELECT ? FROM�� ���̿� �� ��.
WHERE bno = 1;



INSERT INTO BOARD
    (bno, title, content, writer, reg_date)
VALUES
    (2, '�ȳ�~', '��մ� �����Դϴ�.', '������', SYSDATE);
    INSERT INTO BOARD
    (bno, title, content, writer, reg_date)
VALUES
    (3, '�ȳ�~', '��մ� �����Դϴ�.', '������', SYSDATE);

INSERT INTO BOARD
    (bno, title, content, writer, reg_date)
VALUES
    (4, '�ȳ�~', '��մ� �����Դϴ�.', '������', SYSDATE);





--*****************--
SELECT*FROM board;
--*****************--

-- * < TRANSACTION >
-- 4�� Ư¡(ACID) �ϱ�
--1)���ڼ� : ALL OF NOTHING
COMMIT; -- ��� �������� �� �ݿ�

ROLLBACK; -- �����Ѱ� ��ҽ�Ű�°�. (���� Ŀ�Խ������� ���ư�)
--2)�ϰ���
--3)���� : �¼� ������ ���� �� LOCK�ɾ���°�
--4)���Ӽ� : ������. COMMIT�Ǹ� ������ ������ ����.


-- * ��ü������ ����
--1. WHERE���� ������ DELETE�� (ROLLBACK ����, ����Ŀ�� ����, �α׳���� ����)
DELETE FROM board;

--2. TRUNCATE TABLE(�ѹ�X, �ڵ�Ŀ��, �α׳��� ����, ���̺� ���� �ʱ���·� ���ư�.  ->�ٽ� INSERT�ϸ� ��.)
TRUNCATE TABLE board;
--DDL�� ����.

--3. DROP TABLE (�ѹ�X, �ڵ�Ŀ��, �α�X, ���̺� ������ ���� ������. ���̺� ��ü�� �����)
DROP TABLE board;
