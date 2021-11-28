package com.spring.mvc.board.repository;

import com.spring.mvc.board.domain.Board;
import com.spring.mvc.board.dto.ModBoard;
import com.spring.mvc.board.service.BoardService;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
class BoardMapperTest {

    @Autowired BoardService boardService;

    @Test
    @DisplayName("게시물 등록 테스트.")
    void register() {
//        Board b1 = Board.builder().writer("성영모").title("왜안되는거냐").content("ㅡㅡㅡㅡㅡㅡ").build();
//        boardService.write(b1);
    }

    @Test
    @DisplayName("게시물 목록을 다 끄집어 내와야함.")
    void getList() {
        List<Board> boardList = boardService.getList();
        for (Board board : boardList) {
            System.out.println(board);
        }
    }

    @Test
    @DisplayName("게시글 번호를 받아, 그 게시글 번호의 상세 정보들을 뽑아내야함.")
    void getContent() {
//        Board board = boardService.get(3L);
//        System.out.println(board);

    }

    @Test
    @DisplayName("게시글 번호를 받아, 그 게시글 삭제")
    void delete() {
        boardService.kill(3L);

    }

    @Test
    @DisplayName("게시글 정보를 모두 받아, 글을 수정")
    void modify() {
        ModBoard mb1 = new ModBoard();
        mb1.setBoardNo(2L);
        //
        mb1.setTitle("글 제목 수정합니다22.");
        mb1.setContent("글 내용을 수정합니다22.");
        System.out.println(mb1);
        boolean change = boardService.change(mb1);
        System.out.println(change);


    }

}