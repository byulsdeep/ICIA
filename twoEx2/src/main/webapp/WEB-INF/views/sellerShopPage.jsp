<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <html lang="ko">
    <head>
      <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>::: TwoEX ::: 교환 플랫폼 </title>
        <!-- 기타 meta 정보 -->
          <meta name="mainPage" content="TwoEx site">
          <meta name="author" content="TwoEX">
          <link rel="icon" type="image/png" href="">
       
        <!-- LOGO, FONT SOURCE-->
        <!-- Font Awesome 부분은 이클립스 랙걸려서 임시로 빼놨습니다 -->
        <!--
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="">
        <link href="https://fonts.googleapis.com/css2?family=Raleway:ital,wght@0,800;1,900&amp;display=swap" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="">
        <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@900&amp;display=swap" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="">
        <link href="https://fonts.googleapis.com/css2?family=Exo:wght@800;900&amp;display=swap" rel="stylesheet">
        -->
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
    
        <!-- JS, CSS 연결 -->
          <link rel="stylesheet" href="res/css/style.css">
          <link rel="stylesheet" href="res/css/header.css">
          <link rel="stylesheet" href="res/css/sellerShopPage.css">
          <link rel="stylesheet" href="res/css/myShop.css">
          <script src="res/js/main.js" defer=""></script>
          <script src="res/js/header.js" defer></script>  
    <script>       
        let selCode;
        
        function init() {   	
            postAjaxJson("isSession", null, "isSessionCallBack");

            /* 셀러 정보 */
            let json_sbList = JSON.parse('${json_sbList}');
            makeSellerInfo(json_sbList);

            /* 셀러의 상품 */
            let json_pbList = JSON.parse('${json_pbList}');
            makeProductList(json_pbList, json_sbList);

            let json_paging = JSON.parse('${json_paging}');
            makePaging(json_paging);
            /* 팔로우 관련 */

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
        function makeSellerInfo(json_sbList){
          let sellerInfo__shopName = document.querySelector(".sellerInfo__shopName");
          let sellerInfo__sellerNickname = document.querySelector(".sellerInfo__sellerNickname");
          let seller__profile__div = document.querySelector(".seller__profile__div");
          let sellerInfo__sellerEmail = document.querySelector(".sellerInfo__sellerEmail");

          sellerInfo__shopName.innerText = json_sbList[0].selShopName;
          sellerInfo__sellerNickname.innerText = json_sbList[0].selNickname;
          seller__profile__div.innerText = json_sbList[0].selProfile;
          sellerInfo__sellerEmail.innerText = json_sbList[0].selEmail;
        }

		
//         function makeProductList(json_pbList){
//           alert("makeProductList 입구");
//           alert("json_pbList : " + json_pbList);
        
//         }


//         function makePaging(json_paging){
//           alert("makePaging 입구");
//           alert("json_paging : " + json_paging);
        
//         }



        
  /** 상품리스트 생성 **/
    /* -- 상품리스트 생성 함수 1 */
    function makeProductList(json_pbList, json_sbList){
      //alert("makeProductList() 입구");	
      //alert(json_pbList.length);
      
      let sample_img = "\res\imgs\product__default.jpg";
      // 삭제
      document.querySelector(".productList__container").remove();
      // 재생성
      let productList__container = createDiv("","productList__container","","");
      //alert("json_pbList.length : " + json_pbList.length);
      for(idx=0; idx<json_pbList.length; idx++){
        /*
        if(idx=0){
          alert("json_pbList[idx].prdCode : " + json_pbList[idx].prdCode);
        }
        */
        // 0번 : json_sbList[0].selShopName
        productList__container.appendChild(makeItem(json_pbList[idx].prfLocation, json_pbList[idx].prdCteCode, json_pbList[idx].prdSelCode, json_pbList[idx].prdCode, json_pbList[idx].prdName, json_pbList[idx].prdPrice, json_pbList[idx].prdType, json_sbList[0].selShopName));
        //alert("사진파일주소 : " + json_pbList[idx].prfLocation);
      }

      /* html에 넣기*/
      console.log(productList__container);
      let productList__zone = document.querySelector(".productList__zone");
      productList__zone.appendChild(productList__container);
    }	

    /* -- 상품리스트 생성 함수 1 (상품아이템 생성) */
    function makeItem(prfLocation, prdCteCode, prdSelCode, prdCode, prdName, prdPrice, prdType, selShopName){
      let productItem = createDiv("","product__item item1", "", "");
      
      /** image **/
      let productImageDiv = productItem.appendChild(createDiv("", "product__image__div", "", ""));
      let productImage = document.createElement("img");
          productImage.setAttribute("class","product__image");
          productImage.setAttribute("src", prfLocation);
      productImageDiv.appendChild(productImage);
      productItem.appendChild(productImageDiv);
      /** 상품정보 페이지 이동 함수 **/
      /**
       * 카테고리 코드 : prdCteCode
       * 셀러 코드 : prdSelCode
       * 상품 코드 : prdCode
       */

      productItem.addEventListener("click", ()=> moveProductInfo(prdCteCode, prdSelCode, prdCode));

      /** 나머지 정보 **/ 
      /* 판매자 */
      let product__seller__div = createDiv("","product__seller__div","",prdSelCode);
      product__seller__div.innerHTML = "<span>판매자 : </span><span class=\"sellerShop\">"+selShopName+"</span>";
      productItem.appendChild(product__seller__div); /* 샵 네임으로 바꿔야함 */

      /* 상품명 */
      productItem.appendChild(createDiv("","product__title__div","",prdName));
      /* 가격 */
      productItem.appendChild(createDiv("","product__price__div","",prdPrice));

      

      /* 기타 정보 */
      let classOption;
      if(prdType == "C"){
        classOption = "클래스룸 상품";
      }else if(prdType="N"){
        classOption = "일반 상품";
      }else{
        classOption ="DB확인필요";
      }
      let product__etc__div = createDiv("","product__etc__div","","");
      product__etc__div.innerHTML ="<span class=\"classOption\">"+classOption+"</span>"
      productItem.appendChild(product__etc__div);

      return productItem;
    }
        </script>    
        </head>
    <body onLoad="init()">
        <!-- [Navbar] ------------------------------------------------------->
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
        <main id="common__zone">
            <div class="sellerShop__content__zone">
              <h1>셀 러 샵</h1>
              <div class="sellerShop__wrapper">
                      <!-- [ 1 샵 정보 ] -->
                      <div class="seller__info__container">
                        <h2>샵 정보</h2>
                        <div class="seller__info__div">
                            <!--
                            <div class="sellerInfo__image info_detail_div">
                                image
                            </div>
                            -->
                            <div class="selerInfo__detail">
                                <div class="info_detail_div">
                                    <span class="sellerInfo__span">샵이름 : </span>
                                    <span class="sellerInfo__shopName">shopName</span>
                                </div>
                                <div class="info_detail_div">
                                    <span class="sellerInfo__span">셀러닉네임 : </span>
                                    <span class="sellerInfo__sellerNickname">sellerNickname</span>
                                </div>
                                <div class="info_detail_div">
                                  <span class="sellerInfo__span">셀러 이메일 : </span>
                                  <span class="sellerInfo__sellerEmail">sellerEmail</span>
                              </div>
                                <div class="seller__followBtn">
                                    <span class="" ></span>
                                </div>
                            </div>
                        </div>
                    </div>
        
                    <!-- [ 2 셀러 소개글 ]-->
                    <div class="seller__profile__container">
                        <h2>소개글</h2>
                        <div class="seller__profile__div">
                              Lorem ipsum dolor sit amet, consectetur adipisicing elit. Iusto vero explicabo porro quidem deleniti tempore excepturi magni ad deserunt. Iste ad in nam asperiores ipsa. Explicabo quaerat incidunt minima eum! Lorem ipsum dolor, sit amet consectetur adipisicing elit. Dolore vitae aliquam consectetur repellendus autem maxime non, necessitatibus inventore, labore unde ipsam consequatur. Rem eveniet culpa nulla qui quisquam veniam consequuntur?
                              Lorem ipsum dolor sit amet consectetur adipisicing elit. Repudiandae vero provident quaerat nulla, ducimus illo facere ipsum, exercitationem aliquam molestias, voluptas ipsam sunt a officia. Quis dicta minus corrupti autem.
                        </div>
                    </div>
              </div><!-- -->
              <!-- [ 셀러 상품리스트 ]-->
                <div class="seller__productList__wrapper">
                    <h2>상품 리스트</h2>
                    <div class="productList__zone">
                        <div class="productList__container">
                            <!-- 상품리스트 공간-->
                        </div>
                    </div>
                    <!--페이징 --------------------->
                    <div class="paging__zone">
                      <div class="paging__div">
                        <ul class="paging__ul"></ul>
                      </div>
                    </div><!--페이징 끝------------->
                </div>     
            </div><!--sellerShop__content__zone 끝-->
        </main>	
        <!--[ 모달 시작 ] -------------------->
          <div class="modal__wrapper">
            <div class="common__modal">
              <div class="modal__head">
                <div class="modal__title">
                </div> 
                <div class="modal__close" onclick="closeModal()">
                  X
                </div>
              </div>
              <div class="modal__body">
              <!-- 자신의 전문분야 선택 -->
                  ${selectCte}
             <input type="button" value="등록" name="btn" onClick="regCte()"/>
                </div>
                <div class="moadl__content">
                </div>
              </div>
            </div>
        <form name = "clientData" ></form> 
        </body>
    </body>
    </html>