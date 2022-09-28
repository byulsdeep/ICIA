<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>::: TwoEX ::: 학생 관리</title>
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
	
div[id^=student] {

}

.productList__container.khb{
	float : left ;
	height : 125%;
	width: 950px !important;
	display:block ;
	margin:0px;
}

.productList__container__khb{
  top : 0;
  /*margin : 40px 0px;*/
  width : 950px;
  /*border: dotted 1px var(--color-headerGrey);*/
  display: flex;
  flex-wrap: wrap;
  align-content : flex-start;
  align-items: center;;
}

.common__content__zone {
	 width: 4000px;
}
</style>
</head>
<script>
	let claSelCode;
	let claCteCode;
	let claPrdCode;
	let studentId;
	
	let claName;
	let claInfo;
	let claStartDate;
	let claEndDate;
	let claTotDay;
	let claCurDay;
	let claCurPercentage;

	function init() {
		postAjaxJson("isSession", null, "isSessionCallBack");
		classroomInfo = JSON.parse('${jsonClassroomInfo}');
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
		
		makeStudent(classroomInfo);
	}
	function makeStudent(classroomInfo) {
		const today = new Date();
		const year = today.getFullYear();

		let studentListDiv = document
				.getElementsByClassName("productList__container")[0];
		let studentDiv = [];

		for (i = 0; i < classroomInfo[0].student.length; i++) {
			studentDiv[i] = createDiv("student" + i, null, null,
					null);
			let box = [];
			let img = document.createElement('img');
			img.src = classroomInfo[0].student[i].stuBuyProfile;
			img.setAttribute("class", "profilePhoto");
			box.push(createDiv(null, "img", null,
					null));
			box[0].appendChild(img);
			box.push(createHidden("stuOrdBuyCode",
					classroomInfo[0].student[i].stuOrdBuyCode));
			box.push(createDiv("stuBuyNickname["+i+"]", null, null,
					classroomInfo[0].student[i].stuBuyNickname));
			box
					.push(createDiv(
							"stuBuyGender["+i+"]",
							null,
							null,
							classroomInfo[0].student[i].stuBuyGender == 'M' ? '남'
									: '여'));
			box.push(createDiv("stuBuyAge["+i+"]", null, null,
					(year - classroomInfo[0].student[i].stuBuyAge) + '세'));
			box.push(createDiv("stuBuyRegion["+i+"]", null, null,
					classroomInfo[0].student[i].stuBuyRegion));
			box.push(createDiv("stuBuyEmail["+i+"]", null, null,
					classroomInfo[0].student[i].stuBuyEmail));
			for (j = 0; j < box.length; j++) {
				studentDiv[i].appendChild(box[j]);
			}
			studentListDiv.appendChild(studentDiv[i]);
		}
	}

	function isSessionCallBack(ajaxData) {
		if (ajaxData != null) {
			accessInfo = JSON.parse(ajaxData);
			makeHeader(accessInfo);
		}
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
				<h3>학생 정보</h3>
				<div class="productList__container__khb">
					<div class="productList__container"></div>
				</div>
			</div>
		</div>
	</main>
	<!-- 모달 시작 ------------------------------>
	<section>
		<div class="modal__wrapper">
			<div class="common__modal">
				<div class="modal__head">
					<div class="modal__title"></div>
					<div class="modal__close" onClick="closeModal()">X</div>
				</div>
				<div class="modal__body"></div>
				<div class="moadl__content"></div>
			</div>
		</div>
	</section>
</body>

</html>