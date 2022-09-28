<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <!DOCTYPE html>
  <html lang="ko">

  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>::: TwoEX ::: 교환 플랫폼 </title>
    <!-- 기타 meta 정보 -->
    <meta name="mainPage" content="TwoEx site" />
    <meta name="author" content="TwoEX" />
    <link rel="icon" type="image/png" href="" />
    <!-- LOGO, FONT SOURCE ------------------------------>
    <script src="https://kit.fontawesome.com/1066a57f0b.js" crossorigin="anonymous"></script>

   <!-- JS, CSS 연결 ------------------------------>
   <script src="res/js/header.js" async></script>
   <script src="res/js/main.js"></script>
   <script src="res/js/main_LSE.js"></script>
   <script src="res/js/myPage.js" defer></script>
   <link rel="stylesheet" href="res/css/header.css" />
   <link rel="stylesheet" href="res/css/style.css" />
   <link rel="stylesheet" href="res/css/mainPage.css" />
   <link rel="stylesheet" href="res/css/modal.css" />

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


      .team__container__layer{
          background-color: var(--color-blue1);
          background: url('res/imgs/team.png') center/cover no-repeat;
      }
    </style>

    <!-- JS 스크립트 영역 -->
    <script>
      function init() {
        /* 세션 확인 */
        postAjaxJson("isSession", null, "isSessionCallBack");

        /* 카테고리 항목 생성 */
        postAjaxJson("getMainCategories", null, "categoryCallBack");

        /* 순위 상품 가져오기 */
        postAjaxJson("getProductListByRank", null, "getProductListByRankCallBack");


      }



      let accessInfo_2 = null;

      function isSessionCallBack(ajaxData) {
        //alert("isSessionCallBak 함수");
        //alert("ajaxData : " + ajaxData);
        console.log("ajaxData : " + ajaxData);

        if (!ajaxData) {
          //alert("if문 : ajaxData가 없을 때");
        } else {
          //alert("else문 : ajaxData가 있을 때");
          accessInfo = JSON.parse(ajaxData);
          accessInfo_2 = accessInfo;
          makeHeader(accessInfo);
        }
      }
      /*
        if(ajaxData != "") {
              accessInfo = JSON.parse(ajaxData);
              makeHeader(accessInfo);
        }
      }
      */

      function searchProduct() {
        //alert("서치함수");
        let input = document.querySelector(".search__input.text");
        if (input.value != null) {
          if (input.value == " ") {
            alert("공백 외 검색어를 입력해주세요.");
          } else if (input.value == "") {
            alert("검색어를 입력해주세요.(2)");
          } else {
            let form = document.querySelector(".search_form");
            form.method = "POST";
            form.action = "searchProduct";
            form.submit();
          }
        } else {
          alert("검색어를 입력해주세요.(1)");
        }
      }

      /*** 상품정보 페이지 이동 함수 **********************************/
      function moveProductInfo(prdCteCode, prdSelCode, prdCode) {
        //alert("moveProductInfo 입구");
        //alert("입구 카테고리 코드 : " + prdCteCode +" "+ prdSelCode +" "+ prdCode);
        let form = document.createElement('form');
        form.appendChild(createFormInput("prdCteCode", prdCteCode));
        form.appendChild(createFormInput("prdSelCode", prdSelCode));
        form.appendChild(createFormInput("prdCode", prdCode));
        //alert(form);

        form.method = "POST";
        form.action = "moveProductInfo"
        document.body.appendChild(form);
        form.submit()
        //alert("moveProductInfo 출구");
      }


      function openMemberModal(member) {
        //alert("member : " + member);

        document.querySelector("#" + member).style.display = "block";
      }

      function closeMemberModal(member) {
        document.querySelector("#" + member).style.display = "none";
      }

    </script><!-- 스크립트의 끝 ---------------------------------------------------------->

  </head>
  <!-- body 시작 -->

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
    <!-- [ Home ] -------------------------------------------------------------------->
    <section id="home">
      <div class="home_wrapper">
        <div class="home__container">
          <h1>반갑습니다.
            <br> 전문능력 교환 마켓 TwoEx 입니다.
          </h1>
          <h3 class="home__description">
            <h4>문제해결, 지식, 기술 그리고 취미까지 교환하는 마켓입니다.</h4>
            <h4>교환 및 지식강의 관리 클래스룸 서비스까지 지원합니다.</h4>
          </h3>
        </div>
        <div class="layer__wrapper">
          <div class="team__container__layer">
            <div class="team__introduction__div">
              <div class="team__introduction__div top">
                  <input class="member" id="lse" type="button" value="이상은" onclick="openMemberModal('member__lse')">
                  <input class="member" id="khb" type="button" value="강한별" onclick="openMemberModal('member__khb')">
                  <input class="member" id="kyc" type="button" value="곽윤철" onclick="openMemberModal('member__kyc')">
                  <input class="member" id="sjh" type="button" value="심준호" onclick="openMemberModal('member__sjh')">
                  <input class="member" id="lgj" type="button" value="이경준" onclick="openMemberModal('member__lgj')">
                  <input class="member" id="hjw" type="button" value="하진우" onclick="openMemberModal('member__hjw')">
              </div>
              <div class="team__introduction__div bottom">
                팀 The Error Killers 입니다
              </div>
            </div>
          </div>
          <div class="backlayer1">
          </div>
          <div class="backlayer2">
          </div>
        </div>
      </div>
    </section><!-- [ Home ] 끝 -->

    <!-- [ Category ] -->
    <section id="main__category__section" class="section__container">
      <h2>카테고리</h2>
      <h3>
        내게 필요한 지식과 기술 그리고 서비스들 찾으세요.
      </h3>
      <div class="main__category__items">
        <!-- 카테고리 아이템 시작
          <div class="main_category__item" data-category="99" onclick="moveCategory('99')">
              <div class="category__icon">
                  <i class="fab fa-html5 category__symbol symbol_1"></i>
              </div>
              <h2 class="main__category__title">카테고리1샘플</h2>
              <div class="mian__category__description">
                  카테고리1 설명들
              </div>
          </div>
           -->
      </div>
    </section>
    <!--카테고리 아이템 영역 끝-->

    <!-- [ Main product] ---------------->
    <section id="main__popularProduct__section" class="section__container">
      <h2>인기 상품</h2>
      <h3>TwoEX의 판매 인기 상품을 먼저 만나보세요.</h3>
      <div class="productList__zone">
        <div class="productList__container">
          <!-- [ 상품 리스트 공간 ] -->
          <!--
                    <div class="product__item item1">
                        <div class="product__image__div">
                            <img class="product__image" src="res/imgs/product__sample.jpg">
                        </div>
                        <div class="product__seller__div">
                            <span class="info_span">판매자 : </span>
                            <span class="selShopName">we2857</span>
                        </div>
                        <div class="product__title__div">
                            정적 HTML 요소
                        </div>
                        <div class="product__price__div">
                            <span></span>
                            <span>
                                <span class="product__price">10,000</span>
                                <span class="won__span">원</span>
                            </span>
                        </div>
                        <div class="product__etc__div">
                            <div></div>
                            <span class="classOption">(기타 정보 영역 div)</span>
                        </div>
                        <div class="product__btn__div">
                            <div>(버튼 옵션)</div>
                            <div>(버튼 옵션)</div>
                        </div>
                    </div>
                   -->
        </div>
      </div>
    </section>
    <!--------------------------------------------------------------------------------------------------------->
    <!--------------------------------------------------------------------------------------------------------->
    <!--------------------------------------------------------------------------------------------------------->
    <!-- [ Footer ] -->
    <section id="footer_section" class="section">
      <div class="footer__container">
        <h2 class="footer__title">Let's talk</h2>
        <h2 class="footer__contact__email">help@twoex.com</h2>
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
        <!--
            <h4 class="footer__description">
              (주)투엑스 인천시 미추홀구 학인동, 5층 대표 : 강한별 개인정보관리책임자 : 이상은  사업자등록번호 : 123-45-67890
              <br>
              통신판매업신고 : 2022-인천미추홀-1234 유료직업소개사업등록번호 : 제2022-12345-12-1-00012호 고객센터 : 1544-0000
              <br>
              (주)투엑스는 통신판매중개자이며, 통신판매의 당사자가 아닙니다. 상품, 상품정보, 거래에 관한 의무와 책임은 판매회원에게 있습니다.
            </h4>
        -->
        <p class="footer__contact__rights">
          </br>
          Copyright © 2022 twoEx Inc. All rights reserved.
        </p>
      </div>
    </section>
    <!-- <div></div> -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.4/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    <!-- 모달 ---------------------------------------------------------------------------------->
    <!-- 모달 ---------------------------------------------------------------------------------->
    <!-- 모달 ---------------------------------------------------------------------------------->
    <!-- 메인모달 시작 ------------------------------>
    <div id="member__khb" class="modal2__root" onclick="closeMemberModal('member__khb')">
      <div class="modal2__background"></div>
      <div class="modal2__wrapper">
        <div class="modal2__wrapper2">
          <div class="modal2__container">
            <div class="modal2__close" onclick="closeMemberModal('member__khb')">
              <i class="fa-solid fa-xmark"></i>
            </div>
            <div class="modal2__content">
              <div class="modal2__part__left">
              </div>
              <div class="modal2__part__right">
                <h1>팀 멤버소개</h1>
                <h2>강 한 별</h2>
                <span>Lorem ipsum dolor sit amet consectetur adipisicing elit. Magni quaerat voluptatibus ut doloremque
                  ullam facilis provident officiis laboriosam beatae soluta quasi earum libero quae tenetur, vitae dolor
                  iure iste perferendis.</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div><!-- 메인모달 끝---------------->
    <!-- 메인모달 시작 ------------------------------>
    <div id="member__kyc" class="modal2__root" onclick="closeMemberModal('member__kyc')">
      <div class="modal2__background"></div>
      <div class="modal2__wrapper">
        <div class="modal2__wrapper2">
          <div class="modal2__container">
            <div class="modal2__close" onclick="closeMemberModal('member__kyc')">
              <i class="fa-solid fa-xmark"></i>
            </div>
            <div class="modal2__content">
              <div class="modal2__part__left">
              </div>
              <div class="modal2__part__right">
                <h1>팀 멤버소개</h1>
                <h2>곽 윤 철</h2>
                <span>Lorem ipsum dolor sit amet consectetur adipisicing elit. Magni quaerat voluptatibus ut doloremque
                  ullam facilis provident officiis laboriosam beatae soluta quasi earum libero quae tenetur, vitae dolor
                  iure iste perferendis.</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div><!-- 메인모달 끝---------------->
    <!-- 메인모달 시작 ------------------------------>
    <div id="member__sjh" class="modal2__root">
      <div class="modal2__background"></div>
      <div class="modal2__wrapper">
        <div class="modal2__wrapper2">
          <div class="modal2__container">
            <div class="modal2__close" onclick="closeMemberModal('member__sjh')">
              <i class="fa-solid fa-xmark"></i>
            </div>
            <div class="modal2__content">
              <div class="modal2__part__left">
              </div>
              <div class="modal2__part__right">
                <h1>팀 멤버소개</h1>
                <h2>심 준 호</h2>
                <span>Lorem ipsum dolor sit amet consectetur adipisicing elit. Magni quaerat voluptatibus ut doloremque
                  ullam facilis provident officiis laboriosam beatae soluta quasi earum libero quae tenetur, vitae dolor
                  iure iste perferendis.</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div><!-- 메인모달 끝---------------->
    <!-- 메인모달 시작 ------------------------------>
    <div id="member__lgj" class="modal2__root">
      <div class="modal2__background"></div>
      <div class="modal2__wrapper">
        <div class="modal2__wrapper2">
          <div class="modal2__container">
            <div class="modal2__close" onclick="closeMemberModal('member__lgj')">
              <i class="fa-solid fa-xmark"></i>
            </div>
            <div class="modal2__content">
              <div class="modal2__part__left">
              </div>
              <div class="modal2__part__right">
                <h1>팀 멤버소개</h1>
                <h2>이 경 준</h2>
                <span>Lorem ipsum dolor sit amet consectetur adipisicing elit. Magni quaerat voluptatibus ut doloremque
                  ullam facilis provident officiis laboriosam beatae soluta quasi earum libero quae tenetur, vitae dolor
                  iure iste perferendis.</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div><!-- 메인모달 끝---------------->
    <!-- 메인모달 시작 ------------------------------>
    <div id="member__lse" class="modal2__root">
      <div class="modal2__background"></div>
      <div class="modal2__wrapper">
        <div class="modal2__wrapper2">
          <div class="modal2__container">
            <div class="modal2__close" onclick="closeMemberModal('member__lse')">
              <i class="fa-solid fa-xmark"></i>
            </div>
            <div class="modal2__content">
              <div class="modal2__part__left">
              </div>
              <div class="modal2__part__right">
                <h1>팀 멤버소개</h1>
                <h2>이 상 은</h2>
                <span>Lorem ipsum dolor sit amet consectetur adipisicing elit. Magni quaerat voluptatibus ut doloremque
                  ullam facilis provident officiis laboriosam beatae soluta quasi earum libero quae tenetur, vitae dolor
                  iure iste perferendis.</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div><!-- 메인모달 끝---------------->
    <!-- 메인모달 시작 ------------------------------>
    <div id="member__hjw" class="modal2__root">
      <div class="modal2__background"></div>
      <div class="modal2__wrapper">
        <div class="modal2__wrapper2">
          <div class="modal2__container">
            <div class="modal2__close" onclick="closeMemberModal('member__hjw')">
              <i class="fa-solid fa-xmark"></i>
            </div>
            <div class="modal2__content">
              <div class="modal2__part__left">
              </div>
              <div class="modal2__part__right">
                <h1>팀 멤버소개</h1>
                <h2>하 진 우</h2>
                <span>Lorem ipsum dolor sit amet consectetur adipisicing elit. Magni quaerat voluptatibus ut doloremque
                  ullam facilis provident officiis laboriosam beatae soluta quasi earum libero quae tenetur, vitae dolor
                  iure iste perferendis.</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div><!-- 메인모달 끝---------------->
  </body>

  </html>