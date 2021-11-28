package com.spring.mvc.score.controller;

import com.spring.mvc.score.domain.Score;
import com.spring.mvc.score.service.ScoreService;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.List;

@Controller
@Log4j2
public class ScoreController {

    private final ScoreService scoreService;

    public ScoreController(ScoreService scoreService) {
        this.scoreService = scoreService;
    }

    //성적 목록 화면
    @GetMapping("/score/list")
    public String list(Model model) {
        log.info("/score/list GET! ");
        List<Score> scoreList = scoreService.all();
        model.addAttribute("score", scoreList);
        return "score/score-list";
    }
    @PostMapping("/score/list")
    public String listPost(Score score) {
        log.info("/score/list POST! -> " + score);
        scoreService.register(score);
        return "redirect:/score/list";
    }

    //성적 상세조회 화면
    @GetMapping("/score/detail")
    public String detail(int stuNum, Model model) {
        log.info("/score/detail GET! -> " + stuNum);
        Score score = scoreService.one(stuNum);
        model.addAttribute("s", score);

        return "score/detail";
    }

    //삭제
    @GetMapping("/score/delete")
    public String kill(int stuNum) {
        log.info("/score/delete GET! -> " + stuNum);
        scoreService.del(stuNum);

        return "redirect:/score/list";
    }

}
