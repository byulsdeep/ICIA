/* 전역 변수 */
let accessInfo;

/* header 동적 생성 */
function makeHeader(accessInfo, info) {
	if(accessInfo == null) {
		accessInfo = info;
	}
	
	if(accessInfo != null) {
		let navbar = document.getElementById("navbar");
		if(accessInfo.userType == "buyer") {
			navbar.innerHTML = "      <div class=\"navbar__upper\">\r\n"
			+ "        <div class=\"navbar__logo\">\r\n"
			+ "          <i class=\"fa-solid fa-arrow-right-arrow-left\"></i>\r\n"
			+ "          <span class=\"title\" onClick=\"moveMainPage()\">Two EX</span>\r\n"
			+ "          <span class=\"subtitle\">Experts Exchange</span>\r\n"
			+ "        </div>\r\n"
			+ "        <div class=\"header__right\">\r\n"
			+ "<form class=\"search_form\">"
			+ "<div class=\"search__input__div\">"
			+ "<input type=\"text\" class=\"search__input text\" name=\"keyword\" onkeyup=\"if(window.event.keyCode==13){searchProduct();}\" placeholder=\"상품을 검색하세요.\" onfocus=\"this.placeholder=''\" onblur=\"this.placeholder='상품을 검색하세요.'\">"
			+  "<input text=\"text\" name=\"\" style=\"display:none;\">"
			+  "<span><i class=\"fa-solid fa-magnifying-glass\" onClick=\"searchProduct()\"></i></span>"
			+  "</div>"
		    +  "</form>"
			+ "            <!-- 헤더 navbar 메뉴 버튼-->\r\n"
			+ "            <ul class=\"navbar__menu\">\r\n"
			+ "              <li class=\"navbar__menu__item myPage\" data-link=\"#contact\" onclick=\"moveAccountInfo()\">마이페이지</li>\r\n"
			+ "              <img class=\"navbar__menu__item profile\" onclick=\"moveMyPage()\">"
			+ "              <li class=\"navbar__menu__item login\" data-link=\"login\" onclick=\"logOut()\">로그아웃</li>\r\n"
			+ "            </ul>\r\n"
			+ "            <!-- Toggle button 향후 사용 예비버튼-->\r\n"
			+ "            <button class=\"navbar__toggle-btn\">\r\n"
			+ "              <i class=\"fas fa-bars\"></i>\r\n"
			+ "            </button>\r\n"
			+ "        </div>\r\n"
			+ "      </div>";
			let img = document.getElementsByClassName("profile")[0];
			img.src = accessInfo.buyProfile;
		} else if (accessInfo.userType == "seller") {
			navbar.innerHTML = "      <div class=\"navbar__upper\">\r\n"
				+ "        <div class=\"navbar__logo\">\r\n"
				+ "          <i class=\"fa-solid fa-arrow-right-arrow-left\"></i>\r\n"
				+ "          <span class=\"title\" onClick=\"moveMainPage()\">Two EX</span>\r\n"
				+ "          <span class=\"subtitle\">Experts Exchange</span>\r\n"
				+ "        </div>\r\n"
				+ "        <div class=\"header__right\">\r\n"
				+ "<form class=\"search_form\">"
				+ "<div class=\"search__input__div\">"
				+ "<input type=\"text\" class=\"search__input text\" name=\"keyword\" onkeyup=\"if(window.event.keyCode==13){searchProduct();}\" placeholder=\"상품을 검색하세요.\" onfocus=\"this.placeholder=''\" onblur=\"this.placeholder='상품을 검색하세요.'\">"
				+  "<input text=\"text\" name=\"\" style=\"display:none;\">"
				+  "<span><i class=\"fa-solid fa-magnifying-glass\" onClick=\"searchProduct()\"></i></span>"
				+  "</div>"
				+  "</form>"
				+ "            <!-- 헤더 navbar 메뉴 버튼-->\r\n"
				+ "            <ul class=\"navbar__menu\">\r\n"
				+ "              <li class=\"navbar__menu__item myShop\" data-link=\"#contact\" onclick=\"moveMyshop()\">마이샵</li>\r\n"
				+ "              <li class=\"navbar__menu__item login\" data-link=\"login\" onclick=\"logOut()\">로그아웃</li>\r\n"
				+ "            </ul>\r\n"
				+ "            <!-- Toggle button 향후 사용 예비버튼-->\r\n"
				+ "            <button class=\"navbar__toggle-btn\">\r\n"
				+ "              <i class=\"fas fa-bars\"></i>\r\n"
				+ "            </button>\r\n"
				+ "        </div>\r\n"
				+ "      </div>";
		}
	}else{
		/*
		navbar.innerHTML = "      <div class=\"navbar__upper\">\r\n"
		+ "        <div class=\"navbar__logo\">\r\n"
		+ "          <i class=\"fa-solid fa-arrow-right-arrow-left\"></i>\r\n"
		+ "          <span class=\"title\" onClick=\"moveMainPage()\">Two EX</span>\r\n"
		+ "          <span class=\"subtitle\">Experts Exchange</span>\r\n"
		+ "        </div>\r\n"
		+ "        <div class=\"header__right\">\r\n"
		+ "<form class=\"search_form\">"
		+ "<div class=\"search__input__div\">"
		+ "<input type=\"text\" class=\"search__input text\" name=\"keyword\" onkeyup=\"if(window.event.keyCode==13){searchProduct();}\" placeholder=\"상품을 검색하세요.\" onfocus=\"this.placeholder=''\" onblur=\"this.placeholder='상품을 검색하세요.'\">"
		+  "<input text=\"text\" name=\"\" style=\"display:none;\">"
		+  "<span><i class=\"fa-solid fa-magnifying-glass\" onClick=\"searchProduct()\"></i></span>"
		+  "</div>"
		+  "</form>"
		+ "<!-- 헤더 navbar 메뉴 버튼-->"
		+ "<ul class=\"navbar__menu\">"
		+ "<li class=\"navbar__menu__item login\" data-link=\"login\" onclick=\"loginDiv(event)\">로그인"
		+ "</li>"
		+ " <li class=\"navbar__menu__item join\" data-link=\"join\" onclick=\"moveJoin()\">회원가입</li>"
		+ " </ul>"
		+ "            <!-- Toggle button 향후 사용 예비버튼-->\r\n"
		+ "            <button class=\"navbar__toggle-btn\">\r\n"
		+ "              <i class=\"fas fa-bars\"></i>\r\n"
		+ "            </button>\r\n"
		+ "        </div>\r\n"
		+ "      </div>";
		*/
	}
} 

/** 로고 메인페이지 이동 */
function moveMainPage(){
    //alert("moveMainPage 입구");
	let form = document.createElement('form');
    form.method="GET";
    form.action="/"
	document.body.appendChild(form);
    form.submit()
    //alert("moveMainPage 출구");
	
}

/* 로그인창 display 컨트롤 */
function loginDiv(event) {
	//alert("loginDiv함수 입구");
	//alert("event : " + event);
	if(!(document.querySelector(".loginDiv__wrapper"))){
		//alert("lginDiv 첫번째 if문");
		let loginDiv_html = "로그인 <!-- [ 로그인 모달 ]*** ***************************-->"
		+ "		  <div class=\"loginDiv__wrapper\">"
		+ "  		<div class=\"loginDiv__container\">"
		+ "			   <div class=\"loginDiv__title\">"
		+ "				  <h4>로그인 선택</h4>"
		+ "    		   </div>"
		+ "			   <div class=\"common__login__div\">"
		+ "			      <div class=\"subLoginBtn buyerLogin\" onclick=\"logInKakao(event)\">구매자 로그인</div>"
		+ "			      <div class=\"subLoginBtn sellerLogin\" onclick=\"logInSeller(event)\">판매자 로그인</div>"
	 	+ " 		   </div>"
		+ "         </div>"
		+ "		  </div>";
		let li_login = document.querySelector(".navbar__menu__item.login");
		//console.log(li_login);
		li_login.innerHTML = loginDiv_html;
		let DOM__loginDiv = document.querySelector(".loginDiv__wrapper");
		DOM__loginDiv.style.display = "block";
		windowAddEvent();
	}else{
		//alert("lginDiv else문");
		//alert("event.target : " + event.target);
		event.stopPropagation();
		//event.stopPropagation();
		/*
		console.log("event.target : " + event.target);
		if(event.target == xxx){
			alert("lginDiv 두번째 if문");
			*/
	}
}
	

	/* 윈도우 이벤트 관련 함수 2개*/
	function windowAddEvent() {
		//alert("windowAddEvent 함수");
		event.stopPropagation();
		window.addEventListener("click", windowEvent);
		//event.stopPropagation();
		}

		function windowEvent(event) {
		const DOM__loginDiv = document.querySelector(".loginDiv__wrapper");
		if (event.target == DOM__loginDiv) {
			// alert("windowEvent if문");
		} else {
			// alert("windowEvent else문");
			//DOM__loginDiv.style.display ="none";
			DOM__loginDiv.style.display="none";
			DOM__loginDiv.remove();
			window.removeEventListener("click", windowEvent);

		}
	}


/* 로그인창 display 컨트롤 과거함수 */
function loginDiv_past(event) {
	//alert("loginDiv함수 입구");
	const DOM__loginDiv = document.querySelector(".loginDiv__wrapper");
	DOM__loginDiv.style.display = "block";
	windowAddEvent();
	//event.stopPropagation();
	//alert("loginDiv함수 출구");
}   

/* 로그인창 변환 -> 구매자 로그인창 */
function logInKakao(event) {
	event.stopPropagation();
	let common__login__div = document.querySelector(".common__login__div");
	common__login__div.innerHTML ="<div class=\"subLoginBtn buyerLogin__title\">구매자 로그인</div>"
		+ "  <div class=\"buyerLogin__input__div\">"
		+ "    <a href=\"/kakaoLogIn\">\r\n"
		+ "         <img width=\"140\" height=\"33\" src=\"../res/imgs/kakao_login_medium_narrow.png\"/>\r\n"
		+ "    </a>"
		+ "	</div>"
		+ " <div class=\"subLoginBtn sellerLogin\" onclick=\"logInSeller(event)\">판매자 로그인</div>";

}
/* 로그인창 변환 -> 판매자 로그인창 */
function logInSeller(event) {
	event.stopPropagation();
	let common__login__div = document.querySelector(".common__login__div");
	common__login__div.innerHTML =" <div class=\"subLoginBtn buyerLogin\" onclick=\"logInKakao(event)\">구매자 로그인</div>"
		+ " <div class=\"subLoginBtn sellerLogin__title\">판매자 로그인</div>"
		+ "             <div class=\"sellerLogin__input__div\">"
		+ "                <input type=\"text\" name=\"selCode\" class=\"input text medium sellerInput\" placeholder=\"아이디\">\n"
		+ "                <input type=\"password\" name=\"selPassword\" class=\"input text medium sellerInput\" onkeyup=\"if(window.event.keyCode==13){submitSellerLogIn();}\" placeholder=\"비밀번호\">\n"
		+ "                <input type=\"button\" class=\"sellerLogin__btn\" value=\"로그인\" onClick=\"submitSellerLogIn()\">\n"
		+ "				</div>";
		
}       
		  //const loginBtn = document.querySelector(".navbar__menu__item login");


/* 로그인 관련 */
/*
function logInKakao(event) {
	event.stopPropagation();
	let buyerLogin = document.getElementsByClassName("buyerLogin")[0];
	buyerLogin.innerHTML = "<a href=\"/kakaoLogIn\">\r\n"
	+ "                    <img width=\"140\" height=\"33\" src=\"../res/imgs/kakao_login_medium_narrow.png\"/>\r\n"
	+ "                </a>";
}
*/
function submitSellerLogIn() {
	let loginDiv = document.getElementsByClassName("loginDiv__wrapper")[0];
	let form = document.createElement("form");
	form.action = "sellerLogIn";
	form.method = "post";
	form.appendChild(loginDiv);
	form.style.display = "none";
	document.body.appendChild(form);
	form.submit();
}     


/* 로그아웃 */
function logOut() {
	if(accessInfo != null) {
		if(accessInfo.userType == 'seller') {
			//판매자로그아웃         		
			let form = document.createElement("form");
			form.action = "sellerLogOut";
			form.method = "post";
			document.body.appendChild(form);
			form.submit();
		} else if(accessInfo.userType == 'buyer'){
			//구매자로그아웃
			location.href = "/kakaoLogOut";
		}
	}
}

/* 회원가입 페이지 이동 */
function moveJoin() {
	let form = document.createElement("form");
	form.action = "moveSelectJoin";
	form.method = "post";
	document.body.appendChild(form);
	form.submit();
}

/* 마이페이지 이동 */
function moveAccountInfo(){
	let form = document.createElement("form");
	form.action = "moveAccountInfo";
	form.method = "post";
	document.body.appendChild(form);
	form.submit();
}          

/* 마이샵 이동 */
function moveMyshop() {	 
	//let prdSelCode = accessInfo.selCode;      
	let form = document.createElement("form");
	form.action = "moveMyshop";
	form.method = "post";            	            	
	form.appendChild(createHidden("prdSelCode",accessInfo.selCode));
	document.body.appendChild(form);
	form.submit();          	
}

function moveMyPage() {	 
	//let prdSelCode = accessInfo.selCode;      
	let form = document.createElement("form");
	form.action = "moveAccountInfo";
	form.method = "post";            	            	
	form.appendChild(createHidden("prdSelCode",accessInfo.buyCode));
	document.body.appendChild(form);
	form.submit();
}
      

/* 헤더 상품 검색창 */
function searchProduct(){
//alert("서치함수");
let input = document.querySelector(".search__input.text");
if(input.value != null){
	if(input.value == " "){
	alert("공백 외 검색어를 입력해주세요.");
	}else if(input.value ==""){
	alert("검색어를 입력해주세요.(2)");
	}else{
	let form = document.querySelector(".search_form");
	form.method="POST";
	form.action="searchProduct";
	form.submit();
	}
}else{
	alert("검색어를 입력해주세요.(1)");
}
}