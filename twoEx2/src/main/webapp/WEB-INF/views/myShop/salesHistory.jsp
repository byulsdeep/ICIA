<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">
<!-- LOGO, FONT SOURCE ------------------------------>
    <script src="https://kit.fontawesome.com/1066a57f0b.js" crossorigin="anonymous"></script>


<!-- JS, CSS 연결 -->
<link rel="stylesheet" href="res/css/header.css">
<link rel="stylesheet" href="res/css/style.css" />
<link rel="stylesheet" href="res/css/myShop.css" />
<link rel="stylesheet" href="res/css/salesHistory.css" />
<script src="res/js/header.js" defer></script>
<script src="res/js/main.js" defer></script>
<script src="res/js/myShop.js" defer></script>
<script src="res/js/main_LSE.js" defer></script>
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

	//1개월이내 데이터 가져오기
	
	
	function getJanMonthsDate() {
		postAjaxJson("getJanMonthsDate", null, "getJanMonthsDateCallBack");
	}

	function getJanMonthsDateCallBack(ajaxData) {
		document.getElementsByName("getMonthsDate")[0].innerText = "";
		alert(ajaxData);
		const getMonthsDateList = JSON.parse(ajaxData)
		let monthsList = document.getElementsByName("getMonthsDate")[0];
		alert(monthsList);
		
		for (idx = 0; idx < getMonthsDateList.length; idx++) {
			let info = "<div class=\"product__image__div\">";
			info += "<img class=\"product__image\" src=\"" + getMonthsDateList[idx].prfLocation + "\">";
			info += "</div>";
			info += "<div class=\"product__title__div\">" + getMonthsDateList[idx].prdName +"</div>";			
			info += "<div class=\"product__price__div\">";
			info += "<span>" + "상품 금액" + "</span>";
			info += "<span>" + getMonthsDateList[idx].prdPrice + "</span>";
			info += "</div>";
			info += "<div class=\"product__etc__div\">";
			info += "<span>" +"구매 시간 : "+"</span>";
			info += "<span>" + getMonthsDateList[idx].ordDate + "</span>";
			info += "</div>";
			info += "</div>";
			let div = createDiv("", "product__item item1", getMonthsDateList[idx].ordSelCode, info);
			div.setAttribute("onclick",'moveProductInfo("'+ getMonthsDateList[idx].ordPrdCteCode +'","' + getMonthsDateList[idx].ordPrdSelCode + '","' + getMonthsDateList[idx].ordPrdCode +'")');
			
			
			monthsList.appendChild(div);
		}

	}

	//3개월이내 데이터 가져오기
	function getMarMonthsDate() {
		postAjaxJson("getMarMonthsDate", null, "getMarMonthsDateCallBack");
	}

	function getMarMonthsDateCallBack(ajaxData) {
		document.getElementsByName("getMonthsDate")[0].innerText = "";
		const getMonthsDateList = JSON.parse(ajaxData)
		let monthsList = document.getElementsByName("getMonthsDate")[0];
		alert(monthsList);
		for (idx = 0; idx < getMonthsDateList.length; idx++) {
			let info = "<div class=\"product__image__div\">";
			info += "<img class=\"product__image\" src=\"" + getMonthsDateList[idx].prfLocation + "\">";
			info += "</div>";
			info += "<div class=\"product__title__div\">" + getMonthsDateList[idx].prdName +"</div>";			
			info += "<div class=\"product__price__div\">";
			info += "<span>" + "상품 금액" + "</span>";
			info += "<span>" + getMonthsDateList[idx].prdPrice + "</span>";
			info += "</div>";
			info += "<div class=\"product__etc__div\">";
			info += "<span>" +"구매 시간 : "+"</span>";
			info += "<span>" + getMonthsDateList[idx].ordDate + "</span>";
			info += "</div>";
			info += "</div>";
			let div = createDiv("", "product__item item1", getMonthsDateList[idx].ordSelCode, info);
			div.setAttribute("onclick",'moveProductInfo("'+ getMonthsDateList[idx].ordPrdCteCode +'","' + getMonthsDateList[idx].ordPrdSelCode + '","' + getMonthsDateList[idx].ordPrdCode +'")');
			monthsList.appendChild(div);
			
		}

	}

	//6개월이내 데이터 가져오기
	function getJunMonthsDate() {
		postAjaxJson("getJunMonthsDate", null, "getJunMonthsDateCallBack");
	}

	function getJunMonthsDateCallBack(ajaxData) {
		document.getElementsByName("getMonthsDate")[0].innerText = "";
		const getMonthsDateList = JSON.parse(ajaxData)
		let monthsList = document.getElementsByName("getMonthsDate")[0];
		alert(monthsList);
		for (idx = 0; idx < getMonthsDateList.length; idx++) {
			let info = "<div class=\"product__image__div\">";
			info += "<img class=\"product__image\" src=\"" + getMonthsDateList[idx].prfLocation + "\">";
			info += "</div>";
			info += "<div class=\"product__title__div\">" + getMonthsDateList[idx].prdName +"</div>";			
			info += "<div class=\"product__price__div\">";
			info += "<span>" + "상품 금액" + "</span>";
			info += "<span>" + getMonthsDateList[idx].prdPrice + "</span>";
			info += "</div>";
			info += "<div class=\"product__etc__div\">";
			info += "<span>" +"구매 시간 : "+"</span>";
			info += "<span>" + getMonthsDateList[idx].ordDate + "</span>";
			info += "</div>";
			info += "</div>";
			let div = createDiv("", "product__item item1", getMonthsDateList[idx].ordSelCode, info);
			div.setAttribute("onclick",'moveProductInfo("'+ getMonthsDateList[idx].ordPrdCteCode +'","' + getMonthsDateList[idx].ordPrdSelCode + '","' + getMonthsDateList[idx].ordPrdCode +'")');
			monthsList.appendChild(div);
		}

	}
	//특정기간 사이에 있는 데이터 가져오기
	function getSalesHistory() {
		let ordFromDate = document.getElementsByName("orderDate")[0].value;
		let ordToDate = document.getElementsByName("orderDate")[1].value;
		let clientData;
		if (ordFromDate != null && ordFromDate != "" && ordToDate != null && ordToDate != "") {

			clientData = "ordFromDate=" + ordFromDate + "&ordToDate=" + ordToDate;
			
			postAjaxJson("getSalesHistory", clientData, "getSalesHistoryCallBack");
		
		}else{
			alert("날짜를 입력해 주세요");
		}

		
	}

	function getSalesHistoryCallBack(ajaxData) {
		document.getElementsByName("getMonthsDate")[0].innerText = "";
		const getMonthsDateList = JSON.parse(ajaxData)
		let monthsList = document.getElementsByName("getMonthsDate")[0];
		alert(monthsList);
		
		for (idx = 0; idx < getMonthsDateList.length; idx++) {
			let info = "<div class=\"product__image__div\">";
			info += "<img class=\"product__image\" src=\"" + getMonthsDateList[idx].prfLocation + "\">";
			info += "</div>";
			info += "<div class=\"product__title__div\">" + getMonthsDateList[idx].prdName +"</div>";			
			info += "<div class=\"product__price__div\">";
			info += "<span>" + "상품 금액" + "</span>";
			info += "<span>" + getMonthsDateList[idx].prdPrice + "</span>";
			info += "</div>";
			info += "<div class=\"product__etc__div\">";
			info += "<span>" +"구매 시간 : "+"</span>";
			info += "<span>" + getMonthsDateList[idx].ordDate + "</span>";
			info += "</div>";
			info += "</div>";
			let div = createDiv("", "product__item item1", getMonthsDateList[idx].ordSelCode, info);
			div.setAttribute("onclick",'moveProductInfo("'+ getMonthsDateList[idx].ordPrdCteCode +'","' + getMonthsDateList[idx].ordPrdSelCode + '","' + getMonthsDateList[idx].ordPrdCode +'")');

			monthsList.appendChild(div);
		}
	}
</script>
</head>
<body onLoad ="init()">
	<!-- [Navbar] ------------------------------------------------------->
	<nav id="navbar">
		<div class="navbar__upper">
			<div class="navbar__logo">
				<i class="fa-solid fa-arrow-right-arrow-left"></i> <span
					class="title">Two EX</span> <span class="subtitle">Experts
					Exchange</span>
			</div>
			<div class="header__right">
				<input class="header__search" type="text" placeholder="  상품을 검색하세요.">
				<!-- 헤더 navbar 메뉴 버튼-->
				<ul class="navbar__menu">
					<li class="navbar__menu__item myPage" data-link="#contact">마이페이지</li>
					<li class="navbar__menu__item myShop" data-link="#contact" >마이샵</li>
					<div class="navbar__menu__item profile"></div>
					<li class="navbar__menu__item login" data-link="login">로그아웃</li>
				</ul>
				<!-- Toggle button 향후 사용 예비버튼-->
				<button class="navbar__toggle-btn">
					<i class="fas fa-bars"></i>
				</button>
			</div>
		</div>
	</nav>
	<!-- [Navbar] 끝 -->
	<main id="common__zone">
		<div id="common__wrapper">
			<!--[공통 메뉴 시작] ------------------------------>
			<nav class="common__menu__Zone">
				<div class="common__menu">
					<div class="common__menu__title" onclick="moveMyShop2()">마이샵</div>
					<div class="common__menu__list">
						<div class="common__menu__item">상품 관리</div>
						<div class="common__menu__item childCte" onClick="showModal()">전문분야 등록</div>
						<div class="common__menu__item childItem" onClick="moveRegisterGoods()">상품 등록</div>
						<div class="common__menu__item childItem" onClick="moveModifyProduct()">상품 수정/삭제</div>
						<div class="common__menu__item">판매 관리</div>
						<div class="common__menu__item childItem" onclick="moveSalesHistory()" style="color:#9370DB;font-size:23px;">판매 내역</div>
						<div class="common__menu__item childItem" onclick="moveStatistics()">통계 조회</div>
					</div>
				</div>
			</nav>
			<!-- 공통 메뉴 끝 -->
			<!--[공통 컨텐츠 시작] ------------------------------>
			<div class="common__content__zone myShop">
				<div class="items title">
				<h3>판매내역 페이지</h3>
				<div>
				<div class="monthsDate">
					<input class="content__btn btn__medium" type="button" onclick="getJanMonthsDate()" value="1개월"> 
					<input class="content__btn btn__medium" type="button" onclick="getMarMonthsDate()" value="3개월"> 
					<input class="content__btn btn__medium" type="button" onclick="getJunMonthsDate()" value="6개월">
					<input class="content__btn btn__medium" name="orderDate" type="date"> ~ <input class="content__btn btn__medium" name="orderDate" type="date"> 
					<input class="content__btn btn__small" type="button" onclick="getSalesHistory()" value="조회">

				</div>
				<div class="monthsDateZone"name="getMonthsDate">${getMoveSalesHistoryList}</div>
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
	<!-- Contact -->
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
	<form name="clientData"></form>
</html>