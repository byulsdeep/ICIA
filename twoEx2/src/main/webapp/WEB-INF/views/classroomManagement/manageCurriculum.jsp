<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>::: TwoEX ::: 클래스룸 관리 ::: 커리큘럼 관리</title>
<!-- 기타 meta 정보 -->
<meta name="mainPage" content="TwoEx site" />
<meta name="author" content="TwoEX" />
<link rel="icon" type="image/png" href="" />

<!-- LOGO, FONT SOURCE-->
<script src="https://kit.fontawesome.com/1066a57f0b.js"
	crossorigin="anonymous"></script>
<link
	href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600;700&family=Russo+One&display=swap"
	rel="stylesheet">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Raleway:ital,wght@0,800;1,900&display=swap"
	rel="stylesheet">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Orbitron:wght@900&display=swap"
	rel="stylesheet">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Exo:wght@800;900&display=swap"
	rel="stylesheet">

<!-- JS, CSS 연결 -->
<link rel="stylesheet" href="res/css/header.css" />
<link rel="stylesheet" href="res/css/style.css" />
<link rel="stylesheet" href="res/css/classroom.css" />
<script src="res/js/main.js" defer></script>
<script src="res/js/header.js" defer></script>
<script src="res/js/classroom.js" defer></script>
<script src="res/js/main_LSE.js" defer></script>
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
	  
	  let json2='${curriculumInfo}';
	  let curriculumInfo = JSON.parse(json2);
	  
	  
	  makeManageCurriculum(curriculumInfo);
	  
  }
  function isSessionCallBack(ajaxData) {
	  if(ajaxData != null) {
    	  accessInfo = JSON.parse(ajaxData);
    	  makeHeader(accessInfo);
	  }
  }
  
function makeManageCurriculum(curriculumInfo){
	
	  let claCurriculum=document.getElementById("contents1");
	  claCurriculum.innerHTML="";
	  
	  claCurriculum.appendChild(createDiv("littleTilte",null,null, "커리컬럼 관리"));
	  if(curriculumInfo != ""){
	  
	  let curList =[];
	  
		for( i = 0 ; i < curriculumInfo.length; i++){
			curList[i] = createDiv("mCurList["+i+"]", null, "", "");
			let curCode = curriculumInfo[i].curCode;
			let curName = curriculumInfo[i].curName;
			let curInfo = curriculumInfo[i].curInfo;
			let curStartDate = curriculumInfo[i].curStartDate.substr(0, 10);
			let curEndDate = curriculumInfo[i].curEndDate.substr(0, 10);
			let curTime = curriculumInfo[i].curTime;
			curList[i].appendChild(createHidden("curCode["+i+"]", curCode));
			curList[i].appendChild(createDiv("mCurName["+i+"]", null , null ,"커리컬럼명 : " + curName));
			curList[i].appendChild(createDiv("mCurInfo["+i+"]", null, null, "커리컬럼내용 : " + curInfo));
			curList[i].appendChild(createDiv("mCurStartDate["+i+"]", null, null, "커리컬럼기간 : " + curStartDate+ " ~ " +curEndDate ));
			curList[i].appendChild(createDiv("mCurTime["+i+"]", null, null, "커리컬럼시간 : " + curTime));
			let setUpdBtn = createButton("수정 및 삭제",null, "setUpdBtn");
			curList[i].appendChild(setUpdBtn);
			setUpdBtn.addEventListener('click', function(){
				updCurForm(curCode, curName, curInfo, curStartDate, curEndDate,curTime);
			})
			claCurriculum.appendChild(curList[i]);
			}
	  }
		let insClaCurriculum=document.getElementById("contents2");
		insClaCurriculum.innerHTML="";
		insClaCurriculum.appendChild(createDiv("actionTitle",null,null,"새로운 커리큘럼 등록"));
		let curCodeHidden = createHidden("curCode", null);
		insClaCurriculum.appendChild(curCodeHidden);
		
		let curNameDiv = createDiv(null,null,null,"커리큘럼 제목 : ");
		curNameDiv.appendChild(createInput(null, "curName", "제목을 입력하세요", null));
		insClaCurriculum.appendChild(curNameDiv);
		
		let curInfoDiv = createDiv(null,null,null,"커리큘럼 내용 : ");
		curInfoDiv.appendChild(createTextArea("curInfo", "4", "47", "내용을 입력하세요"));
		insClaCurriculum.appendChild(curInfoDiv);
		
		let curStartDateDiv = createDiv(null,null,null,"커리큘럼 시작날짜 : ");
		curStartDateDiv.appendChild(createInput("date", "curStartDate", "시작날짜", null));
		insClaCurriculum.appendChild(curStartDateDiv);
		
		let curEndDateDiv = createDiv(null,null,null,"커리큘럼 종료날짜 : ");
		curEndDateDiv.appendChild(createInput("date", "curEndDate", "종료날짜", null));
		insClaCurriculum.appendChild(curEndDateDiv);
		
		let curTimeDiv = createDiv(null,null,null,"커리큘럼 진행 시간 : ");
		curTimeDiv.appendChild(createInput("number", "curTime", "시간입력(숫자)", null));
		insClaCurriculum.appendChild(curTimeDiv);
		
		
		//등록버튼
		let insCurriculumDiv = createButton("등록", null, "insBtn");
		insCurriculumDiv.addEventListener('click', function(){
			insCurriculum();
		});
		insClaCurriculum.appendChild(insCurriculumDiv);
		
		//수정버튼
		let updCurriculumDiv = createButton("수정", null, "updBtn");
		updCurriculumDiv.addEventListener('click', function(){
			updCurriculum();
		});
		updCurriculumDiv.style.display="none";
		insClaCurriculum.appendChild(updCurriculumDiv);
		//삭제버튼
		let delCurriculumDiv = createButton("삭제", null, "delBtn");
		delCurriculumDiv.addEventListener('click', function(){
			delCurriculum();
		});
		delCurriculumDiv.style.display="none";
		insClaCurriculum.appendChild(delCurriculumDiv);	  
}
  function insCurriculum(){
	  //빈데이터제어
	  if(document.getElementsByName("curName")[0].value==""){alert("제목을 입력하세요");return;}
	  if(document.getElementsByName("curName")[0].value.length >21){alert("제목은 20자리 이하로 입력해주세요.");return;}
	  if(document.getElementsByName("curInfo")[0].value==""){alert("내용을 입력하세요");return;}
	  if(document.getElementsByName("curTime")[0].value==""){alert("시간을 입력하세요");return;}
	  if(document.getElementsByName("curStartDate")[0].value==""){alert("시작날짜를 입력하세요");return;}
	  if(document.getElementsByName("curEndDate")[0].value==""){alert("종료날짜를 입력하세요");return;}
	  clientData = ""; //초기화 하지않으면 쌓인다.
		clientData += "curClaSelCode=" + claSelCode.value + "&curClaCteCode=" + claCteCode.value
		+"&curClaPrdCode=" + claPrdCode.value 
		+ "&curName=" + document.getElementsByName("curName")[0].value
		+ "&curInfo=" + document.getElementsByName("curInfo")[0].value
		+ "&curTime=" + document.getElementsByName("curTime")[0].value
		+ "&curStartDate=" + document.getElementsByName("curStartDate")[0].value
		+ "&curEndDate=" + document.getElementsByName("curEndDate")[0].value;
	  postAjaxJson("insCurriculum", clientData, "callback1");
  }
  
  function callback1(json) {
	    
		if(json != null && json != ""){
			let curriculumInfo = JSON.parse(json);
			makeManageCurriculum(curriculumInfo);
		}
	}
  
  function updCurForm(curCode,curName, curInfo, curStartDate, curEndDate, curTime){
	  let contents2 = document.getElementById("actionTitle");
	  let curCodeHidden = document.getElementsByName("curCode")[0];
	  let curNameDiv = document.getElementsByName("curName")[0];
	  let curInfoDiv = document.getElementsByName("curInfo")[0];
	  let curStartDateDiv = document.getElementsByName("curStartDate")[0];
	  let curEndDateDiv = document.getElementsByName("curEndDate")[0];
	  let curTimeDiv = document.getElementsByName("curTime")[0];
	  let insBtn = document.getElementById("insBtn");
	  let updBtn = document.getElementById("updBtn");
	  actionTitle.innerText="커리컬럼 수정 / 삭제";
	  insBtn.style.display="none";
	  updBtn.style.display="";
	  delBtn.style.display="";
	  curCodeHidden.value = curCode;
	  curNameDiv.value = curName;
	  curInfoDiv.value = curInfo;
	  curStartDateDiv.value = curStartDate;
	  curEndDateDiv.value = curEndDate;
	  curTimeDiv.value = curTime;
  }
  
  
function updCurriculum(){
	  clientData = ""; //초기화 하지않으면 쌓인다.
		clientData += "curClaSelCode=" + claSelCode.value + "&curClaCteCode=" + claCteCode.value
		+"&curClaPrdCode=" + claPrdCode.value
		+ "&curCode=" + document.getElementsByName("curCode")[0].value
		+ "&curName=" + document.getElementsByName("curName")[0].value
		+ "&curInfo=" + document.getElementsByName("curInfo")[0].value 
		+ "&curTime=" + document.getElementsByName("curTime")[0].value 
		+ "&curStartDate=" + document.getElementsByName("curStartDate")[0].value 
		+ "&curEndDate=" + document.getElementsByName("curEndDate")[0].value ;
	  
	  postAjaxJson("updCurriculum", clientData, "callback1");
  }
  
function delCurriculum(curCode){
	  clientData = ""; //초기화 하지않으면 쌓인다.
		clientData += "curClaSelCode=" + claSelCode.value + "&curClaCteCode=" + claCteCode.value
		+"&curClaPrdCode=" + claPrdCode.value
		+ "&curCode=" + document.getElementsByName("curCode")[0].value
		if(removeCheck()==false){ return;};// yes or no
		
	  postAjaxJson("delCurriculum", clientData, "callback1");
}
  
  
function removeCheck() {

	 if (confirm("정말 삭제하시겠습니까??") == true){    //확인
		 return true;

	 }else{   //취소

	     return false;

	 }

	}
  
</script>
<body onload="init()">
	<nav id="navbar"></nav>
	<main id="common__zone">
		<div class="classroom__banner__zone">
			<div id="claTitle" class="classroom__banner"></div>
			<div id="claTitle2" class="classroom__banner2"></div>
		</div>
		<div id="common__wrapper">
			<!--[공통 메뉴 시작] ------------------------------>
			<nav class="common__menu__zone">
				<div class="common__menu">
					<div class="common__menu__title">클래스룸 관리</div>
					<div class="common__menu__list">
						<div class="common__menu__item parentItem dashBoardBtn"></div>
						<div class="common__menu__item parentItem"
							onClick="moveManageCurriculum(claSelCode, claCteCode, claPrdCode)">커리큘럼
							관리</div>
						<div class="common__menu__item parentItem"
							onClick="moveManageStudent(claSelCode, claCteCode, claPrdCode)">학생
							관리</div>
						<div class="common__menu__item parentItem"
							onClick="moveManageAssignment(claSelCode, claCteCode, claPrdCode)">과제
							관리</div>
						<div class="common__menu__item parentItem"
							onClick="moveManageNotice(claSelCode, claCteCode, claPrdCode)">공지
							관리</div>
						<div id="moveDashboard" class="common__menu__item parentItem"
							onClick="moveDashboard(claSelCode, claCteCode, claPrdCode)">돌아가기</div>
					</div>
				</div>
			</nav>
			<!-- 공통 메뉴 끝 -->
			<!--[공통 컨텐츠 시작] ------------------------------>
			<div id="contents1" class="common__content__zone"></div>
			<div id="contents2" class="common__content__zone"></div>
		</div>
	</main>
</body>
</html>