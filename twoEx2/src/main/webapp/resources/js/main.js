/* AJAX :: POST */
function postAjaxJson(jobCode, clientData, fn) {
    const ajax = new XMLHttpRequest();

    ajax.onreadystatechange = function () {
        if (ajax.readyState == 4 && ajax.status == 200) {
            window[fn](ajax.responseText);
        }
    };
    ajax.open('post', jobCode);
    ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    ajax.send(clientData);
}
function isFormat(input, type) {
    const cap = /[A-Z]/;
    const lower = /[a-z]/;
    const num = /[0-9]/;
    const spChar = /[!@#$%^&*]/;

    let result;
    let count = 0;

    if (cap.test(input)) count++;
    if (lower.test(input)) count++;
    if (num.test(input)) count++;
    if (spChar.test(input)) count++;

    if (type) {
        result = count >= 3 ? true : false;
    } else {
        result = count == 0 ? true : false;
    }
    return result;
}
function isCharLength(input, min, max) {
    let result = false;
    if (max != null) {
        if (input.length >= min && input.length <= max)
            result = true;
    } else {
        if (input.length >= min)
            result = true;
    }
    return result;
}
function createInput(typeName,objName,placeholder,className, value){
	let input = document.createElement('input');
	if(typeName != null) input.setAttribute("type",typeName);
	if(objName != null) input.setAttribute("name",objName);
	if(placeholder != null) input.setAttribute("placeholder",placeholder);
	if(className != null) input.setAttribute("class",className);
	if(value != null) input.setAttribute("value", value);
	return input;
}

function createTextArea(name, rows,cols, innerText){
	let input = document.createElement('textarea');
	if(name != null) input.setAttribute("name", name);
	if(rows != null) input.setAttribute("rows",rows);
	if(cols != null) input.setAttribute("cols",cols);
	if(innerText != null) input.innerText = innerText;
	return input;
}

function createDiv(id,className,value,text){
	let div = document.createElement('div');
	if (id != null) div.setAttribute("id",id);
	if (className != null) div.setAttribute("class",className);
	if (value != null) div.setAttribute("value",value);
	if (text != null) div.innerHTML=text;
	return div;
}

function createHidden(objName, value){
	let input = document.createElement("input");
	input.setAttribute("type", "hidden");
	if(objName != null) input.setAttribute("name", objName);
	if(value != null) input.setAttribute("value", value);
	return input;
}

/** 상은 추가 공통요소 **/
/*** 상품정보 페이지 이동 함수 **********************************/
function moveProductInfo(prdCteCode, prdSelCode, prdCode){
    //alert("moveProductInfo 입구");
       //alert("입구 카테고리 코드 : " + prdCteCode +" "+ prdSelCode +" "+ prdCode);
    let form = document.createElement('form');
    form.appendChild(createFormInput("prdCteCode", prdCteCode));
    form.appendChild(createFormInput("prdSelCode", prdSelCode));
    form.appendChild(createFormInput("prdCode", prdCode));
    //alert(form);
  
    form.method="POST";
    form.action="moveProductInfo"
      document.body.appendChild(form);
    form.submit()
    //alert("moveProductInfo 출구");
  }
  
  function createFormInput(name, value){
    let input = document.createElement('input');
    input.setAttribute('type', 'hidden');
    input.setAttribute('name', name);
    input.setAttribute('value', value);
    return input;
  }