
/* ::::: IP 체크 관련 ::::: */
let jsonData;
/* Public IP Saving */
function setPublicIp(ajaxData){
	jsonData = JSON.parse(ajaxData);
}


/* ::::: AJAX ::::: */
/* AJAX :: GET */
function getAjaxJson(jobCode, clientData, fn){
	const ajax =  new XMLHttpRequest();
	const action = (clientData != "")? (jobCode + "?" + clientData):jobCode;
	
	ajax.onreadystatechange = function(){
		if(ajax.readyState == 4 && ajax.status == 200){
			window[fn](ajax.responseText);
		}
	}
	
	ajax.open("get", action);
	ajax.send();
}

/* AJAX :: POST */
function postAjaxJson(jobCode, clientData, fn){
	//alert("postAjaxJson 입구");
	const ajax =  new XMLHttpRequest();
	
	ajax.onreadystatechange = function(){
		if(ajax.readyState == 4 && ajax.status == 200){
			window[fn](ajax.responseText);
		}
	}
	//alert("postAjaxJson open 전까지");

	ajax.open("post", jobCode);
	ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	ajax.send(clientData);
	//alert("postAjaxJson ajax.send 후");
}


/* ::: 로그아웃 ::: */
function signOut(){
	//alert("signOut 입구");
	let form = document.getElementsByName("clientData")[0];
	form.method="post";
	form.action="SignOut";
	form.submit()
	//alert("signOut 출구");
}



/* ::: 생성 ::: */
function lightBoxCtl(title, disp){
	let canvas = document.getElementById("canvas");
	let header = document.getElementById("cheader");
	header.innerText = title;
	canvas.style.display = disp? "block":"none";
}

function createDiv(id, className, value, text){
	let div = document.createElement("div");
	if(id != "") div.setAttribute("id", id);
	if(className != "") div.setAttribute("class", className);
	if(value != "") div.setAttribute("value", value);
	if(text != "") div.innerHTML = text;
	
	return div;
}

function createInput(typeName, objName, placeholder, className){
	let input = document.createElement("input");
	input.setAttribute("type", typeName);
	input.setAttribute("name", objName);
	input.setAttribute("placeholder", placeholder);
	input.setAttribute("class", className);
	
	return input;
}

function createHidden(objName, value){
	let input = document.createElement("input");
	input.setAttribute("type", "hidden");
	input.setAttribute("name", objName);
	input.setAttribute("value", value);
	
	return input;
}

function createTextarea(objName, rows, cols, className){
	let textArea = document.createElement("textarea");
	textArea.setAttribute("name", objName);
	textArea.setAttribute("rows", rows);
	textArea.setAttribute("cols", cols);
	textArea.setAttribute("class", className);
	
	return textArea;
}
