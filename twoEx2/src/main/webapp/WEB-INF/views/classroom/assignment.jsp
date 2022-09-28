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
     <script src="res/js/main_LSE.js" defer></script>
  </head>
  <script>
  //
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
  let buyCode;
  let buyOrdDate;
  let assCode;
  let uploadFile = [];
  let assignmentInfo;
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
	  buyCode = createHidden("subStuOrdBuyCode", classInfo.buyCode);
	  //
	  makeTitle();
      let json2='${assignmentInfo}';
	  assignmentInfo = JSON.parse(json2);
	  buyOrdDate = createHidden("subStuOrdDate", assignmentInfo[0].assBuyDate);
	  assCode = createHidden("subAssCode", assignmentInfo[0].assCode);
	  
      makeAssignment(assignmentInfo);
      
  }
  function isSessionCallBack(ajaxData) {
	  if(ajaxData != null) {
    	  accessInfo = JSON.parse(ajaxData);
    	  makeHeader(accessInfo);
	  }
  }
  
  function makeAssignment(assignmentInfo){
  
	  if('${userType}'=='buyer'){
	  let claAssignment=document.getElementById("contents");
	  claAssignment.innerHTML="";
	  //소제목
	  let littleTitle =  createDiv("littleTitle", "littleTitle" ,null, "과제");
	  claAssignment.appendChild(littleTitle);
	  
	  let exfAssignmentInfo =[];
	  let incAssignmentInfo =[];
	  let comAssignmentInfo =[];
	  let resAssignmentInfo =[];
	  
	  // 리스트 기한 타입별 나누기
	  for(i=0; i<assignmentInfo.length; i++){
		  if(assignmentInfo[i].assState <0){
			  exfAssignmentInfo.push(assignmentInfo[i]);
		  }else{
			  if(assignmentInfo[i].submittedAssignment[0] != null){
				  comAssignmentInfo.push(assignmentInfo[i]); 
			  }else{
				  if(assignmentInfo[i].assState2 < 0){
				    resAssignmentInfo.push(assignmentInfo[i]);
				  }else{
					  incAssignmentInfo.push(assignmentInfo[i])
				  }
			  }
		  }
	  }
	  	 
	 let incAssbigList = createDiv("incAssbigList", null, null, null);
	 claAssignment.appendChild(createDiv( null, "assListTitle" , null ,"진행중 과제"));
	 claAssignment.appendChild(incAssbigList);
	  for(i = 0 ; i < incAssignmentInfo.length; i++){
		  let incAssList = createDiv("incAssList["+i+"]", null, "", "");
		  
		  
		  let incAssName = createDiv("incAssName["+i+"]", null , null ,incAssignmentInfo[i].assName);
		  incAssList.appendChild(incAssName);
		  incAssbigList.appendChild(incAssList);
		  let idx = i;
		  incAssName.addEventListener('click', function(){
		  moveAssignmentDetail(incAssignmentInfo, idx);
		  });
		  incAssbigList.appendChild(incAssList);
		}  
	  let exfAssbigList = createDiv("incAssbigList", null, null, null);
	  claAssignment.appendChild(createDiv( null, "assListTitle" , null ,"만료된 과제"));
	  claAssignment.appendChild(exfAssbigList);
	  for(i = 0 ; i < exfAssignmentInfo.length; i++){
		  let exfAssList = createDiv("exfAssList["+i+"]", null, "", "");
		  
		  
		  
		  let exfAssName = createDiv("exfAssName["+i+"]", null , null ,exfAssignmentInfo[i].assName);
		  exfAssList.appendChild(exfAssName);
		  exfAssbigList.appendChild(exfAssList);
		  let idx = i;
		  exfAssName.addEventListener('click', function(){
		        alert("이미 만료된 과제 입니다.");
		  });
		  exfAssbigList.appendChild(exfAssList);
	  }
	  let comAssbigList = createDiv("incAssbigList", null, null, null);
	  claAssignment.appendChild(createDiv( null, "assListTitle" , null ,"완료된 과제")); 
	  claAssignment.appendChild(comAssbigList);
	  for( i = 0 ; i < comAssignmentInfo.length; i++){	
			let comAssList = createDiv("comAssList["+i+"]", null, "", "");
			
			
			
			
			let comAssName = createDiv("comAssName["+i+"]", null , null ,comAssignmentInfo[i].assName+ "   점수 : "+ comAssignmentInfo[i].submittedAssignment[0].subGrade + "/" + comAssignmentInfo[i].assMaxGrade + "점");
			
			comAssList.appendChild(comAssName);
			comAssbigList.appendChild(comAssList);
			let idx = i;
			
			
			comAssName.addEventListener('click', function(){
				
				if(comAssignmentInfo[idx].assState < 0){alert("기간이 지난 과제입니다.");return;}
				
				if(comAssignmentInfo[idx].submittedAssignment[0].subGrade != "미채점"){
					alert("이미 채점된 과제입니다.");return;
				}
				else{
					moveAssignmentDetail(comAssignmentInfo, idx);
				}
			});
			comAssbigList.appendChild(comAssList);
	  }
  	}else{
			
			
	let claAssignment=document.getElementById("contents");
	let resAssignmentInfo =[];
	let incAssignmentInfo =[];
	let comAssignmentInfo =[];
	
	let littleTitle =  createDiv("littleTitle", "littleTitle" ,null, "과제");
	  claAssignment.appendChild(littleTitle);
	
	 for(i=0; i<assignmentInfo.length; i++){
		  if(assignmentInfo[i].assState <0){
			  comAssignmentInfo.push(assignmentInfo[i]);  
		      }else{ 
		    	  if(assignmentInfo[i].assState2 <0){resAssignmentInfo.push(assignmentInfo[i]);
		  	       }else{incAssignmentInfo.push(assignmentInfo[i]);}
		  	               }
	 }
	 
	 let resAssbigList = createDiv("resAssbigList", null, null, null);
	 claAssignment.appendChild(createDiv( null, "assListTitle" , null ,"예약된 과제"));
	 claAssignment.appendChild(resAssbigList);
	 
  		for( i = 0 ; i < resAssignmentInfo.length; i++){	
		let resAssList = createDiv("resAssList["+i+"]", null, "", "");
		
		let resAssName = createDiv("resAssName["+i+"]", null , null ,"과제명 : " + resAssignmentInfo[i].assName);
		let resAssStart = createDiv("resAssStart["+i+"]", null , null , "과제 기간 : " + resAssignmentInfo[i].assStartDate.substr(0, 10) + " ~ "+ resAssignmentInfo[i].assEndDate.substr(0, 10));

		resAssList.appendChild(resAssName);
		resAssList.appendChild(resAssStart);
		resAssbigList.appendChild(resAssList);
      } 	  
	 
	 
		  let incAssbigList = createDiv("incAssbigList", null, null, null);
		  claAssignment.appendChild(createDiv( null, "assListTitle" , null ,"현재 진행 되는 과제")); 
		  claAssignment.appendChild(incAssbigList);
			 
			  for(i = 0 ; i < incAssignmentInfo.length; i++){
				  let incAssList = createDiv("incAssList["+i+"]", null, "", "");
				  
				  
				  let incAssName = createDiv("incAssName["+i+"]", null , null ,incAssignmentInfo[i].assName);
				  let incAssDate = createDiv("incAssDate["+i+"]", null , null , "과제 기간 : " + incAssignmentInfo[i].assStartDate.substr(0, 10) + " ~ "+ incAssignmentInfo[i].assEndDate.substr(0, 10));

				  
				  incAssList.appendChild(incAssName);
				  incAssList.appendChild(incAssDate);

				  incAssbigList.appendChild(incAssList);
				}  

			  let comAssbigList = createDiv("comAssbigList", null, null, null);
			  claAssignment.appendChild(createDiv( null, "assListTitle" , null ,"기간이 지난 과제"));
			  claAssignment.appendChild(comAssbigList);
				 
			  for( i = 0 ; i < comAssignmentInfo.length; i++){	
					let comAssList = createDiv("comAssList["+i+"]", null, "", "");
					
					
					
					let comAssName = createDiv("comAssName["+i+"]", null , null ,comAssignmentInfo[i].assName);
					let comAssDate = createDiv("comAssDate["+i+"]", null , null , "과제 기간 : " + comAssignmentInfo[i].assStartDate.substr(0, 10) + " ~ "+ comAssignmentInfo[i].assEndDate.substr(0, 10));

					comAssList.appendChild(comAssName);
					comAssList.appendChild(comAssDate);

					comAssbigList.appendChild(comAssList);
			  }
  	}
  }
  function moveAssignmentDetail(assignmentInfo ,idx){
	  claAssignment=document.getElementById("contents");
	  claAssignment.innerHTML="";
	  littleTitle = createDiv("littleTitle", "littleTitle" ,null, "과제 상세");
	  claAssignment.appendChild(littleTitle);
	  
	  let claAssignmentDetail = createDiv("",null,null,null);
	  claAssignment.appendChild(claAssignmentDetail);
	  claAssignmentDetail.appendChild(createDiv("assNameTitle" , null ,null, "과제 제목"));
	  claAssignmentDetail.appendChild(createDiv("assNameInfo" , null ,null, assignmentInfo[idx].assName));
	  claAssignmentDetail.appendChild(createDiv("assInfoTitle" , null ,null,"과제 설명" ));
	  claAssignmentDetail.appendChild(createDiv("assInfoInfo" , null ,null,assignmentInfo[idx].assInfo));
	  
	  let assStartDiv = createDiv("assStartDateDiv",null,null,null);
	  claAssignmentDetail.appendChild(assStartDiv);
	  assStartDiv.appendChild(createDiv("assStartDateTitle" , null ,null,"과제 시작 날짜"));
	  assStartDiv.appendChild(createDiv("assStartDateInfo" , null ,null, assignmentInfo[idx].assStartDate.substr(0,10)));
	  
	  let assEndDiv = createDiv("assEndDateDiv",null,null,null);
	  claAssignmentDetail.appendChild(assEndDiv);
	  assEndDiv.appendChild(createDiv("assEndDateTitle" , null ,null,"과제 마감 날짜" ));
	  assEndDiv.appendChild(createDiv("assEndDateInfo" , null ,null,assignmentInfo[idx].assEndDate.substr(0,10)));
	  
	  let assGradeDiv = createDiv("assEndDateDiv",null,null,null);
	  claAssignmentDetail.appendChild(assGradeDiv);
	  assGradeDiv.appendChild(createDiv("assMaxGradeTitle" , null ,null,"과제 만점"));
	  assGradeDiv.appendChild(createDiv("assMaxGradeInfo" , null ,null,assignmentInfo[idx].assMaxGrade));
	  
	  let assUploadInfoDiv = createDiv("assUploadInfoDiv",null,null,null);
	  claAssignmentDetail.appendChild(assUploadInfoDiv);
	  
	  if(assignmentInfo[idx].submittedAssignment.sbfFilName != null ){
	  assUploadInfoDiv.appendChild(createDiv("subInfoTitle" , null ,null,"과제 내용 입력" ));
	  }else{
		  assUploadInfoDiv.appendChild(createDiv("subInfoTitle" , null ,null,"과제 내용" ));
	  }
	  let uploadInfo = createTextArea("subInfo", "3","86",  "과제 내용을 입력하세요 * 필수 *");
	  
	  uploadInfo.addEventListener('click', function(){ 
		  if(assignmentInfo[idx].submittedAssignment == ""){
			  uploadInfo.innerText="";}
		  });
	  assUploadInfoDiv.appendChild(uploadInfo);
	  	
	  
	  
	  if(assignmentInfo[idx].submittedAssignment != ""){
		  
		  let subInfo = document.getElementsByName("subInfo")[0];
		  subInfo.placeholder = "";
		  subInfo.innerText =  assignmentInfo[idx].submittedAssignment[0].subInfo;
		  subInfo.readOnly = true;
		  
	  }
	  
	  if(assignmentInfo[idx].submittedAssignment.length != 0){
	  claAssignmentDetail.appendChild(createDiv("assSubmittedFileListTitle" , null ,null, "과제 파일"));
	  let assSubmittedFileListInfo = createDiv("assSubmittedFileListInfo" , null ,null, null, "")
	  claAssignmentDetail.appendChild(assSubmittedFileListInfo);
	  
	  
	  let submittedFileName = [];
	  
	  
	  
	  
	  for(i=0 ; i < assignmentInfo[idx].submittedAssignment.length; i++ ){
		      
		  let submittedFileList = createDiv("",null,null,null);
		  
		  if(assignmentInfo[idx].submittedAssignment[0].sbfFilName == null){
			  submittedFileName[0] = createDiv("assSubmittedFileName["+0+"]" , null ,null, "파일 없음" );  
		  }
		  
		  submittedFileName[i] = createDiv("assSubmittedFileName["+i+"]" , null ,null, assignmentInfo[idx].submittedAssignment[i].sbfFilName );
	  	  submittedFileList.appendChild(submittedFileName[i]);
		  assSubmittedFileListInfo.appendChild(submittedFileList);
	  }
	  
	  }
	  
	  if(assignmentInfo[idx].submittedAssignment==""){
	  let addUploadFileBtn = createButton("파일추가 (최대 3개 까지 가능)", "addUploadFileBtn");
	  claAssignmentDetail.appendChild(addUploadFileBtn);
	  
	  
	  let uploadFileDiv = createDiv("uploadFileList");
	  claAssignmentDetail.appendChild(uploadFileDiv);
	  
	  addUploadFileBtn.addEventListener("click", function(){
		  if(document.getElementsByName("uploadFile").length == 3) {alert("파일업로드는 최대 3개까지 가능합니다.");return;}
		  let uploadFile2 = createInput("file", "uploadFile");
		  uploadFileDiv.appendChild(uploadFile2);
		  uploadFile.push(uploadFile2);
		  
		  let deleteFileBtn = createButton("파일삭제", "deleteFileBtn")
		  uploadFileDiv.appendChild(deleteFileBtn);
		  deleteFileBtn.addEventListener('click', function(){
			  uploadFileDiv.removeChild(uploadFile2);
			  uploadFile.push(uploadFile2);
			  uploadFile.pop(uploadFile2);
			  uploadFileDiv.removeChild(deleteFileBtn);
			  
		  });
	  });
	  }
	  
	  assCode.value = assignmentInfo[idx].assCode;
	  
	  
	  //제출한과제가 없을시
	  
	  
	  let submitAssignmentBtn =  createButton("과제 제출 하기", "submitAssignment");
	  submitAssignmentBtn.addEventListener('click', function(){
		  submitAssignment(uploadInfo);
	  });
	  claAssignmentDetail.appendChild(submitAssignmentBtn);
	  
	  
	  //제출한 과제가 있을시 
	  if(assignmentInfo[idx].submittedAssignment!=""){
	  let unsubmitAssignmentBtn = createButton("제출 과제 삭제", "unsubmitAssignmentBtn");
	  claAssignmentDetail.appendChild(unsubmitAssignmentBtn);
	  
	  
	  let sbfFilName1 = assignmentInfo[idx].submittedAssignment[0].sbfFilName;
	  unsubmitAssignmentBtn.addEventListener('click', function(){
		  unsubmitAssignment(sbfFilName1);
	  });
	  }
	  
	  
// 	  if(assignmentInfo[idx].submittedAssignment==""){
// 		  unsubmitAssignmentBtn.style.display='none';
// 	  }
	  let returnMoveAssignment =createButton("돌아가기", "returnMoveAssignment")
	  claAssignmentDetail.appendChild(returnMoveAssignment);
	  returnMoveAssignment.addEventListener('click', function(){
		  moveAssignment();
	  });
	  //제출한 과제가 있을시 
	  if( assignmentInfo[idx].submittedAssignment[0] != null){
		  submitAssignmentBtn.style.display='none';
	  }
	  
  }
  function submitAssignment(uploadInfo){
	
	if(uploadInfo.value == ""){
		alert("과제 내용을 입력 해주세요.");
		return;}
	
	let form = document.getElementsByName("form")[0];
	form.innerHTML="";
	
	form.action = "submitAssignment"
	form.method = "POST";
	form.enctype = "multipart/form-data";
	
	//SUB 테이블 프라이머리키 6종세트
	form.appendChild(assCode);
	form.appendChild(createHidden("subAssClaSelCode", claSelCode.value));
	form.appendChild(createHidden("subAssClaCteCode", claCteCode.value));
	form.appendChild(createHidden("subAssClaPrdCode", claPrdCode.value));
	form.appendChild(buyCode);
	form.appendChild(buyOrdDate);
	formInClaInfo(form);
	form.appendChild(createHidden("subInfo", uploadInfo.value));
	
	for(i=0; i < uploadFile.length; i++){
		form.appendChild(uploadFile[i]);
		form.appendChild(createHidden("submittedAssignmentFile["+i+"].sbfFilName", uploadFile[i].value));
	}
	console.log(form);
	
	//document.body.appendChild(form);
	form.submit();
	
  }
  function deleteFile(){
	  
	  let uf = document.getElementByName("uploadFile");
	  
	  uf[uf.length]
	  // 올려놓은 파일리스트 삭제
  }
  
  function unsubmitAssignment(submittedFileName){
	    let form = document.getElementsByName("form")[0];
		form.innerHTML="";
		form.action = "unsubmitAssignment";
		form.method = "POST";
		formInClaInfo(form);
		form.appendChild(assCode);
		form.appendChild(createHidden("subAssClaSelCode", claSelCode.value));
		form.appendChild(createHidden("subAssClaCteCode", claCteCode.value));
		form.appendChild(createHidden("subAssClaPrdCode", claPrdCode.value));
		form.appendChild(buyCode);
		form.appendChild(buyOrdDate);
		
		if(submittedFileName != null ){
		form.appendChild(createHidden("sbfFilName", submittedFileName));
		}
		
		
		console.log(form);
		form.submit();
  }
  function formInClaInfo(form){
	  form.appendChild(claSelCode);
	  form.appendChild(claCteCode);
	  form.appendChild(claPrdCode);
	  form.appendChild(claName); 
	  form.appendChild(claInfo );
	  form.appendChild(claStartDate);
	  form.appendChild(claEndDate);
	  form.appendChild(claTotDay);
	  form.appendChild(claCurDay);
	  form.appendChild(claCurPercentage);
	  form.appendChild(createHidden("buyCode",buyCode.value));
	  return form;
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
              <div class="common__menu__item parentItem2" onClick="moveAssignment()">과제</div>
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
      <form name="form"></form>
  </body>
</html>