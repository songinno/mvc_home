package com.spring.mvc.board.service;

import com.spring.mvc.board.domain.Board;
import com.spring.mvc.board.dto.ModBoard;
import com.spring.mvc.board.repository.BoardMapper;
import com.spring.mvc.board.repository.BoardRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@Log4j2
@RequiredArgsConstructor
public class BoardService {

    public final BoardMapper boardMapper;


    //게시물 목록 중간처리
    public List<Board> getList() {
        List<Board> articles = boardMapper.getArticles();
        //역정렬
//        List<Board> sortedList = new ArrayList<>();
//        for (int i = articles.size() - 1; i >= 0 ; i--) {
//            sortedList.add(articles.get(i));
//        }
//        return sortedList;
        return articles;
    }

    //글쓰기 중간처리
    public boolean write(Board board) {

        return boardMapper.insert(board);
    }

    //상세조회 중간처리
    public Board get(Long boardNo) {
        boardMapper.viewCountUp(boardNo);
        Board content = boardMapper.getContent(boardNo);

        return content;
    }

    //삭제 중간처리
    public boolean kill(Long boardNo) {
        boardMapper.delete(boardNo);
        return true;
    }

    //++수정 중간처리
    //파라미터 ModBoard로 수정함.
    public boolean change(ModBoard board) {
        return boardMapper.update(board);
    }

    //단일 게시글 조회 (게시글번호로만)
    public Board getOne(Long boardNo) {
        return boardMapper.getContent(boardNo);
    }


}
