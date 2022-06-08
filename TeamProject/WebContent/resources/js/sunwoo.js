/**
 * 
 */
function birthCheck() {
	//생년월일 (필수가 아니므로 비어있다면 넘어간다)
	if(document.frm.birthValid.value == "false" && !(document.frm.birth.value == "")){
		alert("생년월일이 유효하지 않습니다(필수X) 기입하지 않으시려면 내용을 지워주세요");
	    document.frm.birth.focus();
	
	    return false;
	}
}

function method(a){
	let form = document.createElement("form");
	
	let str = document.createElement("input");
	str.setAttribute("type","hidden");
	str.setAttribute("name","bbsid");
	str.setAttribute("value",a);
	
	form.appendChild(str);
	form.setAttribute("method" , "post");
	form.setAttribute("action" , "bbsView.do");
	document.body.appendChild(form);
	
	form.submit();
}

function method1(a){
	let form = document.createElement("form");
	
	let str = document.createElement("input");
	str.setAttribute("type","hidden");
	str.setAttribute("name","bbsid");
	str.setAttribute("value",a);
	
	form.appendChild(str);
	form.setAttribute("method" , "post");
	form.setAttribute("action" , "userBbsView.do");
	document.body.appendChild(form);
	
	form.submit();
}

function method2(){
	let form = document.createElement("form");
	
	form.setAttribute("method" , "post");
	form.setAttribute("action" , "userBbs.do");
	document.body.append(form);
	
	form.submit();
}

function method3(){
	let form = document.createElement("form");
	
	form.setAttribute("method" , "post");
	form.setAttribute("action" , "bbsList.do");
	document.body.append(form);
	
	form.submit();
}

function method4(){
	let form = document.createElement("form");
	
	form.setAttribute("method" , "post");
	form.setAttribute("action" , "userBbs.do");
	document.body.append(form);
	
	form.submit();
}

function method10(a){
	let form = document.createElement("form");
	
	let str = document.createElement("input");
	str.setAttribute("type","hidden");
	str.setAttribute("name","userid");
	str.setAttribute("value",a);
	
	form.appendChild(str);
	form.setAttribute("method" , "post");
	form.setAttribute("action" , "memberDelete.do");
	document.body.appendChild(form);
	
	form.submit();
}

