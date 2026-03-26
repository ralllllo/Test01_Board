<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="//t1.kakaocdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	
	<style>
		*{box-sizing: border-box;}
		
		#container{
			border: 1px solid skyblue;
			border-radius: 10px;
			text-align: center;
			position : relative;
			margin: auto;
			width: 500px;
			height: 430px;
		}
		
		#head{
			border: 1px solid skyblue;
			border-radius: 10px;
			text-align: center;
			color: white;
			background-color: skyblue;
			width:100%;
			height: 8%;
		}
		
		#bigbox{
			position: absolute;
			top: 25px;
			left: 1px;
		}
		
		#bigbox *{
			margin: 5px;
		}
	</style>
</head>
<body>
	<div id="container">
		<div id="head">회원 가입 정보 입력</div>
		<form action="/members/joinUpdate" id="frm">
		<div id="bigbox">
			<div>ID<input id="id" name="id" type="text" placeholder="아이디를 입력하세요"><input id="dup1" type="button" value="중복 확인"><br></div>
			<div id="idCheck" class="idCheck"></div>
			<div>PW<input id="pw" name="pw" type="password" placeholder="비밀번호를 입력하세요"><br></div>
			<div>PW 확인<input id="pwc" name="pwc" type="password" placeholder="비밀번호를 다시 입력하세요"><br></div>
            <div id="checkbox" class="checkbox"></div>
			<div>이름<input id="name" name="name" type="text" placeholder="이름을 입력하세요"><br></div>
			<div>전화번호<input id="phone" name="phone" type="text" placeholder="전화번호를 입력하세요"><br></div>
			<div>이메일<input type="text" name="email" placeholder="이메일을 입력하세요"><br></div>
			<div>우편번호<input id="zipcode" name="zipcode" type="text" placeholder="우편번호"><input id="search" type="button" value="찾기"></div>
			<div>주소<input id="address1" name="address1" type="text" placeholder="주소를 입력하세요"><br></div>
			<div>상세주소<input id="address2" name="address2" type="text" placeholder="상세주소를 입력하세요"><br></div>
			<input type="submit" value="회원가입">
		</div>
		</form>
	</div>
	

    <script>
    	$("#dup1").on("click", function() {
    		
    		$.ajax({
				url:"/members/Duplicate", 
				data: {id : $("#id").val()} 
			}).done(function(resp){ 
				console.log(resp); 
				
				resp = JSON.parse(resp);
				if(resp == true){
					$("#idCheck").html("아이디가 중복 되었습니다.")
				}
				else {
					$("#idCheck").html("아이디 사용이 가능합니다.")
				}
			}); 
    	});

        pw.onkeyup = function (e) {
            console.log(e.key);
        }

        pwc.onkeyup = function (e) {
            console.log(e.key);

            if (pw.value == pwc.value) {
                checkbox.innerHTML = "패스워드가 일치 합니다.";
            }
            else if (!(pw.value == pwc.value)) {
                checkbox.innerHTML = "패스워드가 일치하지 않습니다.";
            }
        }
        
        document.getElementById("frm").onsubmit = function() {
        	
        	let id = document.getElementById("id");
    		let pw = document.getElementById("pw");
    		let pwc = document.getElementById("pwc");
            let checkbox = document.getElementById("checkbox");
            let name = document.getElementById("name");
            let phone = document.getElementById("phone");
            let search = document.getElementById("search");
	
        if(!id.value) {
            alert("아이디를 입력해주세요.");
            return false;
        }

		let regex1 = /^[\w!@#$%^&*]{8,16}$/; 
		let result = regex1.test(pw.value);

		if (!pw.value) {
            alert("비밀번호를 입력하세요.");
            return false;
        }
        else if(result == false){
            alert("비밀번호를 정규식을 다시 확인해주세요.");
            return false;
        }
        else if (pw.value !== pwc.value) {
            alert("비밀번호가 일치하지 않습니다.");
            return false;
        }
	
        if(!name.value) {
            alert("이름을 입력해주세요.");
            return false;
        }

        if(!phone.value) {
            alert("전화번호를 입력해주세요.");
            return false;
        }
      }
        search.onclick = function() {
            new kakao.Postcode({
                oncomplete: function (data) {
                    document.getElementById("zipcode").value = data.zonecode;
                    document.getElementById("address1").value = data.roadAddress;
            }
                }).open();
        }
	</script>
</body>
</html>