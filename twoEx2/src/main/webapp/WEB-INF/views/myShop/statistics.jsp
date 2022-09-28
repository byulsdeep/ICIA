<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
  <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>::: TwoEX ::: 교환 플랫폼 </title>
    <!-- 기타 meta 정보 -->
      <meta name="mainPage" content="TwoEx site">
      <meta name="author" content="TwoEX">
      <link rel="icon" type="image/png" href="">
   
   	  <!-- LOGO, FONT SOURCE ------------------------------>
    <script src="https://kit.fontawesome.com/1066a57f0b.js" crossorigin="anonymous"></script>
     <!-- JS, CSS 연결 -->
      <link rel="stylesheet" href="res/css/header.css">
      <link rel="stylesheet" href="res/css/style.css">
      <link rel="stylesheet" href="res/css/salesHistory.css" />
      <link rel="stylesheet" href="res/css/statistics.css" />
      <link rel="stylesheet" href="res/css/myShop.css" />
      <script src="res/js/main.js" defer=""></script>
      <script src="res/js/header.js" defer></script>  
      <script src="res/js/myShop.js" defer></script>  
      <script src="res/js/classroomManagement.js" defer></script>
      <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
 		<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
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
    	
            //강한별: header.js에 중복
            function createHidden(objName, value){
              	let input = document.createElement("input");
              	input.setAttribute("type", "hidden");
              	input.setAttribute("name", objName);
              	input.setAttribute("value", value);
              	
              	return input;
              }
            
           
            //판매자 전문분야 등록(선택된 체크박스값 불러옴 ->한개선택 인서트 가능,다중인서트 완성해야됨)
            function regCte(){     	
            	 let form = document.getElementsByName("insCte")[0];
                 form.action="regCte";
                 form.method="post";
            	 var obj = [];
            	 obj = document.getElementsByName("sctCteCode");         	  		
                 for (var i=0; i<obj.length; i++) {
                     if (document.getElementsByName("sctCteCode")[i].checked == true) {
                         //alert(document.getElementsByName("sctCteCode")[i].value); 
                         form.appendChild(createHidden("categories.sctCteCode",document.getElementsByName("sctCteCode")[i].value))
             				}
                 	} 
             	 form.appendChild(createHidden("categories.sctSellCode",accessInfo.selCode));
                 form.submit();
            }
            
          
            
          
            function classroom(prdCode,prdSelCode,prdCteCode){     	
				  let form = document.getElementsByName("clientData")[0];
                 form.action="moveDashboard";
                 form.method="post";
                 form.appendChild(createHidden("claPrdCode",prdCode));
                 form.appendChild(createHidden("claSelCode",prdSelCode));
                 form.appendChild(createHidden("claCteCode",prdCteCode));               
                 form.submit();
            }
            
            
            $("#check_module").click(function () {
        		var IMP = window.IMP; // 생략가능
        		IMP.init('imp21020068'); 
        		// i'mport 관리자 페이지 -> 내정보 -> 가맹점식별코드
        		// ''안에 띄어쓰기 없이 가맹점 식별코드를 붙여넣어주세요. 안그러면 결제창이 안뜹니다.
        		IMP.request_pay({
        			pg: 'kakao',
        			pay_method: 'card',
        			merchant_uid: 'merchant_' + new Date().getTime(),
        			/* 
        			 *  merchant_uid에 경우 
        			 *  https://docs.iamport.kr/implementation/payment
        			 *  위에 url에 따라가시면 넣을 수 있는 방법이 있습니다.
        			 */
        			name: '주문명 : 아메리카노',
        			// 결제창에서 보여질 이름
        			// name: '주문명 : ${auction.a_title}',
        			// 위와같이 model에 담은 정보를 넣어 쓸수도 있습니다.
        			amount: 2000,
        			// amount: ${bid.b_bid},
        			// 가격 
        			buyer_name: '이름',
        			// 구매자 이름, 구매자 정보도 model값으로 바꿀 수 있습니다.
        			// 구매자 정보에 여러가지도 있으므로, 자세한 내용은 맨 위 링크를 참고해주세요.
        			buyer_postcode: '123-456',
        			}, function (rsp) {
        				console.log(rsp);
        			if (rsp.success) {
        				var msg = '결제가 완료되었습니다.';
        				msg += '결제 금액 : ' + rsp.paid_amount;
        				// success.submit();
        				// 결제 성공 시 정보를 넘겨줘야한다면 body에 form을 만든 뒤 위의 코드를 사용하는 방법이 있습니다.
        				// 자세한 설명은 구글링으로 보시는게 좋습니다.
        			} else {
        				var msg = '결제에 실패하였습니다.';
        				msg += '에러내용 : ' + rsp.error_msg;
        			}
        			alert(msg);
        		});
        	});
            
        	function changeBtnCss(obj, cname) { //이벤트가 발생한 요소를넘겨줌
        		obj.className = cname;
        	}
        </script> 
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
    </head>
<body onLoad="init()">
    <!-- [Navbar] ------------------------------------------------------->
<nav id="navbar">
		<div class="navbar__upper">
			<div class="navbar__logo">
				<i class="fa-solid fa-arrow-right-arrow-left"></i> <span
					class="title">Two EX</span> <span class="subtitle">Experts Exchange</span>
			</div>
			<div class="header__right">
				<input class="header__search" type="text" placeholder="  상품을 검색하세요.">
				<!-- 헤더 navbar 메뉴 버튼-->
				<ul class="navbar__menu">
					<li class="navbar__menu__item myPage" data-link="#contact">마이페이지</li>
					<li class="navbar__menu__item myShop" data-link="#contact" onclick="moveMyshop()">마이샵</li>
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
            <div class="common__menu__title" onclick="moveMyShop2()">
              마이샵
            </div>
				<div class="commonmenulist">
                        <div class="common__menu__item">상품 관리</div>
                        <div class="common__menu__item childCte" onClick="showModal()">전문분야 등록</div>
                        <div class="common__menu__item childItem" onClick="moveRegisterGoods()">상품 등록</div>
                        <div class="common__menu__item childItem" onClick="moveModifyProduct()">상품 수정/삭제</div>
                        <div class="common__menu__item">판매 관리</div>
                        <div class="common__menu__item childItem" onclick="moveSalesHistory()">판매 내역</div>
                        <div class="common__menu__item childItem" onclick="moveStatistics()"style="color:#9370DB;font-size:23px;">통계 조회</div>
                      </div>
          </div>
        </nav><!-- 공통 메뉴 끝 --> 
             <!--[공통 컨텐츠 시작] ------------------------------>
        <div class="common__contents__zone myShop">
          <h3>통계조회 페이지</h3>
          
          
         <!-- 판매자의 상품리스트 -->
      	 <div class="chartZone">
      	 	<div class="statisticsbutton">
				<input type="button" class="content__btn btn__medium" onclick="moveStatistics()" value="내 통계">
          		<input type="button" class="content__btn btn__medium" onclick="getMarketStatistics()"value="전체통계">
         	</div>
         	<div id="chart">
				<!--차트가 그려질 부분-->
				<canvas id="myChart"></canvas>			
			</div>
			<div id="chart1">
				<!--차트가 그려질 부분-->
				<canvas id="myChart1"></canvas>			
			</div>
		
			<div id="chart2">
				<!--차트가 그려질 부분-->
				<canvas id="myChart2"></canvas>			
			</div>
		
			<div id="chart3">
				<!--차트가 그려질 부분-->
				<canvas id="myChart3"></canvas>			
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
                <!--
        <a href="https://github.com/dream-ellie" target="_blank">
          <i class="fab fa-github"></i>
        </a>
        <a href="#" target="_blank">
          <i class="fa fa-linkedin-square"></i>
        </a>
        -->
            </div>
            <p class="footer__description">
                (주)투엑스 인천시 미추홀구 학인동, 5층대표 : 안뇽 개인정보관리책임자 : 안뇽 사업자등록번호 : 123-45-67890
                <br>
                통신판매업신고 : 2018-인천미추홀-1234 유료직업소개사업등록번호 : 제2022-12345-12-1-00012호 고객센터 : 1544-6254 help@twoex.com
                <br>
                (주)투엑스는 통신판매중개자이며, 통신판매의 당사자가 아닙니다. 상품, 상품정보, 거래에 관한 의무와 책임은 판매회원에게 있습니다.
                <br>
                (주)투엑스 사이트의 상품/판매회원/중개 서비스/거래 정보, 콘텐츠, UI 등에 대한 무단복제, 전송, 배포, 스크래핑 등의 행위는 저작권법, 콘텐츠산업 진흥법 등 관련법령에 의하여
                엄격히 금지됩니다.
            </p>
            <p class="footer__contact__rights">
                </br>
                Copyright © 2022 twoEx Inc. All rights reserved.
            </p>
        </section>

        <!-- Arrow up -->
        <button class="arrow-up">
            <i class="fas fa-arrow-up"></i>
        </button>
        
        
        
    <script type="text/javascript">
    		//내 샵 통계리스트	
    		var cte = document.getElementById('cte');
    		
            var context = document
                .getElementById('myChart')
                .getContext('2d');
            var myChart = new Chart(context, {
                type: 'bar', // 차트의 형태
                data: { // 차트에 들어갈 데이터
                    labels: [
                        //x 축
				       
                        '라이프스타일','비즈니스','미디어','IT/테크','디자인',"재태크","법무/노무","취미"
                        
                    ],  
                    datasets: [
                        { //데이터
                            label: '카테고리별 판매 수', //차트 제목
                            fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
                            data: [
                                '${lifeSell}','${businessSell}','${mediaSell}','${techSell}','${designSell}','${financeSell}','${lawSell}','${hobbySell}' //x축 label에 대응되는 데이터 값
                                ],

                            backgroundColor: [
                                //색상
                                'rgba(255, 99, 132, 0.2)',
                                'rgba(54, 162, 235, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(75, 192, 192, 0.2)',
                                'rgba(153, 102, 255, 0.2)',
                                'rgba(255, 159, 64, 0.2)'
                            ],
                            borderColor: [
                                //경계선 색상
                                'rgba(255, 99, 132, 1)',
                                'rgba(54, 162, 235, 1)',
                                'rgba(255, 206, 86, 1)',
                                'rgba(75, 192, 192, 1)',
                                'rgba(153, 102, 255, 1)',
                                'rgba(255, 159, 64, 1)'
                            ],
                            borderWidth: 1 //경계선 굵기
                        }/* ,
                        {
                            label: 'test2',
                            fill: false,
                            data: [
                                8, 34, 12, 24
                            ],
                            backgroundColor: 'rgb(157, 109, 12)',
                            borderColor: 'rgb(157, 109, 12)'
                        } */
                    ]
                },
                options: {
                    scales: {
                        yAxes: [
                            {
                                ticks: {
                                    beginAtZero: true
                                }
                            }
                        ]
                    }
                }
            });

            var context = document
            .getElementById('myChart1')
            .getContext('2d');
        var myChart = new Chart(context, {
            type: 'doughnut', // 차트의 형태
            data: { // 차트에 들어갈 데이터
                labels: [
                    //x 축
                    '20대미만','20대','30대','40대','50대이상','60대이상'
                    
                ],  
                datasets: [
                    { //데이터
                        label: '나이대별 판매 수', //차트 제목
                        fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
                        data: [
                            '${age10}','${age20}','${age30}','${age40}','${age50}','${age60}' //x축 label에 대응되는 데이터 값
                        ],
                        backgroundColor: [
                            //색상
                            'rgba(255, 99, 132, 0.2)',
                            'rgba(54, 162, 235, 0.2)',
                            'rgba(255, 206, 86, 0.2)',
                            'rgba(75, 192, 192, 0.2)',
                            'rgba(153, 102, 255, 0.2)',
                            'rgba(255, 159, 64, 0.2)'
                        ],
                        borderColor: [
                            //경계선 색상
                            'rgba(255, 99, 132, 1)',
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(75, 192, 192, 1)',
                            'rgba(153, 102, 255, 1)',
                            'rgba(255, 159, 64, 1)'
                        ],
                        borderWidth: 1 //경계선 굵기
                    }/* ,
                    {
                        label: 'test2',
                        fill: false,
                        data: [
                            8, 34, 12, 24
                        ],
                        backgroundColor: 'rgb(157, 109, 12)',
                        borderColor: 'rgb(157, 109, 12)'
                    } */
                ]
            },
            options: {
                scales: {
                    yAxes: [
                        {
                            ticks: {
                                beginAtZero: true
                            }
                        }
                    ]
                }
            }
        });
 
        var context = document
        .getElementById('myChart2')
        .getContext('2d');
    var myChart = new Chart(context, {
        type: 'bar', // 차트의 형태
        data: { // 차트에 들어갈 데이터
            labels: [
                //x 축
                '남자','여자'
                
            ],  
            datasets: [
                { //데이터
                    label: '성별 판매  수', //차트 제목
                    fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
                    data: [
                        '${male}','${Female}' //x축 label에 대응되는 데이터 값
                    ],
                    backgroundColor: [
                        //색상
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(153, 102, 255, 0.2)',
                        'rgba(255, 159, 64, 0.2)'
                    ],
                    borderColor: [
                        //경계선 색상
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)'
                    ],
                    borderWidth: 1 //경계선 굵기
                }/* ,
                {
                    label: 'test2',
                    fill: false,
                    data: [
                        8, 34, 12, 24
                    ],
                    backgroundColor: 'rgb(157, 109, 12)',
                    borderColor: 'rgb(157, 109, 12)'
                } */
            ]
        },
        options: {
            scales: {
                yAxes: [
                    {
                        ticks: {
                            beginAtZero: true
                        }
                    }
                ]
            }
        }
    }); 

    
    var context = document
    .getElementById('myChart3')
    .getContext('2d');
var myChart = new Chart(context, {
    type: 'bar', // 차트의 형태
    data: { // 차트에 들어갈 데이터
        labels: [
            //x 축
            '전달 판매 수','이번달 판매 수'
            
        ],  
        datasets: [
            { //데이터
                label: '전달 이번달 판매 실적', //차트 제목
                fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
                data: [
                    '${month2}','${month}' //x축 label에 대응되는 데이터 값
                ],
                backgroundColor: [
                    //색상
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 206, 86, 0.2)',
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(153, 102, 255, 0.2)',
                    'rgba(255, 159, 64, 0.2)'
                ],
                borderColor: [
                    //경계선 색상
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)',
                    'rgba(255, 159, 64, 1)'
                ],
                borderWidth: 1 //경계선 굵기
            }/* ,
            {
                label: 'test2',
                fill: false,
                data: [
                    8, 34, 12, 24
                ],
                backgroundColor: 'rgb(157, 109, 12)',
                borderColor: 'rgb(157, 109, 12)'
            } */
        ]
    },
    options: {
        scales: {
            yAxes: [
                {
                    ticks: {
                        beginAtZero: true
                    }
                }
            ]
        }
    }
}); 
        </script>
        
        
    </body>
  
  


 
</html>