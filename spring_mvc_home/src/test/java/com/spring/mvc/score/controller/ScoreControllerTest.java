package com.spring.mvc.score.controller;

import static org.junit.jupiter.api.Assertions.*;

class ScoreControllerTest {

    public static void main(String[] args) {

        String name = "오승환";
        String name2 = String.valueOf(name.charAt(0));

//        System.out.println(name.charAt(0));
        for (int i = name.length()-1; i > 0; i--) {
            String c = String.valueOf(name.charAt(i));
            c = "*";
            name2 += c;
        }
        System.out.println("name2 = " + name2);
        System.out.println("================================");
        String name1 = "오승환";
        String markName = String.valueOf(name1.charAt(0));

        for (int i = name1.length()-1; i > 0; i--) {
            markName += "*";
        }
        System.out.println("markName = " + markName);


    }


}