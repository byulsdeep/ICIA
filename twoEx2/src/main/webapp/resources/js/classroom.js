
//대시보드 이동
function moveDashboard(){
	let form = document.createElement("form");
	form.action = "moveDashboard";
	form.method = "post"
	form.appendChild(claSelCode);
	form.appendChild(claCteCode);
	form.appendChild(claPrdCode);
	document.body.appendChild(form);
	form.submit();
}

function moveCurriculum(){
	let form = document.createElement("form");
	form.action = "moveCurriculum";
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

function moveAssignment(){
	let form = document.createElement("form");
	form.action = "moveAssignment";
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
function moveSchedule(){
	let form = document.createElement("form");
	form.action = "moveSchedule";
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
function moveLocation(){
	let form = document.createElement("form");
	form.action = "moveLocation";
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
function moveManageCurriculum(){
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
function moveManageStudent(){
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
function moveManageAssignment(){
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
function moveManageGrade(){
	let form = document.createElement("form");
	form.action = "moveManageGrade";
	form.method = "post"
	form.appendChild(claSelCode);
	form.appendChild(claCteCode);
	form.appendChild(claPrdCode);
	document.body.appendChild(form);
	form.submit();
}
function moveManageNotice(){
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
function moveManageLocation(){
	let form = document.createElement("form");
	form.action = "moveManageLocation";
	form.method = "post";
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


function displayManagement(userType){
	if(userType=="buyer"){
		  document.getElementById("moveManageCurriculum").style.display="none";
	  }
}
function createButton(text,className,id){
	let button = document.createElement('button');
	button.type = 'button';
	button.innerHTML = text;
	button.id = id;
    button.className = className;
	
	return button;
}
function createImg(src, width, height, className){
	let img = document.createElement("IMG");
    img.setAttribute("src", src );
    if(width!=null)img.setAttribute("width", width);
	if(height!=null)img.setAttribute("height", height);
	if(className!=null)img.setAttribute("class", className);
	return img;
}




function makeTitle(){
	  let claTitle=document.getElementById("claTitle");
	  claTitle1=createDiv("claTitle1", null,null,null);
	  claTitle2=createDiv("claTitle2", null,null,null);
	  claTitle.appendChild(claTitle1);
	  claTitle.appendChild(claTitle2);
	  claTitle1.appendChild(createDiv("claName", "cla_name", null, claName.value));
	  claTitle1.appendChild(createDiv("claInfo", "cla_info", null, claInfo.value));
	  let claInfom = document.getElementById("claInfo");
	  claInfom.style.display='none';
	  let claInfoBtn2 = createButton("클래스룸 설명보기","claInfoBtn2");
	  claTitle1.appendChild(claInfoBtn2);
	  claInfoBtn2.addEventListener('click', function(){
	  	claInfom.style.display='block';
	  	claInfoBtn2.style.display='none';
	  });
	  claInfom.addEventListener('click', function(){
	   claInfom.style.display='none';
	   claInfoBtn2.style.display='block';
	  });
	  claTitle2.appendChild(createDiv("claStartDate", "cla_date", null,"강의 기간 : " + claStartDate.value.substr(0,10)+ "  ~  " +claEndDate.value.substr(0,10)));	 
	  claTitle2.appendChild(createDiv("claCurday", "cla_curday", null, "진행일수 : " +claCurDay.value+ "/"+  claTotDay.value + "일"));
	  claTitle2.appendChild(createDiv("claCurPercentage", "cla_curpercentage", null,"진행율 : " + claCurPercentage.value + "%"));
  	  
  	  claTitle2.addEventListener('click', function(){
	  claTitle2.style.display='none';
	  claInfoBtn.style.display='block';
		});
  	  claTitle2.style.display='none';
  	  let claInfoBtn=createButton("정보보기","claInfoBtn");
  	  claTitle.appendChild(claInfoBtn);
  	  claInfoBtn.addEventListener('click',function(){
	claTitle2.style.display='block';
	claInfoBtn.style.display='none';
});
  } 
function moveChat() {
	let form = document.createElement("form");
	form.action = "moveChat";
	form.method = "post";
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
  
  
  