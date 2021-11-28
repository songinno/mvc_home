<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<%@ include file="../include/static-head.jsp" %>

<style>
        .modify-container {
            width: 60%;
            margin: 150px auto;
            position: relative;
        }

        .modify-container .main-title {
            font-size: 24px;
            font-weight: 700;
            text-align: center;
            border-bottom: 2px solid rgb(75, 73, 73);
            padding: 0 20px 15px;
            width: fit-content;
            margin: 20px auto 30px;
        }

        .modify-container .main-content {
            border: 2px solid #ccc;
            border-radius: 20px;
            padding: 10px 25px;
            font-size: 1.1em;
            text-align: justify;
            min-height: 400px;
        }

        .modify-container .custom-btn-group {
            position: absolute;
            bottom: -10%;
            left: 50%;
            transform: translateX(-50%);
        }
</style>
</head>

<body>
    <div class="wrap">
        <%@ include file="../include/header.jsp" %>

        <div class="modify-container">

            <h1 class="main-title">${b.boardNo}번 글수정</h1>
            

            <form action="/board/modify" method="post" autocomplete="off">

                <div class="mb-3">
                    <label for="exampleFormControlInput2" class="form-label">글제목</label>
                    <input type="text" class="form-control" id="exampleFormControlInput2" value="${b.title}" name="title">
                </div>
                <div class="mb-3">
                    <label for="exampleFormControlTextarea1" class="form-label">내용</label>
                    <textarea name="content" class="form-control" id="exampleFormControlTextarea1" rows="10">${b.content}</textarea>
                </div>


                <input type="hidden" name="boardNo" value="${b.boardNo}">

                <div class="d-grid gap-2">
                    <button id="update-btn" class="btn btn-dark" type="submit">수정완료</button>
                    <button id="to-list" class="btn btn-warning" type="button">취소</button>
                </div>

            </form>

        </div>

        <%@ include file="../include/footer.jsp" %>


        
    </div>


    <script>
        //수정완료버튼 이벤트
        const $updateBtn = document.getElementById('update-btn');
        $updateBtn.onclick = e => {
            alert('수정이 완료되었습니다.');
        };

        //목록버튼 이벤트
        const $toList = document.getElementById('to-list');
        $toList.onclick = e => {
            location.href = '/board/list';
        };

    </script>

</body>

</html>