<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>write</title>
    <style>
        textarea {
            margin: 20px 0px;
        }
    </style>
</head>

<body>

    <form action="/board/test1?text=GETGETGET" method="get">
        <button type="submit">GET</button>
    </form>

    <form action="/board/test2" method="post">
        <label>
            <input type="text" name="text">
        </label>
        <button type="submit">POST</button>
    </form>


</body>

</html>