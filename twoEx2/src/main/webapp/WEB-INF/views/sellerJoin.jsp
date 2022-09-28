<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>::: TwoEX ::: 교환 플랫폼 </title>
    <!-- 기타 meta 정보 -->
      <meta
        name="mainPage"
        content="TwoEx site"
      />
      <meta name="author" content="TwoEX" />
      <link rel="icon" type="image/png" href="" />
   
    <!-- LOGO, FONT SOURCE-->
      <script src="https://kit.fontawesome.com/1066a57f0b.js" crossorigin="anonymous"></script>
      <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600;700&family=Russo+One&display=swap" 
      rel="stylesheet">

    <!-- JS, CSS 연결 -->
       <link rel="stylesheet" href="res/css/style.css" />
       <link rel="stylesheet" href="res/css/header.css" />
       <link rel="stylesheet" href="res/css/sellerJoin.css" />
      <script src="res/js/main.js"></script>
      <script src="res/js/header.js"></script>
    <!-- 스크립트 영역-->
      <script>
      let isCheckSelCode;

	function regMember(){
		if(isCheckSelCode == 'checked') {
			const form = document.getElementsByName("reg")[0];
			form.action = "insertSeller";
			form.method = "post";
			
			let selPassword = document.getElementsByName("selPassword")[0];
			if(!isFormat(selPassword.value, true)) {
				alert('대소문자, 숫자, 특수문자를 3개 이상 사용해주세요');
				selPassword.focus();
				return;			
			} 
			if(!isCharLength(selPassword.value, 4, 20)) {
				alert('비밀번호는 4자리에서 20자리까지 써주세요');
				selPassword.focus();
				return;				
			}
			form.submit();
		} else {
			alert('아이디 중복 확인을 해주세요');
		}
	}
	
	function checkSelCode() {
		let selCode = document.getElementsByName("selCode")[0];
		if(!isCharLength(selCode.value, 1, 20)) {
			alert('아이디는 최대 20자리까지입니다');
			selCode.focus();
			return;
		}
		postAjaxJson('checkSelCode', 'selCode=' + selCode.value, 'checkSelCodeCallBack');
	}
	
	function checkSelCodeCallBack(ajaxData) {
		if (ajaxData == 'good') {
			alert('사용 가능한 아이디입니다');
			isCheckSelCode = 'checked';
			let selCode = document.getElementsByName("selCode")[0];
			selCode.setAttribute("readOnly", true);
		} else {
			alert('사용 할수 없는 아이디입니다');
		}
	}
	
	function reEnterSelCode() {
		let selCode = document.getElementsByName("selCode")[0];
		selCode.removeAttribute('readonly');
		selCode.value = "";
		selCode.focus();
	}
</script>
  </head>
  <body id="joinPage__body">
    <!-- [ Join ] -->
    <section id="join__title__section">
      <div class="joinPage__logo"><div class="joinPage__logo">
        <span class="joinPage__twoEx" onclick="moveMainPage()"> <i class="fa-solid fa-arrow-right-arrow-left joinPage"></i> Two EX</span>
        <span class="joinPage__expertsExchange">Experts Exchange</span>
      </div>
    </section>
    <section id="join__section">
        <div class="join__container">
      	    <h2 class="join__title">판매자 회원가입</h2><br>
            <form name="reg">
                <div class="join__item__div joinId">
                    <div class="item__name">
                        아이디 : 
                    </div>
                    <input class="item__input sellseId" type="text" id="id" name="selCode" onfocus="this.placeholder=''" onblur="this.placeholder='아이디는 최대 20자리까지입니다'" placeholder="아이디는 최대 20자리까지입니다."/>
                    <input type="button" class="content__btn btn__small checkSelCode" onClick="checkSelCode()" value="중복확인"/>
                    <input type="button" class="content__btn btn__small reEnter" onClick="reEnterSelCode()" value="재입력"/>
                </div>
                <div class="join__item__div joinPassword">
                    <div class="item__name">
                        비밀번호 : 
                    </div>
                    <input class="item__input sellsePassword" id="password"type="password" name="selPassword" placeholder="대소문자, 숫자, 특수문자를 3개 이상 사용해주세요"/>
                </div>
                <div class="join__item__div joinNickname">
                    <div class="item__name">
                        닉네임 : 
                    </div>
                    <input class="item__input sellseNickname" id="Nickname"type="text" name="selNickname"  placeholder="닉네임을 써주세요"/>
                </div>
                <div class="join__item__div joinShopName">
                    <div class="item__name">
                        샵 이름 : 
                    </div>
                    <input class="item__input sellseShopName" type="text" id="ShopName" name="selShopName" placeholder="매장이름을 써주세요"/>
                </div>
                <div class="join__item__div joinProfile">
                    <div class="item__name">
                        샵 소개 : 
                    </div>
                    <input class="item__input sellseProfile"  type="text" id="Profile" name="selProfile" placeholder="매장소개를 써주세요"/>
                </div>
                <div class="join__item__div joinEmail">
                    <div class="item__name">
                    이메일 : 
                    </div>
                    <input class="item__input sellseEmail" type="text" id="Email" name="selEmail" placeholder="이메일을 써주세요"/>
                </div>
            </form>
            <input type="button" class="content__btn btn__blueGreen large" onClick="regMember()" value="회원가입"/> 
        </div>
   </section>
   <section id="section__bottom">

   </section>


  
    <!-- [ Footer ] 
    <section id="footer_section" class="section">
      <h1 class="footer__title">Let's talk</h1>
      <h2 class="footer__contact__email">admin@twoex.com</h2>
      <div class="footer__contact__links">
      </div>
      <p class="footer__description">
        (주)투엑스 인천시 미추홀구 학인동, 5층대표 : 안뇽 개인정보관리책임자 : 안뇽 사업자등록번호 : 123-45-67890
        <br>
        통신판매업신고 : 2018-인천미추홀-1234 유료직업소개사업등록번호 : 제2022-12345-12-1-00012호 고객센터 : 1544-6254 help@twoex.com
        <br>
        (주)투엑스는 통신판매중개자이며, 통신판매의 당사자가 아닙니다. 상품, 상품정보, 거래에 관한 의무와 책임은 판매회원에게 있습니다.
        <br>
        (주)투엑스 사이트의 상품/판매회원/중개 서비스/거래 정보, 콘텐츠, UI 등에 대한 무단복제, 전송, 배포, 스크래핑 등의 행위는 저작권법, 콘텐츠산업 진흥법 등 관련법령에 의하여 엄격히 금지됩니다.
      </p>
      <p class="footer__contact__rights">
        </br>
        Copyright © 2022 twoEx Inc. All rights reserved.
      </p>
    </section>
-->
    <!-- Arrow up -->
    <button class="arrow-up">
      <i class="fas fa-arrow-up"></i>
    </button>
  </body>
</html>