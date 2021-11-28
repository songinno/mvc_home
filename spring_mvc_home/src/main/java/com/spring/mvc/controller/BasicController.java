package com.spring.mvc.controller;

import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Arrays;

//역할: 브라우저의 요청을 처리
@Controller
@Log4j2 //로그를 만들어주는 기능
public class BasicController {

//    @RequestMapping(value = "/req/hello", method = RequestMethod.GET)
    //이걸 간단하게 @GetMapping("") 으로 가능.
    @GetMapping("/req/hello")
    public String hello() {
        //비니니스 로직
        System.out.println("안녕안녕~ hello hello");
        return "req_ex/hello2";
    }
    /////////////////////////////////////
    @GetMapping("/req/v1")
    public String v1() {
        return "req_ex/v1";
    }

    //1. HttpServletRequest 객체 활용
    @PostMapping("/req/v2")
    public String v2Post(HttpServletRequest request, Model model) {
        String petName = request.getParameter("pet");
        String petAge = request.getParameter("age");
        int ageNum = Integer.parseInt(petAge);

        model.addAttribute("petName", petName);
        model.addAttribute("petAge", ageNum);

        log.info("펫 이름: " + petName);
        log.info("나이: " + ageNum);
        return "req_ex/result";
    }

    //2. @RequestParam
    @PostMapping("/req/v3")
    public String v3(@RequestParam("pet") String pet123, int age, Model model) {
        model.addAttribute("petName", pet123);
        model.addAttribute("petAge", age);
        return "req_ex/result";
    }

    //3. 클래스 활용
    @PostMapping("/req/v4")
    public String v4(Pet petInfo, Model model) {
        //1) 일일이 다쓰기 (불편함)
//        model.addAttribute("petName", petInfo.getPet());
//        model.addAttribute("petAge", petInfo.getAge());
//        model.addAttribute("masterName", petInfo.getMaster());
//        model.addAttribute("gender", petInfo.getGender());
//        model.addAttribute("hobby", Arrays.toString(petInfo.getHobby()));

        //2)
        model.addAttribute("p", petInfo); // 이렇게 쓰고, jsp에서 작성.

        //(근데 배열 방 크기 지정안했는데, checkbox로 선택한것들이 숫자에 맞춰서 알아서 들어가져서 잘 나옴.)
        //그리고 jsp파일 ${} 안에 p.getName 이라고 안하고, p.name 이라고 해도 o (private 적용이 안되는 것 같음)

        return "req_ex/result";
    }

    //form(method=get)의 action에  input값을 직접 입력(/?tex=xxx)하는 것은 안됨...
    @GetMapping("/board/test")
    public String t() {
        return "test/test";
    }

    @GetMapping("/board/test1")
    public String test1(String text, Model model) {
        model.addAttribute("text" ,text);
        return "test/testResult";
    }





}