<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>::: TwoEX ::: 과제 관리</title>
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

button {
	background-color: #6667ab;
	cursor: pointer;
	/* border: 	; */
	outline: none;
	color: white;
}

.common__content__zone {
    float: left;
    width: 250%;
    height: 150%;
    border: none;
    margin-left: 0px;
    background-color: #fff;
}
</style>
</head>
<script>
	let claSelCode;
	let claCteCode;
	let claPrdCode;
	let isMagic = false;
	let tempDiv;
	let tempDate;

	let claName;
	let claInfo;
	let claStartDate;
	let claEndDate;
	let claTotDay;
	let claCurDay;
	let claCurPercentage;

	function addAssignment() {
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

		let assName = document.getElementsByName("assName")[0];
		let assInfo = document.getElementsByName("assInfo")[0];
		let assStartDate = document.getElementsByName("assStartDate")[0];
		let assEndDate = document.getElementsByName("assEndDate")[0];
		let assMaxGrade = document.getElementsByName("assMaxGrade")[0];
		if (assName.value == null || assName.value == ''
				|| assInfo.value == null || assInfo.value == ''
				|| assStartDate.value == null || assStartDate.value == ''
				|| assEndDate.value == null || assEndDate.value == ''
				|| assMaxGrade.value == null || assMaxGrade.value == '') {
			alert("필수 입력 항목입니다");
			return;
		}
		if (assMaxGrade.value.trim().length > 3
				|| isNaN(assMaxGrade.value.trim())) {
			assMaxGrade.focus();
			alert("3자리 이하 숫자를 입력해주세요");
			return;
		}
		/*
		if (assEndDate.value.replace(/-/g, "") < date) {
			
			assStartDate.focus();
			alert("이미 지난 시간에는 과제 등록을 할 수 업습니다");
			return;

		}*/
		if (assEndDate.value.replace(/-/g, "") < assStartDate.value.replace(
				/-/g, "")) {
			assEndDate.focus();
			alert("시작일이 종료일보다 늦습니다");
			return;
		}

		let clientData = "assName=" + assName.value + "&assInfo="
				+ assInfo.value + "&assStartDate=" + assStartDate.value
				+ "&assEndDate=" + assEndDate.value + "&assMaxGrade="
				+ assMaxGrade.value + "&assClaSelCode=" + claSelCode.value
				+ "&assClaCteCode=" + claCteCode.value + "&assClaPrdCode="
				+ claPrdCode.value;
		postAjaxJson("addAssignment", clientData, "addAssignmentCallBack");
	}

	function addAssignmentCallBack(ajaxData) {
		let list = JSON.parse(ajaxData);

		if (list[0].assCode != "special" || list != '') {
			remakeAssignment(JSON.parse(ajaxData));
		} else {
			let modal__wrapper = document
					.getElementsByClassName('modal__wrapper')[0];
			modal__wrapper.style.display = "block";
			document.getElementsByClassName('modal__title')[0].innerText = '오류';
			modal__body = document.getElementsByClassName('modal__body')[0];
			modal__body.innerText = '제출된 과제가 있어서 삭제에 실패했습니다. 먼저 제출된 과제를 삭제해주세요';

			let no = document.createElement('button');
			no.innerText = '네';
			no.addEventListener("click", function() {
				modal__body.innerHTML = "";
				modal__wrapper.style.display = 'none';
			});
			no.setAttribute("class", "assBtn");

			for (i = 0; i < 3; i++) {
				modal__body.appendChild(document.createElement('br'));
			}
			let buttonDiv = document.createElement('div');
			buttonDiv.setAttribute('class', 'buttonDiv');
			modal__body.appendChild(buttonDiv);
			buttonDiv.appendChild(no);
		}
	}
	function activateUpd(div) {
		this.tempDiv = div;

		let productList__zone1 = document.getElementsByClassName("createZone")[0];
		let assName = document.getElementsByName("assName")[0];
		let assInfo = document.getElementsByName("assInfo")[0];
		let assStartDate = document.getElementsByName("assStartDate")[0];
		let assEndDate = document.getElementsByName("assEndDate")[0];
		let assMaxGrade = document.getElementsByName("assMaxGrade")[0];
		let assLittleForm = document.getElementsByClassName("assLittleForm")[0];
		let magic = document.getElementsByName("magic")[0];
		assName.value = div.children[1].innerText;
		assInfo.value = div.children[2].innerText;
		assStartDate.value = div.children[3].innerText.substr(5);
		assStartDate.setAttribute("readonly", true);
		assEndDate.value = div.children[4].innerText.substr(5);
		tempDate = assEndDate.value;
		assMaxGrade.value = div.children[5].innerText.substr(4);
		if (!isMagic) {
			magic.innerText = "수정";
			magic.setAttribute("onclick", "updAssignment()");
			let cancel = document.createElement('button');
			cancel.innerText = "취소";
			cancel.setAttribute("onclick", "cancel()");
			cancel.setAttribute("class", "content__btn btn__micro");
			cancel.setAttribute("name", "cancel");
			assLittleForm.children[5].appendChild(cancel);
			isMagic = true;
		}
		assName.focus();
	}
	function cancel() {
		let productList__zone1 = document.getElementsByClassName("createZone")[0];
		let assName = document.getElementsByName("assName")[0];
		let assInfo = document.getElementsByName("assInfo")[0];
		let assStartDate = document.getElementsByName("assStartDate")[0];
		let assEndDate = document.getElementsByName("assEndDate")[0];
		let assMaxGrade = document.getElementsByName("assMaxGrade")[0];
		let magic = document.getElementsByName("magic")[0];
		let cancel = document.getElementsByName("cancel")[0];
		assName.value = "";
		assInfo.value = "";
		assStartDate.value = "";
		assEndDate.value = "";
		assStartDate.removeAttribute("readonly");
		assMaxGrade.value = "";
		magic.innerText = "추가";
		magic.setAttribute("onclick", "addAssignment()");
		if (cancel != null)
			cancel.remove();
		isMagic = false;
	}
	function updAssignment() {
		let assName = document.getElementsByName("assName")[0];
		let assInfo = document.getElementsByName("assInfo")[0];
		let assStartDate = document.getElementsByName("assStartDate")[0];
		let assEndDate = document.getElementsByName("assEndDate")[0];
		let assMaxGrade = document.getElementsByName("assMaxGrade")[0];

		if (assName.value == null || assName.value == ''
				|| assInfo.value == null || assInfo.value == ''
				|| assStartDate.value == null || assStartDate.value == ''
				|| assEndDate.value == null || assEndDate.value == ''
				|| assMaxGrade.value == null || assMaxGrade.value == '') {
			alert("필수 입력 항목입니다");
			return;
		}

		if (assMaxGrade.value.trim().length > 3
				|| isNaN(assMaxGrade.value.trim())) {
			assMaxGrade.focus();
			alert("3자리 이하 숫자를 입력해주세요");
			return;
		}

		if (assEndDate.value.replace(/-/g, "") < tempDate.replace(/-/g, "")) {
			assEndDate.focus();
			alert("기간을 줄일 수는 없습니다");
			return;
		}

		if (assEndDate.value.replace(/-/g, "") < assStartDate.value.replace(
				/-/g, "")) {
			assEndDate.focus();
			alert("시작일이 종료일보다 늦습니다");
			return;
		}

		let clientData = "assName=" + assName.value + "&assInfo="
				+ assInfo.value + "&assStartDate=" + assStartDate.value
				+ "&assEndDate=" + assEndDate.value + "&assMaxGrade="
				+ assMaxGrade.value + "&assClaSelCode=" + claSelCode.value
				+ "&assClaCteCode=" + claCteCode.value + "&assClaPrdCode="
				+ claPrdCode.value + "&assCode="
				+ this.tempDiv.children[0].value;
		postAjaxJson("updAssignment", clientData, "addAssignmentCallBack");
	}

	function activateDel(div) {
		let modal__wrapper = document.getElementsByClassName('modal__wrapper')[0];
		modal__wrapper.style.display = "block";
		document.getElementsByClassName('modal__title')[0].innerText = '과제 삭제';
		modal__body = document.getElementsByClassName('modal__body')[0];
		modal__body.innerText = '정말 ' + div.children[1].innerText
				+ '를 삭제하시겠습니까?';

		let yes = document.createElement('button');
		yes.innerText = '네';
		yes.addEventListener("click", function() {
			delAssignment(div);
		});
		yes.setAttribute("class", "assBtn");

		let no = document.createElement('button');
		no.innerText = '아니오';
		no.addEventListener("click", function() {
			modal__body.innerHTML = "";
			modal__wrapper.style.display = 'none';
		});
		no.setAttribute("class", "assBtn");

		for (i = 0; i < 3; i++) {
			modal__body.appendChild(document.createElement('br'));
		}
		let buttonDiv = document.createElement('div');
		buttonDiv.setAttribute('class', 'buttonDiv');
		modal__body.appendChild(buttonDiv);
		buttonDiv.appendChild(yes);
		buttonDiv.appendChild(no);
	}

	function moveAssignmentDetail(div) {
		let form = document.createElement('form');
		form.action = "moveAssignmentDetail";
		form.method = 'post';
		form.appendChild(div.children[0]);
		form.appendChild(claSelCode);
		form.appendChild(claCteCode);
		form.appendChild(claPrdCode);
		document.body.appendChild(form);
		form.submit();
	}

	function delAssignment(div) {
		let clientData = "assName=" + div.children[1].innerText + "&assInfo="
				+ div.children[2].innerText + "&assStartDate="
				+ div.children[3].innerText.substr(5) + "&assEndDate="
				+ div.children[4].innerText.substr(5) + "&assMaxGrade="
				+ div.children[5].innerText.substr(4) + "&assClaSelCode="
				+ claSelCode.value + "&assClaCteCode=" + claCteCode.value
				+ "&assClaPrdCode=" + claPrdCode.value + "&assCode="
				+ div.children[0].value;
		postAjaxJson("delAssignment", clientData, "addAssignmentCallBack");
		let modal__wrapper = document.getElementsByClassName('modal__wrapper')[0];
		modal__wrapper.style.display = "none";
	}

	function makeAssignment(classroomInfo) {
		const today = new Date();
		const year = today.getFullYear();

		let assignmentListDiv = document
				.getElementsByClassName("productList__zone")[0];
		assignmentListDiv.innerHTML = '<h4> 진행중 과제 </h4>';
		let expiredAssignmentListDiv = document
				.getElementsByClassName("productList__zone")[1];
		expiredAssignmentListDiv.innerHTML = '<h4> 만료된 과제 </h4>';
		let assignmentDiv = [];

		for (i = 0; i < classroomInfo[0].assignment.length; i++) {
			assignmentDiv[i] = createDiv("assignment" + i, "product__item",
					null, null);
			let box = [];
			box.push(createHidden("assCode",
					classroomInfo[0].assignment[i].assCode));
			box.push(createDiv("assName", null, null,
					classroomInfo[0].assignment[i].assName));
			box.push(createDiv("assInfo", null, null,
					classroomInfo[0].assignment[i].assInfo));
			box
					.push(createDiv("assStartDate", null, null, "시작일: "
							+ classroomInfo[0].assignment[i].assStartDate
									.substr(0, 10)));
			box.push(createDiv("assEndDate", null, null, "마감일: "
					+ classroomInfo[0].assignment[i].assEndDate.substr(0, 10)));
			box.push(createDiv("assMaxGrade", null, null, "만점: "
					+ classroomInfo[0].assignment[i].assMaxGrade));
			let div = assignmentDiv[i];
			let buttonDiv = createDiv(null, 'buttonDiv', null, null);
			let upd = createDiv(null, 'assBtn', null, '수정');
			upd.addEventListener("click", function() {
				activateUpd(div);
			});
			let del = createDiv(null, 'assBtn', null, '삭제');
			del.addEventListener("click", function() {
				activateDel(div);
			});
			let detail = createDiv(null, 'assBtn', null, '상세');
			detail.addEventListener("click", function() {
				moveAssignmentDetail(div);
			});
			buttonDiv.appendChild(upd);
			buttonDiv.appendChild(del);
			buttonDiv.appendChild(detail);
			box.push(buttonDiv);
			for (j = 0; j < box.length; j++) {
				assignmentDiv[i].appendChild(box[j]);
			}

			const today = new Date();
			const year = today.getFullYear();
			const month = today.getMonth() + 1;
			const day = today.getDate();
			const date = String(year)
					+ String((month < 10) ? ("0" + month) : month)
					+ String((day < 10) ? ("0" + day) : day);
			if (assignmentDiv[i].children[4].innerText.substr(5).replace(/-/g,
					"") < date) {
				expiredAssignmentListDiv.appendChild(assignmentDiv[i]);
			} else {
				assignmentListDiv.appendChild(assignmentDiv[i]);
			}
		}
		if (expiredAssignmentListDiv.children[1] == null) {
			expiredAssignmentListDiv.innerHTML = '';
		}
	}

	function remakeAssignment(classroomInfo) {
		const today = new Date();
		const year = today.getFullYear();

		let assignmentListDiv = document
				.getElementsByClassName("productList__zone")[0];
		assignmentListDiv.innerHTML = '<h4> 진행중 과제 </h4>';
		let expiredAssignmentListDiv = document
				.getElementsByClassName("productList__zone")[1];
		expiredAssignmentListDiv.innerHTML = '<h4> 만료된 과제 </h4>';
		let assignmentDiv = [];

		for (i = 0; i < classroomInfo.length; i++) {
			assignmentDiv[i] = createDiv("assignment" + i, "product__item",
					null, null);
			let box = [];
			box.push(createHidden("assCode", classroomInfo[i].assCode));
			box
					.push(createDiv("assName", null, null,
							classroomInfo[i].assName));
			box
					.push(createDiv("assInfo", null, null,
							classroomInfo[i].assInfo));
			box.push(createDiv("assStartDate", null, null, "시작일: "
					+ classroomInfo[i].assStartDate.substr(0, 10)));
			box.push(createDiv("assEndDate", null, null, "마감일: "
					+ classroomInfo[i].assEndDate.substr(0, 10)));
			box.push(createDiv("assMaxGrade", null, null, "만점: "
					+ classroomInfo[i].assMaxGrade));
			let div = assignmentDiv[i];
			let buttonDiv = createDiv(null, 'buttonDiv', null, null);
			let upd = createDiv(null, 'assBtn', null, '수정');
			upd.addEventListener("click", function() {
				activateUpd(div);
			});
			let del = createDiv(null, 'assBtn', null, '삭제');
			del.addEventListener("click", function() {
				activateDel(div);
			});
			let detail = createDiv(null, 'assBtn', null, '상세');
			detail.addEventListener("click", function() {
				moveAssignmentDetail(div);
			});
			buttonDiv.appendChild(upd);
			buttonDiv.appendChild(del);
			buttonDiv.appendChild(detail);
			box.push(buttonDiv);
			for (j = 0; j < box.length; j++) {
				assignmentDiv[i].appendChild(box[j]);
			}

			const today = new Date();
			const year = today.getFullYear();
			const month = today.getMonth() + 1;
			const day = today.getDate();
			const date = String(year)
					+ String((month < 10) ? ("0" + month) : month)
					+ String((day < 10) ? ("0" + day) : day);
			if (assignmentDiv[i].children[4].innerText.substr(5).replace(/-/g,
					"") < date) {
				expiredAssignmentListDiv.appendChild(assignmentDiv[i]);
			} else {
				assignmentListDiv.appendChild(assignmentDiv[i]);
			}
		}
		if (expiredAssignmentListDiv.children[1] == null) {
			expiredAssignmentListDiv.innerHTML = '';
		}
		cancel();

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

		makeAssignment(classroomInfo);
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
				<h3>과제 관리</h3>
				<div class="productList__zone"></div>
				<div class="createZone">
					<div class="assForm">
						<h4>과제 생성/수정/삭제</h4>
						<div class="assLittleForm">
							<div>
								<label>제목</label><br> <input type="text" name="assName"
									placeholder="제목을 입력해주세요">
							</div>
							<div>
								<label>내용</label><br>
								<textarea name="assInfo" rows="4" cols="35"
									placeholder="내용을 입력해주세요"></textarea>
							</div>
							<div>
								<label>시작일</label><br> <input type="date"
									name="assStartDate">
							</div>
							<div>
								<label>마감일</label><br> <input type="date" name="assEndDate">
							</div>
							<div>
								<label>최대점수</label><br> <input type="text"
									name="assMaxGrade" placeholder="최대점수" value="100">
							</div>
							<div class="buttonDiv">
								<button name="magic" class="content__btn btn__micro"
									onclick="addAssignment()">추가</button>
							</div>
						</div>
					</div>
				</div>
				<div class="productList__zone"></div>
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