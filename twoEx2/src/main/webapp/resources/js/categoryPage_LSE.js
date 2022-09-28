
  function createDiv(id, className, value, text){
    let div = document.createElement("div");
    if(id != "") div.setAttribute("id", id);
    if(className != "") div.setAttribute("class", className);
    if(value != "") div.setAttribute("value", value);
    if(text != "") div.innerHTML = text;
    
    return div;
  }
  


  /** 카테고리 메뉴존 생성 **/
  /* -- 카테고리 제목 */
  function makeTitleCategoryName(json_titleCteName){
	//alert("makeTitleCategoryName 입구");
    let common__menu__title = document.querySelector(".common__menu__title");
    //alert("카테고리 타이틀 : " + '${json_titleCteName}');
    common__menu__title.innerHTML = json_titleCteName;
  
  }

  /** 카테고리 메뉴항목 **/
  function makeCategoriesMenu(json_cteList){
      let common__menu__list = document.querySelector(".common__menu__list");
      //alert("json_cteList.length :  "+ json_cteList.length);
      for(idx=0; idx<json_cteList.length; idx++){
          let item = createDiv("","common__menu__item parentItem","",json_cteList[idx].cteName);
          									/*item.setAttribute("data-cteCode", json_cteList[idx].cteCode);*/
          let cteCode = json_cteList[idx].cteCode;
          										//alert("cteCode : " + cteCode);
          item.addEventListener("click", ()=> moveCategory(cteCode));
          common__menu__list.appendChild(item);
    }
  }

  /** 상품리스트 생성 **/
    /* -- 상품리스트 생성 함수 1 */
    function makeProductList(json_pbList){
          //alert("makeHTML() 입구");	
          //alert(json_pbList.length);
          
          let sample_img = "res/imgs/PRbIi1662022559.png";
        
          let producList__zone = document.querySelector(".productList__zone");
          for(idx=0; idx<json_pbList.length; idx++){
            producList__zone.appendChild(makeItem(sample_img, json_pbList[idx].prdSelCode,json_pbList[idx].prdName,json_pbList[idx].prdPrice));
          }
          //zoneHtml += "</div>";
          console.log(producList__zone);
    }	

    /* -- 상품리스트 생성 함수 1 (상품아이템 생성) */
    function makeItem(IMAGE, prdSelCode, prdName, prdPrice){
      let productItem = createDiv("","product__item item1", "", "");
      
      /** image **/
      let productImageDiv = productItem.appendChild(createDiv("", "product__image__div", "", ""));
      let productImage = document.createElement("img");
          productImage.setAttribute("class","product__image");
          productImage.setAttribute("src", IMAGE);
      productImageDiv.appendChild(productImage);
      productItem.appendChild(productImageDiv);
      /** 나머지 정보 **/ 
      /* 판매자 */
      productItem.appendChild(createDiv("","prodcut__seller__div","",prdSelCode)); /* 샵 네임으로 바꿔야함 */
      /* 상품명 */
      productItem.appendChild(createDiv("","product__title__div","",prdName));
      /* 가격 */
      productItem.appendChild(createDiv("","product__price__div","",prdPrice));

      return productItem;
    }
