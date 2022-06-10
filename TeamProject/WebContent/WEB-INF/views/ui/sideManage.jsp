<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  		<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
        <!-- Bootstrap core JS-->
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>

<style><!-- 쓸 데 없는 기능들 제거할 것-->
.a{
	float:left;
    margin-right: 15px;
	background-color:orange;
	color:white;
}
.menu {
	position:fixed;
	float:left;
    display: block;
    width: 200px;
    background-color: orange;
    color: white;
    border-radius: 20px;	/* border-radius : 테두리 둥글게둥글게 */
    padding: 10px;
    margin-left: 7%;
    box-sizing: border-box;
    padding-bottom:100;
    margin:50;
}
.menu ul {
    margin: 0;
    padding: 0;
}
.menu a, .menu > label {
    display: block;
    height: 100px;
    padding: 8px;
    cursor: pointer; /* cursor: 마우스 커서가 올라갔을 때 보여줄 모양을 지정  pointer: 링크를 가리키는 표시*/
    color: #fff;
    text-decoration: none;
}

/* li a {
  display: block;
  color: #000;
  padding: 8px 16px;
  text-decoration: none;
}

li a.active { /* // 알아오기 */
  background-color: gray;
  color: white;
}

li a:hover:not(.active) {
/* 가상 클래스 선택자 
	:hover => 마우스 오버했을 때 상태
	:active => 마우스를 클릭했을 때 상태
	link->visited->hover->active
*/
  background-color: gray;
  color: white;
} */
</style>
<script type="text/javascript">
function goPost1(){
	    let f = document.createElement('form');
	    f.setAttribute('method', 'post');
	    f.setAttribute('action', 'memberSearch.do');
	    document.body.appendChild(f);
	    f.submit();
	}
	
function goPost2(){
	    let f = document.createElement('form');
	    f.setAttribute('method', 'post');
	    f.setAttribute('action', 'bbsList.do');
	    document.body.appendChild(f);
	    f.submit();
	}
</script>
</head>
<body>
<br><br>
	<div class="menu">
    <label for="expand-menu">관리자 페이지</label>
    <ul>
        <li><div class="a"><a href="#" onClick="javascript:goPost1()" class="item"><i class="bi bi-people-fill"></i> 회원</a></div></li>        
        <li><div class="a"><a href="#" onClick="javascript:goPost2()" class="item"><i class="bi bi-megaphone-fill"></i> 공지사항</a></div></li>        
        <li><div class="a"><a href="itemListManagePage" class="item"><i class="bi bi-pencil-square"></i> 상품 관리</a></div></li>
        <li><div class="a"><a href="refundManage.do?pageSize=10&pageNum=1&category=userid&keyword=" class="item"><i class="bi bi-clipboard-x"></i> 취소/환불</a></div></li>
        <li><div class="a"><a href="orderManage.do?pageSize=10&pageNum=1&category=userid&keyword=" class="item"><i class="bi bi-truck"></i> 배송</a></div></li>
    </ul>
</div>
</body>
</html>