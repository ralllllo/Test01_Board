<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

	<style>
		* {
			box-sizing: border-box;
		}
		
		#container {
			border: 1px solid skyblue;
			border-radius: 10px;
			margin: auto;
			width: 500px;
			height: 350px;
		}
		
		#header {
			border: 1px solid skyblue;
			border-radius: 10px;
			font-size: 18px;
			text-align: center;
			color: white;
			background-color: skyblue;
			width: 100%;
			height: 10%;
		}
		
		#box *{
			margin: 5px;
			text-align: left;
		}
		
		#successBtn{
			display: none;
		}
		</style>
</head>
<body>
	<div id="container">
		<div id="header">My page</div>
		<form action="/members/update">
			<div id="box">
				<div id="id">아이디 : ${mypage[0].id}</div>
				<div id="name">이름 : ${mypage[0].name}</div>
				<div>전화번호 : <input name="phone" class="phone" id="phone" type="text" value="${mypage[0].phone}" readonly></div>
				<div>이메일 주소 : <input name="email" class="email" id="email" type="text" value="${mypage[0].email}" readonly></div>
				<div>우편번호 : <input name="zipcode" class="zipcode" id="zipcode" type="text" value="${mypage[0].zipcode}" readonly></div>
				<div>주소 : <input name="address1" class="address1" id="address1" type="text" value="${mypage[0].address1}" readonly></div>
				<div>상세 주소 : <input name="address2" class="address2" id="address2" type="text" value="${mypage[0].address2}" readonly></div>
				<div id="date">가입 날짜 : ${mypage[0].join_date}</div>
				<input id="editBtn" type="button" value="수정하기">
				<input id="successBtn" type="submit" value="수정완료"><a href="/members/updateBack"><input type="button" value="뒤로가기"></a>
			</form>
			</div>
		</div>
	<script>
		$("#editBtn").on("click", function(){ // 칸 지우기
			$(".phone").attr("readonly",false);
			$(".email").attr("readonly",false);
			$(".zipcode").attr("readonly",false);
			$(".address1").attr("readonly",false);
			$(".address2").attr("readonly",false);
		});
        
        $("#editBtn").on("click", function(){ // 버튼 바꾸기
			$("#editBtn").css({"display" : "none"});
			$("#successBtn").css({"display" : "inline"});
		});
        
        
	</script>
</body>
</html>