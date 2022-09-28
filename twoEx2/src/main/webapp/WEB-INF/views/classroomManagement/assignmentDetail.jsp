<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>::: TwoEX ::: 과제 상세</title>
<!-- 기타 meta 정보 -->
<meta name="mainPage" content="TwoEx site" />
<meta name="author" content="TwoEX" />
<link rel="icon" type="image/png" href="" />

<!-- LOGO, FONT SOURCE ------------------------------>
<script src="https://kit.fontawesome.com/1066a57f0b.js"
	crossorigin="anonymous"></script>


<!-- JS, CSS 연결 ------------------------------>
<link rel="stylesheet" href="res/css/style.css" />
<link rel="stylesheet" href="res/css/header.css" />
<link rel="stylesheet" href="res/css/categoryPage.css">
<link rel="stylesheet" href="res/css/classroomManagement.css" />

<script src="res/js/main.js" defer></script>
<script src="res/js/header.js" defer></script>
<script src="res/js/classroom.js" defer></script>
<script src="res/js/classroomManagement.js" defer></script>
<style>
/** 로고1 오리지날
       font-family: 'Russo One', sans-serif;  -- 400 */
@import
	url('https://fonts.googleapis.com/css2?family=Russo+One&display=swap');

/** 로고2 대안
       font-family: 'Orbitron', sans-serif; weight 800, 900 */
@import
	url('https://fonts.googleapis.com/css2?family=Orbitron:wght@800;900&display=swap')
	;

/** 로고3
        font-family: 'Exo', sans-serif;  */
@import
	url('https://fonts.googleapis.com/css2?family=Exo:wght@800;900&display=swap')
	;

/** 본문1
       font-family: 'Noto Sans KR', sans-serif;  --- 300, 400, 700 */
@import
	url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;700&display=swap')
	;

/** 본문2
       font-family: 'Spoqa Han Sans Neo', 'sans-serif';*/
@import
	url('https://spoqa.github.io/spoqa-han-sans/css/SpoqaHanSans-kr.css');
</style>
</head>
<script>
	let claSelCode;
	let claCteCode;
	let claPrdCode;
	let assMaxGrade;
	let assEndDate;

	let claName;
	let claInfo;
	let claStartDate;
	let claEndDate;
	let claTotDay;
	let claCurDay;
	let claCurPercentage;

	function makeAssignmentDetail(classroomInfo) {
		const today = new Date();
		const year = today.getFullYear();
		const month = today.getMonth() + 1;
		const day = today.getDate();
		const date = String(year)
				+ String((month < 10) ? ("0" + month) : month)
				+ String((day < 10) ? ("0" + day) : day);

		assMaxGrade = classroomInfo[0].assignment[0].assMaxGrade;
		assEndDate = classroomInfo[0].assignment[0].assEndDate;
		let assignmentDetailDiv = document
				.getElementsByClassName("assDetailList")[0];
		
		
		assignmentDetailDiv.innerHTML = '';
		let box = [];
		box.push(document.createElement('h4'));
		box[0].innerText = ''
				+ ((assEndDate.substr(0, 10).replace(/-/g, "") < date) ? " (만료)"
						: "");
		
		
		box.push(createHidden("assCode",
						classroomInfo[0].assignment[0].assCode));
		box.push(createDiv("assDetailName", null, null,
				classroomInfo[0].assignment[0].assName));
		box.push(createDiv("assDetailInfo", null, null,
				classroomInfo[0].assignment[0].assInfo));
		box.push(createDiv("assDetailStartDate", null, null, "시작일: "
				+ classroomInfo[0].assignment[0].assStartDate.substr(0, 10)));
		box.push(createDiv("assDetailEndDate", null, null, "마감일: "
				+ classroomInfo[0].assignment[0].assEndDate.substr(0, 10)));
		box.push(createDiv("assDetailMaxGrade", null, null, "만점: "
				+ classroomInfo[0].assignment[0].assMaxGrade));
		
		for (j = 0; j < box.length; j++) {
			assignmentDetailDiv.appendChild(box[j]);
		}

		let submittedAssignmentListDiv = document
				.getElementsByClassName("productList__zone")[1];
		submittedAssignmentListDiv.innerHTML = '<h4>제출된 과제</h4>';
		let submittedAssignmentDiv = [];

		for (i = 0; i < classroomInfo[0].assignment[0].submittedAssignment.length; i++) {
			submittedAssignmentDiv[i] = createDiv(null, "product__item", null,
					null);
			let submittedAssignmentInfo = classroomInfo[0].assignment[0].submittedAssignment[i];
			submittedAssignmentDiv[i].addEventListener("click", function() {
				openInfo(submittedAssignmentInfo);
			});
			let box = [];
			box
					.push(createHidden(
							"subStuOrdBuyCode",
							classroomInfo[0].assignment[0].submittedAssignment[i].subStuOrdBuyCode));
			box.push(document.createElement("img"));
			box[1].src = classroomInfo[0].assignment[0].submittedAssignment[i].subBuyProfile;
			box[1].setAttribute("class", "profilePhoto");
			box
					.push(createDiv(
							"subBuyNickname",
							null,
							null,
							classroomInfo[0].assignment[0].submittedAssignment[i].subBuyNickname));
			box
					.push(createDiv(
							"subDate",
							null,
							null,
							'제출시간: '
									+ classroomInfo[0].assignment[0].submittedAssignment[i].subDate));
			box
					.push(createDiv(
							"subGrade",
							null,
							null,
							'점수: '
									+ classroomInfo[0].assignment[0].submittedAssignment[i].subGrade
									+ " / "
									+ classroomInfo[0].assignment[0].assMaxGrade));

			for (j = 0; j < box.length; j++) {
				submittedAssignmentDiv[i].appendChild(box[j]);
			}
			submittedAssignmentListDiv.appendChild(submittedAssignmentDiv[i]);
		}
		if (submittedAssignmentListDiv.children[1] == null) {
			submittedAssignmentListDiv.remove();
		}
	}

	function openInfo(submittedAssignmentInfo) {
		let modal__wrapper = document.getElementsByClassName('modal__wrapper')[0];
		modal__wrapper.style.display = "block";
		document.getElementsByClassName('modal__title')[0].innerText = submittedAssignmentInfo.subBuyNickname
				+ " 님의 과제";
		modal__body = document.getElementsByClassName('modal__body')[0];
		modal__body.innerText = submittedAssignmentInfo.subInfo;

		const today = new Date();
		const year = today.getFullYear();
		const month = today.getMonth() + 1;
		const day = today.getDate();
		const date = String(year)
				+ String((month < 10) ? ("0" + month) : month)
				+ String((day < 10) ? ("0" + day) : day);
		let input = null;
		let ok = null;
		maxGrade = null;
		if (assEndDate.substr(0, 10).replace(/-/g, "") < date) {
			input = document.createElement('div');
			input.innerText = "점수: " + submittedAssignmentInfo.subGrade;
			maxGrade = createDiv("maxGrade", null, null, " / " + assMaxGrade);
			ok = document.createElement('div');
		} else {
			input = document.createElement('input');
			
			input.value = submittedAssignmentInfo.subGrade;
			input.placeholder = '성적을 입력해주세요';
			input.setAttribute("class", "gradeInput");
			maxGrade = createDiv("maxGrade", null, null, " / " + assMaxGrade);

			let gradeBtn = createButton("채점", "gradeBtn", null);
			
			gradeBtn.addEventListener("click", function() {
			updGrade(submittedAssignmentInfo, input);
			});
			maxGrade.appendChild(gradeBtn);	
		}
		
		let close = createButton("취소", "closeBtn" ,null);
		close.addEventListener('click', function(){
			closeModal();
		});
		
		maxGrade.appendChild(close);
		/*
		for (i = 0; i < 12; i++) {
			modal__body.appendChild(document.createElement('br'));
		}
		*/
		for (i = 0; i < submittedAssignmentInfo.submittedAssignmentFile.length; i++) {
			let a = document.createElement('div');
			a.innerText = "첨부파일"
					+ (i + 1)
					+ " : "
					+ submittedAssignmentInfo.submittedAssignmentFile[i].sbfFilName;
			let sbfLocation = submittedAssignmentInfo.submittedAssignmentFile[i].sbfLocation
					+ "/"
					+ submittedAssignmentInfo.submittedAssignmentFile[i].sbfFilName;
			a.addEventListener("click", function() {
				window.open(sbfLocation, '_blank');
			})
			modal__body.appendChild(a);
			modal__body.appendChild(document.createElement('br'));
		}

		let buttonDiv = document.createElement('div');
		buttonDiv.setAttribute('class', 'buttonDiv');
		modal__body.appendChild(buttonDiv);
		buttonDiv.appendChild(input);
		buttonDiv.appendChild(maxGrade);
		buttonDiv.appendChild(ok);
	}

	function updGrade(submittedAssignmentInfo, input) {
		if (input.value.trim().length > 3 || isNaN(input.value.trim())) {
			input.focus();
			alert("3자리 이하 숫자를 입력해주세요");
			return;
		}
		clientData = "subAssClaSelCode=" + claSelCode.value
				+ "&subAssClaCteCode=" + claCteCode.value
				+ "&subAssClaPrdCode=" + claPrdCode.value + "&subAssCode="
				+ submittedAssignmentInfo.subAssCode + "&subStuOrdBuyCode="
				+ submittedAssignmentInfo.subStuOrdBuyCode + "&subStuOrdDate="
				+ submittedAssignmentInfo.subStuOrdDate + "&subGrade="
				+ input.value + "&subDate=" + submittedAssignmentInfo.subDate;

		postAjaxJson("updGrade", clientData, "updGradeCallBack");
		let modal__wrapper = document.getElementsByClassName('modal__wrapper')[0];
		modal__body = document.getElementsByClassName('modal__body')[0];
		modal__body.innerHTML = "";
		modal__wrapper.style.display = 'none';
	}

	function updGradeCallBack(ajaxData) {
		let assingmentInfo = JSON.parse(ajaxData);

		let submittedAssignmentListDiv = document
				.getElementsByClassName("productList__zone")[1];
		submittedAssignmentListDiv.innerHTML = '<h4>제출된 과제</h4>';
		let submittedAssignmentDiv = [];

		for (i = 0; i < assingmentInfo.submittedAssignment.length; i++) {
			submittedAssignmentDiv[i] = createDiv(null, "product__item", null,
					null);
			let submittedAssignmentInfo = assingmentInfo.submittedAssignment[i];
			submittedAssignmentDiv[i].addEventListener("click", function() {
				openInfo(submittedAssignmentInfo);
			});
			let box = [];
			box.push(createHidden("subStuOrdBuyCode",
					assingmentInfo.submittedAssignment[i].subStuOrdBuyCode));
			box.push(document.createElement("img"));
			box[1].src = assingmentInfo.submittedAssignment[i].subBuyProfile;
			box[1].setAttribute("class", "profilePhoto");
			box.push(createDiv("subBuyNickname", null, null,
					assingmentInfo.submittedAssignment[i].subBuyNickname));
			box.push(createDiv("subDate", null, null, '제출시간: '
					+ assingmentInfo.submittedAssignment[i].subDate));
			box.push(createDiv("subGrade", null, null, '점수: '
					+ assingmentInfo.submittedAssignment[i].subGrade + " / "
					+ assingmentInfo.assMaxGrade));

			for (j = 0; j < box.length; j++) {
				submittedAssignmentDiv[i].appendChild(box[j]);
			}
			submittedAssignmentListDiv.appendChild(submittedAssignmentDiv[i]);
		}
	}

	function isSessionCallBack(ajaxData) {
		if (ajaxData != null) {
			accessInfo = JSON.parse(ajaxData);
			makeHeader(accessInfo);
		}
	}

	function init() {
		postAjaxJson("isSession", null, "isSessionCallBack");

		let classroomInfo = JSON.parse('${jsonClassroomInfo}');

		claSelCode = createHidden("claSelCode", classroomInfo[0].claSelCode,
				null);
		claCteCode = createHidden("claCteCode", classroomInfo[0].claCteCode,
				null);
		claPrdCode = createHidden("claPrdCode", classroomInfo[0].claPrdCode,
				null);

		let classInfo = JSON.parse('${classInfo}');
		claName = createHidden("claName", classInfo.claName);
		claInfo = createHidden("claInfo", classInfo.claInfo);
		claStartDate = createHidden("claStartDate", classInfo.claStartDate);
		claEndDate = createHidden("claEndDate", classInfo.claEndDate);
		claTotDay = createHidden("claTotDay", classInfo.claTotDay);
		claCurDay = createHidden("claCurDay", classInfo.claCurDay);
		claCurPercentage = createHidden("claCurPercentage",
				classInfo.claCurPercentage);
		makeTitle();

		makeAssignmentDetail(classroomInfo);
	}
</script>
<body onload="init()">
	<nav id="navbar"></nav>
	<main id="common__zone">
		<div class="classroom__banner__zone">
			<div id="claTitle" class="classroom__banner"></div>
		</div>
		<div id="common__wrapper">
			<!--[공통 메뉴 시작] ------------------------------>
			<nav class="common__menu__zone">
				<div class="common__menu">
					<div class="common__menu__title">클래스룸 관리</div>
					<div class="common__menu__list">
						<div class="common__menu__item parentItem"
							onClick="moveManageCurriculum(claSelCode, claCteCode, claPrdCode)">커리큘럼
							관리</div>
						<div class="common__menu__item parentItem"
							onClick="moveManageStudent()">학생 정보</div>
						<div class="common__menu__item parentItem"
							onClick="moveManageAssignment()">과제 관리</div>
						<div class="common__menu__item parentItem"
							onClick="moveManageNotice()">공지 관리</div>
						<div class="common__menu__item parentItem"
							onClick="moveDashboard(claSelCode, claCteCode, claPrdCode)">돌아가기</div>
					</div>
				</div>
			</nav>
			<!-- 공통 메뉴 끝 -->
			<!--[공통 컨텐츠 시작] ------------------------------>
			<div class="common__content__zone">
				<h3>과제 상세</h3>
				<div id = assProList1 class="productList__zone">
					<div class="assDetailList"></div>
				</div>
				<div id = assProList2 class="productList__zone"></div>
			</div>
	</main>
	<!-- 모달 시작 ------------------------------>
	<section>
		<div class="modal__wrapper">
			<div id="asmModal" class="common__modal">
				<div class="modal__head">
					<div class="modal__title"></div>
				</div>
				<div class="modal__body"></div>
				<div class="moadl__content"></div>
			</div>
		</div>
	</section>
</body>
</html>