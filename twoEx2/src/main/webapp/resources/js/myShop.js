             //상품등록페이지 이동
            function moveRegisterGoods() {
            	let prdSelCode= accessInfo.selCode;
            	let form = document.createElement("form");
            	form.action = "moveRegisterGoods";
            	form.method = "post";           
            	form.appendChild(createHidden("prdSelCode",prdSelCode));
            	document.body.appendChild(form);
            	form.submit();
            }
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
 
      	function moveSalesHistory(){
    		const form = document.getElementsByName("clientData")[0];
    		
    		
    		form.appendChild(createHidden("prdSelCode",selCode));
    		form.action = "moveSalesHistory";
    		form.method = "post";
    		form.submit();
      	}
      	
      	function moveStatistics(){
			let prdSelCode= accessInfo.selCode;
    		const form = document.getElementsByName("clientData")[0];
    		form.action = "moveStatistics";
    		form.method = "post";
    		form.appendChild(createHidden("prdSelCode",prdSelCode));
    		form.submit();
      	}
      	//전체시장 통계 페이지 이동
      	function getMarketStatistics(){
			let prdSelCode= accessInfo.selCode;
    		const form = document.getElementsByName("clientData")[0];
    		form.action = "getMaketStatistics";
    		form.method = "post";
    		form.appendChild(createHidden("prdSelCode",prdSelCode));
    		form.submit();
      	}
      	
      	
      	
      	/* 마이샵 이동 */
function moveMyShop2() {	 
	//let prdSelCode = accessInfo.selCode;      
	let form = document.createElement("form");
	form.action = "moveMyshop";
	form.method = "post";            	
	form.appendChild(createHidden("prdSelCode", selCode));
	document.body.appendChild(form);
	form.submit();          	
}

//모달창 띄우기
    function showModal(){         	
   	 const modal = document.querySelector(".modal__wrapper");
   	 const modalbody = document.querySelector(".modal__body");
		
    	modal.style.display="block";
     }
//모달창 닫기
  function closeModal(){
    const DOM__modal__wrapper = document.querySelector(".modal__wrapper");
    DOM__modal__wrapper.style.display="none";
  }     
  
     //카테고리 등록
   function regCte(){     	
            	 let form = document.getElementsByName("insCte")[0];
                 form.action="regCte";
                 form.method="post";
            	 var obj = [];
            	 obj = document.getElementsByName("prdCteCode");         	  		
                 for (var i=0; i<obj.length; i++) {
                     if (document.getElementsByName("prdCteCode")[i].checked == true) {
                         //alert(document.getElementsByName("prdCteCode")[i].value); 
                         //form.appendChild(createHidden("prdCteCode",document.getElementsByName("prdCteCode")[i].value))
             				}
                 	} 
             	 form.appendChild(createHidden("prdSelCode",accessInfo.selCode));
             	 console.log(form);
                form.submit();
            }   
            
            
            
        