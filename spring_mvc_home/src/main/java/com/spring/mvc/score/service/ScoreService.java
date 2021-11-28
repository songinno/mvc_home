package com.spring.mvc.score.service;

import com.spring.mvc.score.domain.Grade;
import com.spring.mvc.score.domain.Score;
import com.spring.mvc.score.repository.JdbcScoreRepository;
import com.spring.mvc.score.repository.ScoreMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ScoreService {

    private final ScoreMapper scoreMapper;


    //성적 등록 중간처리
    public boolean register(Score score) {
        score.calculate();
        scoreMapper.save(score);
        // !!! 계산 먼저 하고, 저장하라고 시켜야함 (메모리저장소에서는 괜찮은데, db에서 계산 안된 상태로 등록됨)
        return true;
    }

    //전체 성적 조회 중간처리
    public List<Score> all() {
        List<Score> scores = scoreMapper.viewAll();
        for (Score score : scores) {
            score.mark();
        }
        return scores;
    }

    //상세조회 중간처리
    public Score one(int stuNum) {
        Score one = scoreMapper.viewOne(stuNum);
        if (one.getAverage() >= 90) {
            one.setGrade(Grade.A);
        } else if (one.getAverage() >= 80) {
            one.setGrade(Grade.B);
        } else  if (one.getAverage() >= 70) {
            one.setGrade(Grade.C);
        } else if (one.getAverage() >= 60) {
            one.setGrade(Grade.D);
        } else {
            one.setGrade(Grade.F);
        }
        return one;
    }

    //점수 삭제 중간처리
    public boolean del(int stuNum) {
        scoreMapper.delete(stuNum);
        return true;
    }



}
