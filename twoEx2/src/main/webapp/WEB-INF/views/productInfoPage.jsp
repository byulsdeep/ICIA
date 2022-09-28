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
    /* init 계열 ********************/
    function init() {   	
        //alert("init함수 입구");
        /* 공통요소 세션 */
        postAjaxJson("isSession", null, "isSessionCallBack");
        /* 셀러 정보 */
        let sellerInfo = JSON.parse('${json_sellerInfo}');
        //alert('셀러정보 json_sellerInfo :  ' + sellerInfo);
        makeSellerInfo(sellerInfo);
        /* 상품정보 */
        let json_productInfo = JSON.parse('${json_productInfo}');
        //alert('상품정보 json_productInfo : ' + json_productInfo);
        makeProductInfo(json_productInfo);
        
        if(!json_productInfo){
          makeOrderBtn(json_productInfo);
        }else{
          console.log("init() 상품정보 없음");
        }
    }

    /*
    function makeExecuteOrderBtn(json_productInfo){
      consol.log("makeOrderBtn 함수");
      let moveOrderBtn = document.querySelector(".content__btn btn__purchase.moveOrder");
      moveOrderBtn.addEventListener("click", ()=>{executeOrder(json_productInfo); });
    }
    */

    function isSessionCallBack(ajaxData) {
      //alert("isSessionCallBack 함수 입구");
      console.log(ajaxData);
      if(!ajaxData){
        //alert("if문 : ajaxData가 없을 때");
        accessInfo_global = null;
        makeOtherHTML();
      }else{
        //alert("else문 : ajaxData가 있을 때");
        accessInfo = JSON.parse(ajaxData);
        accessInfo_global = accessInfo;
        makeHeader(accessInfo);
        makeOtherHTML();
      }
    }
    function makeOtherHTML(){
      /** 로그인 상태 여부 확인 필요 *****************************/
      //alert("엑세스 인포 전역변수 : " +accessInfo_global);
        if(accessInfo_global!=null){
          //alert("if문 엑세스인포가 있을 때");
          //alert("팔로우 위시 체크 전 : " + accessInfo_global.userType);
          if(accessInfo_global.userType=="buyer"){
            /* 조회 관련 */
            //alert("if문 구매자 로그인 상태");
            let json_vhb = JSON.parse('${json_vhb}');
            checkWish(json_vhb);
            
            /* 팔로우 상태 조회*/
            let json_folbList = JSON.parse('${json_folbList}');
            checkFollow(json_folbList);
          }else if(accessInfo_global.userType=="seller"){
            //alert("if문 판매자 로그인 상태");
            let heart = document.querySelector(".fa-heart");
            heart.addEventListener("click", ()=>{alert("구매자로 로그인 해주세요.");});
            let followBtn = document.querySelector(".seller__info__btn.followSeller");
            followBtn.addEventListener("click", ()=>{alert("구매자로 로그인 해주세요.");});
          }
        }else{
          let heart = document.querySelector(".fa-heart");
          heart.addEventListener("click", ()=>{alert("구매자로 로그인 해주세요.");});
          let followBtn = document.querySelector(".seller__info__btn.followSeller");
          followBtn.addEventListener("click", ()=>{alert("구매자로 로그인 해주세요.");});
        }
    }
    
   
    
  
    /*** 조회 관련 ***/
    function checkWish(json_vhb){
      //alert("checkWish 함수 입구");
      let heart = document.querySelector(".fa-heart");
      
          //alert("json_vhb.vhsWishAction  : " +  json_vhb.vhsWishAction);
          if(json_vhb.vhsWishAction == "N"){
            //alert("N");
            heart.className = "fa-regular fa-heart";
          }else if(json_vhb.vhsWishAction == "Y"){
            //alert("Y");
            heart.className = "fa-solid fa-heart";
          }else{
            //alert("위시상태 조회 실패");
          }
          heart.addEventListener("click", () => changeWish(json_vhb));
    }
    function changeWish(json_vhb){
      //alert("changeWish 함수 입구 ");
          let heart = document.querySelector(".fa-heart");
          if(json_vhb != null){
            if(heart.className=="fa-solid fa-heart"){
              let clientData ="vhsBuyCode=" + json_vhb.vhsBuyCode +"&" + "vhsPrdCteCode=" + json_vhb.vhsPrdCteCode +"&";
              clientData += "vhsPrdSelCode=" + json_vhb.vhsPrdSelCode + "&" + "vhsPrdCode=" +json_vhb.vhsPrdCode+ "&";
              clientData += "vhsWishAction=" + "Y";
              //alert("clientData :  " + clientData);
              postAjaxJson("changeWish", clientData, "changeWishCallBack")
            }else if(heart.className=="fa-regular fa-heart"){
              let clientData ="vhsBuyCode=" + json_vhb.vhsBuyCode +"&" + "vhsPrdCteCode=" + json_vhb.vhsPrdCteCode +"&";
              clientData += "vhsPrdSelCode=" + json_vhb.vhsPrdSelCode + "&" + "vhsPrdCode=" +json_vhb.vhsPrdCode+ "&";
              clientData += "vhsWishAction=" + "N";
              //alert("clientData :  " + clientData);
              postAjaxJson("changeWish", clientData, "changeWishCallBack")
            }else{
              //alert("heart 값 오류");
            }
          }
      
    }
    function changeWishCallBack(ajaxData){
      //alert("콜백 함수 입구");
      //alert("ajaxData :  " + ajaxData);
      let vhbList_back = JSON.parse(ajaxData);
      let heart = document.querySelector(".fa-heart");
      if(vhbList_back[0].message == null ){
        if(vhbList_back[0].vhsWishAction == "Y"){
          //alert("vhbList_back :  " + vhbList_back);
          //alert("vhbList_back.vhsBuyCode :  " + vhbList_back[0].vhsBuyCode);
          //alert("vhbList_back.vhsWishAction :  " + vhbList_back[0].vhsWishAction);
          heart.className = "fa-solid fa-heart";
          followSellerBtn.removeEventListener("click", "changeWish");
          heart.addEventListener("click", () => changeWish(vhbList_back[0]));
        }else if(vhbList_back[0].vhsWishAction == "N"){
          //alert("vhbList_back :  " + vhbList_back);
          //alert("vhbList_back.vhsBuyCode :  " + vhbList_back[0].vhsBuyCode);
          //alert("vhbList_back.vhsWishAction :  " + vhbList_back[0].vhsWishAction);
          heart.className = "fa-regular fa-heart";
          followSellerBtn.removeEventListener("click", "changeWish");
          heart.addEventListener("click", () => changeWish(vhbList_back[0]));
        }
      }else if(vhbList_back[0].message != null){
        //alert(vhbList_back[0].message);
      }
    }
    /*** 셀러정보 ******************************/
    function makeSellerInfo(sellerInfo){
      console.log('maekeSellerInfo 함수 입구 ');
      console.log(sellerInfo);
      console.log('셀럽샵 : ' + sellerInfo.selShopName);
      console.log('셀럽프로필 : ' + sellerInfo.selProfile);
      /*
      String selCode;
      String selEmail;
      String selNickname;
      String selProfile;
      String selShopName;
      String selPassword;
      String userType;
      */
      //alert("셀러명 텍스트 : " + document.querySelector(".seller__title h3").innerText);
      document.querySelector(".seller__title h3").innerText = sellerInfo.selShopName;
      /* 셀러샵 페이지 이동 버튼*/
      //alert("셀러코드 : " + sellerInfo.selCode);
      document.querySelector(".seller__info__btn.moveSellerShop").addEventListener("click", ()=>{moveSellerShop(sellerInfo.selCode);});
    }
    /** 셀러샵 이동 **/
    function moveSellerShop(selCode){
      //alert("moveSellerShop 함수");
      let form = document.createElement('form');
      form.appendChild(createFormInput("selCode", selCode));
    
      //alert(form);
      form.method="POST";
      form.action="moveSellerShop"
        document.body.appendChild(form);
      form.submit()
      //alert("moveSellerShop 출구");
    }
    /** 팔로우 정보 ***********************/
    function checkFollow(json_folbList){
      //alert("checkFollow 함수 입구");
      let followBtn = document.querySelector(".seller__info__btn.followSeller");
            //alert("checkFollow json_folbList.folAction :  " + json_folbList.folAction);
            if(json_folbList != null){
              if(json_folbList.folAction == "Y"){
                //alert("checkFollow 함수 if문 안");
                followBtn.value = "팔로잉";
                followBtn.addEventListener("click", ()=> changeFollow(json_folbList));
                followBtn.style.color = "#ff6863";
              }else if(json_folbList.folAction == "N"){
                //alert("checkFollow 함수 if문 안");
                followBtn.value = "팔로우";
                followBtn.addEventListener("click", ()=> changeFollow(json_folbList));
                followBtn.style.color = "#4ba59c";
              }
            }else{
              console.log("followInfo가 없는 듯 : " + json_folbList);
              //alert("checkFollow else문");
            }
            
    }
    function changeFollow(followInfo){
      //alert("changeFollow 함수 입구");
          //alert("changeFollow followiInfo.folAction :  " + followInfo.folAction);
              let followBtn = document.querySelector(".seller__info__btn.followSeller");
              if(followBtn.value =="팔로잉"){
                followInfo.folAction = "Y"
                let clientData ="folBuyCode=" + followInfo.folBuyCode +"&" + "folSelCode=" + followInfo.folSelCode +"&" + "folAction="+"Y";
                //alert("clientData :  " + clientData);
                postAjaxJson("changeFollow", clientData, "changeFollowCallBack");
              }else if(followBtn.value =="팔로우"){
                followInfo.folAction = "N"
                let clientData ="folBuyCode=" + followInfo.folBuyCode +"&" + "folSelCode=" + followInfo.folSelCode +"&"+"folAction="+"N";
                //alert("clientData :  " + clientData);
                postAjaxJson("changeFollow", clientData, "changeFollowCallBack");
              }
       
     
    }
    
    function changeFollowCallBack(ajaxData){
      //alert("콜백 함수 입구");
          //alert("changeFollowCallBack ajaxData : " + ajaxData);
      let followInfo = JSON.parse(ajaxData);
          //alert("changeFollowCallBack followInfo :  " + followInfo);
      let followSellerBtn = document.querySelector(".seller__info__btn.followSeller");
      if(followInfo.folAction != null){
        if(followInfo.folAction == "Y"){
              //alert("changeFollowCallBack 함수 if문 안");
          followSellerBtn.value = "팔로잉";
          followSellerBtn.style.color = "#ff6863"; //팔로잉
          /*
          followSellerBtn.removeEventListener("click", changeFollow);
          followSellerBtn.addEventListener("click", ()=> changeFollow(followInfo));
          */
              //alert("cfCB Y일 때 folAction : " + followInfo.folAction);
        }else if(followInfo.folAction =="N"){
          //alert("changeFollowCallBack 함수 if문 안");
          followSellerBtn.value = "팔로우";
          followSellerBtn.style.color = "#4ba59c";//팔로우
          /*
          followSellerBtn.removeEventListener("click", changeFollow);
          followSellerBtn.addEventListener("click", ()=> changeFollow(followInfo));
          */
          //alert("cfCB N일 때 folAction : " + followInfo.folAction);
        }
      }else{
      }
    }
    /*** 상품정보 ***/
    function makeProductInfo(json_productInfo){
    //alert("makeProductInfo 입구");
    //alert(document.querySelector(".product__info.title h3"));
    //alert(document.querySelector(".product__info title").children[0]);
    console.log("prdName : "+ json_productInfo.prdName);
    console.log("prdInfo : "+ json_productInfo.prdInfo);
    console.log("prdInfo : "+ json_productInfo.prfLocation);
    console.log("prdType : "+ json_productInfo.prdType);
    console.log("prdStartDate : "+ json_productInfo.prdStartDate);
    console.log("prdEndDate : "+ json_productInfo.prdEndDate);
    
  
    //let title = document.querySelector(".product__info title");
    let title = document.querySelector(".product__info.product__title h1");
    let photo = document.querySelector(".product__info.product__img");
    let description = document.querySelector(".product__info.description");
    let prdType = document.querySelector(".option.prdType");
    let prdStartDate = document.querySelector(".option.prdStartDate");
    let prdEndDate = document.querySelector(".option.prdEndDate");
	  let price = document.querySelector(".price__tag__price");

    if(json_productInfo.prdType =="N"){
      prdType.innerHTML = "일반 상품";
    }else if(json_productInfo.prdType=="C"){
      prdType.innerHTML = "클래스룸 상품";
    }

    photo.src = json_productInfo.prfLocation;
    title.innerText = json_productInfo.prdName;
    prdStartDate.innerHTML = json_productInfo.prdStartDate.substr(0, 10);
    prdEndDate.innerText = json_productInfo.prdEndDate.substr(0, 10);
    description.innerHTML = json_productInfo.prdInfo;
    price.innerText = json_productInfo.prdPrice;
    
    //makeMoveOrderBtn(json_productInfo);
  }
  
  /*
  function makeMoveOrderBtn(json_productInfo){
    //alert("makeMoveOrderBtn 함수 입구");
    let moveOrderBtn = document.querySelector(".content__btn.btn__purchase.moveOrder");
    moveOrderBtn.addEventListener("click", ()=> executeOrder(json_productInfo));
  }
  */

  function moveOrder(json_productInfo){
	 
      //alert("moveOrder 함수 입구");
      
      if(accessInfo_global!=null){
          if(accessInfo_global.userType == "buyer"){
        	 
              /** input 생성 **/
              let form = document.createElement('form');
              form.appendChild(createInput('hidden', 'prdCteCode', '', null, json_productInfo.prdCteCode));
              form.appendChild(createInput('hidden', 'prdSelCode', '', null, json_productInfo.prdSelCode));
              form.appendChild(createInput('hidden', 'prdCode', '', null, json_productInfo.prdCode));
              /*
                // cteCode
                let input1 = document.createElement('input');
                input.setAttribute('type', 'hidden');
                input.setAttribute('name','prdCteCode');
                input.setAttribute('value', json_productInfo.prdCteCode);
                // selCode
                let input2 = document.createElement('input');
                input.setAttribute('type', 'hidden');
                input.setAttribute('name','prdSelCode');
                input.setAttribute('value', json_productInfo.prdSelCode);
                
                // prdCode
                let input3 = document.createElement('input');
                input.setAttribute('type', 'hidden');
                input.setAttribute('name','prdCode');
                  input.setAttribute('value', json_productInfo.prdCode);
              */
                /** form에 추가 **/
                
                //alert("인풋 안 밸류 : " + input1.value +" "+input2.value+" "+input3.value);
                /*
                form.appendChild(input1);
                form.appendChild(input2);
                form.appendChild(input3);
              */
                //alert(form);
                /** 보내기 **/
                form.method="POST";
                form.action="moveOrder"
                document.body.appendChild(form);
                form.submit()
            
          }else{
            alert("구매자로 로그인 해주세요.");
            //location.href="http://192.168.1.47/";
          }
      }else{
        alert("구매자로 로그인 해주세요.");
        //location.href="http://192.168.1.47/";
      }
      //alert("moveOrder 출구");
    }
    
    function loginCheck(){
      if(accessInfo!=null){
        if(accessInfo.userType == "buyer"){
        }else{
          alert("구매자로 로그인 해주세요.");
        }
      }else{
        alert("구매자로 로그인 해주세요.");
      }
    }
    //판매자 전문분야 등록(선택된 체크박스값 불러옴 ->한개선택 인서트 가능,다중인서트 완성해야됨)
  /*
    function purchase(){    
  	   let prdName = document.querySelector(".product__info.title h3");
         let form = document.getElementsByName("product")[0];
         form.action="kakaopay";
         form.method="post";
         form.appendChild(createHidden("prdName", prdName.innerText));
         
         
         form.submit();
    }
  */
  //구매하기
  function executeOrder(){     	
     
    //alert("executeOrder 함수 입구");
    //alert("productInfo EL : " + '${productInfo}');
    //alert("productInfo.prdCode EL : " + '${productInfo.prdCode}');
      
      if(accessInfo_global!=null){
          if(accessInfo_global.userType == "buyer"){
            let prdCode = '${productInfo.prdCode}';
            let prdSelCode = '${productInfo.prdSelCode}';
            let prdPrice = '${productInfo.prdPrice}';
            let prdName = '${productInfo.prdName}';
            let prdCteCode = '${productInfo.prdCteCode}';
            let prdType = '${productInfo.prdType}';
              
            let form = document.createElement("form");
            form.action="kakaopay";
            form.method="post";
            form.appendChild(createHidden("prdCode", prdCode));
            form.appendChild(createHidden("prdSelCode", prdSelCode));
            form.appendChild(createHidden("prdPrice", prdPrice));
            form.appendChild(createHidden("prdName", prdName));
            form.appendChild(createHidden("prdCteCode", prdCteCode));
            form.appendChild(createHidden("prdType", prdType));
            document.body.appendChild(form);
            form.submit();
                  
          }else{
            alert("구매자로 로그인 해주세요.");
            //location.href="http://192.168.1.47/";
          }
      }else{
        alert("구매자로 로그인 해주세요.");
        //location.href="http://192.168.1.47/";
      }
      //alert("moveOrder 출구");



 }


 function createHidden(objName, value){
   let input = document.createElement("input");
   input.setAttribute("type", "hidden");
   if(objName != null) input.setAttribute("name", objName);
   if(value != null) input.setAttribute("value", value);
   return input;
 }


  
    </script><!-- 스크립트 끝-------------------------------------->
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
            </li>
            <li class="navbar__menu__item join" data-link="join" onclick="moveJoin()">회원가입</li>
          </ul>
        </div>
      </div>
    </nav> <!-- [Navbar] 끝 -->
    <!--- [ contentZone ] --------------------------------------------------------------------->
    <main id="common__zone">
        <div id="common__wrapper lse">
            <div class="inner__wrapper">
                  <div class="product__info__zone">
                    <div class="product__info product__title">
                      <h1>제목입니다. 제목입니다. 제목입니다.</h1>
                    </div>
                    <div class="product__info photo">
                      <img class="product__info product__img" src="imgs\product__sample.jpg">
                    </div>
                    <div class="product__info option">
                      <span>
                          <span>타입 :</span>
                          <span class="option prdType">샘플</span>
                      </span>
                      <span>
                          <span>시작일 :</span>
                          <span class="option prdStartDate">샘플</span>
                      </span>
                      <span>
                          <span>종료일 : </span>
                          <span class="option prdEndDate">샘플</span>
                      </span>
                    </div> 
                    <div class="product__info description">
                      <h3>
                        Lorem ipsum dolor sit amet consectetur adipisicing elit. Consequatur et laudantium a, quidem quas quia quis. Tempore mollitia cupiditate velit tempora veniam culpa blanditiis cum, consequuntur excepturi earum harum ullam? Lorem ipsum dolor sit, amet consectetur adipisicing elit. Repellat praesentium ratione labore animi sapiente dolores aperiam enim, laudantium, voluptate, adipisci optio fuga vitae nam vel eum. Aspernatur beatae similique quas? Lorem ipsum dolor sit amet consectetur adipisicing elit. Nihil at pariatur, ad ratione facere dolorem accusantium temporibus reiciendis voluptatem expedita, tempora non nobis numquam tempore libero laborum quisquam excepturi. Doloribus. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Excepturi illum eos, numquam pariatur assumenda sunt veritatis! Distinctio optio, perferendis officiis dignissimos sapiente nulla! Accusamus dignissimos error doloremque dolores, vel expedita. Lorem ipsum dolor sit amet consectetur adipisicing elit. Nostrum dolor obcaecati sed deserunt repellendus voluptates praesentium doloribus officia iusto blanditiis neque ut, beatae fuga unde. Porro maxime reiciendis adipisci provident.
                      </h3>
                    </div>
                  </div>
                  <!-- other_Info__zone-->
                  <div class="other__Info__zone">
                    <div class="other__info seller">
                        <div class="seller__blank">
                        </div>
                        <div class="seller__info">
                          <div class="seller__title">
                            <h3>셀러 또는 샵 이름</h3> 
                          </div>
                          <div class="seller__info__btnDiv">
                            <input type="button" class="seller__info__btn moveSellerShop" value="판매자샵 방문">
                            <input type="button" class="seller__info__btn followSeller" value="팔로우">
                          </div>
                        </div>
                    </div>
                    <div class="other__info price">
                      <div class="price__div">
                        <div class="price__title__div">
                          <span class="price__title">가격 : </span>
                        </div>
                        <div class="price__tag__div">
                          <span class="price__tag__price">샘플가격</span>
                          <span> 원</span>
                        </div>
                      </div>
                      <div class="price__btnDiv">
                        <!--<input type="button" class="wishBtn" value="♡">-->
                        <div class="wishBtn">
                          <i class="fa-regular fa-heart"></i>
                          <!--<i class="fa-solid fa-heart"></i>-->
                        </div>
                        <input class="content__btn btn__purchase moveOrder" type="button" value="구매하기" onclick="executeOrder()">
                      </div>
                    </div>
                  </div>
            </div><!-- inner_wrapper -->
        </div>    
    </main>
    <form name="product"></form>
  </body>
</html>