select * from member;

delete from member where name='±èÃ¶¼ö';

update member set auth='ADMIN'  where account='def1234';

commit;

select * from board ORDER BY board_no DESC;


ALTER TABLE board ADD account VARCHAR2(50); --BOARD µµ¸ÞÀÎ¿¡ Ãß°¡

UPDATE board
SET account='NONE'
WHERE account IS NULL;