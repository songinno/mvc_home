package com.spring.mvc.controller;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.List;

@Setter @Getter @ToString
public class Pet {
    private String pet;
    private int age;
    private String master;
    private String gender;
//    private String[] hobby; // List로 해도 o (List가 더 좋은듯)
    //근데 배열 방 크기 지정안했는데, checkbox로 선택한것들이 숫자에 맞춰서 알아서 들어가져서 잘 나옴.
    private List<String> hobby;
}
