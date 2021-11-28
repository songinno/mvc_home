
-- <DML : 데이터 조작어> --
-- SLECT, INSERT, UPDATE, DELETE


INSERT INTO BOARD
    (bno, title, content, writer, reg_date)
VALUES
    (1, '안녕~', '재밌는 내용입니다.', '마이콜', SYSDATE);  -- 스트링 표현할때 '' 이거로만.

--NOT NULL 제약조건에 위반
INSERT INTO BOARD
    (bno, content, writer, reg_date)
VALUES
    (2, '재밌는 내용입니다2.', '둘리', SYSDATE);  
    ---> 오류남. ORA-01400: cannot insert NULL into ("SQLD"."BOARD"."TITLE") : NOT NULL걸어놔서.

-- PK 제약조건 위반
INSERT INTO BOARD
    (bno, title, content, writer, reg_date)
VALUES
    (1, '새로운 글이야', '재밌는 내용입니다3.', '둘리', SYSDATE); 
    ---> 오류 ORA-00001: unique constraint (SQLD.PK_BOARD_BNO) violated : PK
    
INSERT INTO BOARD
    (bno, title, writer, reg_date)
VALUES
    (3, '새로운 글이야', '둘리', SYSDATE); 
    
--테이블의 모든 컬럼을 채워서 삽입할 경우 컬럼지정을 생략할 수 있다.
INSERT INTO BOARD
    --(bno, title, writer, reg_date)-> 생략O
VALUES
    (4, '안녕~4', '재밌는 내용입니다4.', '고길동', SYSDATE);

--*데이터 수정
UPDATE board
SET title = '수정된 제목'
WHERE bno = 3;           -- => 특정 데이터 1행 수정. pk로 지정.
    
UPDATE board
SET content = '굿애프터눈'
WHERE bno = 3; 

-- 1번게시물 다 수정하고싶음.
UPDATE board
SET title = '메롱메롱이'
    , content = '야호야호'
    , writer = '박영희'
WHERE bno = 1;

--주의사항 : WHERE절 생략할 경우 전체행이 수정됨.
UPDATE board
Set writer = '관리자';

-- *데이터 삭제
DELETE FROM board          
    -- DELETE FROM 으로 외우기. 사이에 아무것도 안들어감. SELECT ? FROM은 사이에 뭐 들어감.
WHERE bno = 1;



INSERT INTO BOARD
    (bno, title, content, writer, reg_date)
VALUES
    (2, '안녕~', '재밌는 내용입니다.', '마이콜', SYSDATE);
    INSERT INTO BOARD
    (bno, title, content, writer, reg_date)
VALUES
    (3, '안녕~', '재밌는 내용입니다.', '마이콜', SYSDATE);

INSERT INTO BOARD
    (bno, title, content, writer, reg_date)
VALUES
    (4, '안녕~', '재밌는 내용입니다.', '마이콜', SYSDATE);





--*****************--
SELECT*FROM board;
--*****************--

-- * < TRANSACTION >
-- 4대 특징(ACID) 암기
--1)원자성 : ALL OF NOTHING
COMMIT; -- 모두 성공했을 때 반영

ROLLBACK; -- 성공한걸 취소시키는것. (최종 커밋시점으로 돌아감)
--2)일관성
--3)고립성 : 좌석 선택후 결제 전 LOCK걸어놓는거
--4)지속성 : 영구적. COMMIT되면 영구적 보존을 보장.


-- * 전체데이터 삭제
--1. WHERE절을 생략한 DELETE절 (ROLLBACK 가능, 수동커밋 가능, 로그남기기 가능)
DELETE FROM board;

--2. TRUNCATE TABLE(롤백X, 자동커밋, 로그남지 않음, 테이블 생성 초기상태로 돌아감.  ->다시 INSERT하면 들어감.)
TRUNCATE TABLE board;
--DDL에 속함.

--3. DROP TABLE (롤백X, 자동커밋, 로그X, 테이블 구조가 완전 삭제됨. 테이블 자체가 사라짐)
DROP TABLE board;
