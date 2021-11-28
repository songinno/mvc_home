package com.spring.mvc.board.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class ModBoard {

    //수정시 필요한 필드만 생성함.

    private Long boardNo; // * 그런데 얘는 sql에서 수정할때 이거 없으면, 전체 수정돼서 있어야함.(where에 써야함.)
//    private String writer; // 얜 고정이라 필요없음
    private String title;
    private String content;

    private int viewCount;

}
