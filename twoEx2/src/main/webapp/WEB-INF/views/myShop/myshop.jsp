<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
  <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>::: TwoEX ::: 교환 플랫폼 </title>
    <!-- 기타 meta 정보 -->
      <meta name="mainPage" content="TwoEx site">
      <meta name="author" content="TwoEX">
      <link rel="icon" type="image/png" href="">
   
   
   <!-- CSS 영역 ------------------------------>
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
    </style>
   
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

    
    <!-- JS, CSS 연결 -->
    
    
    
      <link rel="stylesheet" href="res/css/style.css">
           <link rel="stylesheet" href="res/css/header.css" />
           <link rel="stylesheet" href="res/css/myShop.css" />
           <link rel="stylesheet" href="res/css/sellerShopPage.css" />
        
      <script src="res/js/main.js" defer=""></script>
      <script src="res/js/header.js" defer></script>  
      <script src="res/js/myShop.js" defer></script>
      <script src="res/js/classroomManagement.js" defer></script>
      <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
        <script>
        let selCode;
        
        function init() {   	
            postAjaxJson("isSession", null, "isSessionCallBack");
            
            //상품등록
            if("${message}" != null && "${message}" != ""){
            alert('${message}');
            }
            
            //상품수정
            if("${message1}" != null && "${message1}" != ""){
            alert('${message1}');
            }
            
            //전문분야 등록
            if("${message2}" != null && "${message2}" != ""){
            alert('${message2}');
            }

            makeSellerInfo();
            
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
           
       
        
        function makeSellerInfo(){
        	let selShopName = '${sellerInfoBean.selShopName}';
            let selNickname ='${sellerInfoBean.selNickname}';
            let selEmail = '${sellerInfoBean.selEmail}';
            let selProfile ='${sellerInfoBean.selProfile}';

          /*
          let sellerInfo__shopName = document.querySelector(".sellerInfo__shopName").innerText = selShopName;
          let sellerInfo__sellerNickname = document.querySelector(".sellerInfo__sellerNickname").innerText = selNickname;
          let seller__profile__div = document.querySelector(".seller__profile__div").innerText = selProfile;
          let sellerInfo__sellerEmail = document.querySelector(".sellerInfo__sellerEmail").innerText = selEmail;
          */

          document.querySelector(".sellerInfo__shopName").innerText = selShopName;
          document.querySelector(".sellerInfo__sellerNickname").innerText = selNickname;
          document.querySelector(".seller__profile__div").innerText = selProfile;
          document.querySelector(".sellerInfo__sellerEmail").innerText = selEmail;

        }  

            //모달창 띄우기
            function showModal(){         	
           	 const modal = document.querySelector(".modal__wrapper");
           	 const modalbody = document.querySelector(".modal__body");
				
            	modal.style.display="block";
             }
            
            //모달창 닫기
              function closeModal(){
                const DOM__modal__wrapper = document.querySelector(".modal__wrapper");
                DOM__modal__wrapper.style.display="none";
              }
    	
            //강한별: header.js에 중복
            function createHidden(objName, value){
              	let input = document.createElement("input");
              	input.setAttribute("type", "hidden");
              	input.setAttribute("name", objName);
              	input.setAttribute("value", value);
              	
              	return input;
              }
            
           
            //판매자 전문분야 등록(선택된 체크박스값 불러옴 ->한개선택 인서트 가능,다중인서트 완성해야됨)
            function regCte(){     	
            	 let form = document.getElementsByName("insCte")[0];
                 form.action="regCte";
                 form.method="post";
            	 var obj = [];
            	 obj = document.getElementsByName("prdCteCode");         	  		
                 for (var i=0; i<obj.length; i++) {
                     if (document.getElementsByName("prdCteCode")[i].checked == true) {
                         //alert(document.getElementsByName("prdCteCode")[i].value); 
                         //form.appendChild(createHidden("prdCteCode",document.getElementsByName("prdCteCode")[i].value))
             				}
                 	} 
             	 form.appendChild(createHidden("prdSelCode",accessInfo.selCode));
             	 console.log(form);
                form.submit();
            }
            
          
            
          
          function classroom(prdCode,prdSelCode,prdCteCode){     	
				  let form = document.getElementsByName("clientData")[0];
                 form.action="moveDashboard";
                 form.method="post";
                 form.appendChild(createHidden("claPrdCode",prdCode));
                 form.appendChild(createHidden("claSelCode",prdSelCode));
                 form.appendChild(createHidden("claCteCode",prdCteCode));               
                 form.submit();
            }
            
         
        	function changeBtnCss(obj, cname) { //이벤트가 발생한 요소를넘겨줌
        		obj.className = cname;
        	}

          function clickProduct(event){
            let classroomBtn = document.querySelector(".more");
            if(event.target === classroomBtn){
              
            }
          }


          	
      	function moveStatistics(){
			let prdSelCode= accessInfo.selCode;
    		const form = document.getElementsByName("clientData")[0];
    		form.action = "moveStatistics";
    		form.method = "post";
    		form.appendChild(createHidden("prdSelCode",prdSelCode));
    		form.submit();
      	}

        
    </script><!-- 스크립트의 끝 -->
    <style>
	 #prdList{
	 	float: left;
	    margin:10% 5px 5px 10px;
	    border: 3px solid #ffffff; 	
        }
        
        
      .colorSelect{
      color: rgb(210,220,255);
      color: rgb(244,246,149);
      color: rgb(255,199,168);
      color: rgb(217,209,255);
      color: rgb(198,225,254);
      color: rgb(255,176,216);
      }
        
</style>     
    </head>
<body onLoad="init()">
    <!-- [Navbar] --------------------------------------------------------------------->
    <nav id="navbar">
      <div class="navbar__upper">
        <div class="navbar__logo" onclick="showChat()">
          <i class="fa-solid fa-arrow-right-arrow-left"></i>
          <span class="title" onClick="moveMainPage()">Two EX</span>
          <span class="subtitle">Experts Exchange</span>
        </div>
        <div class="header__right">
          <!-- 상품 검색 기능 -->
          <form class="search_form">
            <div class="search__input__div">
              <input type="text" class="search__input text" name="keyword"
                onkeyup="if(window.event.keyCode==13){searchProduct();}" placeholder="상품을 검색하세요."
                onfocus="this.placeholder=''" onblur="this.placeholder='상품을 검색하세요.'">
              <input text="text" name="" style="display:none;">
              <span><i class="fa-solid fa-magnifying-glass" onClick="searchProduct()"></i></span>
              <!--<input type="button" class="search__input__button " onClick="searchProduct()" value="검색" style="margin-right: 5px;"> -->
            </div>
          </form>
          <!-- 헤더 navbar 메뉴 버튼-->
          <ul class="navbar__menu">
            <li class="navbar__menu__item login" data-link="login" onclick="loginDiv(event)">로그인
              <!-- [ 로그인 모달 ] ******************************-->
              <!--
                        <div id="loginDiv" class="loginDiv__wrapper" style="display: none;">
                          <div class="loginDiv__container">
                            <div class="loginDiv__title">
                              <h4>로그인 선택</h4>
                            </div>
                            <input type="button" class="subLoginBtn buyerLogin" value="구매자 로그인" onclick="logInKakao()">
                            <div class="subLoginBtn buyerLogin" onclick="logInKakao()">구매자 로그인</div>
                            <input type="button" class="subLoginBtn sellerLogin" value="판매자 로그인" onclick="logInSeller()">
                          </div>
                        </div>             
                      -->
            </li>
            <li class="navbar__menu__item join" data-link="join" onclick="moveJoin()">회원가입</li>
          </ul>
        </div>
      </div>
    </nav> <!-- [Navbar] 끝 -->
<main id="common__zone">
    <div id="common__wrapper">
        <!--[공통 메뉴 시작] ------------------------------>
        <nav class="common__menu__Zone">
          <div class="common__menu">
            <div class="common__menu__title" onclick="moveMyShop2()">
              마이샵
           
            </div>
            <div class="common__menu__list">
              <div class="common__menu__item">상품 관리</div>
              <div class="common__menu__item childCte" onClick="showModal()">전문분야 등록</div>
              <div class="common__menu__item childItem" onClick="moveRegisterGoods()">상품 등록</div>              
              <div class="common__menu__item childItem" onClick="moveModifyProduct()">상품 수정/삭제</div>              
              <div class="common__menu__item">판매 관리</div>
              <div class="common__menu__item childItem" onClick="moveSalesHistory()">판매 내역</div>              
              <div class="common__menu__item childItem" onClick="moveStatistics()">통계 조회</div> 
            </div>
          </div>
        </nav><!-- 공통 메뉴 끝 --> 
        <!--[공통 컨텐츠 시작] ------------------------------>
        <div class="common__content__zone myShop">
          <div class="content__title">마이샵 페이지</div>
          
          <div class="sellerShop__content__zone">
                <!-- [ 1. 나의 정보 ] -->
                <div class="sellerShop__wrapper">
                    <!--  샵 정보 -->
                    <div class="seller__info__container">
                        <h2>샵 정보</h2>
                        <div class="seller__info__div">
                              <div class="selerInfo__detail">
                                  <div class="info_detail_div">
                                      <span class="sellerInfo__span">샵이름 : </span>
                                      <span class="sellerInfo__shopName">샵이름영역</span>
                                  </div>
                                  <div class="info_detail_div">
                                      <span class="sellerInfo__span">닉네임 : </span>
                                      <span class="sellerInfo__sellerNickname">닉네임영역</span>
                                  </div>
                                  <div class="info_detail_div">
                                      <span class="sellerInfo__span">이메일 : </span>
                                      <span class="sellerInfo__sellerEmail">이메일영역</span>
                                  </div>
                              </div>
                        </div>
                    </div>
                </div>
                <!-- 셀러 소개글 -->
                <div class="seller__profile__container">
                    <h2>소개글</h2>
                    <div class="seller__profile__div">
                      셀러소개글 영역
                    </div>
                </div>
        </div><!-- sellerShop__content__zone 끝 -->
        <!-- [ 2. 판매자의 상품리스트 ] -->
          <div class="seller__product__container">
              <h2>등록한 상품</h2>
                <div class="productList__container">
                  ${list}
                </div>
              </div>
          </div>
        </div><!-- common__content__zone myShop 끝 -->
    </div><!-- common__wrapper끝-->
</main>	
      <div class="modal__wrapper">
        <div class="common__modal">
        
          <div class="modal__head">
          <div class="modla__name">카테고리 등록</div>
            <div class="modal__title">
            </div> 
            
          </div>
          <div class="modal__body">
          <!-- 자신의 전문분야 선택 -->
          	${selectCte}
         <div class="buttons">
         <input type="button" value="등록" name="btn" onClick="regCte()"/>
         <input type="button" value="취소" name="btn" onClick="closeModal()"/>
         <div>
         <br><br><br>
         등록되어있는 전문분야 : <br><br>
         ${checkedCte}
            </div>
            <div class="moadl__content">
            </div>
          </div>
        </div>
        </div>
        </div>        
    <form name = "clientData" ></form> 
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
                (주)투엑스 사이트의 상품/판매회원/중개 서비스/거래 정보, 콘텐츠, UI 등에 대한 무단복제, 전송, 배포, 스크래핑 등의 행위는 저작권법, 콘텐츠산업 진흥법 등 관련법령에 의하여
                엄격히 금지됩니다.
            </p>
            <p class="footer__contact__rights">
                </br>
                Copyright © 2022 twoEx Inc. All rights reserved.
            </p>
        </section>
      -->
    </body>
</body>
</html>