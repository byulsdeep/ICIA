<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>::: TwoEX ::: 교환 플랫폼</title>
<!-- 기타 meta 정보 -->
<meta name="mainPage" content="TwoEx site">
<meta name="author" content="TwoEX">
<link rel="icon" type="image/png" href="">

<!-- LOGO, FONT SOURCE-->
<script src="https://kit.fontawesome.com/1066a57f0b.js"
	crossorigin="anonymous"></script>
<link
	href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600;700&family=Russo+One&display=swap"
	rel="stylesheet">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Raleway:ital,wght@0,800;1,900&display=swap"
	rel="stylesheet">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Orbitron:wght@900&display=swap"
	rel="stylesheet">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Exo:wght@800;900&display=swap"
	rel="stylesheet">
<!-- JS, CSS 연결 -->
<link rel="stylesheet" href="res/css/style.css">
<link rel="stylesheet" href="res/css/header.css" />
<link rel="stylesheet" href="res/css/myShop.css" />
<script src="res/js/main.js" defer=""></script>
<script src="res/js/header.js" defer></script>
<!--          <script src="res/js/myShop.js" defer></script>   -->
<script>
        
       	
        let selCode;
        function init() {  
        	postAjaxJson("isSession", null, "isSessionCallBack");    
            
            if("${message1}" != null && "${message1}" != ""){
                alert('${message1}');
                
                
                }
            
            
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
            
            
              //클래스룸 여부 클릭시 공개,비공개 변경
            function toggleButton() {
        		let visible = document.getElementsByName("prdType")[0];
        		if (visible.value == "N") {
        			visible.value = "C";
        		} else {
        			visible.value = "N";
        		}
        	}
            
              //상품수정 버튼
            function updProduct(prdCode,prdSelCode,prdCteCode){
      	      	let form= document.getElementsByName("updGoods")[0];         	
            	form.action = "updProduct";
            	form.method = "post";
            	form.appendChild(createHidden("prdCode",prdCode))
            	form.appendChild(createHidden("prdSelCode",prdSelCode))
            	form.appendChild(createHidden("prdCteCode",prdCteCode))
            	
//             	document.getElementsBtName("prdInfo")[0];
//             	document.getElementsBtName("prdName")[0];
//             	document.getElementsBtName("prdStartDate")[0];
//             	document.getElementsBtName("prdEndDate")[0];
//             	document.getElementsBtName("prdPrice")[0];
            	if(document.getElementsByName("prdName")[0].value == ""){
					alert("상품이름을 입력하세여");
					
            		document.getElementsByName("prdName")[0].focus();
					return;	
			       }
            	
            	      	if(document.getElementsByName("prdInfo")[0].value == ""){
            		alert("상품설명을 입력하세여");
            		
            		document.getElementsByName("prdInfo")[0].focus();

            		return;
            	}
				
				if(document.getElementsByName("prdStartDate")[0].value == ""){
					alert("상품시작일을 입력하세여");
					
            		document.getElementsByName("prdStartDate")[0].focus();
					return;
				}
				if(document.getElementsByName("prdEndDate")[0].value == ""){
					alert("상품종료일을 입력하세여");
					
            		document.getElementsByName("prdEndDate")[0].focus();
					return;
				}
				if(document.getElementsByName("prdPrice")[0].value == ""){
					alert("상품가격을 입력하세여");
					
            		document.getElementsByName("prdPrice")[0].focus();
					return;
				}

            	form.submit();
      	      }
            
            
            function createHidden(objName, value){
              	let input = document.createElement("input");
              	input.setAttribute("type", "hidden");
              	input.setAttribute("name", objName);
              	input.setAttribute("value", value);
              	
              	return input;
              }
            
            
        	//상품등록 페이지로 이동
                    function moveRegisterGoods() {
                    	let prdSelCode= '${selCode}';
                    	let form = document.createElement("form");
                    	form.action = "moveRegisterGoods";
                    	form.method = "post";           
                    	 form.appendChild(createHidden("prdSelCode",prdSelCode));
                    	document.body.appendChild(form);
                    	form.submit();
                    }
            
            //상품수정,삭제페이지로이동
            function moveModifyProduct(){
            	//alert(PRDSELCODE);
            	let prdSelCode= '${selCode}';
            	let form = document.createElement("form");
            	form.action = "moveModifyProduct";
            	form.method = "post";           
            	form.appendChild(createHidden("prdSelCode",prdSelCode));
            	document.body.appendChild(form);
            	form.submit();   	 
            }
            
        	function moveSalesHistory(){
        		const form = document.getElementsByName("clientData")[0];
        		form.action = "moveSalesHistory";
        		form.method = "post";
        		form.submit();
          	}
        	
        	function moveStatistics(){
        		let prdSelCode= '${selCode}';
        		const form = document.getElementsByName("clientData")[0];
        		form.action = "moveStatistics";
        		form.method = "post";
        		form.appendChild(createHidden("prdSelCode",prdSelCode));
        		form.submit();
          	}
        	
        	function moveMyshop() {	 
        		let prdSelCode= '${selCode}';    
        		let form = document.createElement("form");
        		form.action = "moveMyshop";
        		form.method = "post";            	            	
        		form.appendChild(createHidden("prdSelCode",prdSelCode));
        		document.body.appendChild(form);
        		form.submit();          	
        	}
        	
        	function moveMainPage(){
        	    //alert("moveMainPage 입구");
        		let form = document.createElement('form');
        	    form.method="GET";
        	    form.action="/"
        		document.body.appendChild(form);
        	    form.submit()
        	    //alert("moveMainPage 출구");
        		
        	}
        	
        </script>    
        <style>
        #prdList{
	 	float: left;
	    margin: 20% 5px 5px 10px;
	    border: 3px solid #ffffff; 	
        }
        #menu{
        	float : left;   
 			margin-top : 100px;    
 			
 			width :100%;
        	border : 3px solid #ffffff;
        }
        #menuVar{
        width :15%;
        border : 3px solid #ffffff;
        }
        #productList{
        	float :left;
        	margin-left : 20%;
        }
       .modal__body{
       	background-color : #ffffff;
       }
        </style>   
    </head>
<body>
    <!-- [Navbar] ------------------------------------------------------->
    <nav id="navbar" class="">
      <div class="navbar__upper">
        <div class="navbar__logo">
          <i class="fa-solid fa-arrow-right-arrow-left"></i>
          <span class="title" onClick="moveMainPage()">Two EX</span>
          <span class="subtitle">Experts Exchange</span>
        </div>
        <div class="header__right">
            <input class="header__search" type="text" placeholder="  상품을 검색하세요.">
            <!-- 헤더 navbar 메뉴 버튼-->
            <ul class="navbar__menu">
              <li class="navbar__menu__item myPage" data-link="#contact">마이페이지</li>
              <li class="navbar__menu__item myShop" data-link="#contact" >마이샵</li>
              <div class="navbar__menu__item profile">asdsad</div>
              <li class="navbar__menu__item login" data-link="login" onclick="logOut()">로그아웃</li>
            </ul>
            <!-- Toggle button 향후 사용 예비버튼-->
            <button class="navbar__toggle-btn">
              <i class="fas fa-bars" aria-hidden="true"></i>
            </button>
        </div>
      </div>
    </nav>  	
    <main id="common__zone">
      <div id="common__wrapper">
        <!--[공통 메뉴 시작] ------------------------------>
        <nav class="common__menu__Zone myShop">
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
              <div class="common__menu__item parentItem">공지사항</div>
            </div>
          </div>
        </nav><!-- 공통 메뉴 끝 -->
    <!--[공통 컨텐츠 시작] ----------------------------->
        <div class="common__content__zone myShop">
          <div class="updProductList">
          <div class="content__title">
            <h2>상품수정</h2>
          </div>
          <!-- 수정하기위해 선택한 상품의 정보 출력 -->
          ${getProductInfo }
        </div>
        </div>
        </div>
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
    <!-- 
      <div class="modal__wrapper" style="display: block;">
        <div class="common__modal">
          <div class="modal__head">
            <div class="modal__title">
            </div> 
            <div class="modal__close" onclick="closeModal()">
              X
            </div>
          </div>
          <div class="modal__body">${getProductInfo}
            </div>
            <div class="moadl__content">
            </div>
          </div>
        </div>
     -->
	<!-- [ Footer ] -->
	<section id="footer_section" class="section">
		<h1 class="footer__title">Let's talk</h1>
		<h2 class="footer__contact__email">admin@twoex.com</h2>
		<div class="footer__contact__links">
			<!--
        <a href="https://github.com/dream-ellie" target="_blank">
          <i class="fab fa-github"></i>
        </a>
        <a href="#" target="_blank">
          <i class="fa fa-linkedin-square"></i>
        </a>
        -->
            </div>
            <p class="footer__contact__rights">
                </br>
                Copyright © 2022 twoEx Inc. All rights reserved.
            </p>
        </section>
        <!-- Arrow up -->
        <button class="arrow-up">
            <i class="fas fa-arrow-up"></i>
        </button>
    </body>
</body>
</html>