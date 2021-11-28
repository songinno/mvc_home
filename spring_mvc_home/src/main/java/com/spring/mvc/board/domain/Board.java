package com.spring.mvc.board.domain;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;

@Setter @Getter @ToString
//@Builder
public class Board {

    private Long boardNo; //글번호
    private String writer; //작성자
    private String title; //글제목
    private String content; //글내용

    private Date regDate; // 작성일자
    private Date modifyDate; // 수정일자
    private int viewCount; // 조회수


    private static long seq;

    public Board() {
        this.boardNo = ++seq;
    }

    public Board(String writer, String title, String content) {
        this();
        this.writer = writer;
        this.title = title;
        this.content = content;
    }
    //????)글작성 @PostMapping시 오류 발생.  Field error in object 'board' on field 'viewCount': rejected value [null];~~~ (db에 기본값 0으로 뒀는데, null로 받아들임)
    //@Builder 없애고 생성자 살리니깐 오류 안남.

}
