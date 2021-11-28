package com.spring.mvc;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class JDBCBasicCRUD {

    //DB 접속 정보 설정
    private String id = "spring4";
    private String pw = "1234";
    private String url = "jdbc:oracle:thin:@localhost:1521:xe";
    private String driver = "oracle.jdbc.driver.OracleDriver";

    @Test
    @DisplayName("product 데이터 생성")
    void insertTest() {

        try (Connection conn = DriverManager.getConnection(url, id, pw)){
            //1.드라이버 커넥터 동적 로딩
            Class.forName(driver);
            //2.연결정보 생성
//            Connection conn = DriverManager.getConnection(url, id, pw);
            //3. SQL실행
            String sql = "INSERT INTO product VALUES (seq_product.nextval, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            //4. ?값 채우기
            pstmt.setString(1, "스타일러");
            pstmt.setInt(2, 5000000);

            //5. SQL실행 명령령
           int resultNum = pstmt.executeUpdate();
            if (resultNum == 1) {
                System.out.println("입력 성공!");
            }
            Assertions.assertTrue(resultNum == 1);

        } catch (Exception e) {
            System.out.println("DB연결 실패");
            e.printStackTrace();
        }

    }//end insert

    @Test
    @DisplayName("product 데이터 수정")
    void updateTest() {

        try (Connection conn = DriverManager.getConnection(url, id, pw)){
            //1.드라이버 커넥터 동적 로딩
            Class.forName(driver);
            //2.연결정보 생성
//            Connection conn = DriverManager.getConnection(url, id, pw);
            //3. SQL실행
            String sql = "UPDATE product SET product_name=?, product_price=? WHERE product_id=?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            //4. ?값 채우기
            pstmt.setString(1, "테레비_fix");
            pstmt.setInt(2, 2000000);
            pstmt.setInt(3, 2);

            //5. SQL실행 명령령
            int resultNum = pstmt.executeUpdate();
            if (resultNum == 1) {
                System.out.println("입력 성공!");
            }
            Assertions.assertTrue(resultNum == 1);

        } catch (Exception e) {
            System.out.println("DB연결 실패");
            e.printStackTrace();
        }

    }//end update

    @Test
    @DisplayName("product 데이터 삭제")
    void deleteTest() {

        try (Connection conn = DriverManager.getConnection(url, id, pw)){
            //1.드라이버 커넥터 동적 로딩
            Class.forName(driver);
            //2.연결정보 생성
//            Connection conn = DriverManager.getConnection(url, id, pw);
            //3. SQL실행
            String sql = "DELETE FROM product WHERE product_id=?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            //4. ?값 채우기
            pstmt.setInt(1,3);

            //5. SQL실행 명령령
            int resultNum = pstmt.executeUpdate();
            if (resultNum == 1) {
                System.out.println("입력 성공!");
            }
            Assertions.assertTrue(resultNum == 1);

        } catch (Exception e) {
            System.out.println("DB연결 실패");
            e.printStackTrace();
        }

    }//end delete

}
