function itemCheck() {
	if (document.frm.item_name.value.length == 0) {
		alert("상품명을 써 주세요.");
		frm.item_name.focus();

		return false;
	}

	if (document.frm.item_price.value.length == 0) {
		alert("가격을 써 주세요.");
		frm.item_price.focus();

		return false;
	}

	if (isNaN(document.frm.item_price.value)) {
		alert("숫자를 입력해야 합니다.");
		frm.item_price.focus();

		return false;
	}

	if (document.frm.item_quantity.value.length == 0) {
		alert("재고를 써 주세요.");
		frm.item_quantity.focus();

		return false;
	}

	if (document.frm.item_total.value.length == 0) {
		alert("인분을 써 주세요.");
		frm.item_total.focus();

		return false;
	}

	if (document.frm.item_time.value.length == 0) {
		alert("조리 시간을 써 주세요.");
		frm.item_time.focus();

		return false;
	}
	
	//판매량
	if (document.frm.item_sales.value.length == 0) {
		document.frm.item_sales.value = "0";

	}
	
	//할인율
	if (document.frm.item_discount.value.length == 0) {
		document.frm.item_discount.value = "0";
	}
	
	//별점 평균
	if (document.frm.item_starsAvg.value.length == 0) {
		document.frm.item_starsAvg.value = "0";

	}
	
	return true;
}

function displayWrite(id) {
	var openClose = document.getElementById(id);
	if (openClose.style.display == 'none') {
		openClose.style.display = '';
	} else {
		openClose.style.display = 'none';
	}
}

function displayContent(id, post_num) {
	var openClose = document.getElementById(id);
	if (openClose.style.display == 'none') {
		openClose.style.display = '';
		
		var url = "postScriptContent?post_num=" + post_num;
		window.open(url, "_blank_1", "width=800, height=600, menubar=no, resizable=no, scrollbars=yes, toolbar=no");
	} else {
		openClose.style.display = 'none';
	}
}

function helpful(post_num) {
	alert("도움된 후기예요!");
	
	location.href = "updateHelp?post_num=" + post_num;
}

function deleteOK(post_num, post_writer, userid) {
	if (post_writer == userid) {
		var result = confirm("정말 후기를 삭제하시겠습니까?");

		if (result == true) {
			location.href = "postDelete?post_num=" + post_num;
		}
	} else {
		alert("이 후기는 다른 사람이 쓴 거예요!");
	}

}