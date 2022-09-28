<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="kor">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>TwoEX ::: 교환 플랫폼 </title>
    <meta
      name="description"
      content=""  
    />
    <meta name="author" content="" />
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


	<!-- CSS, JS 연결 ---------------------------------------------------------------------->
    <link rel="stylesheet" href="res/css/style.css" />
    <link rel="stylesheet" href="res/css/header.css" />
    <link rel="stylesheet" href="res/css/productInfoPage.css" />
    
    <script src="res/js/header.js" async></script>  
    <script src="res/js/main.js" async></script>
    <script src="res/js/main_LSE.js" async></script>
    <script src="res/js/myPage.js" defer></script> 
    <!-- <script src="res/js/productInfoPage_LSE.js" async></script>-->

    <!-- 스크립트 영역 -------------------------------------------------------------------------->
   <script>
    let selCode;
    
    function init() {   	
        postAjaxJson("isSession", null, "isSessionCallBack");
    }     
    function isSessionCallBack(ajaxData) {
  	  if(ajaxData != null) {
      	  accessInfo = JSON.parse(ajaxData);
      	  makeHeader(accessInfo);
          if(accessInfo != null) {
          	if(accessInfo.userType = "seller") {
          		selCode = accessInfo.selCode;
          	}
          }
  	  }
    }
    
  //구매하기
    function executeOrder(){     	
    	 
    	  	let prdCode = '${product.prdCode}';
    	  	let prdSelCode = '${product.prdSelCode}';
    	  	let prdPrice = '${product.prdPrice}';
    	  	let prdName ='${product.prdName}';
    		let prdCteCode = '${product.prdCteCode}';
    		let prdType = '${product.prdType}';
    		
    		
    		
         let form = document.getElementsByName("clientData")[0];
         form.action="kakaopay";
         form.method="post";
         form.appendChild(createHidden("prdCode",prdCode));
         form.appendChild(createHidden("prdSelCode",prdSelCode));
         form.appendChild(createHidden("prdPrice",prdPrice));
         form.appendChild(createHidden("prdName",prdName));
         form.appendChild(createHidden("prdCteCode",prdCteCode));
         form.appendChild(createHidden("prdType",prdType));
         
         form.submit();
    }
  

    function createHidden(objName, value){
    	let input = document.createElement("input");
    	input.setAttribute("type", "hidden");
    	if(objName != null) input.setAttribute("name", objName);
    	if(value != null) input.setAttribute("value", value);
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
            <!-- Toggle button 향후 사용 예비버튼-->
            <button class="navbar__toggle-btn">
              <i class="fas fa-bars"></i>
            </button>
        </div>
      </div>
    </nav> <!-- [Navbar] 끝 -->
    <!--- [ contentZone ] --------------------------------------------------------------------->
    <main id="common__zone">
      <div id="common__wrapper">
        <section class="product__info__zone">
          <div class="product__info title">
            <div id="prdName" class="productInfo product__name">${product.prdName}</div>
          </div>
          <div class="product__info photo">
            <img class="product__info img" src="imgs\product__sample.jpg">
          </div>
          <div class="product__info option">
            <span>
                <span>타입 :</span>
                <span class="option prdType"></span>
            </span>
            <span>
                <span>시작일 :    ${product.prdStartDate}</span>
                <span class="option prdStartDate"></span>
            </span>
            <span>
                <span>종료일 : ${product.prdEndDate}</span>
                <span class="option prdEndDate"></span>
            </span>
          </div> 
          <div class="product__info description">
                 <div class="orderInfo payOption__container">
                    <h3>결제 옵션</h3>
                    <div class="payOption__div">
                        <input type="radio">카카오페이</input> 
                        <input type="radio">무통장입금</input>  
                        <input type="radio">계좌이체</input> 
                    </div>
               </div>
          </div>
        </section>
        <section class="other__Info__zone">
          <div class="other__info seller">
            <div class="seller__blank">
            
            </div>
            <div class="seller__info">
              <div class="seller__title">
                <div  class="productInfo sellerShop__name">${product.selShopName}</div>
              </div>
              <div  class="productInfo sellerNick__name">${product.selNickname}</div>
              <div class="seller__info__btnDiv">
                
              </div>
            </div>
          </div>
          <div class="other__info price">
            <div class="payInfo__container">
                    <div class="payInfo price__div">
                        <span>총 서비스 금액 : </span>
                        <div>${product.prdPrice}</div>원
                    </div>
                    <div class="payInfo price__div">
                        <span>포인트 : </span>
                        <div>0</div>
                    </div>
                    <div class="payInfo price__div">
                        <span>쿠폰 </span>
                        <div>0</div>
                    </div>
                    <div class="payInfo payAmount__div">
                        <span>총 결제 금액 : </span>
                          <div id="prdPrice">${product.prdPrice}</div>원
                    </div>
                    <div class="payInfo price__btnDiv">
                        <input class="content__btn btn__purchase order" type="button" value="결제 하기" onClick="executeOrder()">
                    </div>
                </div>
          </div>
        </section>
      </div>    
    </main>
     <form name = "clientData" ></form> 
  </body>
</html>



