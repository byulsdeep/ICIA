<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>::: TwoEX ::: 교환 플랫폼 :: 상품/수정 삭제페이지 </title>
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

      <!-- JS, CSS 연결 -->
      <link rel="stylesheet" href="res/css/style.css" />
      <link rel="stylesheet" href="res/css/header.css" />
      <link rel="stylesheet" href="res/css/myShop.css" />
      <script src="res/js/main.js" defer></script>
      <script src="res/js/header.js" defer></script>  
       <script src="res/js/myShop.js" defer></script>  
      <script>
      let selCode;
      function init() {   	
          postAjaxJson("isSession", null, "isSessionCallBack");
		
          if("${message}" != null && "${message}" != ""){
              alert('${message}');
              }

      } 
      
      function isSessionCallBack(ajaxData) {
    	  if(ajaxData != null) {
        	  accessInfo = JSON.parse(ajaxData);
        	  selCode = accessInfo.selCode;
        	  makeHeader(accessInfo);
    	  }
      }

      function createHidden(objName, value){
      	let input = document.createElement("input");
      	input.setAttribute("type", "hidden");
      	input.setAttribute("name", objName);
      	input.setAttribute("value", value);
      	
      	return input;
      }
      
      //선택한상품수정을위한 페이지로이동
	function moveUpdProduct(prdCode,prdSelCode,prdCteCode){
		//let prdSelCode= accessInfo.selCode;
    	let form = document.createElement("form");
    	form.action = "moveUpdProduct";
    	form.method = "post";            	            	
        form.appendChild(createHidden("prdCode",prdCode));
        form.appendChild(createHidden("prdSelCode",prdSelCode));
        form.appendChild(createHidden("prdCteCode",prdCteCode));
    	document.body.appendChild(form);
    	form.submit();
	}
	
      //선택한상품 삭제 버튼
	function delProduct(prdCode, prdCteCode ,prdSelCode){
    	let form= document.getElementsByName("clientData")[0];         	
    	form.action = "delProduct";
    	form.method = "post";
    	form.appendChild(createHidden("prdCode",prdCode));
    	form.appendChild(createHidden("prdCteCode",prdCteCode));
    	form.appendChild(createHidden("prdSelCode",prdSelCode));

    	form.submit();
	}
	

	  
	  //상품등록 페이지로 이동
	  function moveRegisterGoods() {
		  let prdSelCode= accessInfo.selCode;
      	let form = document.createElement("form");
      	form.action = "moveRegisterGoods";
      	form.method = "post";          
      	form.appendChild(createHidden("prdSelCode",prdSelCode));
      	document.body.appendChild(form);
      	form.submit();
      }
	  
	  
	  
	  
</script>
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


/** product **/
.product__item{
    margin: 15px;
    height: 430px;
    width: 250px;
    border: solid 1.5px #cacaca;
    border-radius: 10px;
    box-shadow: 1.5px 1.5px 10px 1px rgb(205 205 205);
    background-color: rgb(250, 250, 250);
    /* padding: 11px; */
    align-items: flex-start;
    padding-top: 0px;
    color: var(--color-black);
    text-align: center;
    overflow: hidden;
    cursor: pointer;
    float : left;
}


.product__image__div{
	    position: relative;
    margin: 0;
    width: 251px;
    height: 250px;
    background-color: var(--color-headerGrey);
    margin-bottom: 15px;
    object-fit: cover;
}
.more {      display: block;
    font-size: 18x;
    color: #fff;
    background: var(--color-serenity);
    line-height: 40px;
    width: 180px;
    height: 50px;
    margin-top: 100px;
    margin-left: 30px;
    opacity: 1;
    transition: 0.5s all;
}



.product__seller__div,
.product__title__div,
.product__price__div,
.product__etc__div,
.product__btn__div{
/*   margin-bottom: 10px; */

}



.product__image{
     height: 100%;
    width: 100%;
    object-fit: fill;

}


.product__seller__div{
  text-align: start;
  font-size: 16px;
  font-size : 10px;
}

.product__seller__div span{
  margin-right : 5px;
}

.product__title__div{
  text-align: start;
  font-size: 22px;
  font-weight: 550;
  color: black;
  font-size : 10px;
}


.product__price__div{
       text-align: end;
    font-size: 21px;
}

.product__btn__div{
  padding : 5px;
  color: var(--color-black);

  display:flex;
  justify-content: space-between;
  align-items: center;
}

.product__etc__div{
   padding: 5px;
    color: var(--color-black);
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-size: 12pt;
}
</style>
</head>
<body onLoad="init()">
 <!-- [Navbar] ------------------------------------------------------->
    <nav id="navbar" class="">
      
      
    </nav> 	
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
        <div class="common__content__zone myShop" id="productList">
          <h3>상품 수정/삭제</h3>
          <!-- 상품삭제/수정을위한 상품리스트 출력 -->
          ${productList}
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
            <div class="moadl__content">
            </div>
          </div>
        </div>
        <form name = "clientData" ></form> 
	<!-- [ Footer ] -->
        <section id="footer_section" class="section">
            <h1 class="footer__title">Let's talk</h1>
            <h2 class="footer__contact__email">admin@twoex.com</h2>
            <div class="footer__contact__links">
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
<style> 
     	.common__content__zone{
     	height : 1300px;
     	}
     	
     </style>
</html>