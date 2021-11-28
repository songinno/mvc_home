package com.spring.mvc.score.repository;

import com.spring.mvc.score.domain.Score;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
@Mapper
public interface ScoreMapper {

    //학생 성적 저장
    boolean save(Score score);

    //전체 성적 조회
    List<Score> viewAll();

    //상세 정보 조회
    Score viewOne(int stuNum);

    //학생 성적 삭제
    boolean delete(int stuNum);

}
