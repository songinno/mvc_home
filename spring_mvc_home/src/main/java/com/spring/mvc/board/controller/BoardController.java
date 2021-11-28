package com.spring.mvc.board.controller;

import com.spring.mvc.board.domain.Board;
import com.spring.mvc.board.dto.ModBoard;
import com.spring.mvc.board.service.BoardService;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@Log4j2
@RequestMapping("/board")
public class  BoardController {

    /**
     * 게시물 목록요청: /board/list: GET
     * 게시물 상세조회요청: /board/content: GET
     * 게시글 쓰기 화면요청: /board/write: GET
     * 게시글 등록요청: /board/write: POST
     * 게시글 삭제요청: /board/delete: GET
     * 게시글 수정화면요청: /board/modify: GET
     * 게시글 수정요청: /board/modify: POST
     */
    private final BoardService boardService;

    @Autowired
    public BoardController(BoardService boardService) {
        this.boardService = boardService;
    }

    //게시판 화면요청
    @GetMapping("/list")
    public String list(Model model) {
        log.info("/board/list GET!! ");
        List<Board> boardList = boardService.getList();
        log.info(boardList);
        model.addAttribute("articles", boardList);
        return "board/list";
    }

    //글쓰기 화면요청
    @GetMapping("/write")
    public String write() {
        log.info("/board/write GET!");
        return "board/write";
    }

    //글쓰기 등록요청
    @PostMapping("/write")
    public String write(Board board) {
        log.info("/board/write POST! " + board);
        boardService.write(board);
        return "redirect:/board/list";
    }

    //상세조회 요청
    // /board/content?boardNo=3
    @GetMapping("/content")
    public String content(Long boardNo, Model model) {
        log.info("/board/content GET! - " + boardNo);
        Board board = boardService.get(boardNo);
        log.info("board - " + board);
        model.addAttribute("b", board);
        return "board/content";
    }

    //++삭제 요청
    @GetMapping("/delete")
    public String delete(Long boardNo) {
        log.info("/board/delete GET! -> " + boardNo);
        boardService.kill(boardNo);
        return "redirect:/board/list";
    }

    //++수정 요청
    @GetMapping("/modify")
    public String modify(Long boardNo, Model model) { // GetMapping에서도 파라미터를 board로 받으면 안됨.
        //파라미터가 Board면 그냥 객체 하나 생성되는거임.
        log.info("/board/modify GET! -> " + boardNo);

        Board board = boardService.getOne(boardNo);
        model.addAttribute("b", board);
        return "board/modify";
    }

    //ModBoard이용
    //->인터페이스, 메모리레퍼지토리, 서비스 수정
    @PostMapping("/modify")
    public String modifyPost(ModBoard board) {
        boardService.change(board);
        return "redirect:/board/list";
//        return "redirect:/board/content?boardNo=" + board.getBoardNo();
        //원래는 이거로 했는데, 이렇게하면 수정할때마다 조회수가 늘어나서, 그냥 list로 돌아가게함... 방법이 있으려나
    }


}
