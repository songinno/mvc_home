<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
</head>

<body>
    <h1>result.jsp입니다.</h1>
    <!-- 1. HttpServletRequest -->
    <!-- 2. @RequestParam -->
    <h2>나의 펫은 ${p.pet}이고,</h2>
    <h2>${p.pet}의 나이는 ${p.age}입니다.</h2>
    <!-- 3. 클래스 -->
    <p>
        <!-- 
        1) 
        주인 이름은 ${masterName} 이고,
        성별은 ${gender},
        취미는 ${hobby} 입니다. ㅎㅎ -->
        2)
        주인 이름은 ${p.master},
        성별은 ${p.gender}, <br>
        취미는

        <c:forEach var="h" items="${p.hobby}">
            <li>${h}</li>
        </c:forEach>
        <!-- 반복문 c:forEach -->
        <!-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> -> 반복문 쓰려고 적어놓은거. -->

        입니다.


    </p>


</body>

</html>