
--���ӵ� ���� ���� (ex �Ϸù�ȣ)
CREATE SEQUENCE seq_product; 

--TEST ���̺�
CREATE TABLE product (
    product_id NUMBER(10)
    , product_name VARCHAR2(255) NOT NULL
    , product_price NUMBER(10)
    , CONSTRAINT pk_product_id PRIMARY KEY (product_id)
);

INSERT INTO product VALUES(seq_product.nextval, '��Ź��', 500000);
INSERT INTO product VALUES(seq_product.nextval, '�����', 1500000);
COMMIT;

--INSERT INTO product VALUES(1, '�ڵ���', 150000000);
--DELETE FROM product WHERE product_id=4;

SELECT * FROM product;

