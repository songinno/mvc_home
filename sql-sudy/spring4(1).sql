
--연속된 숫자 생성 (ex 일련번호)
CREATE SEQUENCE seq_product; 

--TEST 테이블
CREATE TABLE product (
    product_id NUMBER(10)
    , product_name VARCHAR2(255) NOT NULL
    , product_price NUMBER(10)
    , CONSTRAINT pk_product_id PRIMARY KEY (product_id)
);

INSERT INTO product VALUES(seq_product.nextval, '세탁기', 500000);
INSERT INTO product VALUES(seq_product.nextval, '냉장고', 1500000);
COMMIT;

--INSERT INTO product VALUES(1, '자동차', 150000000);
--DELETE FROM product WHERE product_id=4;

SELECT * FROM product;

