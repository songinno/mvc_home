package com.spring.mvc.score.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.sql.ResultSet;
import java.sql.SQLException;

@Getter @Setter @ToString
public class Score {
    //자체 데이터
    private String name; // 이름
    private int kor;
    private int eng;
    private int math;

    //자동생성 데이터
    private int stuNum;
    private static int seq;
    private int total; // 총점
    private double average; //평균

    private Grade grade;

    private String markName;

    public Score() {
        System.out.println("Score객체 생성!");
        this.stuNum = ++seq;
    }

    public Score(String name, int kor, int eng, int math) {
        this();
        this.name = name;
        this.kor = kor;
        this.eng = eng;
        this.math = math;
        calculate();
        mark();
    }

    public void calculate() {
        this.total = kor + eng + math;
        this.average = total / 3;
    }

    //이름에 마킹처리하기
    public String mark() {
        String name = this.name;
        char firstName = name.charAt(0);
        this.markName = String.valueOf(firstName);

        for (int i = name.length()-1; i > 0; i--) {
            this.markName += "*";
        }
        return this.markName;
    }

    // *** JdbcScoreRepository 생성자 (spring, mapper 모두에서 쓰임.
    public Score(ResultSet rs) throws SQLException {
        this.stuNum = rs.getInt("stu_num");
        this.name = rs.getString("stu_name");
        this.kor = rs.getInt("kor");
        this.eng = rs.getInt("eng");
        this.math = rs.getInt("math");
        this.total = rs.getInt("total");
        this.average = rs.getDouble("average");
    }
}
