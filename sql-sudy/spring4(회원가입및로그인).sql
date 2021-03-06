--[21.11.22] 회원관리

-- 회원 관리 테이블
CREATE TABLE member (
    account VARCHAR2(50),
    password VARCHAR2(150) NOT NULL, -- 암호화해야해서 넉넉히
    name VARCHAR2(50) NOT NULL,
    email VARCHAR2(100) NOT NULL UNIQUE,
    auth VARCHAR2(20) DEFAULT 'COMMON',
    reg_date DATE DEFAULT SYSDATE,
    CONSTRAINT pk_member PRIMARY KEY (account)
);

INSERT INTO member (account, password, name, email, auth)
VALUES ('admin', '1234', '관리자', 'admin@gmail.com', 'ADMIN');

COMMIT;

SELECT COUNT (*) FROM member
WHERE account = 'admin';  --> 1이면 중복o. 0이면 중복x

select * from member order by reg_date;

select * from member where account='def1234'; --없으면 공집합