-----21.08.19-----

--SQL�� ��/�ҹ��ڸ� �������� �ʴ´�

select sysdate from dual;
SELECT SYSDATE FROM DUAL; -- Ű����� �빮�ڷ� ���°� ����(SELECT, FROM)


------ DDL : ������ ���Ǿ�-------
-- CREATE TABLE
CREATE TABLE BOARD(
    BNO NUMBER(10),
    TITLE VARCHAR2(200) NOT NULL, 
    CONTENT VARCHAR2(2000),
    WRITER VARCHAR2(50) NOT NULL,
    REG_DATE DATE
);

--*�⺻Ű : NOT NULL�� UNIQUE�� ���ÿ� ����Ǵ� �Ϳ� �ɾ��� => BNO�� ����. ���� �ĺ��� ����

--�⺻Ű �ɾ��ֱ� : ALTER�� ����

--ALTER : �����ͺ��̽��� ������ ����
ALTER TABLE BOARD
ADD CONSTRAINT pk_board_bno
PRIMARY KEY (BNO);  
-- ���� �˾Ƶα�


-- ������ �߰� : INSERT��
INSERT INTO BOARD
    (bno, title, content, writer, reg_date)
VALUES
    (2, '�ȳ�ȳ�', '���볻��', '��ö��', SYSDATE);

SELECT*FROM board;

--*�ܷ�Ű :  
--����� �Ǵٸ� ���̺� �ʿ�. �Խ��� ���̺� ������ ������ �״�� �Ⱦ��ϱ�.
-- �� ��۸��� �� ���� �Խù� ��ȣ�� �ٸ�. �׷��� ��� ���̺� ��� �Խù�(PK)�� �� ������� ǥ���������.
-- -> �Խ��ǰ� ����� 1:m ����. ��� �Խù��� �� ������� ǥ�����ִ°� FK(�ܷ�Ű) 

--��� ���̺� ����
CREATE TABLE REPLY(
    RNO NUMBER(10),
    R_CONTENT VARCHAR2(500),
    R_WRITER VARCHAR2(50),
    BNO NUMBER(10)                      
);

--�������� ���� : BOARD ���̺�� REPLY���̺� ���踦 ����
ALTER TABLE REPLY
ADD CONSTRAINT fk_reply_bno
FOREIGN KEY(BNO)
REFERENCES BOARD(BNO);

------21.08.20------
-- <�÷� ����> --

ALTER TABLE BOARD
ADD(view_count NUMBER(10) DEFAULT 0 NOT NULL); -- �߰�, ��ī��Ʈ��� �÷�. Ÿ���� ���� 10�ڸ�����, �⺻�� 0, �ΰ�X

ALTER TABLE BOARD
MODIFY (title VARCHAR2(400));

ALTER TABLE BOARD
DROP COLUMN view_count;

--���̺� ����
DROP TABLE REPLY;
DROP TABLE BOARD;  -- ���� : ������ �ȵ�.







