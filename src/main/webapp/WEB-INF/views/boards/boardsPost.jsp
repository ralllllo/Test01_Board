<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
     <script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

    <style>

        *{
            box-sizing: border-box;
        }
        .title{
            text-align: center;
            font-size: xx-large;
            font-weight: 700;
        }
        .body>div{
            border-top: 1px solid rgb(201, 201, 201);
            border-bottom: 1px solid rgb(201, 201, 201);
            display: flex;
            align-items: center;
        }
        .postTitle>span{
            font-weight: bold;
            background-color: rgb(235, 234, 234);
            height: 50px;
            width: 10%;
            line-height: 50px;
           
        }
        .writer>span{
            font-weight: bold;
            background-color: rgb(235, 234, 234);
            height: 50px;
            width: 10%;
            line-height: 50px;
        }
        .attachment>span{
            font-weight: bold;
            background-color: rgb(235, 234, 234);
            height: 50px;
            width: 10%;
            line-height: 50px;
        }
        .content>span{
            font-weight: bold;
            background-color: rgb(235, 234, 234);
            height: 500px;
            width: 10%;
            line-height: 500px;
        }
        .btns>span{
            font-weight: bold;
            
        }
        .btns{
            text-align: center;
        }
    </style>
    </head>
<body>
    <div class="title">
        글쓰기
    </div>
    <form action="/boards/postUpload" method="post" enctype="multipart/form-data">
    <div class="body">
        <div class="writer"><span>작성자</span><input type="text" name="writer" value="${loginId}" style="width: 90%; height: 30px;" readonly></div>
        <div class="postTitle"><span>제목</span><input type="text" name="title" placeholder="제목을 입력하세요" style="width: 90%; height: 30px; padding : 0px"></div>
        <div class="content"><span>내용</span><input type="text" name="contents" style="width: 90%; height :480px" placeholder="내용을 입력하세요"></div>
    </div>
    <div class="btns">
        <button>등록</button> 
        <a href="/boards/list?cPage="${cPage}><input type="button" value="취소"></a>
    </div>
    </form>
</body>
</html>