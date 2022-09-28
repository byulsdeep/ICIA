/** 카테고리 동적 생성 **/
  function categoryCallBack(ajaxData){
	  //alert("categoryCallBack 함수");
	  /* 카테고리 아이콘 심볼 */
      if(ajaxData != null){
    	cteList = JSON.parse(ajaxData);
  		        //alert("카테고리 정보" + cteList);
        /* 메인 카테고리 영역 선택 */
        let main__category__items = document.querySelector(".main__category__items");
        for(idx=0; idx<ajaxData.length; idx++){
            /* 아이콘 요소 생성 */
            let category__icon = createDiv('','category__icon','','');
            let category__symbol = document.createElement("i");
            
            /* 아이콘 클래스명 */
            console.log("ctySymbol : " + cteList[idx].cteSymbol);
            let icon_symbol = cteList[idx].cteSymbol;
            icon_symbol +=" "+" category__symbol" +" "+" symbol_" +idx;
            category__symbol.setAttribute("class", icon_symbol);
            category__icon.appendChild(category__symbol);
            /*
            let icon_symbol;
            for(i=0; i<icon_symbol_array.length; i++){
              if(icon_symbol_array[i][0] == cteList[idx].cteCode){
                icon_symbol = icon_symbol_array[i][1];
                //alert(icon_symbol);
              }
            }
            */
            //cteList[idx].cteCode

            /* 카테고리명 */
            let main__category__title = document.createElement("h2");
            let cteName = cteList[idx].cteName;
                //alert("카테네임 : " + cteName);
            main__category__title.innerHTML = cteName;
            /* 아이템 생성 */
            let main_category__item = createDiv('','main_category__item','','')
            let cteCode = cteList[idx].cteCode;
                //alert("카테코드 : " +cteCode);
            main_category__item.addEventListener('click', () => moveCategory(cteCode));
            /* 아이템에 넣기 */
            main_category__item.appendChild(category__icon);
            main_category__item.appendChild(main__category__title);
            /* 아이템 목록에 넣기 */
            main__category__items.appendChild(main_category__item);
        }
      }
   }


/** 카테고리 버튼 기능 */
function moveCategory(cteCode){
    //alert("moveCategory 입구");
   	//alert("입구 카테고리 코드 : " + cteCode);

    let input = document.createElement('input');
    input.setAttribute('type', 'hidden');
    input.setAttribute('name','cteCode');
    input.setAttribute('value', cteCode);

  	let form = document.createElement('form');
    //alert("인풋 안 밸류 : " + input.value);
    form.appendChild(input);
    //alert(form);
    
    form.method="POST";
    form.action="moveCategory"
	  document.body.appendChild(form);
    form.submit()
    //alert("moveCategory 출구");
}


/* 순위 상품 callback */
function getProductListByRankCallBack(ajaxData){
  console.log("getProductListByRankCallBack 콜백 함수");
  //alert("순위함수 콜백 : " + ajaxData);
  console.log("ajaxData : "+ ajaxData);
  let json_pbList = JSON.parse(ajaxData);	

  makeProductListByRank(json_pbList);

}


function makeProductListByRank(json_pbList){
  //alert("makeProductListByRank 함수");
      //alert(json_pbList.length);
      
      let sample_img = "\res\imgs\product__default.jpg";
      // 삭제
      document.querySelector(".productList__container").remove();
      // 재생성
      let productList__container = createDiv("","productList__container","","");
      for(idx=0; idx<json_pbList.length; idx++){
        productList__container.appendChild(makeItem(json_pbList[idx].prfLocation, json_pbList[idx].prdCteCode, 
          json_pbList[idx].prdSelCode, json_pbList[idx].prdCode, json_pbList[idx].prdName, json_pbList[idx].prdPrice, json_pbList[idx].prdType, json_pbList[idx].selShopName));
        //alert("사진파일주소 : " + json_pbList[idx].prfLocation);
      }

      /* html에 넣기*/
      console.log(productList__container);
      let productList__zone = document.querySelector(".productList__zone");
      productList__zone.appendChild(productList__container);
    }	


  /* -- 상품리스트 생성 함수 1 (상품아이템 생성) *******************************************************/
  function makeItem_past(prfLocation, prdCteCode, prdSelCode, prdCode, prdName, prdPrice){
    let productItem = createDiv("","product__item item"+(idx+1), "", "");
    
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

    console.log("이벤트리스너에 들어갈 코드들 : " + prdCteCode +" "+prdSelCode+" "+prdCode);
    productItem.addEventListener("click", ()=> moveProductInfo(prdCteCode, prdSelCode, prdCode));

    /** 나머지 정보 **/ 
    /* 판매자 */
    let product__seller__div = createDiv("","product__seller__div","",prdSelCode);
    product__seller__div.innerHTML = "<span>판매자 : </span><span class=\"sellerShop\">we2857</span>";
    productItem.appendChild(product__seller__div); /* 샵 네임으로 바꿔야함 */

    /* 상품명 */
    productItem.appendChild(createDiv("","product__title__div","",prdName));
    /* 가격 */
    productItem.appendChild(createDiv("","product__price__div","",prdPrice));

    let productItem__wrapper = createDiv("","productItem__wrapper", "", "");
    productItem__wrapper.innerHTML="<h3>판매 "+(idx+1)+"위</h3>";
    productItem__wrapper.appendChild(productItem);
    return productItem__wrapper;
  }


    /* -- 상품리스트 생성 함수 1 (상품아이템 생성) */
    function makeItem(prfLocation, prdCteCode, prdSelCode, prdCode, prdName, prdPrice, prdType, selShopName){
      let productItem = createDiv("","product__item rank", "", "");
      
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
      //alert("셀샵네임" + selShopName);
      let product__seller__div = createDiv("","product__seller__div","","");
      product__seller__div.innerHTML = "<span class=\"info_span\">판매자 : </span><span class=\"+ selShopName +\">" + selShopName +"</span>";
      productItem.appendChild(product__seller__div); /* 샵 네임으로 바꿔야함 */

      /* 상품명 */
      productItem.appendChild(createDiv("","product__title__div","",prdName));
      /* 가격 */
      let product__price__div = createDiv("","product__price__div rank","","");
          product__price__div.innerHTML ="<span></span><span>"
            + "<span class=\"product__price\">"+ prdPrice +"</span>"
            + "<span class=\"won__span\">원</span></span>";
      productItem.appendChild(product__price__div);
      
      /* 기타 정보 */
      let classOption;
      if(prdType == "C"){
        classOption = "클래스룸 상품";
      }else if(prdType="N"){
        classOption = "일반 상품";
      }else{
        classOption ="DB확인필요";
      }
      let product__etc__div = createDiv("","product__etc__div rank","","");
      product__etc__div.innerHTML ="<span class=\"classOption\">"+classOption+"</span>"
      productItem.appendChild(product__etc__div);
      
        let productItem__wrapper = createDiv("","productItem__wrapper", "", "");
        productItem__wrapper.innerHTML="<h3>판매 "+(idx+1)+"위</h3>";
        productItem__wrapper.appendChild(productItem);
        return productItem__wrapper;

      // return
      return productItem;
    }



