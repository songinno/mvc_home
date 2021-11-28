package com.spring.mvc.score.repository;

import com.spring.mvc.score.domain.Score;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
@Repository("msr")
@Log4j2
public class MemoryScoreRepository  implements ScoreRepository{

    //저장소
    Map<Integer, Score> scoreMap = new HashMap<>();

    public MemoryScoreRepository() {
        scoreMap.put(1, new Score("고길동", 70, 80, 90));
        scoreMap.put(2, new Score("나라비", 30, 20, 40));
        scoreMap.put(3, new Score("다람쥐", 100, 100, 90));
        scoreMap.put(4, new Score("라디오", 65, 70, 30));
    }

    @Override
    public boolean save(Score score) {
        scoreMap.put(score.getStuNum(), score);
        return true;
    }

    @Override
    public List<Score> viewAll() {
        ArrayList<Score> scoreList = new ArrayList<>();
        for (Integer keys : scoreMap.keySet()) {
            Score score = scoreMap.get(keys);
            scoreList.add(score);
        }
        return scoreList;
    }

    @Override
    public Score viewOne(int stuNum) {
        return scoreMap.get(stuNum);
    }

    @Override
    public boolean delete(int stuNum) {
        scoreMap.remove(stuNum);
        return true;
    }
}
