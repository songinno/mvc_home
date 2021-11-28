CREATE SEQUENCE seq_board;

DROP TABLE board;

CREATE TABLE board (
    board_no NUMBER(10),
    writer VARCHAR2(20) NOT NULL,
    title VARCHAR2(200) NOT NULL,
    content VARCHAR2(2000),
    view_cnt NUMBER(10) DEFAULT 0, --��ȸ��. �⺻��0. -> insert�� �� �־��� �ʿ�x
    reg_date DATE DEFAULT SYSDATE, -- �ۼ���. �⺻�� ����ð�. -> insert �־��� �ʿ�x
    CONSTRAINT pk_board PRIMARY KEY (board_no)
);

INSERT INTO board (board_no, writer, title, content) VALUES (seq_board.nextval, '������', '�β��β�', '��~~~~~~~');
--INSERT INTO board VALUES (seq_board.nextval, '������', '�β��β�', '��~~~~~~~'); -- �̷��Ը� ����x, 6�� �ٽ����.

SELECT * FROM board ORDER BY board_no DESC;
SELECT COUNT(*) FROM board;
COMMIT;

--UPDATE board SET writer='ȣ������', title='�ȳ�2', content='���' WHERE board_no=2;
--UPDATE board SET writer = ?, title = ?, content = ? WHERE board_no=?

ALTER TABLE board
ADD update_date DATE;
---------------------------------------------------
-- �Խ��� ����¡ ���� (rownum���� ����)
--1������
SELECT
    board_no, title, writer, content
FROM 
    (SELECT /*+INDEX_DESC(board pk_board)*/ rownum rn, board_no, title, writer, content FROM board WHERE rownum <= 10)
WHERE rn > 0
;
--2������
SELECT
    board_no, title, writer, content
FROM 
    (SELECT /*+INDEX_DESC(board pk_board)*/ rownum rn, board_no, title, writer, content FROM board WHERE rownum <= 20)
WHERE rn > 10
;





