<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script
	src="//t1.kakaocdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>


<style>
* {
	box-sizing: border-box;
}

.container {
	border: 1px solid black;
	border-radius: 7px;
	width: 600px;
	height: 250px;
	text-align: center;
	margin: auto;
}

.Name {
	float: left;
	
	margin-left: 80px;
}

.upBox {
	width: 100%;
	height: 25%;
	text-align: center;
	font-weight: bold;
	font-size: 20px;
	margin-top: 10px;
}

.midBox {
	width: 100%;
	height: 45%;
	margin-top: -5px;
}

.midBox>div {
	margin-left: 70px;
}

.downBox {
	width: 100%;
	height: 20%;
	margin-top: -7px;
}

#textId {
	margin-left: 28px;
}

#textPw {
	margin-left: 14px;
}

body {
	font-family: "Open Sans", -apple-system, BlinkMacSystemFont, "Segoe UI",
		Roboto, Oxygen-Sans, Ubuntu, Cantarell, "Helvetica Neue", Helvetica,
		Arial, sans-serif;
}
</style>


</head>

<body>

	<c:choose>
		<c:when test="${loginId == null}">

			<form action="/members/login" method="post">
				<div class="container">

					<div class="upBox">Login Box</div>

					<div class="midBox">

						<div class="midUp">
							<div class="Name" id="id">
								아이디 <input type="text" placeholder="ID" id="textId" name="id">
							</div>

						</div>
						
						<br>
						<br>

						<div class="midDown">
							<div class="Name" id="name">
								비밀번호 <input type="password" placeholder="PW" id="textPw" name="pw">
							</div>

						</div>

					</div>

					<div class="downBox">
						<button class="loginBtn">로그인</button>
						<a href="/members/join"><input type="button" value="회원가입"
							class="loginBtn"></a>
					</div>

				</div>
			</form>


		</c:when>
		<c:otherwise>


			<table border="1" align="center">

				<tr>
					<th colspan="4">${loginId}님환영합니다.</th>
				</tr>

				<tr>
					<td><a href="/boards/list?cPage=1"><input type="button"
							value="게시판으로" id="noticeBoard"></a></td>
							
					<td><a href="/members/myPage"><input type="button"
							value="마이페이지" id="myPage"></a></td>
							
					<td><a href="/members/logout"><input type="button"
							value="로그아웃"></a></td>
							
					<td><input type="button" value="회원탈퇴" id="deleteAccountBtn"></td>
				</tr>


			</table>


		</c:otherwise>
	</c:choose>

	<script>
	
		$("#deleteAccountBtn").on("click",function(){
		
			    Swal.fire({
			        title: "정말 탈퇴하시겠습니까?",
			        text: "탈퇴 후에는 정보를 복구할 수 없습니다!",
			        icon: "warning",
			        showCancelButton: true,
			        confirmButtonColor: "#d33",   // 탈퇴 버튼은 빨간색으로
			        cancelButtonColor: "#3085d6",  // 취소 버튼은 파란색으로
			        confirmButtonText: "회원탈퇴",
			        cancelButtonText: "취소",
			        reverseButtons: true // 버튼 순서 반전 (취소-확인 순서)
			    }).then((result) => {
			        if (result.isConfirmed) {
			            // 1. 확인을 눌렀을 때 바로 서버로 전송
			            // 2. 서버(Controller)에서 탈퇴 처리 후 index로 보낼 때 알림을 띄우는 게 정석입니다.
			            location.href = "/members/deleteAccount";
			        } else if (result.dismiss === Swal.DismissReason.cancel) {
			            Swal.fire({
			                title: "취소됨",
			                text: "탈퇴 요청이 취소되었습니다.",
			                icon: "error"
			            });
			        }
			    });
			

		});
		
		
	</script>



</body>
</html>