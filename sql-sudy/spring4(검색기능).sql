
-- ���� '3'���� ã��
SELECT * FROM board WHERE title LIKE '%3%';

--���� 10���� ��������
 SELECT
            board_no, title, writer, content, view_cnt, reg_date
            FROM
            (SELECT /*+INDEX_DESC(board pk_board)*/ 
            rownum rn, board_no, title, writer, content, view_cnt, reg_date 
            FROM board 
            WHERE rownum <= 10
                AND (title LIKE '%3%' OR content LIKE '%' || '����' || '%') -- ���� 3 �Ǵ� ���뿡 ����,  ���� ã��
            )
            WHERE rn > 0;