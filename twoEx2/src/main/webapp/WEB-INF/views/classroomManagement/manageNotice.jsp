<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>::: TwoEX ::: 공지 관리</title>
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
	
	.productList__container {
    top: 0;
    margin: 40px 0px;
    width: 1130px;
    /* border: dotted 1px var(--color-headerGrey); */
    /* display: flex; */
}
.productList__zone {
    height: auto;
    overflow: visible;
}
</style>
</head>
<script>
	let claSelCode;
	let claCteCode;
	let claPrdCode;
	let noticeDivCount = 0;
	let clickedPlus = false;
	let newNoticeCode;

	let claName;
	let claInfo;
	let claStartDate;
	let claEndDate;
	let claTotDay;
	let claCurDay;
	let claCurPercentage;
	
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
		
		makeNotice(classroomInfo);
	}
	function makeNotice(classroomInfo) {
		let noticeListDiv = document
				.getElementsByClassName("productList__container")[0];
		let noticeDiv = [];

		for (i = 0; i < classroomInfo[0].notice.length; i++) {
			noticeDiv[i] = createDiv("notice" + i, "product__item", null, null);
			let box = [];
			box
					.push(createHidden("ntcCode",
							classroomInfo[0].notice[i].ntcCode));
			box.push(createInput("text", "ntcName", null, "input text medium",
					classroomInfo[0].notice[i].ntcName));
			box.push(createTextArea("ntcInfo", "10", "28",
					classroomInfo[0].notice[i].ntcInfo));
			box.push(createInput("text", "ntcDate", null, "input text",
					classroomInfo[0].notice[i].ntcDate.substr(0,10)));
			box[3].setAttribute("readonly", "readonly");
			// 삭제, 수정버튼	
			let del = createInput("button", "ntcDelete", null,
					"content__btn btn__micro", "삭제");
			let upd = createInput("button", "ntcUpdate" + i, null,
					"content__btn btn__micro", "수정");

			del.setAttribute("onclick", 'deleteNotice("'
					+ classroomInfo[0].notice[i].ntcCode + '","'
					+ claSelCode.value + '","' + claPrdCode.value + '","'
					+ claCteCode.value + '" )');
			upd.setAttribute("onclick", 'updateNotice("'
					+ classroomInfo[0].notice[i].ntcCode + '","'
					+ claSelCode.value + '","' + claPrdCode.value + '","'
					+ claCteCode.value + '","' + "notice" + i + '")');
			let div = document.createElement('div');
			div.setAttribute('class', 'buttonDiv');
			
			div.appendChild(upd);
			div.appendChild(del);
			box.push(div);
			for (j = 0; j < box.length; j++) {
				noticeDiv[i].appendChild(box[j]);
			}
			noticeListDiv.appendChild(noticeDiv[i]);
			noticeDivCount++;
		}
		let newNoticeDiv = createDiv("notice" + (noticeDivCount),
				"product__item", null,  "클릭하시면 공지 추가란이 생성됩니다.");
		newNoticeDiv.addEventListener("click", function() {
			activateInput(this);
		});
		noticeListDiv.appendChild(newNoticeDiv);
	}

	function activateInput(newNoticeDiv) {
		if (!clickedPlus) {
			clickedPlus = true;
			postAjaxJson("getNewNoticeCode", 'ntcClaPrdCode='
					+ claPrdCode.value + '&ntcClaSelCode=' + claSelCode.value
					+ '&ntcClaCteCode=' + claCteCode.value,
					'getNewNoticeCodeCallBack');
		}
	}
	function getNewNoticeCodeCallBack(ajaxData) {
		let newNoticeDiv = document.getElementById("notice" + noticeDivCount);
		if (ajaxData != null) {
			newNoticeCode = ajaxData;
			newNoticeDiv.innerText = "";
			if (newNoticeDiv.children[0] == null) {
				let box = [];
				box.push(createHidden("ntcCode", newNoticeCode));
				box.push(createInput("text", "ntcName", null,
						"input text medium", "제목"));
				box.push(createTextArea("ntcInfo", "10", "28", "내용"));
				let ntcAddBtn = createButton("추가하기", "ntcAddBtn", null);
				ntcAddBtn.addEventListener('click', function(){
					addOrNo();
				} );
				box.push(ntcAddBtn);
				
				
				for (j = 0; j < box.length; j++) {
					newNoticeDiv.appendChild(box[j]);
				}
				box[1].focus();
			}
		}
	}

	function addOrNo() {
		let newNoticeDiv = document.getElementById("notice" + noticeDivCount);
		let modal__wrapper = document.getElementsByClassName('modal__wrapper')[0];
		modal__wrapper.style.display = "block";
		document.getElementsByClassName('modal__title')[0].innerText = '공지 추가';
		modal__body = document.getElementsByClassName('modal__body')[0];

		if (!clickedPlus) {
			modal__body.innerText = '+ 를 눌러서 새로운 공지를 작성해주세요';
			let ok = document.createElement('button');
			ok.innerText = '확인';
			ok.addEventListener("click", function() {
				modal__body.innerHTML = "";
				modal__wrapper.style.display = 'none';
			});
			ok.setAttribute("class", "okBtn");
			
			//for (i = 0; i < 3; i++) {
				modal__body.appendChild(document.createElement('br'));
			//}
			modal__body.appendChild(ok);
		} else {
			if (newNoticeDiv.children[1].value == null
					|| newNoticeDiv.children[1].value == ''
					|| newNoticeDiv.children[2].value == null
					|| newNoticeDiv.children[2].value == ''
					|| newNoticeDiv.children[1].value == "제목"
					|| newNoticeDiv.children[2].value == "내용") {
				modal__body.innerText = '제목과 내용을 입력해주세요';
				let ok = document.createElement('button');
				ok.innerText = '확인';
				ok.addEventListener("click", function() {
					modal__body.innerHTML = "";
					modal__wrapper.style.display = 'none';
					newNoticeDiv.children[0].focus();
				});
				ok.setAttribute("class", "okBtn");
				//for (i = 0; i < 3; i++) {
					modal__body.appendChild(document.createElement('br'));
				//}
				modal__body.appendChild(ok);
			} else {
				modal__body.innerText = '공지를 추가하시겠습니까?';
				let yes = document.createElement('button');
				yes.innerText = '네';
				yes.addEventListener("click", function() {
					addNotice();
				});
				yes.setAttribute("class", "yesBtn");

				let no = document.createElement('button');
				no.innerText = '아니오';
				no.addEventListener("click", function() {
					modal__body.innerHTML = "";
					modal__wrapper.style.display = 'none';
				});
				no.setAttribute("class", "noBtn");

					modal__body.appendChild(document.createElement('br'));
				
				modal__body.appendChild(yes);
				modal__body.appendChild(no);
			}
		}
	}
	function addNotice() {
		let modal__body = document.getElementsByClassName('modal__body')[0];
		let modal__wrapper = document.getElementsByClassName('modal__wrapper')[0];
		modal__body.innerHTML = "";
		modal__wrapper.style.display = 'none';
		let newNoticeDiv = document.getElementById("notice" + noticeDivCount);
		postAjaxJson('addNotice', 'ntcCode=' + newNoticeDiv.children[0].value
				+ '&ntcClaPrdCode=' + claPrdCode.value + '&ntcClaSelCode='
				+ claSelCode.value + '&ntcClaCteCode=' + claCteCode.value
				+ '&ntcName=' + newNoticeDiv.children[1].value + '&ntcInfo='
				+ newNoticeDiv.children[2].value, 'addNoticeCallBack');
	}
	function addNoticeCallBack(ajaxData) {
		clickedPlus = false;
		noticeDivCount = 0;
		let noticeInfo = JSON.parse(ajaxData);
		let noticeListDiv = document
				.getElementsByClassName("productList__container")[0];
		noticeListDiv.innerHTML = "";
		let noticeDiv = [];

		for (i = 0; i < noticeInfo.length; i++) {
			noticeDiv[i] = createDiv("notice" + i, "product__item", null, null);
			let box = [];
			box.push(createHidden("ntcCode", noticeInfo[i].ntcCode));
			box.push(createInput("text", "ntcName", null, "input text medium",
					noticeInfo[i].ntcName));
			box.push(createTextArea("ntcInfo", "10", "28",
					noticeInfo[i].ntcInfo));
			box.push(createInput("text", "ntcDate", null, "input text",
					noticeInfo[i].ntcDate));
			box[3].setAttribute("readonly", "readonly");

			// 삭제, 수정버튼	
			let upd = createInput("button", "ntcUpdate" + i, null,
					"content__btn btn__micro", "수정");
			
			let del = createInput("button", "ntcDelete", null,
					"content__btn btn__micro", "삭제");
			

			
			upd.setAttribute("onclick", 'updateNotice("'
					+ noticeInfo[i].ntcCode + '","' + claSelCode.value + '","'
					+ claPrdCode.value + '","' + claCteCode.value + '","'
					+ "notice" + i + '")');
			del.setAttribute("onclick", 'deleteNotice("'
					+ noticeInfo[i].ntcCode + '","' + claSelCode.value + '","'
					+ claPrdCode.value + '","' + claCteCode.value + '" )');
			let div = document.createElement('div');
			div.setAttribute('class', 'buttonDiv');
			
			div.appendChild(upd);
			
			div.appendChild(del);
			box.push(div);
			for (j = 0; j < box.length; j++) {
				noticeDiv[i].appendChild(box[j]);
			}
			noticeListDiv.appendChild(noticeDiv[i]);
			noticeDivCount++;
		}
		let newNoticeDiv = createDiv("notice" + (noticeDivCount),
				"product__item", null, "클릭하시면 공지 추가란이 생성됩니다.");
		newNoticeDiv.addEventListener("click", function() {
			activateInput(this);
		});
		noticeListDiv.appendChild(newNoticeDiv);
	}

	function deleteNotice(ntcCode, claSelCode, claPrdCode, claCteCode) {
		

		postAjaxJson("deleteNotice", "ntcCode=" + ntcCode + "&ntcClaSelCode="
				+ claSelCode + "&ntcClaPrdCode=" + claPrdCode
				+ "&ntcClaCteCode=" + claCteCode, "addNoticeCallBack");
	}
	function updateNotice(ntcCode, claSelCode, claPrdCode, claCteCode, abc) {
		let parent = document.getElementById(abc);

		let ntcInfo = parent.getElementsByTagName('textarea')[0].value;
		let ntcName = parent.getElementsByTagName('input')[1].value;

		
		postAjaxJson("updateNotice", "ntcCode=" + ntcCode + "&ntcClaSelCode="
				+ claSelCode + "&ntcClaPrdCode=" + claPrdCode
				+ "&ntcClaCteCode=" + claCteCode + "&ntcInfo=" + ntcInfo
				+ "&ntcName=" + ntcName, "addNoticeCallBack");

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
				<h3>공지 관리</h3>
				<form>
					<div class="productList__zone">
						<div class="productList__container"></div>
					</div>
				</form>
				<!-- <button class="content__btn btn__micro" onClick="updateOrNo()">수정</button>
                	<button class="content__btn btn__micro" onClick="deleteOrNo()">삭제</button> -->
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