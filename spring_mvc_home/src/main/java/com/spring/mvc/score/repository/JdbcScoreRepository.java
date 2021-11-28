package com.spring.mvc.score.repository;

import com.spring.mvc.score.domain.Score;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Repository;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
@Repository("jsr")
@Log4j2
public class JdbcScoreRepository implements ScoreRepository{

    //DB 접속 정보 설정
    private String id = "spring4";
    private String pw = "1234";
    private String url = "jdbc:oracle:thin:@localhost:1521:xe";
    private String driver = "oracle.jdbc.driver.OracleDriver";

    @Override
    public boolean save(Score score) {
        try (Connection conn = DriverManager.getConnection(url, id, pw)){
            //1.드라이버 커넥터 동적 로딩
            Class.forName(driver);
            //2.연결정보 생성
//            Connection conn = DriverManager.getConnection(url, id, pw);
            //3. SQL실행
            String sql = "INSERT INTO score VALUES (seq_score.nextval,?,?,?,?,?,?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            //4. ?값 채우기
            pstmt.setString(1, score.getName());
            pstmt.setInt(2, score.getKor());
            pstmt.setInt(3, score.getEng());
            pstmt.setInt(4, score.getMath());
            pstmt.setInt(5, score.getTotal());
            pstmt.setDouble(6,score.getAverage());

            //5. SQL실행 명령령
            return pstmt.executeUpdate() == 1;

        } catch (Exception e) {
            System.out.println("DB연결 실패");
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<Score> viewAll() {
        List<Score> scoreList = new ArrayList<>();
        try(Connection conn = DriverManager.getConnection(url, id, pw)) {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            System.out.println("DB연결 성공! = " + conn);
            //3.SQL 실행하기
            String sql = "SELECT * FROM score";
            //PreparedStatement: SQL실행 객체
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                //***Score 클래스 -> 새로운 생성자 생성
                scoreList.add(new Score(rs));
            }
            return scoreList;

        } catch (Exception e) {
            System.out.println("DB연결 실패!!");
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public Score viewOne(int stuNum) {
        try(Connection conn = DriverManager.getConnection(url, id, pw)) {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            System.out.println("DB연결 성공! = " + conn);
            String sql = "SELECT * FROM score WHERE stu_num=" + stuNum ;
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return new Score(rs);
            }
        } catch (Exception e) {
            System.out.println("DB연결 실패!!");
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean delete(int stuNum) {
        try(Connection conn = DriverManager.getConnection(url, id, pw)) {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            System.out.println("DB연결 성공! = " + conn);
            String sql = "DELETE FROM score WHERE stu_num=" + stuNum ;
            PreparedStatement pstmt = conn.prepareStatement(sql);
            int resultNum = pstmt.executeUpdate();
            if (resultNum == 1) {
                return true;
            }
        } catch (Exception e) {
            System.out.println("DB연결 실패!!");
            e.printStackTrace();
        }
        return false;
    }
}
