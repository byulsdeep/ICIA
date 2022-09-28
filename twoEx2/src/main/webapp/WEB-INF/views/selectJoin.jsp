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
   
     
    <!-- JS, CSS 연결 -->
    <link rel="stylesheet" href="res/css/style.css" />
    <link rel="stylesheet" href="res/css/selectJoin.css" />
    <script src="res/js/main.js"></script>
    <script src="res/js/header.js"></script>
    <!-- 스크립트 영역 시작-->
    <script>
      function joinSeller(){
        const form = document.createElement("form");
        form.action = "moveSellerJoin";
        form.method = "post";
        document.body.appendChild(form);
        form.submit();
      }
      </script>
    <!-- LOGO, FONT SOURCE-->
        <script src="https://kit.fontawesome.com/1066a57f0b.js" crossorigin="anonymous"></script>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600;700&family=Russo+One&display=swap" 
        rel="stylesheet">

        <style>
          /** 로고1 오리지날
          font-family: 'Russo One', sans-serif;  -- 400 */
          @import url('https://fonts.googleapis.com/css2?family=Russo+One&display=swap');
          
          /** 로고2 대안
          font-family: 'Orbitron', sans-serif; weight 800, 900 */
          @import url('https://fonts.googleapis.com/css2?family=Orbitron:wght@800;900&display=swap');
          
          /** 로고3
            font-family: 'Exo', sans-serif;  */
          @import url('https://fonts.googleapis.com/css2?family=Exo:wght@800;900&display=swap'); 
          
          /** 본문1
          font-family: 'Noto Sans KR', sans-serif;  --- 300, 400, 700 */
          @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;700&display=swap');
          
          /** 본문2
          font-family: 'Spoqa Han Sans Neo', 'sans-serif';*/
          @import url('https://spoqa.github.io/spoqa-han-sans/css/SpoqaHanSans-kr.css');

          .kakao__image{
            height: 70px;
            width: 350px;
            background: url('res/imgs/kakao__join.png') center/cover no-repeat;
            display:inline-block;
          }
        </style>
  </head>
  <body id="joinPage__body">
    <!-- [ Join ] -->
    <section id="join__title__section">
      <div class="joinPage__logo">
        <span class="joinPage__twoEx" onclick="moveMainPage()"> <i class="fa-solid fa-arrow-right-arrow-left JoinPage"></i> Two EX</span>
        <span class="joinPage__expertsExchange">Experts Exchange</span>
      </div>
    </section>
    <section id="join__section">
      <div class="join__container">
        <div class="join__description__div">
            <h2 class="join__title">반갑습니다. <br> 회원가입 페이지입니다.</h2>
            <h4 class="join_description">원하는 회원가입 종류를 선택하세요.</h4>
        </div>
        <div class="join__btn__kakao" onclick="location.href='/kakaoLogIn'">
          <div class="kakao__image"></div>
        </div>
        <input class="join__btn__seller" type="button" value="판매자로 가입" onClick="joinSeller()">
      </div>
    </section>
    
    <!--<input class="joinBtn large buyer" type="button" value="구매자 카카오톡으로 간편 가입">  -->
    <!-- <img class="join__btn__kakao__img" src=""/> -->
    <!--
      <a href="/kakaoLogIn" class="join__btn__kakao__a" type="button" value="구매자 카카오톡으로 간편 가입">
      </a>
    -->


  
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