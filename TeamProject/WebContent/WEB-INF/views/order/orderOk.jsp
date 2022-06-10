<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="refresh" content="3;url=orderOkList.do?pageNum=1&pageSize=10">
<title>이젠, 집에서 | 주문 완료</title>
<style type="text/css">
</style>
</head>
<body>
<div id="wrap">
	<jsp:include page="/WEB-INF/views/ui/nav.jsp"></jsp:include>
	<section>
	<div align="center">
		<div style="width: 60%; margin-left: auto; margin-right: auto;">
			<div align="right">
				<span style="color:gray">01 장바구니 <i class="bi-caret-right-fill"></i></span>
				<span style="color:gray"> 02 주문서작성/결제 <i class="bi-caret-right-fill"></i></span>
				<span style="color:black"><strong> 03 주문완료 </strong></span>
			</div>
			<hr>
	<br>
	<br>
	<br>
			<div style="font-size:200px;color:orange"><i class="bi-bag-check"></i></div>
			<div style="font-size:30px;color:gray">결제가 정상적으로 완료되었습니다.<br>
			잠시 후 주문 내역페이지로 이동합니다.
			</div>
		</div>
	</div>
	</section>
	<jsp:include page="/WEB-INF/views/ui/footer.jsp"></jsp:include>
	</div>
</body>
</html>
