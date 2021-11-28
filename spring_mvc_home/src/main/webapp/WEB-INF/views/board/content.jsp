<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <%@ include file="../include/static-head.jsp" %>

    <style>
        .content-container {
            width: 60%;
            margin: 150px auto;
            position: relative;
        }

        .content-container .main-title {
            font-size: 24px;
            font-weight: 700;
            text-align: center;
            border-bottom: 2px solid rgb(75, 73, 73);
            padding: 0 20px 15px;
            width: fit-content;
            margin: 20px auto 30px;
        }

        .content-container .main-content {
            border: 2px solid #ccc;
            border-radius: 20px;
            padding: 10px 25px;
            font-size: 1.1em;
            text-align: justify;
            min-height: 400px;
        }

        .content-container .bottom-group {
            padding-left: 400px;
            display: flex;
            /* background: blue; */
            text-align: center;
            
        }

        .content-container .bottom-group .custom-btn-group {
            
            /* position: absolute;
            bottom: -10%;
            left: 50%;
            transform: translateX(-50%); */
        }
        .content-container .bottom-group .modify-date {
            /* background: yellow; */
            margin-left: 150px;
            font-size: 0.8em;
        }
    </style>
</head>

<body>

    <div class="wrap">
        <%@ include file="../include/header.jsp" %>

        <div class="content-container">

            <h1 class="main-title">${b.boardNo}번 게시물</h1>

            <div class="mb-3">
                <label for="exampleFormControlInput1" class="form-label">작성자</label>
                <input type="text" class="form-control" id="exampleFormControlInput1" placeholder="이름" name="writer"
                    value="${b.writer}" disabled>
            </div>
            <div class="mb-3">
                <label for="exampleFormControlInput2" class="form-label">글제목</label>
                <input type="text" class="form-control" id="exampleFormControlInput2" placeholder="제목" name="title"
                    value="${b.title}" disabled>
            </div>
            <div class="mb-3">
                <label for="exampleFormControlTextarea1" class="form-label">내용</label>

                <p class="main-content">
                    ${b.content}
                </p>

            </div>


            <div class="bottom-group">
                <div class="btn-group btn-group-lg custom-btn-group" role="group" >
                    <a href="/board/modify?boardNo=${b.boardNo}&writer=${b.writer}">
                        <button id="go-modify" type="button" class="btn btn-warning">
                            수정
                        </button>
                    </a>
                    <a class="del-btn" href="/board/delete?boardNo=${b.boardNo}">
                        <button type="button" class="btn btn-danger">
                            삭제
                        </button>
                    </a>
                    <a href="/board/list">
                        <button id="go-list" type="button" class="btn btn-dark">
                            목록
                        </button>
                    </a>
                </div>

                <div class="modify-date">
                    <p>마지막 수정 시간: <fmt:formatDate value="${b.modifyDate}" pattern="yyyy년 MM월 dd일 a hh:mm" /></p>
                </div>
            </div>

            

        </div>


        <%@ include file="../include/footer.jsp" %>

        
    </div>

    <script>
        //진짜 삭제할거냐고 물어보기
        const $delBtn = document.querySelector('.del-btn');
        $delBtn.addEventListener('click', e=>{
            console.log('클릭이벤트 발동');
            e.preventDefault();

            if(confirm('정말로 삭제하시겠습니까?')) {
                // location.href = e.target.getAttribute('href'); // 이건 왜 안되지
                location.href = '/board/delete?boardNo=${b.boardNo}';
            } else {
                return;
            }
        });
    </script>

    
</body>

</html>