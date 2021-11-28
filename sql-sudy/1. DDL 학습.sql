-----21.08.19-----

--SQL은 대/소문자를 구분하지 않는다

select sysdate from dual;
SELECT SYSDATE FROM DUAL; -- 키워드는 대문자로 쓰는게 관례(SELECT, FROM)


------ DDL : 데이터 정의어-------
-- CREATE TABLE
CREATE TABLE BOARD(
    BNO NUMBER(10),
    TITLE VARCHAR2(200) NOT NULL, 
    CONTENT VARCHAR2(2000),
    WRITER VARCHAR2(50) NOT NULL,
    REG_DATE DATE
);

--*기본키 : NOT NULL과 UNIQUE가 동시에 적용되는 것에 걸어줌 => BNO가 최적. 빠른 식별을 위함

--기본키 걸어주기 : ALTER를 통해

--ALTER : 데이터베이스의 구조를 변경
ALTER TABLE BOARD
ADD CONSTRAINT pk_board_bno
PRIMARY KEY (BNO);  
-- 형태 알아두기


-- 데이터 추가 : INSERT로
INSERT INTO BOARD
    (bno, title, content, writer, reg_date)
VALUES
    (2, '안녕안녕', '내용내용', '김철수', SYSDATE);

SELECT*FROM board;

--*외래키 :  
--댓글은 또다른 테이블 필요. 게시판 테이블 형식을 보통은 그대로 안쓰니깐.
-- 또 댓글마다 다 달은 게시물 번호가 다름. 그래서 댓글 테이블에 어느 게시물(PK)에 단 댓글인지 표시해줘야함.
-- -> 게시판과 댓글은 1:m 관계. 어느 게시물에 단 댓글인지 표시해주는게 FK(외래키) 

--댓글 테이블 생성
CREATE TABLE REPLY(
    RNO NUMBER(10),
    R_CONTENT VARCHAR2(500),
    R_WRITER VARCHAR2(50),
    BNO NUMBER(10)                      
);

--연관관계 설정 : BOARD 테이블과 REPLY테이블 관계를 지정
ALTER TABLE REPLY
ADD CONSTRAINT fk_reply_bno
FOREIGN KEY(BNO)
REFERENCES BOARD(BNO);

------21.08.20------
-- <컬럼 변경> --

ALTER TABLE BOARD
ADD(view_count NUMBER(10) DEFAULT 0 NOT NULL); -- 추가, 뷰카운트라는 컬럼. 타입은 숫자 10자리까지, 기본값 0, 널값X

ALTER TABLE BOARD
MODIFY (title VARCHAR2(400));

ALTER TABLE BOARD
DROP COLUMN view_count;

--테이블 삭제
DROP TABLE REPLY;
DROP TABLE BOARD;  -- 주의 : 복구가 안됨.







