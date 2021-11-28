--21.11.18 ��۱��

CREATE TABLE reply (
    reply_no NUMBER (10),
    reply_text VARCHAR2(1000) NOT NULL,
    reply_writer VARCHAR2(50) NOT NULL,
    reply_date DATE default SYSDATE,
    board_no NUMBER(10),
    CONSTRAINT pk_reply PRIMARY KEY (reply_no),
    CONSTRAINT fk_reply_board FOREIGN KEY (board_no) REFERENCES board (board_no)
);

CREATE SEQUENCE seq_reply;

SELECT * FROM reply;