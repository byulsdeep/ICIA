<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>::: TwoEX ::: 주문 완료 </title>
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

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Raleway:ital,wght@0,800;1,900&display=swap" rel="stylesheet">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@900&display=swap" rel="stylesheet">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Exo:wght@800;900&display=swap" rel="stylesheet">

    
    <!-- JS, CSS 연결 --------------------------------------------------------------------------------------------------->
    <link rel="stylesheet" href="res/css/style.css" />
    <link rel="stylesheet" href="res/css/header.css" />
    <link rel="stylesheet" href="res/css/orderCompletePage.css">
    <script src="res/js/main.js"></script>
    <script src="res/js/main_LSE.js"></script>
    <script src="res/js/common_LSE.js"></script>
    <script src="res/js/header.js" async></script>  
    <!-- <script src="res\js\categoryPage_LSE.js"></script>-->   
    <!-- 스타일 ---------------------------------------------------------------------------------------------------------->
    <style>
    /*font-family: 'Russo One', sans-serif;  -- 400 */
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
    </style>
    
    
<!-- 스크립트 ----------------------------------------------------------------------------------------------------->
<script>
  function init(){
    /* 세션 확인 */
    postAjaxJson("isSession", null, "isSessionCallBack");

    /* 구매한 상품 정보 */
    let json_pb = JSON.parse('${jsonOrderInfo}');
    makeOrderDetail(json_pb);
  }

  function isSessionCallBack(ajaxData) {
          if(ajaxData != null) {
              accessInfo = JSON.parse(ajaxData);
              makeHeader(accessInfo);
          }
  }
  function makeOrderDetail(json_pb){
      let buyerImage = document.getElementById("buyerImage");
        buyerImage.src = json_pb.odtBuyProfile; 

        /*
      var x = document.createElement("IMG");
      x.setAttribute("src", json_pb.odtBuyProfile);
      document.body.appendChild(x);
      buyerImage.appendChild(x);
        */
      
      /* 구매자 정보들 */
      let buyerName= document.getElementById("buyerName");
        buyerName.innerText = json_pb.odtBuyNickname;
      
        //buyerName.innerText = bname;
      
      let buyerEmail= document.getElementById("buyerEmail");
        buyerEmail.innerText = json_pb.odtBuyEmail;
        
        //buyerEmail.innerText = email;
        
      /* 상품 정보들 */
        let prdName= document.getElementById("prdName");
        prdName.innerText = json_pb.odtPrdName;
          //prdName.innerText= pName;
          
        let prdPrice= document.getElementById("prdPrice");           
        prdPrice.innerText= json_pb.odtPrdPrice;
        //let price = json_pb.odtPrdPrice;
            
      /* 주문 정보들 */
      let ordDate= document.getElementById("ordDate");        
      ordDate.innerText= json_pb.odtDate;
      
      let totalPrice= document.getElementById("totalPrice");
        totalPrice.innerText= json_pb.odtPrdPrice;
  }
  
  function moveOrderHistory(){
    //alert("moveOrderHistory 함수");

    if(accessInfo != null){
      if(accessInfo.userType == "buyer"){
        let form = document.createElement('form');
        //alert(form);
        
        form.method="POST";
        form.action="moveOrderHistory"
        document.body.appendChild(form);
        form.submit()
      }else{
        alert("구매자로 로그인해주세요.");
      }
    }else{
      alert("구매자로 로그인해주세요.");
    }
}

  function createFormInput(name, value){
    let input = document.createElement('input');
    input.setAttribute('type', 'hidden');
    input.setAttribute('name', name);
    input.setAttribute('value', value);
    return input;
  }
    
    </script>
  </head>
  <body onload="init()">
    <!-- [Navbar] --------------------------------------------------------------------->
    <nav id="navbar">
      <div class="navbar__upper">
        <div class="navbar__logo" onclick="showChat()">
          <i class="fa-solid fa-arrow-right-arrow-left"></i>
          <span class="title" onClick="moveMainPage()">Two EX</span>
          <span class="subtitle">Experts Exchange</span>
        </div>
        <div class="header__right">
            <input class="header__search" type="text" placeholder="  상품을 검색하세요.">
            <!-- 헤더 navbar 메뉴 버튼-->
            <ul class="navbar__menu">
              <li class="navbar__menu__item login" data-link="login" onclick="loginDiv()">로그인</li>
                    <!-- [ 로그인 모달 ] ******************************-->
                      <div class="loginDiv__wrapper">
                        <div class="loginDiv__container">
                          <div class="loginDIv__title">
                            <h4>로그인 선택</h4>
                          </div>
                        <!-- <input type="button" class="subLoginBtn buyerLogin" value="구매자 로그인" onclick="logInKakao()">-->
                          <div class="subLoginBtn buyerLogin" onclick="logInKakao()">구매자 로그인</div>
                          <input type="button" class="subLoginBtn sellerLogin" value="판매자 로그인" onclick="logInSeller()">
                        </div>
                      </div>
              <li class="navbar__menu__item join" data-link="join" onclick="moveJoin()">회원가입</li>
            </ul>
        </div>
      </div>
    </nav> <!-- [Navbar] 끝 -->
    <section id="common__zone">
      <div id="common__wrapper orderCompletePage">
        <div class="orderComplete__content__zone">
          <h1>결제 완료 내역</h1>
          <h3>             
            결제가 정상적으로 완료되었습니다.
          </h3>
          <!-- 2. 결과 Zone -->
          <div class="orderComplete__wrapper">
            <div class="buyerInfo__container">
                <h2>구매자 정보</h2>
                <div class="buyInfo__div">
                    <div class="buyerInfo__image__div">
                        <img id="buyerImage" src="img_640x640.jpg"/>
                    </div>
                    <div class="buyInfo__detail">
                        <div class="info_detail_div">
                            <span class="info__label">이름 : </span>
                            <span class="info__span1" id="buyerName">이름영역</span>
                        </div>
                        <div class="info_detail_div" >
                            <span class="info__label">이메일 : </span>
                            <span class="info__span2" id="buyerEmail">이메일영역</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="productInfo__container">
                <h2>구매상품 정보</h2>
                <div class="productInfo__div">
                    <div class="prodcutInfo__image__div" >
                      <!--<img src="${getPrdImg}"/>-->
                      <img id="prdImage" src="${getPrdImg}">
                    </div>
                    <div class="productInfo__detail">
                        <div class="info_detail_div" >
                            <span class="info__label">상품이름 : </span>
                            <span class="info__span3" id="prdName">상품이름영역</span>
                        </div>
                        <div class="info_detail_div">
                            <span class="info__label">상품가격 : </span>
                            <span>
                              <span class="info__span4" id="prdPrice">상품가격영역</span>
                              <span class="info__won">원</span>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="paymentInfo__container">
                <h2>결제 정보</h2>
                <div class="payment__div" >
                    <div class="" >
                        <span>
                            <span class="info__label">결제완료 시간 : </span>
                            <span id="ordDate" class="info__time">시간영역</span>
                        </span>
                    </div>
                    <div class="" >    
                        <span>
                            <span class="info__label">총 결제금액 : </span>
                            <span>
                                <span id="totalPrice" class="info__amount">결제금액영역</span>
                                <span class="info__won">원</span>
                            </span>
                        </span>
                    </div>
                </div>
            </div>
            <div class="moveOrderList">
              <input class="content__btn moveOrderList" 
              type="button" value="주문 목록으로 이동"
              onClick="moveOrderHistory()">
            </div>
          </div>
        
        </div><!--content__zone 끝-->
      </div>
    </section>
  </body>
</html>

