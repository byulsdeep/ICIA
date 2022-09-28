<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    
      let uploadFile = [];
      
      let info2 = JSON.parse('${accessInfo}');
      let selCode = info2.selCode;
      
      function init() {   	
          postAjaxJson("isSession", null, "isSessionCallBack");
          let info = JSON.parse('${accessInfo}');
     
          let selCode2 = document.getElementsByName("prdSelCode")[0];
          selCode2.setAttribute("value",info.selCode);
          
          if("${message}" != null && "${message}" != ""){
              alert('${message}');
              }
     	
          if("${prfLocation}" != null  && "${prfLocation}" != ""){
        	  let file = document.getElementById("upload");
        	  
        	  
        	  file.innerHTML=
        	   "<img src='${prfLocation}' style=\"max-width: 100%; height: auto;\"></img>"
        	  +"<br><br>"
        	  +"<form name='upload' id='upload'>"
      		  +"파일을 수정하시려면 재등록해주세요  <br><input type='file' name='file' >"
    		  +"<br><br><br><input type='button' value='전송' class='btn' onClick='updload()'>"
    		  +"<br>"
    		  +"</form>";  
    		  
    		  
          }
          
          
          
      }     
      function isSessionCallBack(ajaxData) {
    	  if(ajaxData != null) {
        	  accessInfo = JSON.parse(ajaxData);
        	  makeHeader(accessInfo);
    	  }
      }

            //상품수정,삭제페이지로 이동
            function moveModifyProduct(){
            	//alert(PRDSELCODE);
            	let prdSelCode= accessInfo.selCode;
            	let form = document.createElement("form");
            	form.action = "moveModifyProduct";
            	form.method = "post";           
            	form.appendChild(createHidden("prdSelCode",prdSelCode));
            	document.body.appendChild(form);
            	form.submit();   	 
            }
    
           
		//상품등록 버튼
            function registerGoods(){
			
            	let form= document.getElementsByName("regGoods")[0];
            	let prdType = document.getElementsByName("prdType")[0].value;
        	
            	form.action = "registerProduct";
            	form.method = "post";
            	form.appendChild(createHidden("prdType",prdType))
         
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
            
            //클래스룸 여부 클릭시 공개,비공개 변경
            function toggleButton() {
        		let visible = document.getElementsByName("prdType")[0];
        		if (visible.value == "N") {
        			visible.value = "C";
        		} else {
        			visible.value = "N";
        			visible.style.backgroundcolor
        		}
        	}
            function createHidden(objName, value){
              	let input = document.createElement("input");
              	input.setAttribute("type", "hidden");
              	input.setAttribute("name", objName);
              	input.setAttribute("value", value);
              	
              	return input;
              }
            
            //상품등록페이지로 이동
            function moveRegisterGoods() {
            	let prdSelCode= accessInfo.selCode;
            	let form = document.createElement("form");
            	form.action = "moveRegisterGoods";
            	form.method = "post";           
            	form.appendChild(createHidden("prdSelCode",prdSelCode));
            	document.body.appendChild(form);
            	form.submit();
            }
            
          
        	function updload(){
        		let form = document.getElementsByName("upload")[0];
        		form.action="upload_ok";
        		form.method="post";
        		form.enctype="multipart/form-data";
        		
//         		let prdCode= document.getElementsByName("prdCode")[0];
         		let prdSelCode= accessInfo.selCode;
//         		let prdCteCode= document.getElementsByName("prdCteCode")[0];
        		
         		form.appendChild(createHidden("prdSelCode",prdSelCode));
//         		form.appendChild(createHidden("prfPrdCode",prdCode));
//         		form.appendChild(createHidden("prfPrdCteCode",prdCteCode));
//         		form.appendChild(createHidden("prfFileCode",prfCode));
//         		form.appendChild(createHidden("prfFileName",prfCode));
        		
        		
//         		alert(prdCode.value);	
        		
        		form.submit();
        	}
        
        </script>
        <style>
   
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
            <div class="common__menu__title" onclick="moveMyshop()">
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
          <div class="content__title">
              <h2>상품등록 페이지</h2>
          </div>
        
       
         <!-- 판매자의 상품리스트 -->
	<div class ="proInfoList">
	<form name="upload" id="upload">
		상품이미지를 선택해주세요 <br>
		<br><br>
		<input type="file" name="file" >
		<br>
		<br>
		<input type="button" value="전송" onClick="updload()"><br>
		<br>
		<span id="text">*미선택시 기본이미지로 대체됩니다.</span>		
	</form><br><br><br>

<form name="regGoods" >
      	<div class="joinId">
      	<div>클래스룸 여부  
      	<br>
      	<br>
      	<div>
      	<input type="button"  class="content__btn btn__medium"  name="prdType" placeholder="상품타입" value="N" onClick="toggleButton()"></input></div>
    	</div>
    <div class="selId">
    <label for="selId"></label><br>
    <input class="selId" id="ID" type="hidden" name="prdSelCode" class="input text medium" placeholder="판매자ID"  style="width:400px;height:51px;font-size:15px;" readOnly/>
    </div>

    <input type="hidden" name="prfCode" value="${prfCode}"/>
    <input type="hidden" name="prfName" value="${prfName}"/>
    <input type="hidden" name="prfLocation" value="${prfLocation}"/>
    
    <div class="regPrdCode">
	    <label for="prdCode"></label><br> 
	    <input class="registerPrdCode" id="Nickname" type="hidden" name="prdCode" class="input text medium" placeholder="상품코드"  value="${prdCode}"  readOnly style="width:400px;height:51px;font-size:15px;"/>
    </div>
    
    <div class="regCte">
    <label for="cteCode">카테고리</label><br><br>
    	<div>* 첫 판매시 좌측 전문분야를 먼저 등록해 주세요</div>
    	${selectData }<br><br>
    </div>
    
    <div class="regPrdName">
    <label for="Name">상품이름</label><br>
    <input class="registerPrdName" type="text" name="prdName" class="input text medium" placeholder="상품이름" style="width:400px;height:51px;font-size:15px;"/><br><br>
    </div>
    
    <div class="regPrdInfo">
    <label for="Inf0">상품설명</label><br>
    <textarea name="prdInfo" placeholder="상품정보" class="input text medium" style="width:400px;height:51px;font-size:15px;"></textarea><br><br>
    </div>
    
    <div class="regPrdStart">
    <label for="Start">시작일</label><br>
    <input class="sellseShopName" type="date"  name="prdStartDate" class="input text medium" placeholder="시작일" style="width:400px;height:51px;font-size:15px;"/><br><br>
    </div>
    
    <div class="regPrdEnd">
    <label for="End">종료일</label><br>
    <input class="sellseShopName" type="date"  name="prdEndDate" class="input text medium" placeholder="종료일" style="width:400px;height:51px;font-size:15px;"/><br><br>
    </div>
    
    <div class="regPrdPrice">
    <label for="Price">가격</label><br>
    <input class="sellseShopName" type="text"  name="prdPrice" class="input text medium" placeholder="상품가격" style="width:400px;height:51px;font-size:15px;"/><br><br>
    </div>
 
     <div class="regProduct">
    <label for="product">상품등록하기</label><br>
    <input class="registerProduct" type="button"  name="regProduct" class="content__btn btn__medium" value="상품등록" onClick="registerGoods()" style="width:400px;height:51px;font-size:15px;"/><br><br><br><br>
    </div>
     </div>
     
     
  </form>  
   	
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


</html>
