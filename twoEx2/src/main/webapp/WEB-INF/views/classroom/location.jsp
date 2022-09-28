<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>::: TwoEX ::: 클래스룸 </title>
    <!-- 기타 meta 정보 -->
      <meta
        name="mainPage"
        content="TwoEx site"
      />
      <meta name="author" content="TwoEX" />
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


    <!-- JS, CSS 연결 -->
      <link rel="stylesheet" href="res/css/header.css" />
      <link rel="stylesheet" href="res/css/style.css" />
      <link rel="stylesheet" href="res/css/classroom.css" />
      <script src="res/js/main.js" defer></script>
      <script src="res/js/header.js" defer></script>
      <script src="res/js/classroom.js" defer></script>
      
  </head>
  <script>
  let claSelcode;
  let claCteCode;
  let claPrdCode;
  let claName;
  let claInfo;
  let claStartDate;
  let claEndDate;
  let claTotDay;
  let claCurDay;
  let claCurPercentage;
  function init() {   	
      postAjaxJson("isSession", null, "isSessionCallBack");
      displayManagement('${userType}');
      let json='${classInfo}';
	  let classInfo = JSON.parse(json);
	  claSelCode = createHidden("claSelCode",classInfo.claSelCode);
	  claCteCode = createHidden("claCteCode",classInfo.claCteCode);
	  claPrdCode = createHidden("claPrdCode",classInfo.claPrdCode);
	  claName = createHidden("claName",classInfo.claName);
	  claInfo = createHidden("claInfo",classInfo.claInfo);
	  claStartDate = createHidden("claStartDate",classInfo.claStartDate);
	  claEndDate = createHidden("claEndDate",classInfo.claEndDate);
	  claTotDay = createHidden("claTotDay",classInfo.claTotDay);
	  claCurDay = createHidden("claCurDay",classInfo.claCurDay);
	  claCurPercentage = createHidden("claCurPercentage",classInfo.claCurPercentage);
      makeTitle();
      
      let json2='${locationInfo}';
	  let locationInfo = JSON.parse(json2);
      makelocation(locationInfo);
  }
  function isSessionCallBack(ajaxData) {
	  if(ajaxData != null) {
    	  accessInfo = JSON.parse(ajaxData);
    	  makeHeader(accessInfo);
	  }
  }

  function makelocation(locationInfo){
	  let clalocation=document.getElementById("contents");
		for( i = 0 ; i < locationInfo.length; i++){
			let locList = createDiv("locList["+i+"]", null, "", "");
			locList.appendChild(createDiv("locName["+i+"]", null , null ,locationInfo[i].locName));
			locList.appendChild(createDiv("locInfo["+i+"]", null, null, locationInfo[i].locInfo));
			locList.appendChild(createDiv("locPOS["+i+"]", null, null, locationInfo[i].locPOS));
			clalocation.appendChild(locList);
			}
  }
  </script>
  <body onload="init()">
  	<nav id="navbar"></nav>	
    <main id="common__zone">
      <div class="classroom__banner__zone">
        <div id="claTitle" class="classroom__banner"></div>
        <div id="claTitle2" class="classroom__banner2"> </div>
      </div>
      <div id="common__wrapper">
        <!--[공통 메뉴 시작] ------------------------------>
       <nav class="common__menu__Zone">
          <div class="common__menu">
            <div class="common__menu__title" onClick="moveDashboard()">
              클래스룸
            </div>
            <div class="common__menu__list">
              <div class="common__menu__item parentItem dashBoardBtn"></div>  
              <div class="common__menu__item parentItem" onClick="moveDashboard()">대시보드</div>
              <div class="common__menu__item parentItem" onClick="moveCurriculum()">커리큘럼</div>
              <div class="common__menu__item parentItem" onClick="moveAssignment()">과제</div>              
              <div class="common__menu__item parentItem" onClick="moveSchedule()">일정</div>
              <div class="common__menu__item parentItem" onClick="moveChat()">채팅방</div>
              <div id="moveManageCurriculum" class="common__menu__item parentItem" onClick="moveManageCurriculum()">관리</div>
            </div>
          </div>
        </nav><!-- 공통 메뉴 끝 -->
        <!--[공통 컨텐츠 시작] ------------------------------>
        <div id="contents" class="common__content__zone">
          
        </div>
      </div>
      </main>
  </body>
</html>


