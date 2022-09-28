<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>::: TwoEX ::: 교환 플랫폼</title>
    <!-- 기타 meta 정보 -->
    <meta name="mainPage" content="TwoEx site" />
    <meta name="author" content="TwoEX" />
    <link rel="icon" type="image/png" href="" />

    <!-- LOGO, FONT SOURCE-->
    <script
      src="https://kit.fontawesome.com/1066a57f0b.js"
      crossorigin="anonymous"
    ></script>
    <link
      href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600;700&family=Russo+One&display=swap"
      rel="stylesheet"
    />

    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Raleway:ital,wght@0,800;1,900&display=swap"
      rel="stylesheet"
    />

    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Orbitron:wght@900&display=swap"
      rel="stylesheet"
    />

    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Exo:wght@800;900&display=swap"
      rel="stylesheet"
    />
    <script>
      function updateEmail() {
        let form = document.createElement("form");
        form.appendChild(document.getElementsByName("buyEmail")[0]);
        form.action = "updateEmail";
        form.method = "post";
        document.body.appendChild(form);
        form.submit();
      }
      function updateRegion() {
        let form = document.createElement("form");
        form.appendChild(document.getElementsByName("buyRegion")[0]);
        form.action = "updateRegion";
        form.method = "post";
        document.body.appendChild(form);
        form.submit();
      }

      function moveDashBoard(claPrdCode, claSelCode, claCteCode){
        let form = document.createElement("form");
        
     
        form.action = "moveDashboard";
        form.method = "post";

        form.appendChild(createHidden("claPrdCode", claPrdCode));
        form.appendChild( createHidden("claSelCode", claSelCode));
        form.appendChild( createHidden("claCteCode", claCteCode));

        document.body.appendChild(form);
        form.submit();
          
      }
      function createHidden(objName, value) {
        let input = document.createElement("input");
        input.setAttribute("type", "hidden");
        input.setAttribute("name", objName);
        input.setAttribute("value", value);

        return input;
      }


      function init() {
          //alert("init함수 시작");
          postAjaxJson("isSession", null, "isSessionCallBack");
        
          let json_MCList = JSON.parse('${json_MCList}');
          let myClassList= "";
          let myClassList2= "";

          for(idx=0; idx < json_MCList.length; idx++){
            // 수강중
            if((json_MCList[idx].claState1 >= 0) && (json_MCList[idx].claState2 >= 0)){
            myClassList +=  "<div class=\"product__item item" +idx + "\" onClick=\"moveDashBoard(\'"+ json_MCList[idx].claPrdCode+"\',\'"+ json_MCList[idx].claSelCode + "\',\'" + json_MCList[idx].claCteCode + "\')\">\r\n"
            + "  <div class=\"product__image__div\">\r\n"
            + "      <img class=\"product__image\" src=\"" +json_MCList[idx].prfLocation +"\">\r\n"
            + "  </div>\r\n"
            + "  <div class=\"product__seller__div\">\r\n"
            + "      <span>전문가 : </span>\r\n"
            + "      <span class=\"sellerShop\">"+ json_MCList[idx].selNickName +"</span>\r\n"
            + "  </div>\r\n"
            + "  <div class=\"product__title__div\">\r\n"
            + "    "+ json_MCList[idx].claName +"\r\n"
            + "  </div>\r\n"
            + "  <div class=\"product__etc__div\">\r\n"
            + "      <div><div>시작일</div><div>" + json_MCList[idx].claStartDate +"</div></div>"
            + "      <div>~</div>\r\n"
            + "      <div><div>종료일</div><div>" + json_MCList[idx].claEndDate +"</div></div>\r\n"
            + "  </div>\r\n"
            + " <div class=\"product__btn__div\">"
            + "     <input type=\"button\" class=\"content__btn btn__blueGreen classList\" onClick=\"moveDashBoard(\'"+ json_MCList[idx].claPrdCode+"\',\'"+ json_MCList[idx].claSelCode + "\',\'" + json_MCList[idx].claCteCode + "\')\" value=\"클래스룸으로 이동\"/>"
            +"</div>"
            + "</div>"
              document.getElementsByName("myClassList")[0].innerHTML = myClassList;
            }
        
              // 수강전
            if(json_MCList[idx].claState1 < 0){
                myClassList2 +=  "<div class=\"product__item item" +idx + "\">\r\n"
            + "  <div class=\"product__image__div\">\r\n"
            + "      <img class=\"product__image\" src=\"" +json_MCList[idx].prfLocation +"\">\r\n"
            + "  </div>\r\n"
            + "  <div class=\"product__seller__div\">\r\n"
            + "      <span>전문가 : </span>\r\n"
            + "      <span class=\"sellerShop\">"+ json_MCList[idx].selNickName +"</span>\r\n"
            + "  </div>\r\n"
            + "  <div class=\"product__title__div\">\r\n"
            + "    "+ json_MCList[idx].claName +"\r\n"
            + "  </div>\r\n"
            + "  <div class=\"product__etc__div\">\r\n"
            + "      <div><div>시작일</div><div>" + json_MCList[idx].claStartDate +"</div></div> ~\r\n"
            + "      <div><div>종료일</div><div>" + json_MCList[idx].claEndDate +"</div></div>\r\n"
            + "  </div>\r\n"
            + " <div class=\"product__btn__div\">"
            + "     <input type=\"button\" class=\"content__btn btn__blueGreen classList\" onClick=\"moveDashBoard(\'"+ json_MCList[idx].claPrdCode+"\',\'"+ json_MCList[idx].claSelCode + "\',\'" + json_MCList[idx].claCteCode + "\')\" value=\"클래스룸으로 이동\"/>"
            +"  </div>"
            + "</div>"
                document.getElementsByName("myClassList")[1].innerHTML = myClassList2;

          }
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
      
    </script>

    <!-- JS, CSS 연결 -->
    <link rel="stylesheet" href="res/css/style.css" />
    <link rel="stylesheet" href="res/css/header.css" />
    <link rel="stylesheet" href="res/css/myPage.css" />
    <script src="res/js/main.js"></script>
    <script src="res/js/header.js"></script>
    <script src="res/js/myPage.js"></script>
    <script src="res/js/main_LSE.js"></script>
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
    <section id="common__zone__lse">
      <div id="common__wrapper__lse">
        <!--[공통 메뉴 시작] ------------------------------>
        <nav class="common__menu__Zone">
          <div class="common__menu">
            <div class="common__menu__title">마이페이지</div>
            <div class="common__menu__list">
              <div
                class="common__menu__item parentItem"
                onclick="moveAccountInfo()"
              >
                계정 정보
              </div>
              <div
                class="common__menu__item parentItem"
                onclick="moveViewHistory()"
              >
                조회 상품
              </div>
              <div
                class="common__menu__item parentItem"
                onclick="moveWishList()"
              >
                찜 상품 / 팔로우 목록
              </div>
              <div
                class="common__menu__item parentItem"
                onclick="moveOrderHistory()"
              >
                주문 목록
              </div>
              <div
                class="common__menu__item parentItem"
                onclick="moveMyClass()" style="color:var(--color-dark-pink);"
              >
                마이클래스
              </div>
            </div>
          </div>
        </nav>
        <!-- 공통 메뉴 끝 -->
        <!--[공통 컨텐츠 시작] ------------------------------>
        <div class="common__content__zone lse myPage">
          <div class="content__title">
            <h1>내 클래스</h1>
            <br>
          </div >
            <h2>수강 중 클래스</h2>
    
            <div class="listZone myClass" style='border: 1px solid #A18CD1; margin: 3px;' name="myClassList">
                <h3>
                  지금은 수강 중인 클래스가 없어요.
                </h3>
            </div>
            <h2>수강 전 클래스</h2>
    
            <div class="listZone myClass" style='border: 1px solid #A18CD1; margin: 3px;' name="myClassList">
                <h3>
                  지금은 수강 전인 클래스가 없어요.
                </h3>
            </div>
          </div>
        </div>
      </div>
    </section>
  </body>
</html>
