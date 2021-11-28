
-- 제목에 '3'들어간거 찾기
SELECT * FROM board WHERE title LIKE '%3%';

--상위 10개만 가져오기
 SELECT
            board_no, title, writer, content, view_cnt, reg_date
            FROM
            (SELECT /*+INDEX_DESC(board pk_board)*/ 
            rownum rn, board_no, title, writer, content, view_cnt, reg_date 
            FROM board 
            WHERE rownum <= 10
                AND (title LIKE '%3%' OR content LIKE '%' || 'ㅎㅇ' || '%') -- 제목에 3 또는 내용에 ㅎㅇ,  들어간거 찾기
            )
            WHERE rn > 0;