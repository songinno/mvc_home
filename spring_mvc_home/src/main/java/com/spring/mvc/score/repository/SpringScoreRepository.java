package com.spring.mvc.score.repository;

import com.spring.mvc.score.domain.Score;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
@Repository("ssr")
@Log4j2
@RequiredArgsConstructor
public class SpringScoreRepository  implements ScoreRepository{

    //jDBC의 중복코드를 처리해주는 템플릿 (외부 라이브러리에 있음)
    private final JdbcTemplate jdbcTemplate;

//    public SpringScoreRepository(JdbcTemplate jdbcTemplate) {
//        this.jdbcTemplate = jdbcTemplate;
//    }
    //=> @RequiredArgsConstructor 이거로 자동주입o (주입 받을게 하나뿐일 때)

    @Override
    public boolean save(Score score) {
        String sql = "INSERT INTO score VALUES (seq_score.nextval,?,?,?,?,?,?)";

        int resultNum
                = jdbcTemplate.update(sql
                , score.getName(), score.getKor(), score.getEng(), score.getMath(), score.getTotal(), score.getAverage());

        return resultNum == 1;
    }

    @Override
    public List<Score> viewAll() {
        String sql = "SELECT * FROM score";
        List<Score> scoreList = jdbcTemplate.query(sql, new RowMapper<Score>() {
            @Override
            public Score mapRow(ResultSet rs, int rowNum) throws SQLException {
                return new Score(rs);
            }
        });

        return scoreList;
    }

    @Override
    public Score viewOne(int stuNum) {
        String sql = "SELECT * FROM score WHERE stu_num=?";
        /* 1)
        List<Score> scoreList = jdbcTemplate.query(sql, new RowMapper<Score>() {
                    @Override
                    public Score mapRow(ResultSet rs, int rowNum) throws SQLException {
                        return new Score(rs);
                    }
                }
                , stuNum);
        return scoreList.get(0);
        */

        // 1)을 한줄로 =>
//        List<Score> scoreList = jdbcTemplate.query(sql, (rs, rowNum) -> new Score(rs), stuNum);
//        return scoreList.get(0);

        //2) 한 데이터만 가져올 때 (queryForObject)
        return jdbcTemplate.queryForObject(sql, (rs, rowNum) -> new Score(rs), stuNum);

    }

    @Override
    public boolean delete(int stuNum) {
        return false;
    }
}
