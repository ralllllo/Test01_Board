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
		#container {
			border: 1px solid black;
			width: 170px;
			height: 100px;
		}
	</style>
</head>
<body>
	<c:choose>
		<c:when test="${dup}">
			중복된 ID 입니다.
			<input id="btn" type="button" value="Close">
			<script>
				let btn = document.getElementById("btn"); // if문을 붙이지 않으면 '중복된 ID 입니다'만 확인하고 끝나버리기 때문에 하나씩 조건을 부여한다.
				
				btn.onclick = function() {
					opener.document.getElementById("id").value="" // 팝업창에서 회원가입창을 부르는 객체 -> 중복된 아이디라서 사용이 불가능하니까 id창을 빈칸으로 만들어주기
					window.close();
				}
			</script>
		</c:when>
		<c:otherwise>
			사용 가능한 ID 입니다. 사용 하시겠습니까?
			<input id="close" type="button" value="닫기">
			<script>
				let close = document.getElementById("close");
			
				close.onclick = function() {
					opener.document.getElementById("id").value=""
					// 부모창(회원가입 화면)의 id 입력칸을 비움
					// opener : 팝업을 열었던 부모 창
					// true : 중복된 아이디, false : 사용 가능한 아이디
					window.close();
				}
			</script>
			
			<input id="use" type="button" value="사용">
			<script>
				let use = document.getElementById("use");
				use.onclick = function() {
					window.close();
			}
			</script>
		</c:otherwise>
	</c:choose>
</body>
</html>