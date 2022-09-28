<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="res/js/header.js" defer></script>
<script>
function masterInsert() {
	document.getElementById("masterInsert").submit();	
}
function masterLogIn() {
	document.getElementById("masterLogIn").submit();	
}
</script>
</head>
<body onload="isSuccess()">
	<section>
		<form action="masterInsert" method="post" id="masterInsert">
			<input name="buyCode" placeholder="buyCode" ><br>
			<input name="buyEmail" placeholder="buyEmail" value="fakeEmail"><br>
			<input name="buyAge" placeholder="buyAge" ><br>
			<select name="buyGender">
				<option value="F">여</option>
				<option value="M">남</option>
			</select><br>
			<select name="buyRegion">
				<option value="서울특별시">서울특별시</option>
				<option value="부산광역시">부산광역시</option>
				<option value="인천광역시">인천광역시</option>
				<option value="대구광역시">대구광역시</option>
				<option value="광주광역시">광주광역시</option>
				<option value="대전광역시">대전광역시</option>
				<option value="울산광역시">울산광역시</option>
				<option value="세종특별자치시">세종특별자치시</option>
				<option value="경기도">경기도</option>
				<option value="강원도">강원도</option>
				<option value="충청북도">충청북도</option>
				<option value="충청남도">충청남도</option>
				<option value="경상북도">경상북도</option>
				<option value="경상남도">경상남도</option>
				<option value="전라북도">전라북도</option>
				<option value="전라남도">전라남도</option>
				<option value="제주특별자치도">제주특별자치도</option>
			</select><br>
			<input name="buyNickname" placeholder="buyNickname" value="fakeNickname"><br>
			<input name="buyProfile" placeholder="buyProfile" value="http://k.kakaocdn.net/dn/dpk9l1/btqmGhA2lKL/Oz0wDuJn1YV2DIn92f6DVK/img_640x640.jpg"><br>
			<button onClick="masterInsert()">INSERT</button>
		</form>
	</section>
	<section>
		<form action="masterLogIn" method="post" id="masterLogIn">
			<input name="buyCode" placeholder="buyCode"><br>
			<button onClick="masterLogIn()">LOGIN</button>
		</form>
	</section>
	<section>
	${isSuccess}
	</section>
	<button onClick="moveMainPage()">MAIN PAGE</button>
	<nav id="navbar"></nav>
</body>
</html>