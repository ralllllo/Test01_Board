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
        .body div{
             padding: 10px 20px;
        }
        .colName{
            background-color: rgb(235, 234, 234);
            display: flex;
        }
        .colName span{
            font-weight: bold;
            text-align: center;
        }
        .colName>.span1{
            width: 10%;
            text-align: left;
        }
        .colName>.span2{
            width: 50%;
            
        }
        .colName>.span3{
            width:15%;
        }
        .colName>.span4{
            width: 15%;
        }
        .colName>.span5{
            width: 10%;
            text-align: right;
        }
        .list{
            border-top: 1px solid rgb(235, 234, 234);
            border-bottom: 1px solid rgb(235, 234, 234);
            text-align: center;
            display : flex;
        }
        
        .list span{
            font-weight: bold;
        }
        .list>.span6{
            width: 10%;
            text-align: left;
        }
        .list>.span7{
            width: 50%;
            
        }
        .list>.span8{
            width:15%;
        }
        .list>.span9{
            width: 15%;
        }
        .list>.span10{
            width: 10%;
            text-align: right;
        }
        
        .post{
            border-bottom: 1px solid rgb(235, 234, 234);
            text-align: right;
        }
        .pageNum{
            border-bottom: 1px solid rgb(235, 234, 234);
            text-align: center;
        }
        .pageNum a{
        	margin : 5px
        }
    </style>
</head>
<body>
    <div class="title">
        회원게시판
    </div>
    <div class="body">
        <div class="colName">
            <span class="span1">글번호</span>
            <span class="span2">제목</span>
            <span class="span3">작성자</span>
            <span class="span4">작성일</span>
            <span class="span5">조회수</span>
        </div>
        <c:choose>
        	<c:when test="${not empty list}">
       		<c:forEach var="i" items="${list}">
       		<div class="list">
            <span class="span6">${i.seq}</span>
            <span class="span7"><a href="/boards/detail?seq=${i.seq}" class="link">${i.title}</a></span>
            <span class="span8">${i.writer}</span>
            <span class="span9">${i.write_date}</span>
            <span class="span10">${i.view_count}</span>
        		</div>
       		</c:forEach>
       		</c:when>
       		<c:otherwise>
       			<div class="list">
       				글 없음
       			</div>
       		</c:otherwise>
    	</c:choose>
      	  
        
        <div class="post"><a href="/boards/toBoardPost"><input type="button" value="글쓰기"></a><a href="/"><input type="button" value="돌아가기"></a></div>
        <div class="pageNum">
        
        </div>
    </div>
    
    <script>
    	let recordTotalCount =${recordTotalCount};
    	let recordCountPerPage = ${recordCountPerPage};
    	let naviCountPerPage = ${naviCountPerPage};
    	let currentPage = ${cPage};
    	let pageTotalCount =0;
    	//정수와 실수를 구분하지 않음
    	let startNavi = Math.floor((currentPage - 1)/ naviCountPerPage) * naviCountPerPage + 1;
    	let endNavi = startNavi + naviCountPerPage - 1;
    	
    	if(recordTotalCount%recordCountPerPage>0){
    		pageTotalCount = Math.floor(recordTotalCount/recordCountPerPage)+1;
    	}else{
    		pageTotalCount = Math.floor(recordTotalCount/recordCountPerPage);
    	}
    	// pageTotalCount = Math.ceil(recordTotalCount/recordCountPerPage);
 		
    	if(endNavi > pageTotalCount){
    		endNavi = pageTotalCount;
    	}
    	console.log(startNavi);
    	console.log(endNavi);
    	
    	console.log(pageTotalCount);
    	let needPrev =true;
    	let needNext =true;
    	
    	if(startNavi==1){needPrev=false}
    	if(endNavi==pageTotalCount){needNext=false}
    	
    	if(needPrev){
    		let prev = $("<a>");
    		prev.attr("href","/board/list?cPage="+(startNavi-1));
    		prev.html("<<");
    		$(".pageNum").append(prev);
    	}
    	
    	for(let i = startNavi ;i <= endNavi ;i++){
    		let navi = $("<a>");
    		navi.attr("href","/board/list?cPage="+i);
    		navi.html(i);
    		$(".pageNum").append(navi);
    	}
    	
    	if(needNext){
    		let next = $("<a>");
    		next.attr("href","/board/list?cPage="+(endNavi+1));
    		next.html(">>");
    		$(".pageNum").append(next);
    	}
    </script>
</body>
</html>