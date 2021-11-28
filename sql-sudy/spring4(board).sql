CREATE SEQUENCE seq_board;

DROP TABLE board;

CREATE TABLE board (
    board_no NUMBER(10),
    writer VARCHAR2(20) NOT NULL,
    title VARCHAR2(200) NOT NULL,
    content VARCHAR2(2000),
    view_cnt NUMBER(10) DEFAULT 0, --조회수. 기본값0. -> insert할 때 넣어줄 필요x
    reg_date DATE DEFAULT SYSDATE, -- 작성일. 기본값 현재시간. -> insert 넣어줄 필요x
    CONSTRAINT pk_board PRIMARY KEY (board_no)
);

INSERT INTO board (board_no, writer, title, content) VALUES (seq_board.nextval, '개굴이', '두껍두껍', '즐~~~~~~~');
--INSERT INTO board VALUES (seq_board.nextval, '개굴이', '두껍두껍', '즐~~~~~~~'); -- 이렇게만 쓰면x, 6개 다써야함.

SELECT * FROM board ORDER BY board_no DESC;
SELECT COUNT(*) FROM board;
COMMIT;

--UPDATE board SET writer='호랑이이', title='안녕2', content='깔깔' WHERE board_no=2;
--UPDATE board SET writer = ?, title = ?, content = ? WHERE board_no=?

ALTER TABLE board
ADD update_date DATE;
---------------------------------------------------
-- 게시판 페이징 쿼리 (rownum으로 제어)
--1페이지
SELECT
    board_no, title, writer, content
FROM 
    (SELECT /*+INDEX_DESC(board pk_board)*/ rownum rn, board_no, title, writer, content FROM board WHERE rownum <= 10)
WHERE rn > 0
;
--2페이지
SELECT
    board_no, title, writer, content
FROM 
    (SELECT /*+INDEX_DESC(board pk_board)*/ rownum rn, board_no, title, writer, content FROM board WHERE rownum <= 20)
WHERE rn > 10
;





