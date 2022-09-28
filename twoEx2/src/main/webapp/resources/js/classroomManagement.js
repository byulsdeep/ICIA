var colors = [
	'#fe918d', '#ff6863', '#73aace', '#feb546',
	'#dbe95b', '#4ba59c', '#FBC2EB', '#A18CD1',
	'#ff6863', '#0F4C81'
];
function getColor() {
	var index;
	index = Math.floor(Math.random() * 10);
	if(index > 7) {
		index = 0;
	}
	return colors[index];
}

function moveManageCurriculum(claSelCode, claCteCode, claPrdCode) {
	let form = document.createElement("form");
	form.action = "moveManageCurriculum";
	form.method = "post"
	form.appendChild(claSelCode);
	form.appendChild(claCteCode);
	form.appendChild(claPrdCode);
	form.appendChild(claName);
	form.appendChild(claInfo);
	form.appendChild(claStartDate);
	form.appendChild(claEndDate);
	form.appendChild(claTotDay);
	form.appendChild(claCurDay);
	form.appendChild(claCurPercentage);
	document.body.appendChild(form);
	form.submit();
}
function moveManageStudent() {
	let form = document.createElement("form");
	form.action = "moveManageStudent";
	form.method = "post"
	form.appendChild(claSelCode);
	form.appendChild(claCteCode);
	form.appendChild(claPrdCode);
	form.appendChild(claName);
	form.appendChild(claInfo);
	form.appendChild(claStartDate);
	form.appendChild(claEndDate);
	form.appendChild(claTotDay);
	form.appendChild(claCurDay);
	form.appendChild(claCurPercentage);
	document.body.appendChild(form);
	form.submit();
}
function moveManageAssignment() {
	let form = document.createElement("form");
	form.action = "moveManageAssignment";
	form.method = "post"
	form.appendChild(claSelCode);
	form.appendChild(claCteCode);
	form.appendChild(claPrdCode);
	form.appendChild(claName);
	form.appendChild(claInfo);
	form.appendChild(claStartDate);
	form.appendChild(claEndDate);
	form.appendChild(claTotDay);
	form.appendChild(claCurDay);
	form.appendChild(claCurPercentage);
	document.body.appendChild(form);
	form.submit();
}

function moveManageNotice() {
	let form = document.createElement("form");
	form.action = "moveManageNotice";
	form.method = "post"
	form.appendChild(claSelCode);
	form.appendChild(claCteCode);
	form.appendChild(claPrdCode);
	form.appendChild(claName);
	form.appendChild(claInfo);
	form.appendChild(claStartDate);
	form.appendChild(claEndDate);
	form.appendChild(claTotDay);
	form.appendChild(claCurDay);
	form.appendChild(claCurPercentage);
	document.body.appendChild(form);
	form.submit();
}
function moveManageMap() {
	let form = document.createElement("form");
	form.action = "moveManageMap";
	form.method = "post"
	form.appendChild(claSelCode);
	form.appendChild(claCteCode);
	form.appendChild(claPrdCode);
	form.appendChild(claName);
	form.appendChild(claInfo);
	form.appendChild(claStartDate);
	form.appendChild(claEndDate);
	form.appendChild(claTotDay);
	form.appendChild(claCurDay);
	form.appendChild(claCurPercentage);
	document.body.appendChild(form);
	form.submit();
}
function moveSellerMyClass(selCode) {

	let form = document.createElement("form");
	form.action = "moveSellerMyClass";
	form.method = "post";
	let claSelCode = document.createElement("input");

	claSelCode.setAttribute("name", "claSelCode");
	claSelCode.value = selCode;
	form.appendChild(claSelCode);
	document.body.appendChild(form);
	form.submit();
}

function makeClassroomInfo(classroomInfo) {
	let classroom__banner = document.getElementsByClassName("classroom__banner")[0];
	let claTitle = document.getElementById("claTitle");
	classroom__banner.style.backgroundColor = getColor();
	let box = [];
	let a = document.createElement('div');
	a.innerText = " " + classroomInfo[0].claCteName;
	a.setAttribute("class","box");
	let b = document.createElement('div');
	b.innerText = " " + classroomInfo[0].claName;
	b.setAttribute("class","box");
	let c = document.createElement('div');
	c.innerText = " " + classroomInfo[0].claInfo;
	c.setAttribute("class","box");
	let left = document.createElement('div');
	left.setAttribute("class", "left");
	left.appendChild(a);left.appendChild(b);left.appendChild(c);
	box.push(left);
	let d = document.createElement('div');
	d.innerText = " 강의 시작일 : " + classroomInfo[0].claStartDate.substr(0, 10);
	d.setAttribute("class","box");
	let e = document.createElement('div');
	e.innerText = " 강의 종료일 : " + classroomInfo[0].claEndDate.substr(0, 10);
	e.setAttribute("class","box");
	
	let startYear = classroomInfo[0].claStartDate.substr(0, 4);
	let startMonth = classroomInfo[0].claStartDate.substr(5, 2);
	let startDay = classroomInfo[0].claStartDate.substr(8, 2);
	let endYear = classroomInfo[0].claEndDate.substr(0, 4);
	let endMonth = classroomInfo[0].claEndDate.substr(5, 2);
	let endDay = classroomInfo[0].claEndDate.substr(8, 2);
	let claStartDate = new Date(startMonth + "/" + startDay + "/" + startYear);
	let claEndDate = new Date(endMonth + "/" + endDay + "/" + endYear);
	let today = new Date();
	let total = (claEndDate.getTime() - claStartDate.getTime()) / (1000 * 3600 * 24);
	let progress = (today.getTime() - claStartDate.getTime()) / (1000 * 3600 * 24);
	let rate = Math.round(((progress / total) * 100) * 100) / 100;

	let f = document.createElement('div');
	f.innerText = " 진행일수 : " + Math.trunc(progress) + " / " + Math.trunc(total);
	f.setAttribute("class","box");
	let g = document.createElement('div');
	g.innerText = " 진행율 : " + rate + "%";
	g.setAttribute("class","box");
	let right = document.createElement('div');
	right.setAttribute("class", "right");
	right.appendChild(d);
	right.appendChild(e);
	right.appendChild(f);
	right.appendChild(g);
	box.push(right);
	for (i = 0; i < box.length; i++) {
		claTitle.appendChild(box[i]);
	}


}
function closeModal() {
	const DOM__modal__wrapper = document.querySelector(".modal__wrapper");
	DOM__modal__wrapper.style.display = "none";

}




function createButton(text,className,id){
	let button = document.createElement('button');
	button.type = 'button';
	button.innerHTML = text;
	button.id = id;
    button.className = className;
	
	return button;
}


